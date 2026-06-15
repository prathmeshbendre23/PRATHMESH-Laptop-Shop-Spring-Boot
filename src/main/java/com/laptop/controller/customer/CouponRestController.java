package com.laptop.controller.customer;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.laptop.model.Coupon;
import com.laptop.repository.CouponRepository;

@RestController
public class CouponRestController {

    @Autowired
    private CouponRepository couponRepository;

    /**
     * 🏷️ LIVE PROMO CODE VALIDATOR API
     * URL: /api/validate-coupon?code=LAPTOP10 (GET)
     */
    @GetMapping("/api/validate-coupon")
    public ResponseEntity<Map<String, Object>> validateCoupon(@RequestParam("code") String code) {
        Map<String, Object> response = new HashMap<>();
        
        if (code == null || code.trim().isEmpty()) {
            response.put("valid", false);
            response.put("message", "Voucher field cannot be empty.");
            return ResponseEntity.ok(response);
        }

        // Search active coupon code in database directory
        Optional<Coupon> optCoupon = couponRepository.findByCouponCodeAndActive(code.toUpperCase().trim(), true);

        if (optCoupon.isPresent()) {
            Coupon coupon = optCoupon.get();
            response.put("valid", true);
            response.put("discount", coupon.getDiscountPercentage());
            response.put("message", "Promo code applied successfully! You got " + coupon.getDiscountPercentage() + "% off.");
        } else {
            response.put("valid", false);
            response.put("message", "Invalid or expired promo voucher string.");
        }

        return ResponseEntity.ok(response);
    }
}