<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Shopping Cart | PRATHMESH Store</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex flex-col justify-between">

    <header class="h-16 border-b border-white/5 bg-gray-900/60 backdrop-blur-md px-6 flex justify-between items-center sticky top-0 z-50">
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-bold">🛒</div>
            <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH CART</span>
        </div>
        <div class="flex items-center gap-4">
            <a href="/shop" class="text-xs font-medium text-blue-400 hover:underline">Continue Shopping</a>
            <span class="text-xs text-gray-500">|</span>
            <span class="text-xs text-gray-400">👤 User: <span class="text-gray-200 font-semibold">${customerName}</span></span>
        </div>
    </header>

    <main class="p-6 max-w-5xl mx-auto w-full flex-1">
        
        <div class="mb-8">
            <h2 class="text-3xl font-extrabold tracking-tight">Your Shopping Cart</h2>
            <p class="text-xs text-gray-400 mt-1">Review your selected machines before initializing final bulk procurement dispatch.</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
            
            <div class="lg:col-span-2 space-y-4">
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="item" items="${cartItems}">
                            
                            <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 hover:border-white/20 transition-all duration-300">
                                <div class="space-y-1">
                                    <span class="px-2 py-0.5 rounded bg-blue-500/10 text-blue-400 text-[10px] uppercase font-bold tracking-wider border border-blue-500/10">
                                        ${item.laptop.brand}
                                    </span>
                                    <h3 class="text-lg font-bold text-gray-100 mt-1">${item.laptop.modelName}</h3>
                                    <p class="text-xs text-gray-400 font-mono">Specs: ${item.laptop.processor} | ${item.laptop.ramGb}GB RAM</p>
                                    <p class="text-xs text-gray-500">Base Price: ₹<span id="basePrice-${item.laptop.id}">${item.laptop.price}</span></p>
                                </div>

                                <div class="flex sm:flex-col justify-between sm:justify-center items-center sm:items-end w-full sm:w-auto gap-4 border-t sm:border-t-0 border-white/5 pt-3 sm:pt-0">
                                    
                                    <div class="flex items-center gap-1.5 bg-gray-950 border border-white/10 p-1 rounded-xl">
                                        <button type="button" onclick="updateQuantity(${item.laptop.id}, -1)" class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center font-bold text-xs cursor-pointer transition-all">-</button>
                                        <span id="qty-display-${item.laptop.id}" class="w-8 text-center font-bold font-mono text-xs text-gray-200">${item.quantity}</span>
                                        <button type="button" onclick="updateQuantity(${item.laptop.id}, 1)" class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center font-bold text-xs cursor-pointer transition-all">+</button>
                                    </div>

                                    <div class="text-left sm:text-right">
                                        <p class="text-lg font-black text-emerald-400 font-mono">₹<span id="itemTotal-${item.laptop.id}">${item.totalPrice}</span></p>
                                    </div>
                                    
                                    <form action="/removeFromCart" method="POST">
                                        <input type="hidden" name="laptopId" value="${item.laptop.id}">
                                        <button type="submit" class="px-2.5 py-1 rounded-lg border border-red-500/10 text-red-400 text-[10px] font-bold bg-red-500/5 hover:bg-red-600 hover:text-white transition-all duration-200 cursor-pointer">
                                            Remove 🗑️
                                        </button>
                                    </form>
                                </div>
                            </div>

                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-16 rounded-2xl bg-white/5 border border-white/10 p-6">
                            <div class="text-4xl mb-3">🛒</div>
                            <h3 class="text-base font-bold text-gray-300">Your Cart is Empty</h3>
                            <p class="text-xs text-gray-500 mt-1 max-w-xs mx-auto">You haven't stacked any hardware setups inside your cart yet.</p>
                            <a href="/shop" class="inline-block mt-4 px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-500 text-xs font-bold transition-all shadow-lg shadow-blue-600/20">Browse Laptops</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty cartItems}">
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-2xl backdrop-blur-xl space-y-4 sticky top-24">
                    <h3 class="text-sm uppercase font-bold tracking-wider text-gray-400 border-b border-white/5 pb-3">Bill Summary</h3>
                    
                    <div class="space-y-2 text-xs text-gray-400">
                        <div class="flex justify-between">
                            <span>Secure Packaging:</span>
                            <span class="text-emerald-400 font-medium font-mono">FREE</span>
                        </div>
                        <div class="flex justify-between">
                            <span>Logistics Delivery:</span>
                            <span class="text-emerald-400 font-medium font-mono">FREE</span>
                        </div>
                        <div class="h-px bg-white/5 my-2"></div>
                        
                        <p class="text-[10px] text-indigo-400 font-medium bg-indigo-500/5 p-2 border border-indigo-500/10 rounded-lg text-center">
                            💡 You can apply discount coupons on the next checkout step!
                        </p>

                        <div class="h-px bg-white/5 my-2"></div>
                        <div class="flex justify-between items-end pt-1">
                            <span class="text-sm font-bold text-gray-200">Grand Total Amount:</span>
                            <span class="text-2xl font-black text-emerald-400 font-mono">₹<span id="cartGrandTotal">${grandTotal}</span></span>
                        </div>
                    </div>

                    <form action="/cartCheckout" method="POST" class="pt-2">
                        <button type="submit" class="w-full py-3 rounded-xl font-bold text-xs uppercase tracking-wider bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 active:scale-[0.99] transition-all shadow-lg shadow-blue-600/20 cursor-pointer text-center">
                            Secure Checkout 🔒
                        </button>
                    </form>
                </div>
            </c:if>

        </div>
    </main>

    <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950 mt-12">
        &copy; 2026 Prathmesh Systems Inc. Checkout Engine Console.
    </footer>

    <script>
        function updateQuantity(laptopId, change) {
            let qtyDisplay = document.getElementById("qty-display-" + laptopId);
            let currentQty = parseInt(qtyDisplay.innerText);
            let newQty = currentQty + change;
            
            // Boundary Guard: Can't drop below 1 item row
            if(newQty < 1) return;

            // Hit custom async backend route to alter session state
            fetch('/api/cart/update-qty?laptopId=' + laptopId + '&newQty=' + newQty, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    // Check if response success key is explicitly true
                    if(data.success === true || data.success === "true") {
                        // 1. Update text displays
                        qtyDisplay.innerText = data.updatedQty;
                        
                        let basePrice = parseFloat(document.getElementById("basePrice-" + laptopId).innerText);
                        let calculatedRowTotal = basePrice * data.updatedQty;
                        
                        document.getElementById("itemTotal-" + laptopId).innerText = calculatedRowTotal.toFixed(2);
                        document.getElementById("cartGrandTotal").innerText = data.finalGrandTotal.toFixed(2);
                    } else {
                        // 🚨 POP-UP ALERT FIX: Dynamically handles the custom validation error from controller map
                        alert("⚠️ Stock Limit Restriction Hit!\n\n" + (data.message || "Requested quantity exceeds available warehouse stock."));
                    }
                })
                .catch(err => {
                    console.error("Cart quantity update exception:", err);
                    alert("Unable to process request. Server verification channel disrupted.");
                });
        }
    </script>

</body>
</html>