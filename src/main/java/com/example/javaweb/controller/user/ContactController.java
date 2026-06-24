package com.example.javaweb.controller.user;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/contact")
public class ContactController {

    /**
     * Hiển thị trang liên hệ
     */
    @GetMapping
    public String showContact(HttpSession session, Model model) {
        String successMsg = (String) session.getAttribute("successMessage");
        if (successMsg != null) {
            model.addAttribute("success", successMsg);
            session.removeAttribute("successMessage");
        }
        return "user/contact"; // views/user/contact.jsp
    }

    /**
     * Xử lý gửi tin nhắn liên hệ
     */
    @PostMapping
    public String handleContactSubmit(@RequestParam("name") String name,
                                      @RequestParam("email") String email,
                                      @RequestParam(value = "phone", required = false) String phone,
                                      @RequestParam("title") String title,
                                      @RequestParam("message") String message,
                                      HttpSession session) {
        
        // Giả lập lưu tin nhắn liên hệ thành công
        String alertMsg = "Cảm ơn " + name + "! Tin nhắn liên hệ của bạn ('" + title 
                + "') đã được gửi thành công. Tech Store sẽ phản hồi qua email " + email + " trong vòng 24 giờ tới.";
                
        session.setAttribute("successMessage", alertMsg);
        return "redirect:/contact";
    }
}
