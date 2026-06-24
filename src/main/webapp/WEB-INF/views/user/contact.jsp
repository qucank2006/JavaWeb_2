<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ | TECH STORE</title>
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

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }

        .contact-info-icon {
            width: 40px;
            height: 40px;
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .map-mockup {
            height: 250px;
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.9) 0%, rgba(15, 23, 42, 0.9) 100%);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            padding: 2rem;
            margin-top: 2rem;
            position: relative;
            overflow: hidden;
        }

        .map-mockup::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background-image: 
                radial-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
                radial-gradient(rgba(255,255,255,0.03) 1px, transparent 1px);
            background-size: 20px 20px;
            background-position: 0 0, 10px 10px;
            opacity: 0.5;
            top: -50%;
            left: -50%;
        }

        .map-icon {
            font-size: 3rem;
            color: #ef4444;
            margin-bottom: 1rem;
            z-index: 1;
            filter: drop-shadow(0 4px 10px rgba(239, 68, 68, 0.4));
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
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

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative me-3">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                    </a>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-warning btn-sm me-3">
                                <i class="fa-solid fa-clock-rotate-left me-1"></i> Đơn mua
                            </a>
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
    <div class="container mt-5 mb-5">
        <h1 class="mb-4" style="font-weight: 700;"><i class="fa-solid fa-map-location-dot me-3 text-primary"></i>Liên hệ với chúng tôi</h1>

        <!-- Feedback Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border-color: rgba(16, 185, 129, 0.3); padding: 1.25rem 2rem;">
                <i class="fa-solid fa-circle-check me-2"></i> ${success}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row">
            <!-- Left: Contact Details & Mock Map -->
            <div class="col-lg-5 col-12 mb-4">
                <div class="glass-card p-4 h-100">
                    <h3 class="text-white mb-4" style="font-weight: 600;"><i class="fa-solid fa-building me-2 text-primary"></i>Thông tin Tech Store</h3>
                    
                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="fa-solid fa-location-dot"></i></div>
                        <div>
                            <span class="text-muted d-block small">Địa chỉ trụ sở chính</span>
                            <span class="text-white fw-semibold">123 Đường Láng, Quận Đống Đa, Hà Nội</span>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="fa-solid fa-phone-volume"></i></div>
                        <div>
                            <span class="text-muted d-block small">Điện thoại hỗ trợ</span>
                            <span class="text-white fw-semibold">1900 8888 - 0987 654 321</span>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="fa-solid fa-envelope"></i></div>
                        <div>
                            <span class="text-muted d-block small">Hòm thư điện tử</span>
                            <span class="text-white fw-semibold">contact@techstore.com</span>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <div class="contact-info-icon"><i class="fa-solid fa-clock"></i></div>
                        <div>
                            <span class="text-muted d-block small">Giờ phục vụ khách hàng</span>
                            <span class="text-white fw-semibold">8:00 AM - 10:00 PM (Tất cả các ngày trong tuần)</span>
                        </div>
                    </div>

                    <!-- Simulated Google map container -->
                    <div class="map-mockup">
                        <div class="map-icon"><i class="fa-solid fa-location-pin"></i></div>
                        <h6 class="text-white fw-bold mb-1" style="z-index: 1;">Bản đồ Tech Store</h6>
                        <p class="text-muted small mb-3" style="z-index: 1; max-width: 250px;">Bản đồ mô phỏng định vị cửa hàng tại 123 Đường Láng, Hà Nội.</p>
                        <a href="https://maps.google.com/?q=123+Duong+Lang+Dong+Da+Ha+Noi" target="_blank" rel="noopener noreferrer" class="btn btn-outline-light btn-sm px-3" style="z-index: 1; border-radius: 8px;">
                            Xem trên Google Maps <i class="fa-solid fa-up-right-from-square ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right: Contact Message Form -->
            <div class="col-lg-7 col-12 mb-4">
                <div class="glass-card p-4">
                    <h3 class="text-white mb-4" style="font-weight: 600;"><i class="fa-solid fa-paper-plane me-2 text-success"></i>Gửi lời nhắn cho Tech Store</h3>
                    <p class="text-muted mb-4">Nếu bạn có bất cứ thắc mắc, phản ánh hay đóng góp ý kiến nào, xin vui lòng để lại tin nhắn theo biểu mẫu dưới đây.</p>
                    
                    <form action="${pageContext.request.contextPath}/contact" method="post">
                        <div class="row">
                            <div class="col-md-6 col-12 mb-3">
                                <label for="name" class="form-label text-muted">Họ và tên của bạn *</label>
                                <input type="text" class="form-control" id="name" name="name" required placeholder="Nhập đầy đủ họ tên">
                            </div>
                            <div class="col-md-6 col-12 mb-3">
                                <label for="email" class="form-label text-muted">Địa chỉ Email liên hệ *</label>
                                <input type="email" class="form-control" id="email" name="email" required placeholder="example@email.com">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label text-muted">Số điện thoại di động (Không bắt buộc)</label>
                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                        </div>

                        <div class="mb-3">
                            <label for="title" class="form-label text-muted">Tiêu đề tin nhắn *</label>
                            <input type="text" class="form-control" id="title" name="title" required placeholder="Ví dụ: Tư vấn mua sản phẩm, Bảo hành thiết bị...">
                        </div>

                        <div class="mb-4">
                            <label for="message" class="form-label text-muted">Nội dung tin nhắn cần gửi *</label>
                            <textarea class="form-control" id="message" name="message" rows="5" required placeholder="Nhập nội dung tin nhắn chi tiết tại đây..."></textarea>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-gradient px-4 py-2">
                                Gửi đi <i class="fa-solid fa-paper-plane ms-2"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
