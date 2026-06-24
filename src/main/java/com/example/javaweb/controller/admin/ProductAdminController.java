package com.example.javaweb.controller.admin;

import com.example.javaweb.entity.Category;
import com.example.javaweb.entity.Product;
import com.example.javaweb.service.CategoryService;
import com.example.javaweb.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/products")
public class ProductAdminController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @Autowired
    public ProductAdminController(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    /**
     * Hiển thị danh sách sản phẩm phía Admin
     */
    @GetMapping
    public String listProducts(Model model) {
        List<Product> products = productService.findAll();
        List<Category> categories = categoryService.findAll();
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("productForm", new Product()); // Dùng cho modal thêm mới
        
        return "admin/product-list"; // Trả về file views/admin/product-list.jsp
    }

    /**
     * Thêm mới hoặc cập nhật thông tin sản phẩm
     */
    @PostMapping("/save")
    public String saveProduct(@ModelAttribute("productForm") Product product, 
                              @RequestParam("categoryId") Long categoryId,
                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        
        // Nếu là cập nhật, tìm sản phẩm cũ để lấy lại ảnh cũ nếu không tải lên ảnh mới
        if (product.getId() != null) {
            productService.findById(product.getId()).ifPresent(existingProduct -> {
                if (imageFile == null || imageFile.isEmpty()) {
                    product.setImage(existingProduct.getImage());
                }
            });
        }

        // Xử lý upload ảnh mới
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                // Tạo thư mục uploads tại root của project nếu chưa tồn tại
                File uploadDir = new File("uploads");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Tạo tên file duy nhất để tránh bị đè
                String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
                Path filePath = Paths.get("uploads", fileName);
                
                // Lưu file xuống đĩa
                Files.copy(imageFile.getInputStream(), filePath);
                
                // Lưu đường dẫn truy cập ảnh vào DB
                product.setImage("/uploads/" + fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Tìm và gắn Category cho Product trước khi lưu
        categoryService.findById(categoryId).ifPresent(c -> product.setCategory(c));
        productService.save(product);
        return "redirect:/admin/products";
    }

    /**
     * Hiển thị form chỉnh sửa sản phẩm (nếu không dùng modal chỉnh sửa)
     */
    @GetMapping("/edit/{id}")
    public String editProductForm(@PathVariable("id") Long id, Model model) {
        productService.findById(id).ifPresent(product -> model.addAttribute("productForm", product));
        model.addAttribute("products", productService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        return "admin/product-list";
    }

    /**
     * Xóa sản phẩm theo ID
     */
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id) {
        productService.deleteById(id);
        return "redirect:/admin/products";
    }
}
