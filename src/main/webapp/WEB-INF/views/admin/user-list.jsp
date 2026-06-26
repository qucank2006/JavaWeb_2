<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng | Kênh Admin</title>
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

        .badge-role-user {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
            margin-right: 4px;
        }

        .badge-role-admin {
            background: rgba(236, 72, 153, 0.15);
            color: #f472b6;
            border: 1px solid rgba(236, 72, 153, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
            margin-right: 4px;
        }

        .badge-status-active {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-status-locked {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        /* Buttons & Actions */
        .btn-gradient {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 8px;
            padding: 10px 20px;
            transition: opacity 0.2s ease;
        }

        .btn-gradient:hover {
            opacity: 0.9;
            color: white;
        }

        .btn-action-text {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .btn-toggle-admin {
            background: rgba(139, 92, 246, 0.15);
            color: #a78bfa;
            border: 1px solid rgba(139, 92, 246, 0.3);
        }

        .btn-toggle-admin:hover {
            background: #8b5cf6;
            color: white;
        }

        .btn-toggle-status {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .btn-toggle-status:hover {
            background: #f59e0b;
            color: white;
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-delete:hover {
            background: #ef4444;
            color: white;
        }

        .page-header-title {
            font-size: 1.75rem;
            font-weight: 700;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-1"></i> Người dùng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice-dollar me-1"></i> Đơn hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/statistics"><i class="fa-solid fa-chart-line me-1"></i> Thống kê</a>
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
                <h1 class="page-header-title mb-1"><i class="fa-solid fa-users-gear me-2 text-primary"></i>Quản lý người dùng</h1>
                <p class="text-muted mb-0">Theo dõi danh sách tài khoản, thay đổi quyền quản trị, khóa hoặc mở khóa thành viên.</p>
            </div>
        </div>

        <!-- Users Table Glass Card -->
        <div class="card glass-card p-4">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 80px;">Mã số</th>
                            <th>Tên tài khoản</th>
                            <th>Địa chỉ Email</th>
                            <th>Vai trò (Roles)</th>
                            <th class="text-center" style="width: 150px;">Trạng thái</th>
                            <th class="text-center" style="width: 320px;">Hành động điều khiển</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td><span class="text-muted fw-semibold">#${user.id}</span></td>
                                <td>
                                    <span class="fw-semibold text-white d-block" style="font-size: 1.05rem;">
                                        ${user.username}
                                        <c:if test="${sessionScope.currentUser.id == user.id}">
                                            <small class="badge bg-secondary ms-1" style="font-size: 0.65rem;">Tôi</small>
                                        </c:if>
                                    </span>
                                </td>
                                <td><span class="text-muted">${user.email}</span></td>
                                <td>
                                    <c:forEach var="role" items="${user.roles}">
                                        <c:choose>
                                            <c:when test="${role.name == 'ADMIN'}">
                                                <span class="badge-role-admin"><i class="fa-solid fa-user-shield me-1"></i>ADMIN</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-role-user"><i class="fa-solid fa-user me-1"></i>USER</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            <span class="badge-status-active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-status-locked">Đã khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${sessionScope.currentUser.id == user.id}">
                                            <!-- Cấp/Hủy Admin (Disabled for self) -->
                                            <span class="btn-action-text btn-toggle-admin text-muted me-1" style="opacity: 0.5; cursor: not-allowed;" title="Không thể tự tước quyền quản trị của chính mình">
                                                <i class="fa-solid fa-shield me-1"></i> Cấp/Hủy Admin
                                            </span>
                                            
                                            <!-- Khóa/Mở (Disabled for self) -->
                                            <span class="btn-action-text btn-toggle-status text-muted me-1" style="opacity: 0.5; cursor: not-allowed;" title="Không thể tự khóa tài khoản của chính mình">
                                                <i class="fa-solid fa-ban me-1"></i> Khóa/Mở
                                            </span>
                                            
                                            <!-- Xóa (Disabled for self) -->
                                            <span class="btn-action-text btn-delete text-muted" style="opacity: 0.5; cursor: not-allowed;" title="Không thể tự xóa tài khoản của chính mình">
                                                <i class="fa-solid fa-trash-can me-1"></i> Xóa
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Cấp/Hủy Admin -->
                                            <a href="${pageContext.request.contextPath}/admin/users/toggle-admin/${user.id}" 
                                               class="btn-action-text btn-toggle-admin me-1" 
                                               onclick="return confirm('Bạn có chắc chắn muốn thay đổi quyền hạn của tài khoản ${user.username}?')">
                                                <i class="fa-solid fa-shield me-1"></i> Cấp/Hủy Admin
                                            </a>
                                            
                                            <!-- Khóa/Mở khóa -->
                                            <a href="${pageContext.request.contextPath}/admin/users/toggle-status/${user.id}" 
                                               class="btn-action-text btn-toggle-status me-1" 
                                               onclick="return confirm('Bạn có chắc chắn muốn khóa/mở khóa tài khoản ${user.username}?')">
                                                <i class="fa-solid fa-ban me-1"></i> Khóa/Mở
                                            </a>
                                            
                                            <!-- Xóa tài khoản -->
                                            <a href="${pageContext.request.contextPath}/admin/users/delete/${user.id}" 
                                               class="btn-action-text btn-delete" 
                                               onclick="return confirm('Hành động xóa người dùng ${user.username} không thể hoàn tác! Bạn vẫn muốn tiếp tục?')">
                                                <i class="fa-solid fa-trash-can me-1"></i> Xóa
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
