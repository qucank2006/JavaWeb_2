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
     * Tính tổng doanh thu từ các đơn hàng có trạng thái là "PAID" hoặc "COMPLETED".
     */
    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status IN ('PAID', 'COMPLETED')")
    BigDecimal calculateTotalRevenue();

    /**
     * Lấy 5 đơn hàng gần nhất sắp xếp theo ngày đặt giảm dần.
     */
    List<Order> findTop5ByOrderByOrderDateDesc();

    /**
     * Lấy doanh thu theo từng tháng trong năm cho trước.
     */
    @Query("SELECT MONTH(o.orderDate) as month, SUM(o.totalAmount) as total " +
           "FROM Order o " +
           "WHERE o.status IN ('PAID', 'COMPLETED') AND YEAR(o.orderDate) = :year " +
           "GROUP BY MONTH(o.orderDate) " +
           "ORDER BY MONTH(o.orderDate) ASC")
    List<Object[]> findMonthlyRevenueForYear(@org.springframework.data.repository.query.Param("year") int year);
}
