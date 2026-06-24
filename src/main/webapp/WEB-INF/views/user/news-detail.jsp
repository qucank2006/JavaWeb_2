<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${article.title} | TECH STORE</title>
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

        /* Breadcrumb Glass Design */
        .breadcrumb-container {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            margin-bottom: 2rem;
        }

        .breadcrumb-item a {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb-item a:hover {
            text-decoration: underline;
        }

        /* Detail Glass Card */
        .detail-glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
            padding: 2.5rem;
        }

        .article-meta-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .article-source-tag {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
        }

        .article-banner-img {
            width: 100%;
            height: 350px;
            object-fit: cover;
            border-radius: 16px;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .article-summary-box {
            background: rgba(255, 255, 255, 0.03);
            border-left: 4px solid #3b82f6;
            padding: 1.25rem 1.5rem;
            border-radius: 0 12px 12px 0;
            margin-bottom: 2rem;
            font-size: 1.05rem;
            font-style: italic;
            line-height: 1.6;
            color: #e2e8f0;
        }

        .article-text-content {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #e2e8f0;
        }

        .article-text-content p {
            margin-bottom: 1.5rem;
            text-align: justify;
        }

        .source-link-card {
            background: rgba(16, 185, 129, 0.05);
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .btn-source-link {
            background: var(--accent-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 20px;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .btn-source-link:hover {
            opacity: 0.9;
            color: white;
        }

        /* Sidebar Related Articles */
        .sidebar-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 1.5rem;
            position: sticky;
            top: 90px;
        }

        .sidebar-title {
            font-weight: 700;
            font-size: 1.2rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
            margin-bottom: 1.25rem;
            color: white;
        }

        .sidebar-item {
            display: flex;
            gap: 12px;
            margin-bottom: 1.25rem;
            padding-bottom: 1.25rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
        }

        .sidebar-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .sidebar-item-img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }

        .sidebar-item-title {
            font-size: 0.9rem;
            font-weight: 600;
            line-height: 1.4;
            height: 2.5rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .sidebar-item-title a {
            color: white;
            text-decoration: none;
            transition: color 0.2s;
        }

        .sidebar-item-title a:hover {
            color: #60a5fa;
        }

        .sidebar-item-meta {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 4px;
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
    <div class="container mt-4 mb-5">
        
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-container mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
                <li class="breadcrumb-item active" aria-current="page">${article.title}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Left: Article Content -->
            <div class="col-lg-8 col-12 mb-4">
                <div class="detail-glass-card">
                    <h1 class="fw-bold mb-3 text-white" style="font-size: 2rem; line-height: 1.35;">${article.title}</h1>
                    
                    <!-- Meta Row -->
                    <div class="article-meta-row">
                        <div>
                            <i class="fa-regular fa-clock me-2"></i>
                            <span>${article.publishDate.substring(0,10)} ${article.publishDate.substring(11,16)}</span>
                        </div>
                        <div>
                            <span>Nguồn: </span>
                            <span class="article-source-tag">${article.source}</span>
                        </div>
                    </div>

                    <!-- Banner Image -->
                    <c:if test="${not empty article.imageUrl}">
                        <img src="${article.imageUrl}" class="article-banner-img" alt="${article.title}">
                    </c:if>

                    <!-- Summary Block -->
                    <c:if test="${not empty article.summary}">
                        <div class="article-summary-box">
                            <strong>Tóm tắt:</strong> ${article.summary}
                        </div>
                    </c:if>

                    <!-- Excerpt Content text -->
                    <div class="article-text-content">
                        <p>${article.content}</p>
                    </div>

                    <!-- External Source Redirection Link -->
                    <c:if test="${not empty article.sourceUrl}">
                        <div class="source-link-card">
                            <div>
                                <h6 class="text-white mb-1 fw-bold"><i class="fa-solid fa-square-rss text-warning me-2"></i>Xem thông tin gốc</h6>
                                <p class="text-muted small mb-0">Bài viết được đăng tải chính thức trên kênh báo chí công nghệ ${article.source}.</p>
                            </div>
                            <a href="${article.sourceUrl}" target="_blank" rel="noopener noreferrer" class="btn-source-link">
                                Truy cập bài báo gốc<i class="fa-solid fa-arrow-up-right-from-square ms-2"></i>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Right: Related Articles Sidebar -->
            <div class="col-lg-4 col-12">
                <div class="sidebar-card">
                    <h4 class="sidebar-title"><i class="fa-solid fa-fire text-danger me-2"></i>Tin khác mới đăng</h4>
                    
                    <c:forEach var="related" items="${relatedArticles}">
                        <div class="sidebar-item">
                            <c:if test="${not empty related.imageUrl}">
                                <img src="${related.imageUrl}" class="sidebar-item-img" alt="${related.title}">
                            </c:if>
                            <div>
                                <h5 class="sidebar-item-title">
                                    <a href="${pageContext.request.contextPath}/news/${related.id}">${related.title}</a>
                                </h5>
                                <div class="sidebar-item-meta">
                                    <span class="badge bg-secondary me-1" style="font-size: 0.65rem;">${related.source}</span>
                                    <span>${related.publishDate.substring(0,10)}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>

</body>
</html>
