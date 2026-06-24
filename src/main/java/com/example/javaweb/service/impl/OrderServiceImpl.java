package com.example.javaweb.service.impl;

import com.example.javaweb.entity.Order;
import com.example.javaweb.entity.OrderDetail;
import com.example.javaweb.entity.Product;
import com.example.javaweb.entity.User;
import com.example.javaweb.model.Cart;
import com.example.javaweb.model.CartItem;
import com.example.javaweb.repository.OrderDetailRepository;
import com.example.javaweb.repository.OrderRepository;
import com.example.javaweb.repository.ProductRepository;
import com.example.javaweb.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository,
                            OrderDetailRepository orderDetailRepository,
                            ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;
    }

    @Override
    @Transactional
    public Order placeOrder(User user, Cart cart, String recipientName, String phone, String address, String note) {
        if (cart == null || cart.getItems().isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng của bạn đang trống!");
        }

        // 1. Validate stock levels for all products
        for (CartItem item : cart.getItems()) {
            Product dbProduct = productRepository.findById(item.getProduct().getId())
                    .orElseThrow(() -> new IllegalArgumentException("Sản phẩm " + item.getProduct().getName() + " không tồn tại!"));
            
            if (dbProduct.getQuantity() < item.getQuantity()) {
                throw new IllegalArgumentException("Sản phẩm " + dbProduct.getName() + " không đủ hàng trong kho (Còn lại: " + dbProduct.getQuantity() + " sản phẩm)!");
            }
        }

        // 2. Create the Order
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setTotalAmount(cart.getTotalAmount());
        order.setStatus("PENDING"); // Default status for COD orders
        order.setRecipientName(recipientName);
        order.setPhone(phone);
        order.setAddress(address);
        order.setNote(note);

        Order savedOrder = orderRepository.save(order);

        // 3. Process CartItems
        for (CartItem item : cart.getItems()) {
            Product dbProduct = productRepository.findById(item.getProduct().getId()).get();
            
            // Deduct stock
            dbProduct.setQuantity(dbProduct.getQuantity() - item.getQuantity());
            productRepository.save(dbProduct);

            // Create OrderDetail
            OrderDetail detail = new OrderDetail();
            detail.setOrder(savedOrder);
            detail.setProduct(dbProduct);
            detail.setQuantity(item.getQuantity());
            detail.setPrice(dbProduct.getPrice()); // Capture current price

            orderDetailRepository.save(detail);
            savedOrder.getOrderDetails().add(detail);
        }

        return savedOrder;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserId(user.getId());
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> findAll() {
        return orderRepository.findAll(org.springframework.data.domain.Sort.by(org.springframework.data.domain.Sort.Direction.DESC, "orderDate"));
    }

    @Override
    @Transactional
    public void updateOrderStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Đơn hàng không tồn tại!"));

        String currentStatus = order.getStatus();
        if (currentStatus.equalsIgnoreCase(newStatus)) {
            return;
        }

        // 1. If changing to CANCELLED (Refund inventory stock)
        if (newStatus.equalsIgnoreCase("CANCELLED")) {
            for (OrderDetail detail : order.getOrderDetails()) {
                Product product = detail.getProduct();
                product.setQuantity(product.getQuantity() + detail.getQuantity());
                productRepository.save(product);
            }
        }
        // 2. If changing FROM CANCELLED back to active (Deduct stock again, check availability)
        else if (currentStatus.equalsIgnoreCase("CANCELLED")) {
            // Validate stock levels first
            for (OrderDetail detail : order.getOrderDetails()) {
                Product product = detail.getProduct();
                if (product.getQuantity() < detail.getQuantity()) {
                    throw new IllegalArgumentException("Không thể khôi phục đơn hàng! Sản phẩm '" + product.getName() 
                            + "' không đủ số lượng trong kho (Yêu cầu: " + detail.getQuantity() 
                            + ", Hiện có: " + product.getQuantity() + ").");
                }
            }
            // Deduct stock
            for (OrderDetail detail : order.getOrderDetails()) {
                Product product = detail.getProduct();
                product.setQuantity(product.getQuantity() - detail.getQuantity());
                productRepository.save(product);
            }
        }

        order.setStatus(newStatus.toUpperCase());
        orderRepository.save(order);
    }
}
