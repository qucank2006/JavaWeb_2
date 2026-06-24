<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm | Kênh Admin</title>
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

        /* Glassmorphism Sidebar & Navigation */
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
            padding: 1rem 0.75rem;
        }

        .product-img-placeholder {
            width: 48px;
            height: 48px;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.05);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        .product-img-thumbnail {
            width: 48px;
            height: 48px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border-color);
        }

        .badge-category {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-stock {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.3);
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 8px;
        }

        .badge-out-stock {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
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

        .form-control, .form-select {
            background-color: #0f172a;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            border-radius: 8px;
        }

        .form-control:focus, .form-select:focus {
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box me-1"></i> Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul me-1"></i> Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-1"></i> Người dùng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice-dollar me-1"></i> Đơn hàng</a>
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
        <div class="row mb-4 align-items-center">
            <div class="col-md-6 col-12">
                <h1 class="page-header-title mb-1"><i class="fa-solid fa-boxes-stacked me-2 text-primary"></i>Quản lý danh sách sản phẩm</h1>
                <p class="text-muted mb-0">Thêm, sửa, xóa và theo dõi kho hàng máy tính & linh kiện điện tử.</p>
            </div>
            <div class="col-md-6 col-12 text-md-end mt-3 mt-md-0">
                <button class="btn btn-gradient" data-bs-toggle="modal" data-bs-target="#productModal" onclick="openAddModal()">
                    <i class="fa-solid fa-plus me-2"></i>Thêm sản phẩm mới
                </button>
            </div>
        </div>

        <!-- Product Table Glass Card -->
        <div class="card glass-card p-4">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 80px;">Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th class="text-end">Đơn giá (VNĐ)</th>
                            <th class="text-center">Số lượng tồn</th>
                            <th>Mô tả chi tiết</th>
                            <th class="text-center" style="width: 120px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="${pageContext.request.contextPath}${product.image}" class="product-img-thumbnail" alt="${product.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="product-img-placeholder">
                                                        <i class="fa-solid fa-laptop fa-lg"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-white d-block">${product.name}</span>
                                            <small class="text-muted">ID: ${product.id}</small>
                                        </td>
                                        <td>
                                            <span class="badge badge-category">${product.category.name}</span>
                                        </td>
                                        <td class="text-end fw-semibold text-info">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${product.quantity > 0}">
                                                    <span class="badge badge-stock">${product.quantity} cái</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-out-stock">Hết hàng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 200px;" title="${product.description}">
                                                ${product.description}
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <a href="javascript:void(0);" 
                                               class="btn-action btn-edit me-1" 
                                               title="Sửa sản phẩm" 
                                               onclick="openEditModal('${product.id}', '${product.name}', '${product.price}', '${product.quantity}', '${product.category.id}', '${product.description}', '${product.image}')">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/products/delete/${product.id}" 
                                               class="btn-action btn-delete" 
                                               title="Xóa sản phẩm" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ${product.name}?')">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="fa-regular fa-folder-open fa-3x mb-3 text-muted"></i>
                                        <p class="mb-0">Chưa có sản phẩm nào được tạo. Hãy nhấn "Thêm sản phẩm mới".</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Product Form Modal (Dùng chung cho cả Thêm và Sửa) -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <form id="productForm" action="${pageContext.request.contextPath}/admin/products/save" method="post" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productModalLabel"><i class="fa-solid fa-box-open me-2 text-primary"></i>Thêm sản phẩm máy tính mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Id ẩn phục vụ Edit -->
                        <input type="hidden" id="productId" name="id">
 
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label text-muted">Tên sản phẩm *</label>
                                <input type="text" class="form-control" id="name" name="name" required placeholder="Ví dụ: Laptop Asus ROG Strix G16">
                            </div>
                            <div class="col-md-6">
                                <label for="categoryId" class="form-label text-muted">Danh mục sản phẩm *</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="" disabled selected>-- Chọn danh mục --</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="price" class="form-label text-muted">Đơn giá (VNĐ) *</label>
                                <input type="number" step="1000" class="form-control" id="price" name="price" required placeholder="Ví dụ: 25000000">
                            </div>
                            <div class="col-md-6">
                                <label for="quantity" class="form-label text-muted">Số lượng tồn kho *</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required placeholder="Ví dụ: 15">
                            </div>
                            <div class="col-12">
                                <label for="imageFile" class="form-label text-muted">Hình ảnh sản phẩm</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(this)">
                                <div class="mt-2 text-center" id="imagePreviewContainer" style="display: none;">
                                    <img id="imagePreview" src="" alt="Xem trước ảnh" style="max-height: 150px; border-radius: 8px; border: 1px solid var(--border-color);">
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="description" class="form-label text-muted">Mô tả chi tiết sản phẩm</label>
                                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Mô tả cấu hình CPU, RAM, GPU, Ổ cứng..."></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy bỏ</button>
                        <button type="submit" class="btn btn-gradient"><i class="fa-solid fa-floppy-disk me-2"></i>Lưu thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript & Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Hàm mở modal để thêm mới
        function openAddModal() {
            document.getElementById('productModalLabel').innerHTML = '<i class="fa-solid fa-box-open me-2 text-primary"></i>Thêm sản phẩm máy tính mới';
            document.getElementById('productId').value = '';
            document.getElementById('productForm').reset();
            document.getElementById('imagePreview').src = '';
            document.getElementById('imagePreviewContainer').style.display = 'none';
        }
 
        // Hàm mở modal để sửa đổi sản phẩm đã có
        function openEditModal(id, name, price, quantity, categoryId, description, imageUrl) {
            document.getElementById('productModalLabel').innerHTML = '<i class="fa-solid fa-pen-to-square me-2 text-warning"></i>Cập nhật thông tin sản phẩm';
            document.getElementById('productId').value = id;
            document.getElementById('name').value = name;
            // Xử lý giá nếu có số phân thập phân
            document.getElementById('price').value = Math.round(price);
            document.getElementById('quantity').value = quantity;
            document.getElementById('categoryId').value = categoryId;
            document.getElementById('description').value = description;
 
            // Xử lý hiển thị ảnh hiện tại
            var preview = document.getElementById('imagePreview');
            var container = document.getElementById('imagePreviewContainer');
            if (imageUrl && imageUrl.trim() !== '') {
                preview.src = '${pageContext.request.contextPath}' + imageUrl;
                container.style.display = 'block';
            } else {
                preview.src = '';
                container.style.display = 'none';
            }

            // Trigger modal hiển thị qua Bootstrap API
            var myModal = new bootstrap.Modal(document.getElementById('productModal'));
            myModal.show();
        }

        // Hàm xem trước ảnh khi chọn file
        function previewImage(input) {
            var preview = document.getElementById('imagePreview');
            var container = document.getElementById('imagePreviewContainer');
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    container.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '';
                container.style.display = 'none';
            }
        }
    </script>
</body>
</html>
