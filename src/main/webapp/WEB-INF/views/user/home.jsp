<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>TECH STORE - Thế giới máy tính & Linh kiện</title>
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
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

                    /* Hero Banner Section */
                    .hero-banner {
                        background: linear-gradient(135deg, rgba(30, 41, 59, 0.9) 0%, rgba(15, 23, 42, 0.95) 100%);
                        border: 1px solid var(--border-color);
                        border-radius: 24px;
                        padding: 4rem 2rem;
                        position: relative;
                        overflow: hidden;
                        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
                        margin-bottom: 2.5rem;
                    }

                    .hero-banner::before {
                        content: '';
                        position: absolute;
                        width: 300px;
                        height: 300px;
                        background: rgba(139, 92, 246, 0.2);
                        filter: blur(80px);
                        top: -50px;
                        right: -50px;
                        border-radius: 50%;
                    }

                    .hero-title {
                        font-size: 2.75rem;
                        font-weight: 800;
                        line-height: 1.2;
                        background: linear-gradient(to right, #ffffff, #94a3b8);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    /* Search Form Glass Design */
                    .search-container {
                        max-width: 600px;
                        margin-top: 1.5rem;
                    }

                    .search-input {
                        background: rgba(15, 23, 42, 0.6);
                        border: 1px solid var(--border-color);
                        color: white !important;
                        padding: 0.8rem 1.5rem;
                        border-radius: 12px 0 0 12px;
                        font-size: 1rem;
                    }

                    .search-input:focus {
                        background: rgba(15, 23, 42, 0.8);
                        border-color: #3b82f6;
                        box-shadow: 0 0 12px rgba(59, 130, 246, 0.3);
                    }

                    .search-btn {
                        background: var(--primary-gradient);
                        border: none;
                        color: white;
                        padding: 0 1.5rem;
                        border-radius: 0 12px 12px 0;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .search-btn:hover {
                        opacity: 0.95;
                        box-shadow: 0 0 12px rgba(139, 92, 246, 0.4);
                    }

                    /* Catalog Layout */
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

                    .product-card a {
                        text-decoration: none;
                    }

                    .product-card a:hover .product-title {
                        color: #60a5fa;
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
                </style>
            </head>

            <body>

                <!-- Customer Navigation Bar -->
                <nav class="navbar navbar-expand-lg store-navbar navbar-dark">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                            <i class="fa-solid fa-laptop-code me-2"></i>TECH STORE
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#userNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="userNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang
                                        chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/news">Tin tức</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                                </li>
                            </ul>
                            <div class="d-flex align-items-center">
                                <!-- Kiểm tra quyền ADMIN để hiển thị nút quản trị -->
                                <c:set var="isAdmin" value="false" />
                                <c:forEach var="role" items="${sessionScope.currentUser.roles}">
                                    <c:if test="${role.name == 'ADMIN'}">
                                        <c:set var="isAdmin" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${isAdmin}">
                                    <a href="${pageContext.request.contextPath}/admin/products"
                                        class="btn btn-outline-info btn-sm me-3">
                                        <i class="fa-solid fa-lock me-1"></i> Trang quản trị (Admin)
                                    </a>
                                </c:if>

                                <c:if test="${not empty sessionScope.currentUser}">
                                    <a href="${pageContext.request.contextPath}/order/history"
                                        class="btn btn-outline-warning btn-sm me-3">
                                        <i class="fa-solid fa-clock-rotate-left me-1"></i> Đơn mua
                                    </a>
                                </c:if>

                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative me-3">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    <span
                                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                                </a>
                                
                                <!-- Tương tác tài khoản đăng nhập/đăng xuất -->
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

                <!-- Main Container -->
                <div class="container mt-4 mb-5">

                    <!-- Thông báo lỗi phân quyền hoặc lỗi khác -->
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" style="background: rgba(239, 68, 68, 0.15); color: #f87171; border-color: rgba(239, 68, 68, 0.3); border-radius: 12px;">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i> ${sessionScope.errorMessage}
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <!-- Hero Banner with Big Title and Search Bar -->
                    <div class="hero-banner text-center text-md-start">
                        <div class="row align-items-center">
                            <div class="col-lg-7">
                                <h2 class="hero-title mb-3">Tìm kiếm Linh Kiện & Máy Tính mơ ước của bạn</h2>
                                <p class="text-muted fs-5 mb-4">Hệ thống phân phối laptop gaming, máy tính văn phòng và
                                    các linh kiện điện tử chính hãng hàng đầu Việt Nam.</p>

                                <!-- Search Form -->
                                <form action="${pageContext.request.contextPath}/home" method="get">
                                    <!-- Giữ lại CategoryId đang chọn nếu có -->
                                    <c:if test="${not empty selectedCategoryId}">
                                        <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                                    </c:if>
                                    <div class="search-container input-group">
                                        <input type="text" class="form-control search-input" name="keyword"
                                            value="${keyword}" placeholder="Nhập tên laptop, CPU, VGA..."
                                            aria-label="Tìm kiếm sản phẩm">
                                        <button class="btn search-btn" type="submit"><i
                                                class="fa-solid fa-magnifying-glass me-2"></i>Tìm kiếm</button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-lg-5 d-none d-lg-block text-center">
                                <i class="fa-solid fa-computer fa-10x text-white opacity-25"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Sidebar: Danh mục sản phẩm (Trái) -->
                        <div class="col-lg-3 col-md-4 col-12 mb-4">
                            <div class="sidebar-card">
                                <h5 class="fw-bold mb-3 text-white"><i
                                        class="fa-solid fa-bars-staggered me-2 text-primary"></i>Danh mục</h5>
                                <ul class="category-list">
                                    <!-- Tất cả sản phẩm -->
                                    <li>
                                        <a href="${pageContext.request.contextPath}/home?keyword=${keyword != null ? keyword : ''}"
                                            class="category-item-link ${selectedCategoryId == null ? 'active' : ''}">
                                            <span>Tất cả sản phẩm</span>
                                            <i class="fa-solid fa-chevron-right fs-xs"></i>
                                        </a>
                                    </li>
                                    <!-- Duyệt qua danh sách các danh mục -->
                                    <c:forEach var="category" items="${categories}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/home?categoryId=${category.id}&keyword=${keyword != null ? keyword : ''}"
                                                class="category-item-link ${selectedCategoryId == category.id ? 'active' : ''}">
                                                <span>${category.name}</span>
                                                <i class="fa-solid fa-chevron-right fs-xs"></i>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>

                        <!-- List of products (Phải) -->
                        <div class="col-lg-9 col-md-8 col-12">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <h4 class="fw-bold mb-0">Sản phẩm nổi bật</h4>
                                    <c:if test="${not empty keyword}">
                                        <small class="text-muted">Kết quả tìm kiếm cho từ khóa: "<span
                                                class="text-info">${keyword}</span>"</small>
                                    </c:if>
                                </div>
                                <span class="text-muted">Tìm thấy <strong class="text-white">${products != null ?
                                        products.size() : 0}</strong> sản phẩm</span>
                            </div>

                            <!-- Grid view -->
                            <div class="row g-4">
                                <c:choose>
                                    <c:when test="${not empty products}">
                                        <c:forEach var="product" items="${products}">
                                            <div class="col-xl-4 col-md-6 col-sm-12">
                                                <div class="product-card">
                                                    <div class="product-img-wrapper">
                                                        <span
                                                            class="product-badge-category">${product.category.name}</span>
                                                        <a href="${pageContext.request.contextPath}/products/${product.id}" class="w-100 h-100 d-flex align-items-center justify-content-center">
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
                                                        <a href="${pageContext.request.contextPath}/products/${product.id}" class="text-decoration-none">
                                                            <h5 class="product-title" title="${product.name}">${product.name}</h5>
                                                        </a>
                                                        <p class="product-desc" title="${product.description}">
                                                            ${product.description}</p>

                                                        <!-- Trạng thái tồn kho -->
                                                        <div class="stock-indicator">
                                                            <c:choose>
                                                                <c:when test="${product.quantity > 0}">
                                                                    <span class="stock-dot dot-instock"></span>
                                                                    <span class="text-success">Còn hàng
                                                                        (${product.quantity} sản phẩm)</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="stock-dot dot-outstock"></span>
                                                                    <span class="text-danger">Tạm hết hàng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <div class="product-meta">
                                                            <span class="product-price">
                                                                <fmt:formatNumber value="${product.price}"
                                                                    type="currency" currencySymbol=""
                                                                    maxFractionDigits="0" />đ
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${product.quantity > 0}">
                                                                    <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&buyNow=true"
                                                                        class="btn btn-buy">
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
                                        <div class="col-12 text-center py-5 glass-card">
                                            <i class="fa-regular fa-face-frown fa-4x mb-3 text-muted"></i>
                                            <h5 class="text-white">Không tìm thấy sản phẩm nào phù hợp</h5>
                                            <p class="text-muted">Vui lòng thử tìm kiếm bằng một từ khóa khác hoặc
                                                chuyển đổi danh mục.</p>
                                            <a href="${pageContext.request.contextPath}/home"
                                                class="btn btn-gradient mt-3"><i
                                                    class="fa-solid fa-rotate-left me-2"></i>Xem tất cả sản phẩm</a>
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