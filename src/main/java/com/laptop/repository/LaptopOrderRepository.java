package com.laptop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptop.model.LaptopOrder;

public interface LaptopOrderRepository extends JpaRepository<LaptopOrder, Integer> {

}
