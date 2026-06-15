<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders Ledger | Prathmesh Store</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex flex-col justify-between">

    <header class="h-16 border-b border-white/5 bg-gray-900/60 backdrop-blur-md px-6 flex justify-between items-center sticky top-0 z-50">
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-bold">P</div>
            <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH CUSTOMER CORNER</span>
        </div>
        <div class="flex items-center gap-4">
            <a href="/shop" class="text-xs font-semibold text-blue-400 hover:underline">← Back to Store</a>
            <span class="text-xs text-gray-600">|</span>
            <span class="text-xs text-gray-400">Active User: <span class="text-indigo-400 font-bold">${sessionScope.loggedInUser}</span></span>
            <a href="/logout" class="text-xs font-bold text-red-400 hover:underline ml-2">Logout</a>
        </div>
    </header>

    <main class="p-6 max-w-5xl mx-auto w-full flex-1 space-y-6">
        
        <div>
            <h2 class="text-3xl font-extrabold tracking-tight">Procurement & Order Ledger</h2>
            <p class="text-xs text-gray-400 mt-1">Track active transit lifecycles and view authenticated transaction receipts.</p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div class="p-4 rounded-xl bg-white/5 border border-white/10 flex justify-between items-center">
                <div>
                    <p class="text-[10px] font-bold tracking-wider uppercase text-gray-400">Total Procured</p>
                    <p class="text-2xl font-black font-mono mt-1">${totalOrders != null ? totalOrders : 0}</p>
                </div>
                <span class="text-xl">📦</span>
            </div>
            <div class="p-4 rounded-xl bg-white/5 border border-white/10 flex justify-between items-center">
                <div>
                    <p class="text-[10px] font-bold tracking-wider uppercase text-gray-400">In Shipping / Pending</p>
                    <p class="text-2xl font-black font-mono mt-1 text-amber-400">${pendingOrders != null ? pendingOrders : 0}</p>
                </div>
                <span class="text-xl">🚚</span>
            </div>
            <div class="p-4 rounded-xl bg-white/5 border border-white/10 flex justify-between items-center">
                <div>
                    <p class="text-[10px] font-bold tracking-wider uppercase text-gray-400">Delivered Safe</p>
                    <p class="text-2xl font-black font-mono mt-1 text-emerald-400">${deliveredOrders != null ? deliveredOrders : 0}</p>
                </div>
                <span class="text-xl">✓</span>
            </div>
        </div>

        <div class="space-y-4">
            <c:choose>
                <c:when test="${not empty customerOrders}">
                    <c:forEach var="order" items="${customerOrders}">
                        
                        <div class="p-5 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-xl flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 hover:border-white/20 transition-all duration-300">
                            
                            <div class="space-y-1.5 flex-1 min-w-0">
                                <span class="text-[10px] font-mono font-bold tracking-wider text-gray-500 block">
                                    TRANSACTION REF // NEX-ORD-${order.orderId}
                                </span>
                                <h3 class="text-lg font-black text-gray-100 truncate">${order.laptopBrand} ${order.laptopModel}</h3>
                                
                                <div class="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-gray-400">
                                    <p>💳 Gateway: <span class="text-gray-300 font-semibold">${order.paymentMode}</span></p>
                                    <p>👤 Consignee Name: <span class="text-gray-300 font-semibold">${order.shippingName}</span></p>
                                    <p>📞 Terminal Mob: <span class="text-gray-300 font-semibold font-mono">${order.contactMobile}</span></p>
                                </div>
                                <p class="text-[11px] text-gray-500 truncate max-w-xl">🏠 Destination Drop-off: ${order.shippingAddress}</p>
                            </div>

                            <div class="sm:text-right flex sm:flex-col justify-between w-full sm:w-auto items-center sm:items-end gap-2.5 border-t sm:border-t-0 border-white/5 pt-3 sm:pt-0">
                                <div>
                                    <span class="text-[10px] text-gray-500 uppercase font-bold tracking-wider block hidden sm:block">Amount Charged</span>
                                    <span class="text-2xl font-black text-emerald-400 font-mono">₹${order.totalAmount}</span>
                                </div>
                                
                                <c:choose>
                                    <c:when test="${order.orderStatus == 'PENDING'}">
                                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[11px] font-bold bg-amber-500/10 text-amber-400 border border-amber-500/20">
                                            <span class="w-1.5 h-1.5 rounded-full bg-amber-400 animate-pulse"></span> In Transit / Shipping
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[11px] font-bold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            📦 Successfully Dispatched
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-16 rounded-2xl bg-white/5 border border-white/10 p-6">
                        <div class="text-4xl mb-3">🛒</div>
                        <h3 class="text-base font-bold text-gray-300">No Historical Receipts Logged</h3>
                        <p class="text-xs text-gray-500 mt-1 max-w-xs mx-auto">You haven't dispatched any machine configurations from our main storefront line.</p>
                        <a href="/shop" class="inline-block mt-4 px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-500 text-xs font-bold transition-all shadow-lg shadow-blue-600/20">Browse Catalog Portal</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

    <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950 mt-12">
        &copy; 2026 Prathmesh L.S Systems Inc. Personal Operations Dashboard.
    </footer>

</body>
</html>