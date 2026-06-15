package com.laptop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan("com.laptop")
public class LaptopShopSpringMvcProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(LaptopShopSpringMvcProjectApplication.class, args);
		System.err.println("Run the My Project....");
	}

}
