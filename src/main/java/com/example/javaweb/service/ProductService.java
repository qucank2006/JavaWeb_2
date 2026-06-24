package com.example.javaweb.service;

import com.example.javaweb.entity.Product;
import java.util.List;
import java.util.Optional;

public interface ProductService {

    List<Product> findAll();

    Optional<Product> findById(Long id);

    Product save(Product product);

    void deleteById(Long id);

    List<Product> searchProducts(String name, Long categoryId);
}
