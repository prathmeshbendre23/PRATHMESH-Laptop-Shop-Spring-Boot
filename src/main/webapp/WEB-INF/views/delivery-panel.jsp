<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logistics Gateway | Delivery Terminal</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-950 text-white font-sans min-h-screen flex flex-col justify-between">

    <header class="h-16 border-b border-white/5 bg-gray-900/60 backdrop-blur-md px-6 flex justify-between items-center sticky top-0 z-50">
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-amber-600 to-orange-500 flex items-center justify-center font-bold text-gray-950">🚚</div>
            <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH LOGISTICS HUB</span>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-xs text-gray-400">Agent Console: <span class="text-amber-400 font-bold">${customerName}</span></span>
            <span class="text-xs text-gray-600">|</span>
            <a href="/logout" class="text-xs font-semibold text-red-400 hover:underline">Logout</a>
        </div>
    </header>

    <main class="p-6 max-w-5xl mx-auto w-full flex-1 space-y-6">
        
        <div>
            <h2 class="text-3xl font-extrabold tracking-tight">Active Shipments Route</h2>
            <p class="text-xs text-gray-400 mt-1">Verify shipping recipient drops and update delivery parameters in real time.</p>
        </div>

        <div class="space-y-4">
            <c:choose>
                <c:when test="${not empty pendingOrders}">
                    <c:forEach var="order" items="${pendingOrders}">
                        
                        <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 hover:border-white/20 transition-all duration-300">
                            
                            <div class="space-y-1.5 flex-1 min-w-0">
                                <span class="px-2 py-0.5 rounded bg-amber-500/10 text-amber-400 text-[10px] font-mono font-bold tracking-wider border border-amber-500/10 uppercase">
                                    In Transit // TXN-${order.orderId}
                                </span>
                                <h3 class="text-base font-bold text-gray-200 mt-1">${order.laptopBrand} - ${order.laptopModel}</h3>
                                
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-4 gap-y-1 text-xs text-gray-400 pt-1">
                                    <p>👤 Recipient: <span class="text-gray-200 font-semibold">${order.shippingName}</span></p>
                                    <p>📞 Phone Contact: <span class="text-gray-200 font-mono">${order.contactMobile}</span></p>
                                    <p>💳 Payment Mode: <span class="text-gray-200 font-bold text-amber-400">${order.paymentMode}</span></p>
                                    <p>💰 Cash Collection: <span class="text-emerald-400 font-bold">₹${order.totalAmount}</span></p>
                                </div>
                                <p class="text-xs text-gray-500 truncate mt-1">📍 Destination: ${order.shippingAddress}</p>
                            </div>

                            <div class="w-full sm:w-auto flex sm:justify-end items-center border-t sm:border-t-0 border-white/5 pt-3 sm:pt-0">
                                <form action="/delivery/updateStatus" method="POST" class="w-full sm:w-auto">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="w-full sm:w-auto px-4 py-2 text-xs font-bold bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-gray-950 uppercase tracking-wider rounded-xl transition-all shadow-lg shadow-emerald-600/10 cursor-pointer">
                                        Mark Delivered ✓
                                    </button>
                                </form>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-16 rounded-2xl bg-white/5 border border-white/10 p-6">
                        <div class="text-4xl mb-3">📦</div>
                        <h3 class="text-base font-bold text-gray-300">All Shipments Cleared</h3>
                        <p class="text-xs text-gray-500 mt-1 max-w-xs mx-auto">No pending cargo packages found for local route delivery right now.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

    <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950/40">
        &copy; 2026 Prathmesh L.S Logistics Systems Inc. Logistics Dispatch Console.
    </footer>

</body>
</html>