<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm | TECH STORE</title>
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

        /* Sidebar Glass Design */
        .sidebar-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1.5rem;
            position: sticky;
            top: 90px;
            z-index: 10;
        }

        .category-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .category-item-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: var(--text-muted);
            text-decoration: none;
            padding: 0.65rem 1rem;
            border-radius: 10px;
            transition: all 0.25s ease;
            margin-bottom: 0.4rem;
            font-weight: 500;
        }

        .category-item-link:hover,
        .category-item-link.active {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            transform: translateX(4px);
        }

        .category-item-link.active {
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        /* Product Card Glassmorphism */
        .product-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(59, 130, 246, 0.15);
            border-color: rgba(59, 130, 246, 0.4);
        }

        .product-img-wrapper {
            background: rgba(255, 255, 255, 0.02);
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid var(--border-color);
            position: relative;
        }

        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-badge-category {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(139, 92, 246, 0.2);
            color: #c084fc;
            border: 1px solid rgba(139, 92, 246, 0.4);
            font-size: 0.75rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
            backdrop-filter: blur(8px);
        }

        .product-info {
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-title-link {
            text-decoration: none;
        }

        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 0.5rem;
            height: 2.6rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            transition: color 0.2s;
        }

        .product-title:hover {
            color: #60a5fa;
        }

        .product-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
            flex-grow: 1;
            height: 2.4rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }

        .product-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #60a5fa;
        }

        .btn-buy {
            background: var(--primary-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 10px;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .btn-buy:hover {
            opacity: 0.9;
            transform: scale(1.05);
            color: white;
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

        .stock-indicator {
            font-size: 0.8rem;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
        }

        .stock-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }

        .dot-instock {
            background-color: #10b981;
        }

        .dot-outstock {
            background-color: #ef4444;
        }

        /* Filter Controls */
        .filter-bar {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1rem 1.5rem;
        }

        .form-select, .form-control {
            background-color: rgba(15, 23, 42, 0.6);
            border: 1px solid var(--border-color);
            color: white !important;
            border-radius: 10px;
        }

        .form-select:focus, .form-control:focus {
            background-color: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            box-shadow: 0 0 8px rgba(59, 130, 246, 0.3);
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
                    <!-- Check Admin permissions -->
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
        
        <!-- Filter and Search Header -->
        <div class="filter-bar mb-4">
            <form action="${pageContext.request.contextPath}/products" method="get" id="filterForm">
                <!-- Keep selected category filter if clicking sorting -->
                <c:if test="${not empty selectedCategoryId}">
                    <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                </c:if>
                <div class="row g-3 align-items-center">
                    <div class="col-lg-5 col-md-6 col-12">
                        <div class="input-group">
                            <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Nhập tên sản phẩm cần tìm...">
                            <button class="btn btn-gradient" type="submit"><i class="fa-solid fa-magnifying-glass me-2"></i>Tìm kiếm</button>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-3 col-6 ms-auto">
                        <div class="d-flex align-items-center">
                            <label for="sortBy" class="me-2 text-nowrap text-muted" style="font-size: 0.9rem;">Sắp xếp:</label>
                            <select class="form-select" id="sortBy" name="sortBy" onchange="document.getElementById('filterForm').submit()">
                                <option value="" ${empty sortBy ? 'selected' : ''}>Mặc định</option>
                                <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                                <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="row">
            <!-- Sidebar Left: Categories filter -->
            <div class="col-lg-3 col-md-4 col-12 mb-4">
                <div class="sidebar-card">
                    <h5 class="fw-bold mb-3 text-white">
                        <i class="fa-solid fa-bars-staggered me-2 text-primary"></i>Danh mục sản phẩm
                    </h5>
                    <ul class="category-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/products?keyword=${keyword != null ? keyword : ''}&sortBy=${sortBy != null ? sortBy : ''}" 
                               class="category-item-link ${selectedCategoryId == null ? 'active' : ''}">
                                <span>Tất cả sản phẩm</span>
                                <i class="fa-solid fa-chevron-right fs-xs"></i>
                            </a>
                        </li>
                        <c:forEach var="category" items="${categories}">
                            <li>
                                <a href="${pageContext.request.contextPath}/products?categoryId=${category.id}&keyword=${keyword != null ? keyword : ''}&sortBy=${sortBy != null ? sortBy : ''}" 
                                   class="category-item-link ${selectedCategoryId == category.id ? 'active' : ''}">
                                    <span>${category.name}</span>
                                    <i class="fa-solid fa-chevron-right fs-xs"></i>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <!-- Main Area: Grid of products -->
            <div class="col-lg-9 col-md-8 col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0">Bộ sưu tập sản phẩm</h4>
                    <span class="text-muted">Tìm thấy <strong class="text-white">${products != null ? products.size() : 0}</strong> sản phẩm</span>
                </div>

                <div class="row g-4">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="product" items="${products}">
                                <div class="col-xl-4 col-md-6 col-sm-12">
                                    <div class="product-card">
                                        <div class="product-img-wrapper">
                                            <span class="product-badge-category">${product.category.name}</span>
                                            <a href="${pageContext.request.contextPath}/products/${product.id}" class="w-100 h-100">
                                                <c:choose>
                                                    <c:when test="${not empty product.image}">
                                                        <img src="${pageContext.request.contextPath}${product.image}" class="product-img" alt="${product.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa-solid fa-laptop fa-5x text-muted opacity-50"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>
                                        <div class="product-info">
                                            <a href="${pageContext.request.contextPath}/products/${product.id}" class="product-title-link">
                                                <h5 class="product-title" title="${product.name}">${product.name}</h5>
                                            </a>
                                            <p class="product-desc" title="${product.description}">${product.description}</p>
                                            
                                            <!-- Stock indicator -->
                                            <div class="stock-indicator">
                                                <c:choose>
                                                    <c:when test="${product.quantity > 0}">
                                                        <span class="stock-dot dot-instock"></span>
                                                        <span class="text-success">Còn hàng (${product.quantity} sản phẩm)</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="stock-dot dot-outstock"></span>
                                                        <span class="text-danger">Tạm hết hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="product-meta">
                                                <span class="product-price">
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                                </span>
                                                <c:choose>
                                                    <c:when test="${product.quantity > 0}">
                                                        <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&buyNow=true" class="btn btn-buy">
                                                            <i class="fa-solid fa-cart-plus me-1"></i> Mua ngay
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-buy disabled" disabled>
                                                            <i class="fa-solid fa-cart-plus me-1"></i> Mua ngay
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center py-5 sidebar-card">
                                <i class="fa-regular fa-face-frown fa-4x mb-3 text-muted"></i>
                                <h5 class="text-white">Không tìm thấy sản phẩm nào phù hợp</h5>
                                <p class="text-muted">Vui lòng thử tìm kiếm bằng một từ khóa khác hoặc thay đổi danh mục.</p>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-gradient mt-3">
                                    <i class="fa-solid fa-rotate-left me-2"></i>Xem tất cả sản phẩm
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript & Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
