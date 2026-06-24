<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng | Kênh Admin</title>
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
            --accent-color: #10b981;
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
        .admin-navbar {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
        }

        .navbar-brand {
            font-weight: 700;
            letter-spacing: 1px;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            box-shadow: 0 12px 40px 0 rgba(59, 130, 246, 0.15);
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

        /* Badges */
        .badge-pending {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-paid {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-completed {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-cancelled {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        /* Action Buttons */
        .btn-action-text {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 6px 10px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s ease;
            margin-bottom: 4px;
        }

        .btn-pay-status {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .btn-pay-status:hover {
            background: #3b82f6;
            color: white;
        }

        .btn-complete-status {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .btn-complete-status:hover {
            background: #10b981;
            color: white;
        }

        .btn-cancel-status {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-cancel-status:hover {
            background: #ef4444;
            color: white;
        }

        .page-header-title {
            font-size: 1.75rem;
            font-weight: 700;
        }

        .delivery-info {
            font-size: 0.85rem;
            line-height: 1.4;
        }

        .detail-list {
            font-size: 0.85rem;
            list-style: none;
            padding-left: 0;
            margin-bottom: 0;
        }

        .detail-item {
            border-bottom: 1px dashed rgba(255,255,255,0.03);
            padding: 3px 0;
        }

        .detail-item:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>

    <!-- Admin Navigation Bar -->
    <nav class="navbar navbar-expand-lg admin-navbar navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-laptop-code me-2"></i>TECH STORE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box me-1"></i> Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul me-1"></i> Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-1"></i> Người dùng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice-dollar me-1"></i> Đơn hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-chart-line me-1"></i> Thống kê</a>
                    </li>
                </ul>
                <div class="d-flex text-muted align-items-center">
                    <span class="text-white me-3">
                        <i class="fa-solid fa-user-shield text-info me-1"></i> Admin: <strong>${sessionScope.currentUser.username}</strong>
                    </span>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2">
                        <i class="fa-solid fa-store me-1"></i> Về cửa hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                        <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container mb-5">
        
        <!-- Alerts for feedback messages -->
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

        <div class="row mb-4 align-items-center">
            <div class="col-12">
                <h1 class="page-header-title mb-1"><i class="fa-solid fa-file-invoice-dollar me-2 text-primary"></i>Quản lý đơn hàng</h1>
                <p class="text-muted mb-0">Theo dõi toàn bộ hóa đơn mua hàng của khách hàng, cập nhật tình trạng giao nhận và thanh toán.</p>
            </div>
        </div>

        <!-- Orders Table Glass Card -->
        <div class="glass-card p-4">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 80px;">Mã số</th>
                            <th>Khách hàng</th>
                            <th style="width: 150px;">Ngày đặt</th>
                            <th>Thông tin người nhận & Địa chỉ</th>
                            <th>Chi tiết sản phẩm mua</th>
                            <th style="width: 120px;">Tổng tiền</th>
                            <th class="text-center" style="width: 130px;">Trạng thái</th>
                            <th class="text-center" style="width: 200px;">Thao tác xử lý</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty orders}">
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td><span class="text-muted fw-semibold">#${order.id}</span></td>
                                        <td>
                                            <span class="fw-semibold text-white d-block">${order.user.username}</span>
                                            <small class="text-muted">${order.user.email}</small>
                                        </td>
                                        <td>
                                            <span class="small text-white">
                                                ${order.orderDate.toString().substring(0,10)}
                                                <br/>
                                                <small class="text-muted">${order.orderDate.toString().substring(11,16)}</small>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="delivery-info text-muted">
                                                <strong class="text-white">${order.recipientName}</strong> - ${order.phone}
                                                <br/>
                                                <span class="small">${order.address}</span>
                                                <c:if test="${not empty order.note}">
                                                    <br/>
                                                    <span class="small text-info style-italic">Ghi chú: "${order.note}"</span>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <ul class="detail-list">
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <li class="detail-item">
                                                        <span class="text-white">${detail.product.name}</span>
                                                        <strong class="text-muted">x${detail.quantity}</strong>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-success">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <span class="badge-pending">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'PAID'}">
                                                    <span class="badge-paid">Đã thanh toán</span>
                                                </c:when>
                                                <c:when test="${order.status == 'COMPLETED'}">
                                                    <span class="badge-completed">Đã giao</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-cancelled">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <!-- Đã thanh toán -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}?status=PAID" 
                                                       class="btn-action-text btn-pay-status w-100" 
                                                       onclick="return confirm('Xác nhận khách hàng đã thanh toán hóa đơn này?')">
                                                        <i class="fa-solid fa-circle-dollar-to-slot me-1"></i> Xác nhận thanh toán
                                                    </a>
                                                    <!-- Hủy đơn -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}?status=CANCELLED" 
                                                       class="btn-action-text btn-cancel-status w-100 mt-1" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id}?')">
                                                        <i class="fa-solid fa-ban me-1"></i> Hủy đơn hàng
                                                    </a>
                                                </c:when>
                                                <c:when test="${order.status == 'PAID'}">
                                                    <!-- Đã giao hàng -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}?status=COMPLETED" 
                                                       class="btn-action-text btn-complete-status w-100" 
                                                       onclick="return confirm('Xác nhận đơn hàng đã giao thành công?')">
                                                        <i class="fa-solid fa-circle-check me-1"></i> Hoàn thành giao nhận
                                                    </a>
                                                    <!-- Hủy đơn -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}?status=CANCELLED" 
                                                       class="btn-action-text btn-cancel-status w-100 mt-1" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id}?')">
                                                        <i class="fa-solid fa-ban me-1"></i> Hủy đơn hàng
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small"><i class="fa-solid fa-lock me-1"></i> Không có thao tác</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        <i class="fa-regular fa-folder-open fa-3x mb-3"></i>
                                        <p class="mb-0">Hệ thống chưa ghi nhận đơn mua hàng nào.</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
