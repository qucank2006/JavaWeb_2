package com.example.javaweb.repository;

import com.example.javaweb.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.Query;
import java.math.BigDecimal;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserId(Long userId);

    /**
     * Tính tổng doanh thu từ các đơn hàng có trạng thái là "PAID".
     * COALESCE(SUM(o.totalAmount), 0) được sử dụng để tránh trả về null khi không có đơn hàng nào.
     */
    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = 'PAID'")
    BigDecimal calculateTotalRevenue();
}
