<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công | TECH STORE</title>
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

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            background-image: 
                radial-gradient(at 0% 0%, rgba(59, 130, 246, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(139, 92, 246, 0.15) 0px, transparent 50%);
            background-attachment: fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }

        /* Glass Cards */
        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: 0 12px 40px 0 rgba(0, 0, 0, 0.4);
            padding: 3rem;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 2px solid rgba(16, 185, 129, 0.3);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            animation: scaleIn 0.5s ease;
        }

        @keyframes scaleIn {
            0% { transform: scale(0); }
            80% { transform: scale(1.1); }
            100% { transform: scale(1); }
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

        .detail-box {
            background: rgba(15, 23, 42, 0.4);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: left;
            margin-bottom: 2rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .detail-row:last-child {
            margin-bottom: 0;
            border-top: 1px dashed var(--border-color);
            padding-top: 0.75rem;
            margin-top: 0.75rem;
        }
    </style>
</head>
<body>

    <div class="glass-card">
        <div class="success-icon">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        
        <h1 class="text-white mb-2" style="font-weight: 700;">Đặt hàng thành công!</h1>
        <p class="text-muted mb-4">Cảm ơn bạn đã tin tưởng mua sắm tại Tech Store. Đơn hàng của bạn đã được ghi nhận và đang chờ xử lý.</p>
        
        <!-- Order details box -->
        <div class="detail-box">
            <h5 class="text-white mb-3" style="font-weight: 600;"><i class="fa-solid fa-file-invoice-dollar me-2 text-info"></i>Chi tiết đơn đặt hàng</h5>
            
            <div class="detail-row">
                <span class="text-muted">Mã đơn hàng:</span>
                <span class="text-white fw-bold">#${order.id}</span>
            </div>
            
            <div class="detail-row">
                <span class="text-muted">Người nhận:</span>
                <span class="text-white">${order.recipientName}</span>
            </div>
            
            <div class="detail-row">
                <span class="text-muted">Số điện thoại:</span>
                <span class="text-white">${order.phone}</span>
            </div>
            
            <div class="detail-row">
                <span class="text-muted">Địa chỉ nhận hàng:</span>
                <span class="text-white text-end" style="max-width: 250px;">${order.address}</span>
            </div>
            
            <c:if test="${not empty order.note}">
                <div class="detail-row">
                    <span class="text-muted">Ghi chú:</span>
                    <span class="text-white text-end" style="max-width: 250px; font-style: italic;">"${order.note}"</span>
                </div>
            </c:if>

            <div class="detail-row">
                <span class="text-muted">Trạng thái:</span>
                <span class="badge bg-warning text-dark"><i class="fa-solid fa-clock me-1"></i>Chờ xử lý</span>
            </div>
            
            <div class="detail-row">
                <span class="text-muted">Tổng thanh toán:</span>
                <span class="text-success fw-bold fs-5">
                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0" />đ
                </span>
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="d-flex justify-content-center gap-3">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-light">
                <i class="fa-solid fa-store me-2"></i>Tiếp tục mua sắm
            </a>
            <a href="${pageContext.request.contextPath}/order/history" class="btn btn-gradient">
                <i class="fa-solid fa-clock-rotate-left me-2"></i>Xem lịch sử đơn mua
            </a>
        </div>
    </div>

</body>
</html>
