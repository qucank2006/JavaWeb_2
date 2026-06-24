<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thanh toán | TECH STORE</title>
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
            width: 100%;
        }

        .btn-success-gradient:hover {
            opacity: 0.9;
            color: white;
        }

        .form-control {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid var(--border-color);
            color: white;
            border-radius: 10px;
            padding: 10px 15px;
        }

        .form-control:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            color: white;
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .item-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
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

    <!-- Main Checkout Page -->
    <div class="container mt-5 mb-5">
        <h1 class="mb-4" style="font-weight: 700;"><i class="fa-solid fa-circle-check me-3 text-success"></i>Xác nhận thông tin đặt hàng</h1>

        <div class="row">
            <!-- Delivery Info Form -->
            <div class="col-lg-7 col-12 mb-4">
                <div class="glass-card p-4">
                    <h3 class="text-white mb-4"><i class="fa-solid fa-truck-fast me-2 text-primary"></i>Thông tin giao nhận hàng</h3>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="mb-3">
                            <label for="recipientName" class="form-label text-muted">Họ và tên người nhận hàng *</label>
                            <input type="text" class="form-control" id="recipientName" name="recipientName" required placeholder="Nhập đầy đủ họ và tên người nhận">
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label text-muted">Số điện thoại liên hệ *</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required placeholder="Nhập số điện thoại di động">
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label text-muted">Địa chỉ nhận hàng chi tiết *</label>
                            <input type="text" class="form-control" id="address" name="address" required placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố">
                        </div>

                        <div class="mb-4">
                            <label for="note" class="form-label text-muted">Ghi chú thêm (Không bắt buộc)</label>
                            <textarea class="form-control" id="note" name="note" rows="3" placeholder="Ví dụ: Giao hàng giờ hành chính, gọi trước khi giao..."></textarea>
                        </div>

                        <div class="mb-3 p-3 rounded" style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-color);">
                            <span class="text-muted d-block small mb-1">Phương thức thanh toán</span>
                            <span class="text-white fw-bold"><i class="fa-solid fa-money-bill-wave text-success me-2"></i>Thanh toán khi nhận hàng (COD)</span>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light">
                                <i class="fa-solid fa-chevron-left me-2"></i>Quay lại giỏ hàng
                            </a>
                            <button type="submit" class="btn btn-gradient px-4">
                                <i class="fa-solid fa-paper-plane me-2"></i>Hoàn tất đặt hàng
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Order Summary Sidebar -->
            <div class="col-lg-5 col-12">
                <div class="glass-card p-4">
                    <h3 class="summary-title text-white"><i class="fa-solid fa-basket-shopping me-2 text-info"></i>Tóm tắt đơn hàng</h3>
                    
                    <!-- Item List -->
                    <div class="mb-4" style="max-height: 300px; overflow-y: auto;">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="item-row">
                                <div class="d-flex align-items-center">
                                    <div class="small text-muted me-2" style="background: rgba(255,255,255,0.1); width: 24px; height: 24px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; font-weight: 600;">
                                        ${item.quantity}
                                    </div>
                                    <span class="text-white fw-semibold text-truncate" style="max-width: 220px;">
                                        ${item.product.name}
                                    </span>
                                </div>
                                <span class="text-info fw-bold">
                                    <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                </span>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="summary-row text-muted">
                        <span>Số lượng sản phẩm</span>
                        <span class="text-white fw-bold">${cart.totalQuantity} món</span>
                    </div>

                    <div class="summary-row text-muted">
                        <span>Hình thức vận chuyển</span>
                        <span class="text-success fw-bold">Miễn phí giao hàng</span>
                    </div>

                    <div class="summary-row summary-total">
                        <span>Tổng tiền cần thanh toán</span>
                        <span>
                            <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
