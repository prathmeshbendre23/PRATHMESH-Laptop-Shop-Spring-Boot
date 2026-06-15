package com.laptop.controller.customer;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.laptop.model.CartItem;
import com.laptop.model.Laptop;
import com.laptop.model.LaptopOrder;
import com.laptop.repository.LaptopRepository;
import com.laptop.repository.LaptopOrderRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerShopController {
	
	@Autowired
	private LaptopRepository laptopRepository;

	@Autowired
	private LaptopOrderRepository laptopOrderRepository;
	
 	@GetMapping("/shop")
	public String openCustomerShopPortal(HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser") == null) {
			return "redirect:/login";
		}
		model.addAttribute("customerName", session.getAttribute("loggedInUser"));
		model.addAttribute("availableLaptops", laptopRepository.findAll());
		return "shop";
	}
	
 	@PostMapping("/purchaseLaptop")
	public String loadCheckoutDetailsPage(@RequestParam("laptopId") int id, Model model, HttpSession session) {
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/login";
		}

		Optional<Laptop> optionalLaptop = laptopRepository.findById(id);
		if (optionalLaptop.isPresent()) {
			Laptop laptop = optionalLaptop.get();
			if (laptop.getStockQuantity() > 0) {
				model.addAttribute("laptop", laptop);
				return "checkout"; // Checkout.jsp form par redirect karega details lene ke liye
			}
			model.addAttribute("error", "This unit is out of stock!");
		} else {
			model.addAttribute("error", "Product identity match missing.");
		}
		
		model.addAttribute("availableLaptops", laptopRepository.findAll());
		return "shop"; 
	}

 	@PostMapping("/confirmPurchase")
	public String processFinalOrder(@RequestParam("laptopId") int laptopId,
                                    @RequestParam("shippingName") String shippingName,
                                    @RequestParam("contactMobile") String contactMobile,
                                    @RequestParam("shippingAddress") String shippingAddress,
                                    @RequestParam("paymentMode") String paymentMode,
                                    HttpSession session, Model model) {
		
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/login";
		}

		Optional<Laptop> optionalLaptop = laptopRepository.findById(laptopId);
		if (optionalLaptop.isPresent()) {
			Laptop laptop = optionalLaptop.get();

			if (laptop.getStockQuantity() > 0) {
 				laptop.setStockQuantity(laptop.getStockQuantity() - 1);
				laptopRepository.save(laptop);

 				LaptopOrder order = new LaptopOrder();
 				
				order.setCustomerName((String) session.getAttribute("loggedInUser"));
				order.setLaptopBrand(laptop.getBrand());
				order.setLaptopModel(laptop.getModelName());
				order.setTotalAmount(laptop.getPrice());
 				order.setShippingName(shippingName);
				order.setContactMobile(contactMobile);
				order.setShippingAddress(shippingAddress);
				order.setPaymentMode(paymentMode);
				order.setOrderStatus("PENDING");

				laptopOrderRepository.save(order);
				model.addAttribute("message", "🎉 Outstanding! Order dispatched via " + paymentMode + " payment mode successfully.");
			} else {
				model.addAttribute("error", "Item just ran out of stock!");
			}
		}

		model.addAttribute("customerName", session.getAttribute("loggedInUser"));
		model.addAttribute("availableLaptops", laptopRepository.findAll());
		return "shop";  
	}
 	
 	@GetMapping("/logout")
 	public String logoutUser(HttpSession session, Model model) {
  	    if (session != null) {
 	        session.invalidate();
 	    }
 	    
  	    model.addAttribute("message", "You have been logged out securely. See you again!");
 	    System.out.println("SECURITY LOG: User session invalidated. Redirecting to Login gateway.");
 	    
 	    return "login";   
 	}
 
 	@GetMapping("/my-orders")
 	public String viewCustomerOrderHistory(HttpSession session, Model model) {
 	    if (session.getAttribute("loggedInUser") == null) {
 	        return "redirect:/login";
 	    }

 	    // Session se name nikalna
 	    String currentCustomer = (String) session.getAttribute("loggedInUser");
 	    
 	    List<LaptopOrder> userSpecificOrders = laptopOrderRepository.findAll().stream()
 	    		.filter(order -> order.getCustomerName() != null && 
 	    		(order.getCustomerName().equalsIgnoreCase(currentCustomer) || 
 	    				currentCustomer.toLowerCase().contains(order.getCustomerName().toLowerCase())))
 	    		.toList();
 	    
 	    long totalOrdersCount = userSpecificOrders.size();
 	    
 	    long pendingOrdersCount = userSpecificOrders.stream()
 	    		.filter(order -> "PENDING".equalsIgnoreCase(order.getOrderStatus())).count();
 	    
 	    long deliveredOrderCount = userSpecificOrders.stream().filter(order -> "DELIVERED".equalsIgnoreCase(order.getOrderStatus())).count();
  	    
 	    model.addAttribute("customerOrders",userSpecificOrders);
 	    model.addAttribute("totalOrders",totalOrdersCount);
 	    model.addAttribute("pendingOrders",pendingOrdersCount);
 	    model.addAttribute("deliveredOrders", deliveredOrderCount); 	    
 	    model.addAttribute("customerName",currentCustomer);
 	   System.out.println("ANALYTICS LOG: Metrics parsed for user [" + currentCustomer + "] Total: " + totalOrdersCount);
 	  return "my-orders";
 	}
  
 	
 	
 // 1. Apne CustomerController ke top par baki repositories ke sath ise jodiye:
 	@Autowired
 	private com.laptop.repository.TokenRepository tokenRepository;

 	@Autowired
 	private com.laptop.repository.CustomerRepository customerRepository; // Agar pehle se na ho


 	// 2. Class ke bottom mein yeh dono endpoints inject kar dijiye:

 	/**
 	 * 🔗 STAGE 1: Verify Secret Token & Open Exclusive Form
 	 * URL Hit: http://localhost:8080/register-staff?token=xyz123... (GET)
 	 */
 	@GetMapping("/register-staff")
 	public String verifyAndOpenStaffForm(@RequestParam("token") String tokenStr, Model model) {
 	    // Database check: Kya yeh token system mein valid aur unused hai?
 	    java.util.Optional<com.laptop.model.RegistrationToken> optToken = tokenRepository.findByTokenAndUsed(tokenStr, false);
 	    
 	    if (optToken.isPresent() && optToken.get().getExpiryTime().isAfter(java.time.LocalDateTime.now())) {
 	        
 	        // Token passes structural verification layer! 
 	        model.addAttribute("token", tokenStr);
 	        model.addAttribute("emailId", optToken.get().getEmailId());
 	        model.addAttribute("assignedRole", optToken.get().getAssignedRole());
 	        
 	        return "register-staff-form"; // Will resolve to register-staff-form.jsp
 	    }
 	    
 	    // Token collapsed or expired
 	    model.addAttribute("error", "This secure token link has expired or has already been deployed inside system.");
 	    return "login"; // Redirect back to generic login viewport
 	}

 	/**
 	 * 🔒 STAGE 2: Securely Process Form Submission and Lock Pre-assigned Role
 	 * URL: /submitStaffOnboarding (POST)
 	 */
 	@PostMapping("/submitStaffOnboarding")
 	public String submitStaffOnboarding(@RequestParam("token") String tokenStr,
 	                                    @RequestParam("first_Name") String firstName,
 	                                    @RequestParam("last_Name") String lastName,
 	                                    @RequestParam("user_Name") String username,
 	                                    @RequestParam("password") String password,
 	                                    @RequestParam("mobile_No") long mobile,
 	                                    @RequestParam("customer_Address") String address,
 	                                    Model model) {
 	    
 	    // Safety re-check token persistence state
 	    java.util.Optional<com.laptop.model.RegistrationToken> optToken = tokenRepository.findByTokenAndUsed(tokenStr, false);
 	    
 	    if (optToken.isPresent()) {
 	        com.laptop.model.RegistrationToken dbToken = optToken.get();
 	        
 	        // Check duplicate handle bounds
 	        if (customerRepository.findByUsernameCustom(username) != null) {
 	            model.addAttribute("error", "Username handle already claimed inside company directory.");
 	            model.addAttribute("token", tokenStr);
 	            model.addAttribute("emailId", dbToken.getEmailId());
 	            model.addAttribute("assignedRole", dbToken.getAssignedRole());
 	            return "register-staff-form";
 	        }
 	        
 	        // Save profile with absolute role restriction
 	        com.laptop.model.Customer staff = new com.laptop.model.Customer();
 	        staff.setFirst_Name(firstName);
 	        staff.setLast_Name(lastName);
 	        staff.setUser_Name(username);
 	        staff.setPassword(password); // Ideally encoded/hashed
 	        staff.setEmail_Id(dbToken.getEmailId());
 	        staff.setMobile_No(mobile);
 	        staff.setCustomer_Address(address);
 	        
 	        // 🔒 THE REAL WORLD MAGIC: Role injected safely from token directory properties
 	        staff.setRole(dbToken.getAssignedRole()); 

 	        customerRepository.save(staff);
 	        
 	        // ⚔️ BURN TOKEN: Set used=true so it cannot be shared or re-used again
 	        dbToken.setUsed(true);
 	        tokenRepository.save(dbToken);
 	        
 	        model.addAttribute("message", "Profile onboarded successfully! Welcome to organization. Login now.");
 	        return "login";
 	    }
 	    
 	    return "redirect:/login";
 	}
 	
 	
 	}
 