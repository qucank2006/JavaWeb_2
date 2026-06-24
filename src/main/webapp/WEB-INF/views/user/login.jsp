<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | TECH STORE</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.6);
            --border-color: rgba(255, 255, 255, 0.08);
            --primary-gradient: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
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
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: 
                radial-gradient(at 0% 0%, rgba(59, 130, 246, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(139, 92, 246, 0.15) 0px, transparent 50%);
            background-attachment: fixed;
            padding: 20px;
        }

        .login-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 450px;
            transition: all 0.3s ease;
        }

        .login-card:hover {
            box-shadow: 0 15px 50px rgba(59, 130, 246, 0.15);
            border-color: rgba(255, 255, 255, 0.15);
        }

        .brand-logo {
            font-size: 2.25rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
            letter-spacing: 1px;
            display: block;
            margin-bottom: 0.5rem;
        }

        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 0.5rem;
        }

        .input-group-text {
            background-color: rgba(15, 23, 42, 0.6);
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            border-radius: 12px 0 0 12px;
        }

        .form-control {
            background-color: rgba(15, 23, 42, 0.6);
            border: 1px solid var(--border-color);
            color: white !important;
            padding: 0.75rem 1rem;
            border-radius: 0 12px 12px 0;
        }

        .form-control:focus {
            background-color: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            box-shadow: 0 0 12px rgba(59, 130, 246, 0.25);
        }

        .btn-gradient {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 12px;
            padding: 0.8rem 2rem;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-gradient:hover {
            opacity: 0.95;
            box-shadow: 0 5px 15px rgba(139, 92, 246, 0.3);
            transform: translateY(-1px);
        }

        .alert {
            border-radius: 12px;
            font-size: 0.9rem;
            border: 1px solid transparent;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border-color: rgba(239, 68, 68, 0.3);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border-color: rgba(16, 185, 129, 0.3);
        }

        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.2s;
            font-size: 0.9rem;
        }

        .back-link:hover {
            color: #60a5fa;
        }

        .register-prompt a {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 600;
        }

        .register-prompt a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-card text-center">
        <!-- Brand Logo -->
        <a href="${pageContext.request.contextPath}/home" class="brand-logo">
            <i class="fa-solid fa-laptop-code me-2"></i>TECH STORE
        </a>
        <h4 class="fw-bold mb-4 text-white">Chào mừng trở lại!</h4>

        <!-- Alerts -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-start mb-3" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success text-start mb-3" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ${success}
            </div>
        </c:if>
        <!-- Form đăng nhập -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3 text-start">
                <label for="username" class="form-label">Tên tài khoản</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" class="form-control" id="username" name="username" required placeholder="Nhập username">
                </div>
            </div>

            <div class="mb-4 text-start">
                <label for="password" class="form-label">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" required placeholder="Nhập mật khẩu">
                </div>
            </div>

            <button type="submit" class="btn btn-gradient">Đăng nhập</button>
        </form>

        <div class="register-prompt mt-4 text-muted">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
        </div>

        <div class="mt-4 pt-3 border-top border-secondary">
            <a href="${pageContext.request.contextPath}/home" class="back-link">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay về trang chủ cửa hàng
            </a>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
