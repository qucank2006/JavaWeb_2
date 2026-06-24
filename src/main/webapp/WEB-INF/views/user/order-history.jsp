<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng | TECH STORE</title>
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

        .btn-gradient {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 20px;
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

        .order-card {
            margin-bottom: 1.5rem;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.75rem;
            margin-bottom: 1rem;
        }

        .order-id {
            font-size: 1.1rem;
            font-weight: 700;
            color: white;
        }

        .order-date {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .detail-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed rgba(255, 255, 255, 0.04);
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .badge-pending {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.3);
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
        }

        .badge-completed {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
        }

        .badge-paid {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
        }

        .badge-cancelled {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 8px;
        }

        .delivery-meta {
            font-size: 0.9rem;
            background: rgba(15, 23, 42, 0.3);
            border-radius: 12px;
            padding: 12px 16px;
            margin-top: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.02);
        }

        .delivery-row {
            display: flex;
            margin-bottom: 4px;
        }

        .delivery-row:last-child {
            margin-bottom: 0;
        }

        .delivery-label {
            color: var(--text-muted);
            min-width: 110px;
        }

        .delivery-value {
            color: white;
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

    <!-- Main Order History Content -->
    <div class="container mt-5 mb-5" style="max-width: 800px;">
        <h1 class="mb-4" style="font-weight: 700;"><i class="fa-solid fa-clock-rotate-left me-3 text-primary"></i>Lịch sử đơn mua hàng</h1>

        <c:choose>
            <c:when test="${empty orders}">
                <!-- No Orders -->
                <div class="glass-card text-center py-5 px-4">
                    <div class="mb-4">
                        <i class="fa-solid fa-receipt fa-4x text-muted"></i>
                    </div>
                    <h3 class="text-white mb-3">Bạn chưa đặt đơn hàng nào!</h3>
                    <p class="text-muted mb-4">Các đơn hàng đã mua của bạn sẽ xuất hiện tại đây.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-gradient">
                        <i class="fa-solid fa-bag-shopping me-2"></i>Mua sắm ngay
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Loop Orders -->
                <c:forEach var="order" items="${orders}">
                    <div class="glass-card p-4 order-card">
                        <!-- Order Header -->
                        <div class="order-header">
                            <div>
                                <span class="order-id">Đơn hàng #${order.id}</span>
                                <span class="order-date ms-3">
                                    <i class="fa-regular fa-calendar me-1"></i>
                                    ${order.orderDate.toString().substring(0,10)} ${order.orderDate.toString().substring(11,16)}
                                </span>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="badge-pending"><i class="fa-solid fa-clock me-1"></i>Chờ xử lý</span>
                                    </c:when>
                                    <c:when test="${order.status == 'PAID'}">
                                        <span class="badge-paid"><i class="fa-solid fa-circle-dollar-to-slot me-1"></i>Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${order.status == 'COMPLETED'}">
                                        <span class="badge-completed"><i class="fa-solid fa-circle-check me-1"></i>Đã giao</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-cancelled"><i class="fa-solid fa-ban me-1"></i>Đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Order Products -->
                        <div class="order-details-items">
                            <c:forEach var="detail" items="${order.orderDetails}">
                                <div class="detail-item">
                                    <div>
                                        <span class="text-white fw-semibold">${detail.product.name}</span>
                                        <span class="text-muted ms-2">x${detail.quantity}</span>
                                    </div>
                                    <span class="text-info fw-bold">
                                        <fmt:formatNumber value="${detail.price * detail.quantity}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                    </span>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Delivery Meta -->
                        <div class="delivery-meta">
                            <div class="delivery-row">
                                <span class="delivery-label">Người nhận:</span>
                                <span class="delivery-value">${order.recipientName}</span>
                            </div>
                            <div class="delivery-row">
                                <span class="delivery-label">Số điện thoại:</span>
                                <span class="delivery-value">${order.phone}</span>
                            </div>
                            <div class="delivery-row">
                                <span class="delivery-label">Địa chỉ nhận:</span>
                                <span class="delivery-value">${order.address}</span>
                            </div>
                            <c:if test="${not empty order.note}">
                                <div class="delivery-row">
                                    <span class="delivery-label">Ghi chú:</span>
                                    <span class="delivery-value" style="font-style: italic;">"${order.note}"</span>
                                </div>
                            </c:if>
                        </div>

                        <!-- Order Total Footer -->
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3" style="border-top: 1px dashed var(--border-color);">
                            <span class="text-muted">Phương thức: <strong class="text-white">COD</strong></span>
                            <div>
                                <span class="text-muted me-2">Tổng tiền:</span>
                                <span class="text-success fw-bold fs-5">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
