package com.example.javaweb.config;

import com.example.javaweb.entity.Role;
import com.example.javaweb.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        String requestURI = request.getRequestURI();

        // Kiểm tra phân quyền Admin cho các đường dẫn /admin/**
        if (requestURI.startsWith(request.getContextPath() + "/admin")) {
            if (currentUser == null) {
                // Chưa đăng nhập: Redirect về trang login kèm thông báo
                session.setAttribute("errorMessage", "Bạn cần đăng nhập bằng tài khoản Quản trị viên!");
                response.sendRedirect(request.getContextPath() + "/login");
                return false;
            }
            
            // Đã đăng nhập: Kiểm tra xem có quyền ADMIN không
            boolean isAdmin = currentUser.getRoles().stream()
                    .map(Role::getName)
                    .anyMatch("ADMIN"::equalsIgnoreCase);
            
            if (!isAdmin) {
                // Không có quyền ADMIN: Redirect về trang chủ kèm lỗi
                session.setAttribute("errorMessage", "Tài khoản của bạn không có quyền truy cập khu vực Quản trị!");
                response.sendRedirect(request.getContextPath() + "/home");
                return false;
            }
        }

        return true;
    }
}
