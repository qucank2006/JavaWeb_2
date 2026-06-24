package com.example.javaweb.service;

import com.example.javaweb.entity.NewsArticle;
import java.util.List;
import java.util.Optional;

public interface NewsArticleService {
    List<NewsArticle> findAll();
    Optional<NewsArticle> findById(Long id);
}
