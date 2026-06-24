<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} | TECH STORE</title>
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

        .breadcrumb-item.active {
            color: var(--text-muted);
        }

        /* Detail Layout Cards */
        .detail-glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
            padding: 2.5rem;
        }

        .product-img-large-wrapper {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 380px;
            overflow: hidden;
        }

        .product-img-large {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 8px;
        }

        .product-badge-category {
            background: rgba(139, 92, 246, 0.2);
            color: #c084fc;
            border: 1px solid rgba(139, 92, 246, 0.4);
            font-size: 0.85rem;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 8px;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .product-price-tag {
            font-size: 2rem;
            font-weight: 800;
            color: #60a5fa;
            margin: 1.5rem 0;
            display: block;
        }

        .btn-buy-large {
            background: var(--primary-gradient);
            color: white !important;
            font-weight: 700;
            border: none;
            border-radius: 12px;
            padding: 0.9rem 2.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(59, 130, 246, 0.3);
            width: 100%;
            max-width: 300px;
        }

        .btn-buy-large:hover {
            opacity: 0.95;
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(139, 92, 246, 0.5);
        }

        .spec-title {
            font-weight: 700;
            font-size: 1.25rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
            color: white;
        }

        .description-content {
            color: var(--text-muted);
            line-height: 1.7;
            font-size: 1rem;
        }

        /* Stock indicator */
        .stock-status-box {
            display: flex;
            align-items: center;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .stock-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
        }

        .dot-instock {
            background-color: #10b981;
        }

        .dot-outstock {
            background-color: #ef4444;
        }

        /* Related Products Section */
        .related-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: all 0.3s ease;
        }

        .related-card:hover {
            transform: translateY(-6px);
            border-color: rgba(59, 130, 246, 0.3);
        }

        .related-img-wrapper {
            background: rgba(255, 255, 255, 0.02);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid var(--border-color);
        }

        .related-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .related-info {
            padding: 1rem;
        }

        .related-title {
            font-size: 0.95rem;
            font-weight: 600;
            color: white;
            margin-bottom: 0.5rem;
            height: 2.5rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            text-decoration: none;
            transition: color 0.2s;
        }

        .related-title:hover {
            color: #60a5fa;
        }

        .related-price {
            color: #60a5fa;
            font-weight: 700;
            font-size: 1.05rem;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            color: white !important;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            padding: 8px 18px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.2);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-gradient:hover {
            opacity: 0.95;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.4);
            color: white !important;
        }
    </style>
</head>
<body>

    <!-- Customer Navigation Bar -->
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/news">Tin tức</a>
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

                    <c:if test="${not empty sessionScope.currentUser}">
                        <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-warning btn-sm me-3">
                            <i class="fa-solid fa-clock-rotate-left me-1"></i> Đơn mua
                        </a>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative me-3">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                    </a>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?categoryId=${product.category.id}">${product.category.name}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
            </ol>
        </nav>

        <!-- Product detail content card -->
        <div class="detail-glass-card mb-5">
            <div class="row g-5">
                <!-- Left: Large Image wrapper -->
                <div class="col-lg-5 col-12">
                    <div class="product-img-large-wrapper">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="${pageContext.request.contextPath}${product.image}" class="product-img-large" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-laptop fa-10x text-muted opacity-25"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Right: Product Info details -->
                <div class="col-lg-7 col-12">
                    <span class="product-badge-category">${product.category.name}</span>
                    <h2 class="fw-bold mb-3 text-white">${product.name}</h2>
                    
                    <!-- Stock details -->
                    <div class="stock-status-box">
                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <span class="stock-dot dot-instock"></span>
                                <span class="text-success">Còn hàng trong kho (${product.quantity} cái)</span>
                            </c:when>
                            <c:otherwise>
                                <span class="stock-dot dot-outstock"></span>
                                <span class="text-danger">Tạm hết hàng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <span class="product-price-tag">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                    </span>

                    <c:choose>
                        <c:when test="${product.quantity > 0}">
                            <div class="d-flex flex-wrap gap-3">
                                <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&buyNow=true" class="btn btn-buy-large text-center">
                                    <i class="fa-solid fa-cart-shopping me-2"></i> MUA NGAY
                                </a>
                                <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}" class="btn btn-outline-light text-center py-2 px-4" style="border-radius: 12px; font-weight: 600; font-size: 1.1rem; display: inline-flex; align-items: center; justify-content: center; border: 1px solid var(--border-color); background: rgba(255,255,255,0.02); max-width: 300px; width: 100%;">
                                    <i class="fa-solid fa-cart-plus me-2"></i> Thêm vào giỏ hàng
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-buy-large disabled" disabled style="opacity: 0.6; cursor: not-allowed;">
                                <i class="fa-solid fa-ban me-2"></i> HẾT HÀNG
                            </button>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="mt-4 pt-4 border-top border-secondary">
                        <div class="d-flex align-items-center text-muted" style="font-size: 0.9rem;">
                            <span class="me-4"><i class="fa-solid fa-shield-halved text-primary me-1"></i> Bảo hành 24 tháng chính hãng</span>
                            <span><i class="fa-solid fa-truck text-success me-1"></i> Giao hàng toàn quốc miễn phí</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Specifications & Description -->
        <div class="detail-glass-card mb-5">
            <h4 class="spec-title">Thông số kĩ thuật & Mô tả chi tiết</h4>
            <div class="description-content">
                <c:choose>
                    <c:when test="${not empty product.description}">
                        <p style="white-space: pre-line;">${product.description}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">Chưa có thông tin mô tả chi tiết cho sản phẩm này.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Related products section -->
        <c:if test="${not empty relatedProducts}">
            <div class="mb-5">
                <h4 class="fw-bold mb-4"><i class="fa-solid fa-lightbulb text-warning me-2"></i>Sản phẩm liên quan</h4>
                <div class="row g-4">
                    <c:forEach var="related" items="${relatedProducts}">
                        <div class="col-lg-4 col-md-6 col-12">
                            <div class="related-card">
                                <div class="related-img-wrapper">
                                    <a href="${pageContext.request.contextPath}/products/${related.id}" class="w-100 h-100">
                                        <c:choose>
                                            <c:when test="${not empty related.image}">
                                                <img src="${pageContext.request.contextPath}${related.image}" class="related-img" alt="${related.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-laptop fa-4x text-muted opacity-50"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                                <div class="related-info">
                                    <a href="${pageContext.request.contextPath}/products/${related.id}" class="related-title" title="${related.name}">
                                        ${related.name}
                                    </a>
                                    <div class="d-flex align-items-center justify-content-between mt-3">
                                        <span class="related-price">
                                            <fmt:formatNumber value="${related.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                        </span>
                                        <a href="${pageContext.request.contextPath}/products/${related.id}" class="btn btn-buy btn-sm">Xem ngay</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        
    </div>

    <!-- Bootstrap 5 JavaScript & Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
