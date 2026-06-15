package com.laptop.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Laptop_Orders")
public class LaptopOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;
    
    private String customerName;
    private String laptopBrand;
    private String laptopModel;
    private double totalAmount;
    
     private String shippingName;
    private String contactMobile;
    private String shippingAddress;
    private String paymentMode;  
    private String orderStatus;  
}