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
@Table(name = "Customer")
public class Customer {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int Customer_Id;
	private String First_Name;
	private String Last_Name;
	@Column(unique = true)
	private String User_Name;
	private String Password;
	@Column(unique = true)
	private String Email_Id;
	@Column(unique = true)
	private long Mobile_No;
	private String Customer_Address;
	
	private String role;
	

}
