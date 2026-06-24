package com.example.javaweb.service.impl;

import com.example.javaweb.entity.Role;
import com.example.javaweb.entity.User;
import com.example.javaweb.repository.RoleRepository;
import com.example.javaweb.repository.UserRepository;
import com.example.javaweb.service.UserService;
import com.example.javaweb.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    @Transactional
    public User registerUser(User user) {
        // 1. Kiểm tra username tồn tại
        if (userRepository.findByUsername(user.getUsername()).isPresent()) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại trên hệ thống!");
        }

        // 2. Kiểm tra email tồn tại
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new RuntimeException("Địa chỉ Email đã được đăng ký sử dụng!");
        }

        // 3. Mã hóa mật khẩu
        String hashed = PasswordUtil.hashPassword(user.getPassword());
        user.setPassword(hashed);

        // 4. Kích hoạt mặc định tài khoản
        user.setActive(true);

        // 5. Gán vai trò USER mặc định
        Role userRole = roleRepository.findByName("USER").orElseGet(() -> {
            Role newRole = new Role("USER");
            return roleRepository.save(newRole);
        });
        
        user.getRoles().add(userRole);

        // 6. Lưu vào cơ sở dữ liệu
        return userRepository.save(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> login(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            // Mã hóa mật khẩu đầu vào để so sánh
            String hashedInput = PasswordUtil.hashPassword(password);
            if (user.getPassword().equals(hashedInput)) {
                if (!user.isActive()) {
                    throw new RuntimeException("Tài khoản này đã bị khóa!");
                }
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    @Transactional(readOnly = true)
    public java.util.List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    @Transactional
    public void toggleActive(Long id) {
        userRepository.findById(id).ifPresent(user -> {
            user.setActive(!user.isActive());
            userRepository.save(user);
        });
    }

    @Override
    @Transactional
    public void toggleAdminRole(Long id) {
        userRepository.findById(id).ifPresent(user -> {
            boolean isAdmin = user.getRoles().stream()
                    .anyMatch(r -> "ADMIN".equalsIgnoreCase(r.getName()));
            if (isAdmin) {
                user.getRoles().removeIf(r -> "ADMIN".equalsIgnoreCase(r.getName()));
            } else {
                roleRepository.findByName("ADMIN").ifPresent(r -> user.getRoles().add(r));
            }
            userRepository.save(user);
        });
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }
}
