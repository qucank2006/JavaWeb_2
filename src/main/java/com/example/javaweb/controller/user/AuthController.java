package com.example.javaweb.controller.user;

import com.example.javaweb.entity.Role;
import com.example.javaweb.entity.User;
import com.example.javaweb.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class AuthController {

    private final UserService userService;

    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Hiển thị trang đăng nhập
     */
    @GetMapping("/login")
    public String showLoginForm(HttpSession session, Model model) {
        // Nếu đã đăng nhập, chuyển về trang chủ
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/home";
        }

        // Lấy thông báo lỗi hoặc thành công từ session (nếu có)
        String errorMsg = (String) session.getAttribute("errorMessage");
        String successMsg = (String) session.getAttribute("successMessage");
        
        if (errorMsg != null) {
            model.addAttribute("error", errorMsg);
            session.removeAttribute("errorMessage");
        }
        if (successMsg != null) {
            model.addAttribute("success", successMsg);
            session.removeAttribute("successMessage");
        }

        return "user/login"; // views/user/login.jsp
    }

    /**
     * Xử lý đăng nhập
     */
    @PostMapping("/login")
    public String handleLogin(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpSession session,
                              Model model) {
        try {
            Optional<User> userOpt = userService.login(username, password);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                session.setAttribute("currentUser", user);

                // Kiểm tra xem user có quyền ADMIN không để điều hướng
                boolean isAdmin = user.getRoles().stream()
                        .map(Role::getName)
                        .anyMatch("ADMIN"::equalsIgnoreCase);

                if (isAdmin) {
                    return "redirect:/admin/products";
                } else {
                    return "redirect:/home";
                }
            } else {
                model.addAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
                return "user/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "user/login";
        }
    }

    /**
     * Hiển thị trang đăng ký
     */
    @GetMapping("/register")
    public String showRegisterForm(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/home";
        }
        model.addAttribute("userForm", new User());
        return "user/register"; // views/user/register.jsp
    }

    /**
     * Xử lý đăng ký tài khoản mới
     */
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("userForm") User user,
                                 HttpSession session,
                                 Model model) {
        try {
            userService.registerUser(user);
            session.setAttribute("successMessage", "Đăng ký tài khoản thành công! Hãy đăng nhập.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("userForm", user);
            return "user/register";
        }
    }

    /**
     * Xử lý đăng xuất
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home";
    }
}
