package com.example.javaweb.service;

import com.example.javaweb.entity.User;
import java.util.Optional;

public interface UserService {
    
    /**
     * Đăng ký tài khoản người dùng mới.
     * Mật khẩu sẽ được mã hóa và gán quyền mặc định là USER.
     * @param user Đối tượng chứa thông tin đăng ký
     * @return Đối tượng User đã lưu thành công
     */
    User registerUser(User user);
    
    /**
     * Xác thực thông tin đăng nhập.
     * @param username Tên đăng nhập
     * @param password Mật khẩu bản rõ
     * @return Đối tượng User nếu đăng nhập thành công, ngược lại trả về Optional.empty()
     */
    Optional<User> login(String username, String password);
    
    /**
     * Tìm kiếm người dùng theo tên tài khoản.
     */
    Optional<User> findByUsername(String username);

    java.util.List<User> findAll();
    Optional<User> findById(Long id);
    void toggleActive(Long id);
    void toggleAdminRole(Long id);
    void deleteById(Long id);
}
