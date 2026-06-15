package com.laptop.model;

import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
	
	private Laptop laptop;
	private int quantity;
	
	public double getTotalPrice() {
		return this.laptop.getPrice()*this.quantity;
	}

	public void setTotalPrice(double d) {
		// TODO Auto-generated method stub
		
	}

}
