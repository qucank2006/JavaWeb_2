<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục | Kênh Admin</title>
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

        .badge-category-count {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        /* Forms in Modal */
        .modal-content {
            background-color: #1e293b;
            color: var(--text-main);
            border: 1px solid var(--border-color);
            border-radius: 16px;
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color);
        }

        .modal-footer {
            border-top: 1px solid var(--border-color);
        }

        .form-control {
            background-color: #0f172a;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            border-radius: 8px;
        }

        .form-control:focus {
            background-color: #0f172a;
            border-color: #3b82f6;
            color: var(--text-main);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
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

        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-edit {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .btn-edit:hover {
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

        .alert-dismissible {
            border-radius: 12px;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul me-1"></i> Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-1"></i> Người dùng</a>
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
            <div class="col-md-6 col-12">
                <h1 class="page-header-title mb-1"><i class="fa-solid fa-list-ul me-2 text-primary"></i>Quản lý danh mục</h1>
                <p class="text-muted mb-0">Thêm mới, sửa đổi hoặc loại bỏ các danh mục sản phẩm của Tech Store.</p>
            </div>
            <div class="col-md-6 col-12 text-md-end mt-3 mt-md-0">
                <button class="btn btn-gradient" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="openAddModal()">
                    <i class="fa-solid fa-plus me-2"></i>Thêm danh mục mới
                </button>
            </div>
        </div>

        <!-- Category Table Glass Card -->
        <div class="card glass-card p-4">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 100px;">Mã danh mục</th>
                            <th>Tên danh mục sản phẩm</th>
                            <th class="text-center" style="width: 250px;">Số lượng sản phẩm thuộc nhóm</th>
                            <th class="text-center" style="width: 150px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <c:forEach var="category" items="${categories}">
                                    <tr>
                                        <td>
                                            <span class="fw-semibold text-muted">#${category.id}</span>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-white d-block" style="font-size: 1.05rem;">${category.name}</span>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge badge-category-count">${productCounts[category.id]} sản phẩm</span>
                                        </td>
                                        <td class="text-center">
                                            <a href="javascript:void(0);" 
                                               class="btn-action btn-edit me-1" 
                                               title="Sửa danh mục" 
                                               onclick="openEditModal('${category.id}', '${category.name}')">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.id}" 
                                               class="btn-action btn-delete" 
                                               title="Xóa danh mục" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục ${category.name}?')">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="fa-regular fa-folder-open fa-3x mb-3 text-muted"></i>
                                        <p class="mb-0">Chưa có danh mục nào được khởi tạo. Hãy nhấn "Thêm danh mục mới".</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Category Form Modal (Dùng chung cho cả Thêm và Sửa) -->
    <div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="categoryForm" action="${pageContext.request.contextPath}/admin/categories/save" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="categoryModalLabel"><i class="fa-solid fa-folder-plus me-2 text-primary"></i>Thêm danh mục mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Id ẩn phục vụ Edit -->
                        <input type="hidden" id="categoryId" name="id">

                        <div class="mb-3">
                            <label for="name" class="form-label text-muted">Tên danh mục *</label>
                            <input type="text" class="form-control" id="name" name="name" required placeholder="Ví dụ: Phụ kiện Gaming">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy bỏ</button>
                        <button type="submit" class="btn btn-gradient"><i class="fa-solid fa-floppy-disk me-2"></i>Lưu lại</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript & Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hàm mở modal để thêm mới danh mục
        function openAddModal() {
            document.getElementById('categoryModalLabel').innerHTML = '<i class="fa-solid fa-folder-plus me-2 text-primary"></i>Thêm danh mục mới';
            document.getElementById('categoryId').value = '';
            document.getElementById('categoryForm').reset();
        }

        // Hàm mở modal để sửa danh mục
        function openEditModal(id, name) {
            document.getElementById('categoryModalLabel').innerHTML = '<i class="fa-solid fa-pen-to-square me-2 text-warning"></i>Cập nhật tên danh mục';
            document.getElementById('categoryId').value = id;
            document.getElementById('name').value = name;

            // Kích hoạt hiển thị modal
            var myModal = new bootstrap.Modal(document.getElementById('categoryModal'));
            myModal.show();
        }
    </script>
</body>
</html>
