package com.example.javaweb.controller.user;

import com.example.javaweb.entity.NewsArticle;
import com.example.javaweb.service.NewsArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/news")
public class NewsController {

    private final NewsArticleService newsArticleService;

    @Autowired
    public NewsController(NewsArticleService newsArticleService) {
        this.newsArticleService = newsArticleService;
    }

    /**
     * Hiển thị danh sách tin tức công nghệ
     */
    @GetMapping
    public String listNews(Model model) {
        List<NewsArticle> articles = newsArticleService.findAll();
        model.addAttribute("articles", articles);
        return "user/news-list"; // views/user/news-list.jsp
    }

    /**
     * Chi tiết bài viết tin tức
     */
    @GetMapping("/{id}")
    public String viewArticle(@PathVariable("id") Long id, Model model) {
        Optional<NewsArticle> articleOpt = newsArticleService.findById(id);
        if (articleOpt.isEmpty()) {
            return "redirect:/news";
        }

        NewsArticle article = articleOpt.get();
        model.addAttribute("article", article);

        // Lấy 3 tin khác làm phần "Bài viết liên quan"
        List<NewsArticle> allArticles = newsArticleService.findAll();
        List<NewsArticle> relatedArticles = allArticles.stream()
                .filter(a -> !a.getId().equals(id))
                .limit(3)
                .toList();
        model.addAttribute("relatedArticles", relatedArticles);

        return "user/news-detail"; // views/user/news-detail.jsp
    }
}
