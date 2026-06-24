package com.example.javaweb.repository;

import com.example.javaweb.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    /**
     * Tìm kiếm sản phẩm theo tên (không phân biệt chữ hoa, chữ thường)
     * và theo categoryId.
     * @param name Tên sản phẩm để tìm kiếm (một phần hoặc toàn bộ)
     * @param categoryId ID của danh mục
     * @return Danh sách sản phẩm phù hợp
     */
    @Query("SELECT p FROM Product p WHERE " +
           "LOWER(p.name) LIKE LOWER(CONCAT('%', :name, '%')) AND " +
           "(:categoryId IS NULL OR p.category.id = :categoryId)")
    List<Product> searchByNameAndCategory(@Param("name") String name, @Param("categoryId") Long categoryId);
}
