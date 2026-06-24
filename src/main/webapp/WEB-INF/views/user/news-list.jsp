<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin tức Công nghệ | TECH STORE</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --border-color: rgba(255, 255, 255, 0.08);
            --primary-gradient: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
            --accent-gradient: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --text-main: #f8fafc;
            --text-muted: #cbd5e1;
        }

        .text-muted {
            color: #cbd5e1 !important;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            background-image: 
                radial-gradient(at 0% 0%, rgba(59, 130, 246, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(139, 92, 246, 0.15) 0px, transparent 50%);
            background-attachment: fixed;
        }

        /* Glassmorphism Navbar */
        .store-navbar {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 700;
            letter-spacing: 1px;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* News Article Glass Card */
        .news-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.2);
        }

        .news-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(59, 130, 246, 0.15);
            border-color: rgba(59, 130, 246, 0.3);
        }

        .news-img-wrapper {
            height: 200px;
            overflow: hidden;
            position: relative;
            background: rgba(255,255,255,0.01);
            border-bottom: 1px solid var(--border-color);
        }

        .news-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .news-card:hover .news-img {
            transform: scale(1.05);
        }

        .news-badge-source {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(59, 130, 246, 0.2);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.4);
            font-size: 0.75rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
            backdrop-filter: blur(8px);
        }

        .news-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .news-meta {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
        }

        .news-title {
            font-size: 1.2rem;
            font-weight: 700;
            line-height: 1.4;
            margin-bottom: 0.75rem;
            height: 3.4rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .news-title a {
            color: white;
            text-decoration: none;
            transition: color 0.2s;
        }

        .news-title a:hover {
            color: #60a5fa;
        }

        .news-excerpt {
            color: var(--text-muted);
            font-size: 0.9rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            height: 4.8rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }

        .btn-read-more {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 8px 18px;
            font-size: 0.85rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            align-self: flex-start;
            margin-top: auto;
            transition: opacity 0.2s ease;
        }

        .btn-read-more:hover {
            opacity: 0.9;
            color: white;
        }

        .hero-banner {
            background: linear-gradient(rgba(15,23,42,0.4), rgba(15,23,42,0.85)), url('https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1600') no-repeat center center;
            background-size: cover;
            border-radius: 24px;
            padding: 4rem 2rem;
            text-align: center;
            border: 1px solid var(--border-color);
            margin-bottom: 3rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg store-navbar navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-laptop-code me-2"></i>TECH STORE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="userNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/news">Tin tức</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <!-- Check Admin role -->
                    <c:set var="isAdmin" value="false" />
                    <c:forEach var="role" items="${sessionScope.currentUser.roles}">
                        <c:if test="${role.name == 'ADMIN'}">
                            <c:set var="isAdmin" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${isAdmin}">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-info btn-sm me-3">
                            <i class="fa-solid fa-lock me-1"></i> Trang quản trị (Admin)
                        </a>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative me-3">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                    </a>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-warning btn-sm me-3">
                                <i class="fa-solid fa-clock-rotate-left me-1"></i> Đơn mua
                            </a>
                            <span class="text-white me-3">
                                <i class="fa-solid fa-circle-user text-info me-1"></i> Chào, <strong>${sessionScope.currentUser.username}</strong>
                            </span>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                                <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-gradient btn-sm">
                                <i class="fa-solid fa-user me-1"></i> Đăng ký / Đăng nhập
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content Container -->
    <div class="container mt-5 mb-5">
        
        <!-- Hero Banner -->
        <div class="hero-banner">
            <h1 class="display-5 fw-bold text-white mb-2" style="letter-spacing: 1px;">TIN TỨC CÔNG NGHỆ</h1>
            <p class="fs-5 text-muted mb-0">Cập nhật những chuyển động công nghệ mới nhất từ các trang báo chính thống hàng đầu.</p>
        </div>

        <!-- News articles list -->
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty articles}">
                    <c:forEach var="article" items="${articles}">
                        <div class="col-lg-6 col-12">
                            <div class="news-card">
                                <div class="news-img-wrapper">
                                    <c:choose>
                                        <c:when test="${not empty article.imageUrl}">
                                            <img src="${article.imageUrl}" class="news-img" alt="${article.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="news-img d-flex align-items-center justify-content-center bg-secondary">
                                                <i class="fa-solid fa-newspaper fa-4x text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="news-badge-source">${article.source}</span>
                                </div>
                                <div class="news-body">
                                    <div class="news-meta">
                                        <i class="fa-regular fa-clock me-2"></i>
                                        <span>${article.publishDate.substring(0,10)} ${article.publishDate.substring(11,16)}</span>
                                    </div>
                                    <h3 class="news-title">
                                        <a href="${pageContext.request.contextPath}/news/${article.id}">${article.title}</a>
                                    </h3>
                                    <p class="news-excerpt">${article.summary}</p>
                                    <a href="${pageContext.request.contextPath}/news/${article.id}" class="btn-read-more">
                                        Đọc thêm<i class="fa-solid fa-chevron-right ms-2"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 glass-card">
                        <i class="fa-regular fa-face-frown fa-4x mb-3 text-muted"></i>
                        <h4 class="text-white">Hiện chưa có tin tức công nghệ nào</h4>
                        <p class="text-muted mb-0">Hệ thống đang cập nhật các nguồn báo chính thống, vui lòng quay lại sau.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
