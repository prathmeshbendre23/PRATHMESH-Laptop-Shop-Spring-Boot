<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Secure Gateway | PRATHMESH</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-950 text-white font-sans min-h-screen flex items-center justify-center p-4">

    <div class="w-full max-w-2xl px-6 py-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl grid grid-cols-1 md:grid-cols-5 gap-6">
        
        <div class="md:col-span-2 bg-white/5 p-4 rounded-xl border border-white/5 flex flex-col justify-between">
            <div>
                <span class="text-[10px] uppercase font-bold tracking-wider text-blue-400">Order Summary</span>
                <h3 class="text-xl font-bold mt-1 text-gray-100">${laptop.brand}</h3>
                <p class="text-sm text-gray-400">${laptop.modelName}</p>
                
                <div class="mt-4 space-y-1.5 text-xs text-gray-400">
                    <p>💾 Specs: ${laptop.ramGb}GB / ${laptop.storageGb}GB</p>
                    <p>⚙️ CPU: ${laptop.processor}</p>
                </div>

                <div class="mt-6 pt-4 border-t border-white/10 space-y-2">
                    <label class="block text-[10px] text-gray-400 uppercase font-mono font-bold">Have a Promo Code?</label>
                    <div class="flex gap-2">
                        <input type="text" id="voucherCodeInput" placeholder="e.g. LAPTOP10" 
                               class="flex-1 px-3 py-1 bg-gray-950 border border-white/10 rounded-lg text-xs uppercase focus:outline-none focus:border-blue-500 text-gray-200">
                        <button type="button" onclick="applySinglePurchaseCoupon()" 
                                class="px-3 py-1 bg-indigo-600 hover:bg-indigo-500 rounded-lg text-[11px] font-bold transition-all cursor-pointer">
                            Apply
                        </button>
                    </div>
                    <p id="couponFeedback" class="text-[10px] font-medium hidden mt-1"></p>
                </div>
            </div>
            
            <div class="border-t border-white/10 pt-4 mt-6 space-y-2">
                <div class="flex justify-between text-xs text-gray-400">
                    <span>Base Price:</span>
                    <span>₹<span id="basePriceDisplay">${laptop.price}</span></span>
                </div>
                <div class="flex justify-between text-xs text-emerald-400 hidden" id="discountRow">
                    <span>Voucher Discount:</span>
                    <span>- ₹<span id="discountDisplay">0.00</span></span>
                </div>
                <div class="border-t border-white/5 pt-1.5">
                    <p class="text-xs text-gray-400">Total Payable Amount:</p>
                    <p class="text-2xl font-black text-emerald-400">₹<span id="finalPayableDisplay">${laptop.price}</span></p>
                </div>
            </div>
        </div>

        <div class="md:col-span-3">
            <div class="mb-4">
                <h2 class="text-xl font-bold tracking-tight">Delivery Manifest Details</h2>
                <p class="text-xs text-gray-400">Specify secure drop-off parameters</p>
            </div>

            <form action="/confirmPurchase" method="POST" class="space-y-3.5">
                <input type="hidden" name="laptopId" value="${laptop.id}">
                
                <input type="hidden" name="discountedPrice" id="finalPriceHidden" value="${laptop.price}">

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Recipient Full Name</label>
                    <input type="text" name="shippingName" required placeholder="e.g. Rahul Sharma" class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all">
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Contact Terminal (Mobile)</label>
                    <input type="tel" name="contactMobile" required placeholder="10-digit mobile number" pattern="[0-9]{10}" class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all">
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Shipping Drop-off Address</label>
                    <textarea name="shippingAddress" rows="2" required placeholder="House No, Street, Landmark, City, Pincode" class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all"></textarea>
                </div>

                <div>
                    <label class="block text-[11px] text-gray-400 font-medium mb-1">Secure Payment Mode</label>
                    <select name="paymentMode" required class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm text-gray-300 focus:outline-none focus:border-blue-500 transition-all">
                        <option value="COD" class="bg-gray-900 text-white">Cash on Delivery (COD)</option>
                        <option value="UPI" class="bg-gray-900 text-white">Instant UPI Network Exchange</option>
                        <option value="CARD" class="bg-gray-900 text-white">Credit / Debit Transaction Card</option>
                    </select>
                </div>

                <button type="submit" class="w-full py-3 mt-2 rounded-xl text-xs font-bold uppercase tracking-wider bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 transition-all shadow-lg shadow-blue-600/20 cursor-pointer">
                    Confirm & Dispatch Order ⚡
                </button>
            </form>
        </div>
    </div>

    <script>
        function applySinglePurchaseCoupon() {
            let code = document.getElementById("voucherCodeInput").value;
            let feedback = document.getElementById("couponFeedback");
            let basePrice = parseFloat(document.getElementById("basePriceDisplay").innerText);
            
            if(!code.trim()) {
                feedback.classList.remove("hidden");
                feedback.className = "text-[10px] font-medium text-red-400 mt-1";
                feedback.innerText = "Please input coupon string first.";
                return;
            }

            // Hitting rest endpoint channel async
            fetch('/api/validate-coupon?code=' + code)
                .then(response => response.json())
                .then(data => {
                    feedback.classList.remove("hidden");
                    
                    if (data.valid) {
                        feedback.className = "text-[10px] font-medium text-emerald-400 mt-1";
                        feedback.innerText = data.message;
                        
                        // Percentage math breakdown
                        let pct = data.discount;
                        let computedDiscount = (basePrice * pct) / 100;
                        let finalizedBill = basePrice - computedDiscount;
                        
                        // Alter DOM layers displays
                        document.getElementById("discountRow").classList.remove("hidden");
                        document.getElementById("discountDisplay").innerText = computedDiscount.toFixed(2);
                        document.getElementById("finalPayableDisplay").innerText = finalizedBill.toFixed(2);
                        
                        // Map state variables inside final payload form field
                        document.getElementById("finalPriceHidden").value = finalizedBill.toFixed(2);
                    } else {
                        feedback.className = "text-[10px] font-medium text-red-400 mt-1";
                        feedback.innerText = data.message;
                        
                        // Fallback reset mechanisms
                        document.getElementById("discountRow").classList.add("hidden");
                        document.getElementById("finalPayableDisplay").innerText = basePrice.toFixed(2);
                        document.getElementById("finalPriceHidden").value = basePrice.toFixed(2);
                    }
                })
                .catch(err => {
                    console.error("Voucher runtime connection exception: ", err);
                });
        }
    </script>

</body>
</html>