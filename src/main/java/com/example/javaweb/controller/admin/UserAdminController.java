package com.example.javaweb.controller.admin;

import com.example.javaweb.entity.User;
import com.example.javaweb.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class UserAdminController {

    private final UserService userService;

    @Autowired
    public UserAdminController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Hiển thị danh sách toàn bộ người dùng
     */
    @GetMapping
    public String listUsers(HttpSession session, Model model) {
        List<User> users = userService.findAll();

        // Lấy thông báo lỗi/thành công từ session
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

        model.addAttribute("users", users);
        return "admin/user-list"; // Trả về file views/admin/user-list.jsp
    }

    /**
     * Khóa hoặc kích hoạt lại tài khoản người dùng
     */
    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable("id") Long id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");

        // Ngăn chặn tự khóa tài khoản của chính mình
        if (currentUser != null && currentUser.getId().equals(id)) {
            session.setAttribute("errorMessage", "Bạn không thể tự khóa tài khoản của chính mình!");
            return "redirect:/admin/users";
        }

        try {
            userService.toggleActive(id);
            session.setAttribute("successMessage", "Thay đổi trạng thái tài khoản thành công!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    /**
     * Cấp hoặc hủy quyền Admin của người dùng
     */
    @GetMapping("/toggle-admin/{id}")
    public String toggleAdmin(@PathVariable("id") Long id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");

        // Ngăn chặn tự tước quyền ADMIN của chính mình
        if (currentUser != null && currentUser.getId().equals(id)) {
            session.setAttribute("errorMessage", "Bạn không thể tự hủy quyền Admin của chính mình!");
            return "redirect:/admin/users";
        }

        try {
            userService.toggleAdminRole(id);
            session.setAttribute("successMessage", "Cập nhật vai trò thành công!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    /**
     * Xóa tài khoản người dùng
     */
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");

        // Ngăn chặn tự xóa tài khoản của chính mình
        if (currentUser != null && currentUser.getId().equals(id)) {
            session.setAttribute("errorMessage", "Bạn không thể tự xóa tài khoản của chính mình!");
            return "redirect:/admin/users";
        }

        try {
            userService.deleteById(id);
            session.setAttribute("successMessage", "Xóa tài khoản người dùng thành công!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi khi xóa người dùng: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
