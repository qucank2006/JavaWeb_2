package com.example.javaweb.controller.admin;

import com.example.javaweb.entity.Order;
import com.example.javaweb.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class OrderAdminController {

    private final OrderService orderService;

    @Autowired
    public OrderAdminController(OrderService orderService) {
        this.orderService = orderService;
    }

    /**
     * Hiển thị danh sách toàn bộ đơn hàng
     */
    @GetMapping
    public String listOrders(HttpSession session, Model model) {
        List<Order> orders = orderService.findAll();

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

        model.addAttribute("orders", orders);
        return "admin/order-list"; // Trả về views/admin/order-list.jsp
    }

    /**
     * Cập nhật trạng thái đơn hàng
     */
    @GetMapping("/update-status/{id}")
    public String updateStatus(@PathVariable("id") Long id,
                               @RequestParam("status") String status,
                               HttpSession session) {
        try {
            orderService.updateOrderStatus(id, status);
            session.setAttribute("successMessage", "Cập nhật trạng thái đơn hàng thành công!");
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi khi cập nhật đơn hàng: " + e.getMessage());
        }
        return "redirect:/admin/orders";
    }
}
