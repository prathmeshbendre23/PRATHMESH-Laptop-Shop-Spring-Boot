<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Prathmesh L.S Command Center</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex relative overflow-x-hidden">

    <aside class="w-64 bg-gray-900 border-r border-white/10 flex flex-col justify-between hidden md:flex z-20">
        <div>
            <div class="px-6 py-5 flex items-center gap-2 border-b border-white/5">
                <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-bold shadow-lg shadow-blue-500/20">
                    P
                </div>
                <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH</span>
            </div>
            
            <nav class="mt-6 px-4 space-y-1">
                <a href="/dashboard" class="flex items-center gap-3 px-4 py-3 rounded-xl bg-blue-600 text-white font-medium shadow-lg shadow-blue-600/10 transition-all">
                    <span>📊</span> Console Overview
                </a>
                <a href="#inventory-section" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>💻</span> Laptop Inventory
                </a>
                <a href="/add-laptops" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>➕</span> Add Laptop
                </a>
                <a href="#orders-section" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>🛒</span> Orders Management
                </a>
                <a href="/manage-accounts" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
               <span>👥</span> Accounts & Customers
                </a>
                <a href="#" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>⚙️</span> System Settings
                </a>
            </nav>
        </div>

        <div class="p-4 border-t border-white/5 bg-gray-950/40">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-indigo-500 to-purple-500 flex items-center justify-center font-bold shadow-md">
                    U
                </div>
                <div class="flex-1 overflow-hidden">
                    <p class="text-xs font-semibold truncate text-gray-200">${sessionScope.loggedInUser}</p>
                    <p class="text-[10px] text-emerald-400 font-medium tracking-wide">Administrator</p>
                </div>
            </div>
        </div>
    </aside>

    <div class="flex-1 flex flex-col min-w-0 overflow-y-auto">
        
        <header class="h-16 border-b border-white/5 bg-gray-900/40 backdrop-blur-md px-6 flex justify-between items-center z-10">
            <h1 class="text-lg font-bold text-gray-200 tracking-wide">Management Console</h1>
            <div class="flex items-center gap-4">
                <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-[11px] font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span> Terminal Secure
                </span>
                <a href="/logout" class="text-xs font-semibold text-red-400 hover:text-red-300 border border-red-500/20 px-3 py-1.5 rounded-lg bg-red-500/5 hover:bg-red-500/10 transition-all">
                    Logout
                </a>
            </div>
        </header>

        <main class="p-6 space-y-6 flex-1">
            
            <div class="relative p-6 sm:p-8 rounded-2xl bg-gradient-to-r from-blue-900/30 to-indigo-900/20 border border-white/10 backdrop-blur-xl shadow-xl overflow-hidden">
                <div class="absolute -right-10 -top-10 w-40 h-40 bg-blue-500/10 rounded-full blur-3xl"></div>
                <div class="relative z-10">
                    <h2 class="text-2xl sm:text-3xl font-extrabold tracking-tight mb-2">Welcome Back, ${sessionScope.loggedInUser}!</h2>
                    <p class="text-sm text-gray-400 max-w-xl leading-relaxed">
                        Here is an overview of your laptop shop operations today. You can monitor laptop storage counts, dispatch tracking info, or handle customer profiles securely.
                    </p>
                </div>
            </div>

            <c:if test="${not empty lowStockItems}">
                <div class="p-4 rounded-2xl bg-red-500/10 border border-red-500/20 shadow-lg shadow-red-500/5">
                    <div class="flex items-start gap-3">
                        <div class="w-7 h-7 rounded-lg bg-red-500/20 text-red-400 flex items-center justify-center font-bold text-sm shrink-0">
                            ⚠️
                        </div>
                        <div class="flex-1">
                            <h4 class="text-sm font-extrabold text-red-400 tracking-wide uppercase">Critical Inventory Alert: Low Stock Warning</h4>
                            <p class="text-xs text-gray-400 mt-0.5">The following hardware configurations are critical or depleted. Restock instantly to avoid customer fulfillment failures:</p>
                            
                            <div class="flex flex-wrap gap-2 mt-3">
                                <c:forEach var="item" items="${lowStockItems}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-xl text-[10px] font-mono font-bold bg-gray-950/60 border border-red-500/30 text-gray-200">
                                        <span class="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                                        ${item.brand} ${item.modelName} 
                                        <span class="text-red-400">(${item.stockQuantity} Left)</span>
                                    </span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md hover:border-white/20 transition-all">
                    <div class="flex justify-between items-start mb-3">
                        <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase">Laptops Tracked</span>
                        <span class="text-lg">💻</span>
                    </div>
                    <p class="text-2xl font-bold tracking-tight">
                        <c:out value="${laptopsCount != null ? laptopsCount : 0}"/> 
                        <span class="text-xs text-blue-400 ml-1 font-normal">Live Items</span>
                    </p>
                </div>
                
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md hover:border-white/20 transition-all">
                    <div class="flex justify-between items-start mb-3">
                        <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase">Total Accounts</span>
                        <span class="text-lg">👥</span>
                    </div>
                    <p class="text-2xl font-bold tracking-tight">
                        <c:out value="${customersCount != null ? customersCount : '342'}"/>
                        <span class="text-xs text-emerald-400 ml-1 font-normal">+4%</span>
                    </p>
                </div>
                
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md hover:border-white/20 transition-all">
                    <div class="flex justify-between items-start mb-3">
                        <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase">Active Shipments</span>
                        <span class="text-lg">📦</span>
                    </div>
                    <p class="text-2xl font-bold tracking-tight text-amber-400">
                        <c:out value="${activeShipments != null ? activeShipments : 0}"/>
                        <span class="text-xs text-gray-400 ml-1 font-normal">Pending</span>
                    </p>
                </div>
                
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md hover:border-white/20 transition-all">
                    <div class="flex justify-between items-start mb-3">
                        <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase">Gross Income</span>
                        <span class="text-lg">💵</span>
                    </div>
                    <p class="text-2xl font-bold tracking-tight text-emerald-400">
                        ₹<c:out value="${grossIncome != null ? grossIncome : '0.00'}"/>
                    </p>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mt-6">
                <div class="lg:col-span-1 p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl">
                    <h4 class="text-xs font-bold uppercase tracking-wider text-blue-400 mb-4">🏷️ Mint New Promo Voucher</h4>
                    <form action="/createNewCoupon" method="POST" class="space-y-3.5">
                        <div>
                            <label class="block text-[11px] text-gray-400 uppercase font-mono mb-1">Coupon Code</label>
                            <input type="text" name="couponCode" placeholder="e.g., LAPTOP10" required 
                                   class="w-full px-3 py-1.5 bg-gray-950/60 border border-white/10 rounded-xl text-xs text-gray-200 uppercase focus:outline-none focus:border-blue-500 transition-all">
                        </div>
                        <div>
                            <label class="block text-[11px] text-gray-400 uppercase font-mono mb-1">Discount Value (%)</label>
                            <input type="number" name="discountPercentage" min="1" max="100" placeholder="e.g., 10" required 
                                   class="w-full px-3 py-1.5 bg-gray-950/60 border border-white/10 rounded-xl text-xs text-gray-200 focus:outline-none focus:border-blue-500 transition-all">
                        </div>
                        <button type="submit" class="w-full py-2 bg-blue-600 hover:bg-blue-500 rounded-xl text-xs font-bold tracking-wide transition-all cursor-pointer">
                            Activate Promo Code ✨
                        </button>
                    </form>
                </div>

                <div class="lg:col-span-2 p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl flex flex-col">
                    <h4 class="text-xs font-bold uppercase tracking-wider text-indigo-400 mb-3">📋 Active Store Discount Vouchers</h4>
                    <div class="overflow-y-auto max-h-40 flex-1 pr-1">
                        <table class="w-full text-left text-xs">
                            <thead>
                                <tr class="text-gray-500 font-mono text-[10px] uppercase border-b border-white/5 pb-2">
                                    <th class="pb-2">Voucher String</th>
                                    <th class="pb-2">Deduction Rate</th>
                                    <th class="pb-2 text-center">Status</th>
                                    <th class="pb-2 text-center">Operation</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/5 text-gray-300">
                                <c:choose>
                                    <c:when test="${not empty allCoupons}">
                                        <c:forEach var="cp" items="${allCoupons}">
                                            <tr>
                                                <td class="py-2.5 font-mono text-indigo-400 font-bold">#${cp.couponCode}</td>
                                                <td class="py-2.5 font-semibold text-emerald-400">${cp.discountPercentage}% OFF</td>
                                                <td class="py-2.5 text-center">
                                                    <span class="px-1.5 py-0.5 text-[9px] font-bold rounded bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">ACTIVE</span>
                                                </td>
                                                <td class="py-2.5 text-center">
                                                    <form action="/expireCoupon" method="POST">
                                                        <input type="hidden" name="couponId" value="${cp.id}">
                                                        <button type="submit" class="px-2 py-0.5 border border-red-500/20 hover:bg-red-600/20 text-red-400 rounded text-[10px] cursor-pointer transition-all">
                                                            Deactivate
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" class="py-6 text-center text-gray-500">No promo discount codes currently floating in system.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div id="inventory-section" class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden pt-1">
                <div class="px-6 py-4 border-b border-white/5 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-gray-900/20">
                    <h3 class="font-bold text-sm tracking-wide uppercase text-gray-300">Live Laptop Inventory Records</h3>
                    <div class="relative w-full sm:w-64">
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500 text-xs">🔍</span>
                        <input type="text" id="laptopSearch" onkeyup="searchLaptops()" placeholder="Search brand, model, core specs..." 
                               class="w-full pl-9 pr-4 py-1.5 bg-gray-950/60 border border-white/10 rounded-xl text-xs text-gray-200 focus:outline-none focus:border-blue-500 transition-all">
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse" id="laptopTable">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 uppercase font-semibold tracking-wider border-b border-white/5">
                                <th class="p-4">ID</th>
                                <th class="p-4">Brand & Model Name</th>
                                <th class="p-4">Processor Type</th>
                                <th class="p-4">RAM / Storage</th>
                                <th class="p-4">Unit Price</th>
                                <th class="p-4">Stock Status</th>
                                <th class="p-4 text-center">Admin Controls</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:choose>
                                <c:when test="${not empty allLaptops}">
                                    <c:forEach var="laptop" items="${allLaptops}">
                                        <tr class="hover:bg-white/5 transition-colors">
                                            <td class="p-4 font-mono text-gray-500">${laptop.id}</td>
                                            <td class="p-4 font-medium flex items-center gap-2">
                                                <span class="w-2 h-2 rounded-full bg-blue-500"></span> 
                                                <c:out value="${laptop.brand}"/> <c:out value="${laptop.modelName}"/>
                                            </td>
                                            <td class="p-4 text-gray-400"><c:out value="${laptop.processor}"/></td>
                                            <td class="p-4 font-mono">${laptop.ramGb} GB / ${laptop.storageGb} GB SSD</td>
                                            <td class="p-4 font-semibold text-emerald-400">₹${laptop.price}</td>
                                            <td class="p-4">
                                                <c:choose>
                                                    <c:when test="${laptop.stockQuantity > 0}">
                                                        <span class="px-2 py-0.5 rounded bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                                            In Stock (${laptop.stockQuantity})
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="px-2 py-0.5 rounded bg-red-500/10 text-red-400 border border-red-500/20">
                                                            Out of Stock
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            
                                            <td class="p-4 flex items-center justify-center gap-3">
                                                <form action="/updateLaptopStock" method="POST" class="flex items-center gap-1.5">
                                                    <input type="hidden" name="laptopId" value="${laptop.id}">
                                                    <input type="number" name="newStock" value="${laptop.stockQuantity}" min="0" required 
                                                           class="w-14 px-2 py-1 bg-white/5 border border-white/10 rounded-lg text-center text-xs text-gray-200 focus:outline-none focus:border-blue-500">
                                                    <button type="submit" class="px-2.5 py-1 bg-blue-600 hover:bg-blue-500 rounded-lg text-[11px] font-bold transition-all cursor-pointer">
                                                        Update
                                                    </button>
                                                </form>

                                                <form action="/deleteLaptop" method="POST" onsubmit="return confirm('Are you sure you want to delete this laptop model permanently?');">
                                                    <input type="hidden" name="laptopId" value="${laptop.id}">
                                                    <button type="submit" class="px-2.5 py-1 bg-red-600/10 hover:bg-red-600 border border-red-500/20 text-red-400 hover:text-white rounded-lg text-[11px] font-bold transition-all cursor-pointer">
                                                        Delete 🗑️
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="p-8 text-center text-gray-500">
                                            No laptops found in warehouse database inventory. Click 'Add Laptop' to log items.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="orders-section" class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden mt-6">
                <div class="px-6 py-4 border-b border-white/5 bg-gray-900/20 flex justify-between items-center">
                    <h3 class="font-bold text-sm uppercase text-gray-300">Live Customer Sales & Logistics Audits</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 uppercase font-semibold tracking-wider border-b border-white/5">
                                <th class="p-4">Transaction ID</th>
                                <th class="p-4">Customer Name</th>
                                <th class="p-4">Laptop Item</th>
                                <th class="p-4">Amount Paid</th>
                                <th class="p-4 text-center">Logistics Status Monitor</th> </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:choose>
                                <c:when test="${not empty allOrders}">
                                    <c:forEach var="order" items="${allOrders}">
                                        <tr class="hover:bg-white/5 transition-colors">
                                            <td class="p-4 font-mono text-gray-500">TXN-${order.orderId}</td>
                                            <td class="p-4 font-medium"><c:out value="${order.customerName}"/></td>
                                            <td class="p-4 text-blue-400"><c:out value="${order.laptopBrand}"/> <c:out value="${order.laptopModel}"/></td>
                                            <td class="p-4 font-semibold text-emerald-400">₹${order.totalAmount}</td>
                                            
                                            <td class="p-4 text-center">
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 'PENDING'}">
                                                        <span class="text-amber-400 font-medium font-mono text-[11px] bg-amber-500/5 px-2.5 py-1 rounded-md border border-amber-500/10 inline-flex items-center gap-1.5">
                                                            <span class="w-1.5 h-1.5 rounded-full bg-amber-400 animate-pulse"></span> In Dispatch Transit
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-emerald-400 font-medium font-mono text-[11px] bg-emerald-500/5 px-2.5 py-1 rounded-md border border-emerald-500/10 inline-flex items-center gap-1.5">
                                                            📦 Delivered to Client
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="p-6 text-center text-gray-500">No active transactions reported yet.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div> 
        </main>

        <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950/40">
            &copy; 2026 Prathmesh L.S Systems Inc. Terminal Core Framework.
        </footer>
    </div>

    <script>
        function searchLaptops() {
            let input = document.getElementById("laptopSearch");
            let filter = input.value.toLowerCase();
            let table = document.getElementById("laptopTable");
            let tr = table.getElementsByTagName("tr");

            for (let i = 1; i < tr.length; i++) {
                let row = tr[i];
                if (row.cells.length < 2) continue;

                let brandAndModel = row.cells[1] ? row.cells[1].textContent.toLowerCase() : "";
                let processor = row.cells[2] ? row.cells[2].textContent.toLowerCase() : "";

                if (brandAndModel.includes(filter) || processor.includes(filter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    </script>
</body>
</html>