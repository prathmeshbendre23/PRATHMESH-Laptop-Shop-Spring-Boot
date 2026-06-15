package com.laptop.controller.customer;

import java.util.HashMap;
import java.util.Map;
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
import com.laptop.repository.LaptopOrderRepository; // Fixed missing import template reference

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	
	@Autowired
	private LaptopRepository laptopRepository;
	
	@Autowired
	private LaptopOrderRepository laptopOrderRepository; // Injecting Order Repo

	@PostMapping("/addToCart")
	public String addItemToCart(@RequestParam("laptopId") int id, HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser")==null) {
			return "redirect:/login";
		}
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("sessionCart");
		if(cart==null) {
			cart = new HashMap<>();
		}
		Optional<Laptop> optionalLaptop = laptopRepository.findById(id);
		if(optionalLaptop.isPresent()) {
			Laptop laptop = optionalLaptop.get();
			if(laptop.getStockQuantity()>0) {
				if(cart.containsKey(id)) {
					CartItem existingItem = cart.get(id);
					if(existingItem.getQuantity()<laptop.getStockQuantity()) {
						existingItem.setQuantity(existingItem.getQuantity() + 1);
					}
				} else {
					cart.put(id, new CartItem(laptop,1));
				}
				session.setAttribute("sessionCart",cart);
				int totalCount = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
				session.setAttribute("cartCount",totalCount);
				System.err.println("Cart Added Successfully "+laptop.getModelName() +" into session cache storage memory");
			}
		}
		return "redirect:/shop";
	}
	
	@GetMapping("/cart")
	public String viewCartDetails(HttpSession session, Model model) {
		if(session.getAttribute("loggedInUser")==null) {
			return "redirect:/login";
		}
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("sessionCart");
		if(cart == null) {
			cart = new HashMap<>();
		}
		
		double grandTotal = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
		model.addAttribute("cartItems", cart.values());
		model.addAttribute("grandTotal", grandTotal);
		model.addAttribute("customerName", session.getAttribute("loggedInUser"));
		
		return "cart";
	}
	
	@PostMapping("/removeFromCart")
	public String removeItemFromCart(@RequestParam("laptopId") int id, HttpSession session) {
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("sessionCart");
		if(cart!= null && cart.containsKey(id)) {
			cart.remove(id);
			
			int totalCount = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
			session.setAttribute("cartCount", totalCount);
			session.setAttribute("sessionCart", cart);
		}
		return "redirect:/cart";
	}
	
	@PostMapping("/cartCheckout")
	public String loadCartCheckoutPage(HttpSession session, Model model) {
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/login";
		}

		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("sessionCart");
		if (cart == null || cart.isEmpty()) {
			return "redirect:/shop";
		}

		double grandTotal = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();

		model.addAttribute("cartItems", cart.values());
		model.addAttribute("grandTotal", grandTotal);
		model.addAttribute("customerName", session.getAttribute("loggedInUser"));
		
		return "cart-checkout";
	}

	/**
	 * 🚀 UPDATED TRANSACTIONAL PROCUREMENT BLOCK (COMPLETED & INTEGRATED)
	 * URL: /confirmCartPurchase (POST)
	 */
	@PostMapping("/confirmCartPurchase")
	public String processBulkOrder(@RequestParam("shippingName") String shippingName,
	                               @RequestParam("contactMobile") String contactMobile,
	                               @RequestParam("shippingAddress") String shippingAddress,
	                               @RequestParam("paymentMode") String paymentMode,
	                               @RequestParam("discountedTotalBill") double discountedBill, // 🚨 INJECTED FROM cart-checkout.jsp Form
	                               HttpSession session, Model model) {
	    
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/login";
		}

		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("sessionCart");
		if (cart == null || cart.isEmpty()) {
			model.addAttribute("error", "Your cart session is expired or empty.");
			return "redirect:/shop";
		}

		String currentCustomer = (String) session.getAttribute("loggedInUser");
		
		// 📊 MATH RULE: Calculate exact discount ratio floating from frontend variables
		double standardGrandTotal = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
		double discountRatio = (standardGrandTotal > 0) ? (discountedBill / standardGrandTotal) : 1.0;

		for (CartItem item : cart.values()) {
			Laptop laptop = item.getLaptop();
			int requestedQty = item.getQuantity();

			Optional<Laptop> dbLaptopOpt = laptopRepository.findById(laptop.getId());
			if (dbLaptopOpt.isPresent()) {
				Laptop dbLaptop = dbLaptopOpt.get();

				if (dbLaptop.getStockQuantity() >= requestedQty) {
					// 1. Deduct Stock Inventory records
					dbLaptop.setStockQuantity(dbLaptop.getStockQuantity() - requestedQty);
					laptopRepository.save(dbLaptop);

					// 2. Compute dynamic item cost using accounting factor ratio
					double normalItemBundleCost = dbLaptop.getPrice() * requestedQty;
					double finalizedDiscountedItemCost = normalItemBundleCost * discountRatio;

					// 3. Write data metrics to entity mapping records
					LaptopOrder order = new LaptopOrder();
					order.setCustomerName(currentCustomer);
					order.setLaptopBrand(dbLaptop.getBrand());
					order.setLaptopModel(dbLaptop.getModelName());
					
					// 🚨 DYNAMIC ADJUSTMENT: Saves precise discounted price directly into schema audit
					order.setTotalAmount(finalizedDiscountedItemCost); 
					
					order.setShippingName(shippingName);
					order.setContactMobile(contactMobile);
					order.setShippingAddress(shippingAddress);
					order.setPaymentMode(paymentMode);
					order.setOrderStatus("PENDING");

					laptopOrderRepository.save(order);
				}
			}
		}

		// 4. Secure clear cached arrays sessions maps parameters
		session.removeAttribute("sessionCart");
		session.setAttribute("cartCount", 0);

		model.addAttribute("message", "🎉 Fantastic! All items from your cart have been successfully ordered via " + paymentMode + " mode.");
		model.addAttribute("customerName", currentCustomer);
		model.addAttribute("availableLaptops", laptopRepository.findAll());
		
		return "shop";  
	}
	
	
	@PostMapping("/api/cart/update-qty")
	@ResponseBody
	public java.util.Map<String, Object> updateCartItemQuantity(@RequestParam("laptopId") int laptopId,
	                                                            @RequestParam("newQty") int newQty,
	                                                            HttpSession session) {
	    java.util.Map<String, Object> response = new java.util.HashMap<>();
	    
	    // 🚨 FIX: Sahi session key "sessionCart" pukaar rahe hain jo Map format mein hai
	    java.util.Map<Integer, CartItem> cart = (java.util.Map<Integer, CartItem>) session.getAttribute("sessionCart");
	    
	    if (cart != null && cart.containsKey(laptopId)) {
	        CartItem item = cart.get(laptopId);
	        
	        // 🛡️ Live Fetch: Humesha database se latest stock verify karein
	        Optional<Laptop> liveLaptopOpt = laptopRepository.findById(laptopId);
	        
	        if (liveLaptopOpt.isPresent()) {
	            Laptop liveLaptop = liveLaptopOpt.get();
	            
	            // Sync instance reference parameters
	            item.getLaptop().setStockQuantity(liveLaptop.getStockQuantity());
	            
	            // Guard Validation Layer
	            if (newQty > liveLaptop.getStockQuantity()) {
	                response.put("success", false);
	                response.put("message", "Requested quantity (" + newQty + ") exceeds available database stock (" + liveLaptop.getStockQuantity() + " left).");
	                return response;
	            }
	            
	            // Set structural balance parameters
	            item.setQuantity(newQty);
	            
	            // Save map back to session state structure
	            session.setAttribute("sessionCart", cart);
	            
	            // Recalculate runtime parameters metrics values
	            double newGrandTotal = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
	            int totalItemUnits = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
	            
	            session.setAttribute("grandTotal", newGrandTotal);
	            session.setAttribute("cartCount", totalItemUnits);

	            response.put("success", true);
	            response.put("updatedQty", newQty);
	            response.put("finalGrandTotal", newGrandTotal);
	            return response;
	        }
	    }
	    
	    response.put("success", false);
	    response.put("message", "Cart target entry context missing.");
	    return response;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}