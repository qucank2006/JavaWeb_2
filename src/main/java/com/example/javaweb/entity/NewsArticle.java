package com.example.javaweb.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "news_article")
public class NewsArticle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Lob
    @Column(name = "content", columnDefinition = "LONGTEXT")
    private String content;

    @Column(name = "summary", length = 1000)
    private String summary;

    @Column(name = "source")
    private String source; // e.g. "VnExpress", "Tinhte", "GenK"

    @Column(name = "source_url", length = 500)
    private String sourceUrl;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @Column(name = "publish_date")
    private LocalDateTime publishDate;

    // Default constructor
    public NewsArticle() {
    }

    // Parameterized constructor
    public NewsArticle(String title, String content, String summary, String source, String sourceUrl, String imageUrl, LocalDateTime publishDate) {
        this.title = title;
        this.content = content;
        this.summary = summary;
        this.source = source;
        this.sourceUrl = sourceUrl;
        this.imageUrl = imageUrl;
        this.publishDate = publishDate;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getSourceUrl() {
        return sourceUrl;
    }

    public void setSourceUrl(String sourceUrl) {
        this.sourceUrl = sourceUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getPublishDate() {
        return publishDate.toString();
    }

    public LocalDateTime getPublishDateRaw() {
        return publishDate;
    }

    public void setPublishDate(LocalDateTime publishDate) {
        this.publishDate = publishDate;
    }
}
