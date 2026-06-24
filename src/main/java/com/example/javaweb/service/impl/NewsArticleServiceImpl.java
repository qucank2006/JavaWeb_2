package com.example.javaweb.service.impl;

import com.example.javaweb.entity.NewsArticle;
import com.example.javaweb.repository.NewsArticleRepository;
import com.example.javaweb.service.NewsArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class NewsArticleServiceImpl implements NewsArticleService {

    private final NewsArticleRepository newsArticleRepository;

    @Autowired
    public NewsArticleServiceImpl(NewsArticleRepository newsArticleRepository) {
        this.newsArticleRepository = newsArticleRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<NewsArticle> findAll() {
        return newsArticleRepository.findAll(Sort.by(Sort.Direction.DESC, "publishDate"));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<NewsArticle> findById(Long id) {
        return newsArticleRepository.findById(id);
    }
}
