package com.example.javaweb.controller.user;

import com.example.javaweb.entity.Category;
import com.example.javaweb.entity.Product;
import com.example.javaweb.service.CategoryService;
import com.example.javaweb.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class ProductUserController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @Autowired
    public ProductUserController(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    /**
     * Trang chủ phía Khách hàng: Hiển thị danh sách sản phẩm, cho phép lọc theo danh mục
     * và tìm kiếm theo tên sản phẩm.
     */
    @GetMapping({"/", "/home"})
    public String showHome(@RequestParam(value = "keyword", required = false) String keyword,
                           @RequestParam(value = "categoryId", required = false) Long categoryId,
                           Model model) {
        
        // Tìm kiếm sản phẩm theo từ khóa và danh mục
        List<Product> products = productService.searchProducts(keyword, categoryId);
        
        // Lấy tất cả danh mục hiển thị lên menu bên cạnh (sidebar)
        List<Category> categories = categoryService.findAll();

        // Gắn dữ liệu vào Model để truyền sang JSP
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategoryId", categoryId);

        return "user/home"; // Trả về file views/user/home.jsp
    }

    /**
     * Trang danh sách sản phẩm phía Khách hàng: Có thêm các bộ lọc và sắp xếp nâng cao
     */
    @GetMapping("/products")
    public String listProducts(@RequestParam(value = "keyword", required = false) String keyword,
                               @RequestParam(value = "categoryId", required = false) Long categoryId,
                               @RequestParam(value = "sortBy", required = false) String sortBy,
                               Model model) {
        
        // Lấy danh sách sản phẩm tìm kiếm được
        List<Product> products = productService.searchProducts(keyword, categoryId);
        
        // Thực hiện sắp xếp theo yêu cầu
        if ("price_asc".equals(sortBy)) {
            products.sort(java.util.Comparator.comparing(Product::getPrice));
        } else if ("price_desc".equals(sortBy)) {
            products.sort(java.util.Comparator.comparing(Product::getPrice).reversed());
        }

        List<Category> categories = categoryService.findAll();

        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("sortBy", sortBy);

        return "user/product-list"; // Trả về file views/user/product-list.jsp
    }

    /**
     * Trang chi tiết sản phẩm phía Khách hàng
     */
    @GetMapping("/products/{id}")
    public String showProductDetail(@PathVariable("id") Long id, Model model) {
        Optional<Product> productOpt = productService.findById(id);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            model.addAttribute("product", product);

            // Tìm kiếm các sản phẩm cùng danh mục (sản phẩm liên quan)
            List<Product> relatedProducts = productService.searchProducts(null, product.getCategory().getId());
            // Loại trừ sản phẩm hiện tại khỏi danh sách liên quan
            relatedProducts.removeIf(p -> p.getId().equals(product.getId()));
            
            // Giới hạn tối đa hiển thị 3 sản phẩm liên quan
            if (relatedProducts.size() > 3) {
                relatedProducts = relatedProducts.subList(0, 3);
            }

            model.addAttribute("relatedProducts", relatedProducts);
            return "user/product-detail"; // Trả về file views/user/product-detail.jsp
        }
        
        // Nếu không tìm thấy sản phẩm, quay về trang chủ
        return "redirect:/home";
    }
}
