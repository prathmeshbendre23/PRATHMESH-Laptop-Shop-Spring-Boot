package com.laptop.controller.delivery;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.laptop.model.LaptopOrder;
import com.laptop.repository.LaptopOrderRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeliveryController {

    @Autowired
    private LaptopOrderRepository laptopOrderRepository;

    /**
     * 🚚 1. LOAD DELIVERY AGENT PANEL
     * URL: /delivery-panel (GET)
     */
    @GetMapping("/delivery-panel")
    public String showDeliveryPanel(HttpSession session, Model model) {
        // Security Gatekeeper Check
        if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("DELIVERY")) {
            return "redirect:/login";
        }

        // Delivery agent ko sirf PENDING orders dikhane hain dispatch karne ke liye
        List<LaptopOrder> pendingOrders = laptopOrderRepository.findAll().stream()
                .filter(order -> "PENDING".equalsIgnoreCase(order.getOrderStatus()))
                .toList();

        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("customerName", session.getAttribute("loggedInUser"));

        return "delivery-panel"; // Will look for delivery-panel.jsp
    }

    /**
     * ⚡ 2. UPDATE ORDER TO DELIVERED (UNIQUE PATH APPLIED)
     * URL: /delivery/updateStatus (POST)
     */
    @PostMapping("/delivery/updateStatus")
    public String updateOrderStatusByAgent(@RequestParam("orderId") int id, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("DELIVERY")) {
            return "redirect:/login";
        }

        Optional<LaptopOrder> optOrder = laptopOrderRepository.findById(id);
        if (optOrder.isPresent()) {
            LaptopOrder order = optOrder.get();
            order.setOrderStatus("DELIVERED"); // Flipped status permanently
            laptopOrderRepository.save(order);
            System.out.println("LOGISTICS RECONCILIATION: Order ID " + id + " successfully marked DELIVERED by field agent.");
        }

        return "redirect:/delivery-panel";
    }
}