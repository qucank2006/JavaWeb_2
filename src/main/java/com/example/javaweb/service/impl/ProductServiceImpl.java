package com.example.javaweb.service.impl;

import com.example.javaweb.entity.Product;
import com.example.javaweb.repository.ProductRepository;
import com.example.javaweb.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    @Transactional
    public Product save(Product product) {
        // Có thể thêm logic validation hoặc xử lý nghiệp vụ ở đây
        return productRepository.save(product);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> searchProducts(String name, Long categoryId) {
        // Xử lý trường hợp name là null hoặc rỗng để tìm tất cả
        if (name == null || name.trim().isEmpty()) {
            name = "";
        }
        return productRepository.searchByNameAndCategory(name, categoryId);
    }
}
