package com.laptop.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "registration_tokens")
public class RegistrationToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(unique = true, nullable = false)
    private String token; // Cryptographic unique string

    private String emailId;
    private String assignedRole; // OWNER, STAFF, DELIVERY
    
    private LocalDateTime expiryTime;
    private boolean used = false;
}