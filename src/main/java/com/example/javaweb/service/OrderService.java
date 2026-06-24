package com.example.javaweb.service;

import com.example.javaweb.entity.Order;
import com.example.javaweb.entity.User;
import com.example.javaweb.model.Cart;
import java.util.List;
import java.util.Optional;

public interface OrderService {
    Order placeOrder(User user, Cart cart, String recipientName, String phone, String address, String note);
    List<Order> getOrdersByUser(User user);
    Optional<Order> getOrderById(Long id);
    List<Order> findAll();
    void updateOrderStatus(Long orderId, String newStatus);
}
