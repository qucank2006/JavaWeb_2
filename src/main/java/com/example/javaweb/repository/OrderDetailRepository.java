package com.example.javaweb.repository;

import com.example.javaweb.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    /**
     * Lấy danh sách sản phẩm bán chạy nhất cùng với số lượng bán và tổng tiền doanh thu.
     * Trả về danh sách chứa Object[]: [0] Product, [1] Long (số lượng bán), [2] BigDecimal (doanh thu)
     */
    @Query("SELECT od.product, SUM(od.quantity) as totalQty, SUM(od.price * od.quantity) as totalVal " +
           "FROM OrderDetail od " +
           "WHERE od.order.status IN ('PAID', 'COMPLETED') " +
           "GROUP BY od.product " +
           "ORDER BY SUM(od.quantity) DESC")
    List<Object[]> findTopSellingProducts(org.springframework.data.domain.Pageable pageable);

    /**
     * Tính tổng doanh thu và số lượng bán theo từng danh mục.
     * Trả về danh sách chứa Object[]: [0] Category, [1] Long (số lượng bán), [2] BigDecimal (doanh thu)
     */
    @Query("SELECT p.category, SUM(od.quantity) as totalQty, SUM(od.price * od.quantity) as totalVal " +
           "FROM OrderDetail od " +
           "JOIN od.product p " +
           "WHERE od.order.status IN ('PAID', 'COMPLETED') " +
           "GROUP BY p.category")
    List<Object[]> findRevenueByCategory();
}
