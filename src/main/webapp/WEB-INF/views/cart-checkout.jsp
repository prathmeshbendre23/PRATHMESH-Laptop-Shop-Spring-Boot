<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bulk Checkout Gateway | Prathmesh</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-950 text-white font-sans min-h-screen flex items-center justify-center p-4">

    <div class="w-full max-w-3xl px-6 py-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl grid grid-cols-1 md:grid-cols-5 gap-6">
        
        <div class="md:col-span-2 bg-white/5 p-4 rounded-xl border border-white/5 flex flex-col justify-between space-y-4">
            <div>
                <span class="text-[10px] uppercase font-bold tracking-wider text-emerald-400">Package Summary</span>
                
                <div class="mt-4 space-y-3 max-h-48 overflow-y-auto pr-1">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="border-b border-white/5 pb-2 text-xs">
                            <p class="font-bold text-gray-200">${item.laptop.brand} - ${item.laptop.modelName}</p>
                            <p class="text-gray-400">Qty: ${item.quantity} × ₹${item.laptop.price}</p>
                        </div>
                    </c:forEach>
                </div>

                <div class="mt-4 pt-4 border-t border-white/10 space-y-2">
                    <label class="block text-[10px] text-gray-400 uppercase font-mono font-bold tracking-wide">Apply Promo Voucher</label>
                    <div class="flex gap-2">
                        <input type="text" id="voucherCodeField" placeholder="e.g. LAPTOP10" 
                               class="flex-1 px-3 py-1 bg-gray-950 border border-white/10 rounded-lg text-xs uppercase focus:outline-none focus:border-emerald-500 text-gray-200">
                        <button type="button" onclick="validateAndApplyCoupon()" 
                                class="px-3 py-1 bg-emerald-600 hover:bg-emerald-500 text-gray-950 rounded-lg text-[11px] font-black tracking-wide uppercase transition-all cursor-pointer">
                            Apply
                        </button>
                    </div>
                    <p id="couponMsgBox" class="text-[10px] font-medium hidden mt-1"></p>
                </div>
            </div>
            
            <div class="border-t border-white/10 pt-4 space-y-2">
                <div class="flex justify-between text-xs text-gray-400">
                    <span>Cart Subtotal:</span>
                    <span>₹<span id="subtotalValueDisplay">${grandTotal}</span></span>
                </div>
                <div class="flex justify-between text-xs text-emerald-400 hidden" id="discountSummaryRow">
                    <span>Coupon Discount:</span>
                    <span>- ₹<span id="discountValueDisplay">0.00</span></span>
                </div>
                <div class="border-t border-white/5 pt-2">
                    <p class="text-xs text-gray-400">Total Cart Value:</p>
                    <p class="text-2xl font-black text-emerald-400 font-mono">₹<span id="finalBillDisplay">${grandTotal}</span></p>
                </div>
            </div>
        </div>

        <div class="md:col-span-3">
            <div class="mb-4">
                <h2 class="text-xl font-bold tracking-tight">Bulk Shipment Parameters</h2>
                <p class="text-xs text-gray-400">Fill details to dispatch entire hardware cart</p>
            </div>

            <form action="/confirmCartPurchase" method="POST" class="space-y-3.5">
                
                <input type="hidden" name="discountedTotalBill" id="hiddenFinalPayableInput" value="${grandTotal}">

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Recipient Full Name</label>
                    <input type="text" name="shippingName" required placeholder="e.g. Sarvesh Nachankar" class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all">
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Contact Terminal Phone</label>
                    <input type="tel" name="contactMobile" required placeholder="10-digit mobile number" pattern="[0-9]{10}" class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all">
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Global Shipping Address</label>
                    <textarea name="shippingAddress" rows="2" required placeholder="Complete Delivery Address here..." class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all"></textarea>
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Payment Exchange Network</label>
                    <select name="paymentMode" required class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm text-gray-300 focus:outline-none focus:border-blue-500 transition-all">
                        <option value="COD" class="bg-gray-900 text-white">Cash on Delivery (COD)</option>
                        <option value="UPI" class="bg-gray-900 text-white">UPI Gateway Network</option>
                        <option value="CARD" class="bg-gray-900 text-white">Credit / Debit Card Exchange</option>
                    </select>
                </div>

                <button type="submit" class="w-full py-3 mt-2 rounded-xl text-xs font-bold uppercase tracking-wider bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 transition-all shadow-lg shadow-emerald-600/20 cursor-pointer">
                    Place Bulk Orders & Empty Cart 🚀
                </button>
            </form>
        </div>
    </div>

    <script>
        function validateAndApplyCoupon() {
            let code = document.getElementById("voucherCodeField").value;
            let msgBox = document.getElementById("couponMsgBox");
            let subtotal = parseFloat(document.getElementById("subtotalValueDisplay").innerText);

            if (!code.trim()) {
                msgBox.classList.remove("hidden");
                msgBox.className = "text-[10px] font-medium text-red-400 mt-1";
                msgBox.innerText = "Please provide a coupon string.";
                return;
            }

            // Hitting backend rest endpoints asynchronous channel
            fetch('/api/validate-coupon?code=' + code)
                .then(res => res.json())
                .then(data => {
                    msgBox.classList.remove("hidden");
                    
                    if (data.valid) {
                        msgBox.className = "text-[10px] font-medium text-emerald-400 mt-1";
                        msgBox.innerText = data.message;

                        // Calculate reductions math factors
                        let percentage = data.discount;
                        let evaluatedDiscount = (subtotal * percentage) / 100;
                        let netPayableBill = subtotal - evaluatedDiscount;

                        // Inject changes to DOM layout view
                        document.getElementById("discountSummaryRow").classList.remove("hidden");
                        document.getElementById("discountValueDisplay").innerText = evaluatedDiscount.toFixed(2);
                        document.getElementById("finalBillDisplay").innerText = netPayableBill.toFixed(2);

                        // Safe sync inside hidden input payload bound parameter
                        document.getElementById("hiddenFinalPayableInput").value = netPayableBill.toFixed(2);
                    } else {
                        msgBox.className = "text-[10px] font-medium text-red-400 mt-1";
                        msgBox.innerText = data.message;

                        // Fallback reset if voucher validation fails
                        document.getElementById("discountSummaryRow").classList.add("hidden");
                        document.getElementById("finalBillDisplay").innerText = subtotal.toFixed(2);
                        document.getElementById("hiddenFinalPayableInput").value = subtotal.toFixed(2);
                    }
                })
                .catch(err => {
                    console.error("Coupon controller layer network exception: ", err);
                });
        }
    </script>

</body>
</html>