<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn | TECH STORE</title>
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

        /* Glass Cards */
        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .table {
            color: var(--text-main);
            vertical-align: middle;
        }

        .table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            border-bottom: 2px solid var(--border-color);
            background: transparent;
        }

        .table td {
            border-bottom: 1px solid var(--border-color);
            background: transparent;
            padding: 1.2rem 0.75rem;
        }

        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: rgba(255, 255, 255, 0.02);
        }

        .product-title {
            font-weight: 600;
            font-size: 1.05rem;
            color: white;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .product-title:hover {
            color: #60a5fa;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 12px 24px;
            transition: opacity 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-gradient:hover {
            opacity: 0.9;
            color: white;
        }

        .btn-success-gradient {
            background: var(--accent-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 12px 24px;
            transition: opacity 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-success-gradient:hover {
            opacity: 0.9;
            color: white;
        }

        .btn-action {
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-remove {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-remove:hover {
            background: #ef4444;
            color: white;
        }

        .summary-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.75rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .summary-total {
            font-size: 1.4rem;
            font-weight: 700;
            color: #34d399;
            border-top: 1px dashed var(--border-color);
            padding-top: 1rem;
            margin-top: 1rem;
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

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative me-3 active">
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

    <!-- Main Cart Area -->
    <div class="container mt-5 mb-5">
        <h1 class="mb-4" style="font-weight: 700;"><i class="fa-solid fa-cart-shopping me-3 text-primary"></i>Giỏ hàng của bạn</h1>

        <!-- Feedback Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" style="background: rgba(239, 68, 68, 0.15); color: #f87171; border-color: rgba(239, 68, 68, 0.3);">
                <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border-color: rgba(16, 185, 129, 0.3);">
                <i class="fa-solid fa-circle-check me-2"></i> ${success}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty cart or empty cart.items}">
                <!-- Empty Cart Alert -->
                <div class="glass-card text-center py-5 px-4 mb-4">
                    <div class="mb-4">
                        <i class="fa-regular fa-folder-open fa-4x text-muted"></i>
                    </div>
                    <h3 class="text-white mb-3">Giỏ hàng của bạn đang trống!</h3>
                    <p class="text-muted mb-4">Bạn chưa chọn sản phẩm nào. Hãy khám phá và mua sắm ngay tại Tech Store.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-gradient">
                        <i class="fa-solid fa-bag-shopping me-2"></i>Khám phá sản phẩm
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <!-- Cart List -->
                    <div class="col-lg-8 col-12 mb-4">
                        <div class="glass-card p-4">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Giá bán</th>
                                            <th class="text-center" style="width: 150px;">Số lượng</th>
                                            <th>Thành tiền</th>
                                            <th class="text-center" style="width: 60px;">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart.items}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${not empty item.product.image}">
                                                                <img src="${pageContext.request.contextPath}${item.product.image}" class="product-img me-3" alt="${item.product.name}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="product-img me-3 d-flex align-items-center justify-content-center bg-secondary">
                                                                    <i class="fa-solid fa-image text-muted"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/products/${item.product.id}" class="product-title d-block mb-1">${item.product.name}</a>
                                                            <span class="text-muted small">Tồn kho: ${item.product.quantity} sản phẩm</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="fw-semibold text-white">
                                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                                    </span>
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex align-items-center justify-content-center">
                                                        <input type="hidden" name="productId" value="${item.product.id}">
                                                        <button type="button" class="btn btn-sm btn-outline-light px-2" style="border-radius: 6px 0 0 6px;" onclick="changeQty(this, -1)">-</button>
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" 
                                                               class="form-control form-control-sm text-center mx-0" 
                                                               style="width: 50px; background: rgba(0,0,0,0.25); color: white; border-top: 1px solid var(--border-color); border-bottom: 1px solid var(--border-color); border-left: none; border-right: none; border-radius: 0; box-shadow: none;" 
                                                               onchange="this.form.submit()">
                                                        <button type="button" class="btn btn-sm btn-outline-light px-2" style="border-radius: 0 6px 6px 0;" onclick="changeQty(this, 1)">+</button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <span class="fw-bold text-info">
                                                        <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cart/remove/${item.product.id}" class="btn-action btn-remove" title="Xóa khỏi giỏ hàng">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-light btn-sm">
                                    <i class="fa-solid fa-arrow-left me-2"></i>Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Cart Summary -->
                    <div class="col-lg-4 col-12">
                        <div class="glass-card p-4">
                            <h3 class="summary-title text-white"><i class="fa-solid fa-receipt me-2 text-success"></i>Tóm tắt giỏ hàng</h3>
                            
                            <div class="summary-row text-muted">
                                <span>Tổng số lượng mặt hàng</span>
                                <span class="text-white fw-bold">${cart.totalQuantity}</span>
                            </div>
                            
                            <div class="summary-row text-muted">
                                <span>Phí giao hàng</span>
                                <span class="text-success fw-bold">Miễn phí</span>
                            </div>

                            <div class="summary-row summary-total">
                                <span>Tổng thanh toán</span>
                                <span>
                                    <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                </span>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success-gradient">
                                    <i class="fa-solid fa-circle-check me-2"></i>Tiến hành đặt hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Script to adjust qty -->
    <script>
        function changeQty(btn, change) {
            var input = btn.parentNode.querySelector('input[name="quantity"]');
            var val = parseInt(input.value) + change;
            var max = parseInt(input.getAttribute('max'));
            if (val >= 1 && val <= max) {
                input.value = val;
                btn.form.submit();
            }
        }
    </script>
</body>
</html>
