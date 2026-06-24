package com.example.javaweb.controller.user;

import com.example.javaweb.entity.Product;
import com.example.javaweb.model.Cart;
import com.example.javaweb.model.CartItem;
import com.example.javaweb.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final ProductService productService;

    @Autowired
    public CartController(ProductService productService) {
        this.productService = productService;
    }

    /**
     * Hiển thị chi tiết giỏ hàng
     */
    @GetMapping
    public String showCart(HttpSession session, Model model) {
        Cart cart = getCartFromSession(session);
        model.addAttribute("cart", cart);

        // Lấy thông điệp lỗi hoặc thành công từ session nếu có
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

        return "user/cart"; // Trả về views/user/cart.jsp
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     */
    @GetMapping("/add")
    public String addToCart(@RequestParam("productId") Long productId,
                            @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity,
                            @RequestParam(value = "buyNow", required = false, defaultValue = "false") Boolean buyNow,
                            HttpSession session,
                            HttpServletRequest request) {
        
        Optional<Product> productOpt = productService.findById(productId);
        if (productOpt.isEmpty()) {
            session.setAttribute("errorMessage", "Sản phẩm không tồn tại!");
            return "redirect:/home";
        }

        Product product = productOpt.get();

        if (product.getQuantity() <= 0) {
            session.setAttribute("errorMessage", "Sản phẩm " + product.getName() + " hiện đã hết hàng!");
            return redirectBack(request, "/home");
        }

        Cart cart = getCartFromSession(session);

        // Kiểm tra xem số lượng yêu cầu + số lượng đã có trong giỏ hàng có vượt quá kho không
        int currentQtyInCart = cart.getItems().stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .mapToInt(CartItem::getQuantity)
                .findFirst()
                .orElse(0);

        if (currentQtyInCart + quantity > product.getQuantity()) {
            session.setAttribute("errorMessage", "Không thể thêm sản phẩm. Số lượng trong giỏ hàng (" 
                    + currentQtyInCart + ") + số lượng thêm mới (" + quantity + ") vượt quá số lượng còn lại trong kho (" 
                    + product.getQuantity() + ")!");
            return redirectBack(request, "/cart");
        }

        cart.addItem(product, quantity);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        session.setAttribute("successMessage", "Đã thêm '" + product.getName() + "' vào giỏ hàng!");

        if (buyNow) {
            return "redirect:/checkout";
        }

        return redirectBack(request, "/cart");
    }

    /**
     * Cập nhật số lượng của sản phẩm trong giỏ hàng
     */
    @PostMapping("/update")
    public String updateCart(@RequestParam("productId") Long productId,
                             @RequestParam("quantity") Integer quantity,
                             HttpSession session) {
        
        Optional<Product> productOpt = productService.findById(productId);
        if (productOpt.isEmpty()) {
            session.setAttribute("errorMessage", "Sản phẩm không tồn tại!");
            return "redirect:/cart";
        }

        Product product = productOpt.get();

        if (quantity <= 0) {
            Cart cart = getCartFromSession(session);
            cart.removeItem(productId);
            session.setAttribute("cartCount", cart.getTotalQuantity());
            session.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng.");
            return "redirect:/cart";
        }

        if (quantity > product.getQuantity()) {
            session.setAttribute("errorMessage", "Không thể cập nhật số lượng! Số lượng yêu cầu (" + quantity 
                    + ") vượt quá tồn kho còn lại của " + product.getName() + " (" + product.getQuantity() + ").");
            return "redirect:/cart";
        }

        Cart cart = getCartFromSession(session);
        cart.updateQuantity(productId, quantity);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        session.setAttribute("successMessage", "Cập nhật số lượng thành công.");
        
        return "redirect:/cart";
    }

    /**
     * Xóa sản phẩm khỏi giỏ hàng
     */
    @GetMapping("/remove/{productId}")
    public String removeFromCart(@PathVariable("productId") Long productId, HttpSession session) {
        Cart cart = getCartFromSession(session);
        cart.removeItem(productId);
        session.setAttribute("cartCount", cart.getTotalQuantity());
        session.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng.");
        return "redirect:/cart";
    }

    // Helper để lấy giỏ hàng từ session hoặc khởi tạo nếu chưa có
    private Cart getCartFromSession(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // Helper để điều hướng quay lại trang cũ hoặc trang dự phòng
    private String redirectBack(HttpServletRequest request, String fallbackUrl) {
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:" + fallbackUrl;
    }
}
