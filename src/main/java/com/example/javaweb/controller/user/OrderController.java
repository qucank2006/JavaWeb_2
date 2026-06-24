package com.example.javaweb.controller.user;

import com.example.javaweb.entity.Order;
import com.example.javaweb.entity.User;
import com.example.javaweb.model.Cart;
import com.example.javaweb.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping
public class OrderController {

    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    /**
     * Hiển thị trang đặt hàng (Checkout)
     */
    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            session.setAttribute("errorMessage", "Bạn cần đăng nhập để tiến hành mua hàng!");
            return "redirect:/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            session.setAttribute("errorMessage", "Giỏ hàng của bạn đang trống!");
            return "redirect:/cart";
        }

        model.addAttribute("cart", cart);
        model.addAttribute("user", currentUser);

        // Lấy thông báo lỗi nếu có
        String errorMsg = (String) session.getAttribute("errorMessage");
        if (errorMsg != null) {
            model.addAttribute("error", errorMsg);
            session.removeAttribute("errorMessage");
        }

        return "user/checkout"; // Trả về views/user/checkout.jsp
    }

    /**
     * Xử lý gửi đơn đặt hàng
     */
    @PostMapping("/checkout")
    public String placeOrder(@RequestParam("recipientName") String recipientName,
                             @RequestParam("phone") String phone,
                             @RequestParam("address") String address,
                             @RequestParam(value = "note", required = false) String note,
                             HttpSession session) {
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            session.setAttribute("errorMessage", "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại!");
            return "redirect:/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            session.setAttribute("errorMessage", "Giỏ hàng trống, không thể đặt hàng!");
            return "redirect:/cart";
        }

        try {
            Order order = orderService.placeOrder(currentUser, cart, recipientName, phone, address, note);
            
            // Xóa giỏ hàng sau khi đặt thành công
            cart.clear();
            session.setAttribute("cartCount", 0);
            session.setAttribute("lastPlacedOrder", order);

            return "redirect:/order/success";
        } catch (IllegalArgumentException e) {
            // Lỗi nghiệp vụ (hết hàng, sản phẩm không tồn tại, v.v.)
            session.setAttribute("errorMessage", e.getMessage());
            return "redirect:/cart";
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi không xác định khi đặt hàng: " + e.getMessage());
            return "redirect:/checkout";
        }
    }

    /**
     * Hiển thị trang thông báo đặt hàng thành công
     */
    @GetMapping("/order/success")
    public String orderSuccess(HttpSession session, Model model) {
        Order lastPlacedOrder = (Order) session.getAttribute("lastPlacedOrder");
        if (lastPlacedOrder == null) {
            return "redirect:/home";
        }
        
        model.addAttribute("order", lastPlacedOrder);
        // Giữ lại trong session hoặc xóa tùy ý. Ta xóa để tránh refresh F5 lặp lại.
        session.removeAttribute("lastPlacedOrder");
        return "user/order-success"; // Trả về views/user/order-success.jsp
    }

    /**
     * Hiển thị lịch sử mua hàng của User hiện tại
     */
    @GetMapping("/order/history")
    public String orderHistory(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            session.setAttribute("errorMessage", "Bạn cần đăng nhập để xem lịch sử đơn hàng!");
            return "redirect:/login";
        }

        List<Order> orders = orderService.getOrdersByUser(currentUser);
        model.addAttribute("orders", orders);

        return "user/order-history"; // Trả về views/user/order-history.jsp
    }
}
