package com.laptop.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Coupons")
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(unique = true, nullable = false)
    private String couponCode; // Jaise: LAPTOP10, PRATHMESH05

    private int discountPercentage; // Jaise: 5, 10, 15

    private boolean active = true; // Coupon active hai ya expired
}