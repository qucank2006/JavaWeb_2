package com.example.javaweb.controller.admin;

import com.example.javaweb.entity.Category;
import com.example.javaweb.entity.Product;
import com.example.javaweb.service.CategoryService;
import com.example.javaweb.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/categories")
public class CategoryAdminController {

    private final CategoryService categoryService;
    private final ProductService productService;

    @Autowired
    public CategoryAdminController(CategoryService categoryService, ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }

    /**
     * Hiển thị danh sách danh mục và form thêm mới
     */
    @GetMapping
    public String listCategories(HttpSession session, Model model) {
        List<Category> categories = categoryService.findAll();
        
        // Tính số lượng sản phẩm thuộc mỗi danh mục
        Map<Long, Integer> productCounts = new HashMap<>();
        for (Category category : categories) {
            List<Product> products = productService.searchProducts(null, category.getId());
            productCounts.put(category.getId(), products.size());
        }

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

        model.addAttribute("categories", categories);
        model.addAttribute("productCounts", productCounts);
        model.addAttribute("categoryForm", new Category());
        
        return "admin/category-list"; // Trả về file views/admin/category-list.jsp
    }

    /**
     * Lưu danh mục (Thêm mới hoặc Cập nhật)
     */
    @PostMapping("/save")
    public String saveCategory(@ModelAttribute("categoryForm") Category category, HttpSession session) {
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            session.setAttribute("errorMessage", "Tên danh mục không được để trống!");
            return "redirect:/admin/categories";
        }
        
        categoryService.save(category);
        session.setAttribute("successMessage", "Lưu thông tin danh mục thành công!");
        return "redirect:/admin/categories";
    }

    /**
     * Xóa danh mục
     */
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id, HttpSession session) {
        // Kiểm tra xem danh mục có chứa sản phẩm hay không
        List<Product> products = productService.searchProducts(null, id);
        if (!products.isEmpty()) {
            session.setAttribute("errorMessage", "Không thể xóa danh mục này vì vẫn còn sản phẩm thuộc danh mục!");
            return "redirect:/admin/categories";
        }

        try {
            categoryService.deleteById(id);
            session.setAttribute("successMessage", "Xóa danh mục thành công!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Đã xảy ra lỗi khi xóa danh mục: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
}
