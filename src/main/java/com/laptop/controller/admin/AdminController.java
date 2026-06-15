package com.laptop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.laptop.model.Coupon;
import com.laptop.model.Customer;
import com.laptop.model.Laptop;
import com.laptop.model.LaptopOrder;
import com.laptop.model.RegistrationToken;
import com.laptop.repository.CouponRepository;
import com.laptop.repository.CustomerRepository;
import com.laptop.repository.LaptopOrderRepository;
import com.laptop.repository.LaptopRepository;
import com.laptop.repository.TokenRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	
	@Autowired
	private CustomerRepository customerRepository;
	
	@Autowired
	private LaptopRepository laptopRepository;
	
	@Autowired
	private LaptopOrderRepository laptopOrderRepository; 
	
	@Autowired
	private CouponRepository couponRepository;
	
	@Autowired
	private TokenRepository tokenRepository;

	@GetMapping("/")
	public String openIndexPage() {
		System.err.println("Index Page is Open....");
		return "index";
	}
	
	@GetMapping("/register")
	public String openRegisterPage() {
		System.err.println("Register Page is Open");
		return "register";
	}
	
	@PostMapping("/registerCustomer")
	public String registerCustomer(@ModelAttribute Customer customer) {
		// 🔒 FORCE PUBLIC REGISTRATION LOCK TO ALWAYS BE CUSTOMER ONLY
		customer.setRole("CUSTOMER");
		customerRepository.save(customer);
		System.out.println("Customer saved successfully: " + customer.getUser_Name());
		return "redirect:/login";
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		System.err.println("Open the Login Page");
		return "login";
	}
	
	@PostMapping("/loginCustomer")
	public String loginCustomer(@RequestParam("User_Name") String username, 
	                            @RequestParam("Password") String password, 
	                            HttpSession session, 
	                            Model model) {
	    
	    Customer user = customerRepository.findByUsernameCustom(username);
	    
	    if (user != null && user.getPassword().equals(password)) {
	        session.setAttribute("loggedInUser", user.getFirst_Name() + " " + user.getLast_Name());
	        
	        // 🛡️ SECURE NULL-SAFE LAYER FOR USER ROLE EXTRACTION
	        String databaseRole = user.getRole();
	        if (databaseRole == null) {
	        	databaseRole = "CUSTOMER"; // Safe Fallback Default
	        }
	        
	        session.setAttribute("userRole", databaseRole.toUpperCase());
	        System.out.println("AUTHENTICATION LOG: User " + username + " logged in with role: " + databaseRole);
	        
	        switch (databaseRole.toUpperCase()) {
	            case "OWNER":
	                return "redirect:/dashboard";  
	            case "STAFF":
	                return "redirect:/staff-dashboard";   
	            case "CUSTOMER":
	                return "redirect:/shop";  
	            case "DELIVERY":
	                return "redirect:/delivery-panel";   
	            default:
	                return "redirect:/shop";
	        }
	    }
	    
	    model.addAttribute("error", "Invalid Credentials! Verification failed.");
	    return "login";
	}

	@GetMapping("/dashboard")
	public String showAdminDashboard(HttpSession session, Model model) {
		// Security Access Guard Filter
		if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("OWNER")) {
			return "redirect:/login";
		}

		// Fetch raw tables datasets from schema
		List<Laptop> allLaptops = laptopRepository.findAll();
		List<LaptopOrder> allOrders = laptopOrderRepository.findAll();

		// Fetch fresh live customer profiles count from DB
		long dynamicCustomersCount = customerRepository.countByRole("CUSTOMER");

		// Low Stock Filter Logic
		List<Laptop> lowStockLaptops = allLaptops.stream()
				.filter(laptop -> laptop.getStockQuantity() <= 3)
				.toList();

		// Calculate metric matrix parameters for UI blocks
		long activeShipmentsCount = allOrders.stream()
				.filter(order -> "PENDING".equalsIgnoreCase(order.getOrderStatus()))
				.count();

		double calculatedGrossIncome = allOrders.stream()
				.filter(order -> "DELIVERED".equalsIgnoreCase(order.getOrderStatus()))
				.mapToDouble(LaptopOrder::getTotalAmount)
				.sum();

		// Binding objects parameters inside view context variables
		model.addAttribute("allLaptops", allLaptops);
		model.addAttribute("laptopsCount", allLaptops.size());
		model.addAttribute("customersCount", dynamicCustomersCount);
		model.addAttribute("lowStockItems", lowStockLaptops); 
		model.addAttribute("allOrders", allOrders);
		model.addAttribute("activeShipments", activeShipmentsCount);
		model.addAttribute("grossIncome", String.format("%.2f", calculatedGrossIncome));
		
		// Dashboard view context data pipeline
		model.addAttribute("allCoupons", couponRepository.findAll().stream().filter(c -> c.isActive()).toList());

		return "dashboard"; 
	}

	@PostMapping("/admin/updateOrderStatus")
	public String updateOrderStatus(@RequestParam("orderId") int orderId, 
	                                @RequestParam("status") String status, 
	                                HttpSession session) {
		if (session.getAttribute("loggedInUser") == null || 
		   (!session.getAttribute("userRole").equals("OWNER") && !session.getAttribute("userRole").equals("STAFF"))) {
			return "redirect:/login";
		}

		Optional<LaptopOrder> optOrder = laptopOrderRepository.findById(orderId);
		if (optOrder.isPresent()) {
			LaptopOrder order = optOrder.get();
			order.setOrderStatus(status.toUpperCase());
			laptopOrderRepository.save(order);
			System.out.println("LOGISTICS LOG: Order ID " + orderId + " changed state to " + status);
		}
		return "redirect:/dashboard";
	}
		
	@GetMapping("/staff-dashboard")
    public String openStaffDashboard(HttpSession session, Model model) {
         if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("STAFF")) {
            return "redirect:/login";
        }

        model.addAttribute("laptopsCount", laptopRepository.count());
        model.addAttribute("allLaptops", laptopRepository.findAll());
        model.addAttribute("allCustomers", customerRepository.findAll());

        long customerProfilesCount = customerRepository.findAll().stream()
                .filter(c -> "CUSTOMER".equalsIgnoreCase(c.getRole())).count();
        model.addAttribute("customersCount", customerProfilesCount);

        return "staff-dashboard";  
    }

	@GetMapping("/add-laptops")
	public String showAddLaptopForm(HttpSession session) {
		if(session.getAttribute("loggedInUser")==null) {
			return "redirect:/login";
		}
		return "add-laptops";
	}
	
	@PostMapping("/saveLaptop") 
	public String saveNewLaptop(@RequestParam("brand") String brand,
	                            @RequestParam("modelName") String modelName,
	                            @RequestParam("processor") String processor,
	                            @RequestParam("ramGb") int ramGb,
	                            @RequestParam("storageGb") int storageGb,
	                            @RequestParam("price") double price,
	                            @RequestParam("stockQuantity") int stockQuantity,
	                            @RequestParam("imageUrl") String imageUrl, 
	                            HttpSession session) {
	    
	    Laptop laptop = new Laptop();
	    laptop.setBrand(brand);
	    laptop.setModelName(modelName);
	    laptop.setProcessor(processor);
	    laptop.setRamGb(ramGb);
	    laptop.setStorageGb(storageGb);
	    laptop.setPrice(price);
	    laptop.setStockQuantity(stockQuantity);
	    laptop.setImageUrl(imageUrl); 

	    laptopRepository.save(laptop);
	    return "redirect:/dashboard";
	}
	
    @GetMapping("/forgot-password")
    public String openForgotPasswordPage() {
        System.err.println("Password recovery terminal opened.");
        return "forgot-password";  
    }

    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam("User_Name") String username,
                                @RequestParam("Email_Id") String email,
                                @RequestParam("Password") String newPassword,
                                Model model) {
        
        Customer customer = customerRepository.findByUsernameAndEmail(username, email);
        
        if (customer != null) {
             customer.setPassword(newPassword);
             customerRepository.save(customer);
            System.out.println("Credentials updated successfully for entity user: " + username);
            return "redirect:/login";  
        }
        
        model.addAttribute("error", "No record found matching the provided identity profile credentials.");
        return "forgot-password";
    }
     
    @PostMapping("/updateLaptopStock")
    public String updateLaptopStock(@RequestParam("laptopId") int id,
                                    @RequestParam("newStock") int newStock,
                                    HttpSession session, Model model) {
    	 if(session.getAttribute("loggedInUser")==null || (!session.getAttribute("userRole").equals("OWNER") && !session.getAttribute("userRole").equals("STAFF"))) {
    		 return "redirect:/login";
    	 }
    	 
    	 Optional<Laptop> optionalLaptop = laptopRepository.findById(id);
    	 if(optionalLaptop.isPresent()) {
    		 Laptop laptop = optionalLaptop.get();
    		 laptop.setStockQuantity(newStock);
    		 laptopRepository.save(laptop);
    		 System.err.println("CRUD LOG Stock Updated for laptop ID " + id + " to new quantity: " + newStock);
    	 } else {
    		 System.err.println("CRUD ERROR: Laptop ID " + id + " not found in database ");
    	 }
    	 return "redirect:/dashboard";
    }

    @PostMapping("/deleteLaptop")
    public String deleteLaptopStock(@RequestParam("laptopId") int id,
                                    HttpSession session, Model model) {
    	 if(session.getAttribute("loggedInUser")==null || (!session.getAttribute("userRole").equals("OWNER") && !session.getAttribute("userRole").equals("STAFF"))) {
    		 return "redirect:/login";
    	 }
    	  
    	 if(laptopRepository.existsById(id)) {
    		 laptopRepository.deleteById(id);
    		 System.err.println("CRUD LOG: Laptop ID " + id + " delete permanently from inventory register.");
    	 }
    	 return "redirect:/dashboard";
    }
    
    @GetMapping("/manage-accounts")
    public String showAccountsManagementPage(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("OWNER")) {
            return "redirect:/login";
        }

        List<Customer> allUsers = customerRepository.findAll();

        List<Customer> customersOnly = allUsers.stream()
                .filter(u -> "CUSTOMER".equalsIgnoreCase(u.getRole()))
                .toList();

        List<Customer> staffOnly = allUsers.stream()
                .filter(u -> "STAFF".equalsIgnoreCase(u.getRole()) || "DELIVERY".equalsIgnoreCase(u.getRole()))
                .toList();

        model.addAttribute("customersList", customersOnly);
        model.addAttribute("staffList", staffOnly);
        model.addAttribute("customerName", session.getAttribute("loggedInUser"));

        return "manage-accounts"; 
    }

    @PostMapping("/deleteAccount")
    public String deleteUserAccount(@RequestParam("accountId") int id, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("OWNER")) {
            return "redirect:/login";
        }

        if (customerRepository.existsById(id)) {
            customerRepository.deleteById(id);
            System.out.println("CRUD LOG: Account Identity Profile ID " + id + " permanently deleted from directory.");
        }

        return "redirect:/manage-accounts"; 
    }
    
    @PostMapping("/createNewCoupon")
    public String createNewCoupon(@RequestParam String couponCode, @RequestParam int discountPercentage) {
        Coupon coupon = new Coupon();
        coupon.setCouponCode(couponCode.toUpperCase().trim());
        coupon.setDiscountPercentage(discountPercentage);
        coupon.setActive(true);
        couponRepository.save(coupon);
        return "redirect:/dashboard";
    }

    @PostMapping("/expireCoupon")
    public String expireCoupon(@RequestParam int couponId) {
        couponRepository.findById(couponId).ifPresent(coupon -> {
            coupon.setActive(false);
            couponRepository.save(coupon);
        });
        return "redirect:/dashboard";
    }

    @PostMapping("/generateInviteLink")
    public String generateInviteLink(@RequestParam("email") String email, 
                                     @RequestParam("role") String role, 
                                     Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null || !session.getAttribute("userRole").equals("OWNER")) {
            return "redirect:/login";
        }

        String uniqueToken = java.util.UUID.randomUUID().toString();
        
        RegistrationToken invite = new RegistrationToken();
        invite.setToken(uniqueToken);
        invite.setEmailId(email);
        invite.setAssignedRole(role.toUpperCase());
        invite.setExpiryTime(java.time.LocalDateTime.now().plusDays(1)); 
        invite.setUsed(false);
        
        tokenRepository.save(invite);

        String generatedLink = "http://localhost:8080/register-staff?token=" + uniqueToken;
        System.out.println("⚠️ SECURE INVITATION LINK: " + generatedLink);
        
        session.setAttribute("latestInviteLink", generatedLink);
        return "redirect:/manage-accounts";
    }
}