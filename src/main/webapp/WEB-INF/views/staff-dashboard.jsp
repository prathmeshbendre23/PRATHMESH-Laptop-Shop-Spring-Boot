<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Console | Prathmesh L.S Management</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex relative overflow-x-hidden">

    <aside class="w-64 bg-gray-900 border-r border-white/10 flex flex-col justify-between hidden md:flex z-20">
        <div>
            <div class="px-6 py-5 flex items-center gap-2 border-b border-white/5">
                <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-amber-600 to-orange-500 flex items-center justify-center font-bold">S</div>
                <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">STAFF CORE</span>
            </div>
            
            <nav class="mt-6 px-4 space-y-1">
                <a href="/staff-dashboard" class="flex items-center gap-3 px-4 py-3 rounded-xl bg-amber-600 text-white font-medium shadow-lg transition-all">
                    <span>📋</span> Staff Overview
                </a>
                <a href="/add-laptops" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>➕</span> Log New Laptop
                </a>
                <a href="/staff-dashboard" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>👥</span> Customer Directory
                </a>
            </nav>
        </div>

        <div class="p-4 border-t border-white/5 bg-gray-950/40">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-amber-500 to-orange-500 flex items-center justify-center font-bold">ST</div>
                <div class="flex-1 overflow-hidden">
                    <p class="text-xs font-semibold truncate text-gray-200">${sessionScope.loggedInUser}</p>
                    <p class="text-[10px] text-amber-400 font-medium tracking-wide">Inventory Clerk</p>
                </div>
            </div>
        </div>
    </aside>

    <div class="flex-1 flex flex-col min-w-0 overflow-y-auto">
        <header class="h-16 border-b border-white/5 bg-gray-900/40 backdrop-blur-md px-6 flex justify-between items-center z-10">
            <h1 class="text-lg font-bold text-gray-200 tracking-wide">Staff Workspace Panel</h1>
            <div class="flex items-center gap-4">
                <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-[11px] font-medium bg-amber-500/10 text-amber-400 border border-amber-500/20">
                    <span class="w-1.5 h-1.5 rounded-full bg-amber-400 animate-pulse"></span> Inventory Mode
                </span>
                <a href="/logout" class="text-xs font-semibold text-red-400 hover:text-red-300 border border-red-500/20 px-3 py-1.5 rounded-lg bg-red-500/5 hover:bg-red-500/10 transition-all">Logout</a>
            </div>
        </header>

        <main class="p-6 space-y-6 flex-1">
            <div class="relative p-6 rounded-2xl bg-gradient-to-r from-amber-900/20 to-orange-900/10 border border-white/10 backdrop-blur-xl shadow-xl">
                <h2 class="text-2xl font-bold mb-1">Operational Station Active, ${sessionScope.loggedInUser}!</h2>
                <p class="text-xs text-gray-400 max-w-xl">As a system Staff member, you are authorized to log new merchandise models and monitor existing registered warehouse stock records.</p>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md">
                    <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase block mb-2">Total Warehouse Stock Models</span>
                    <p class="text-2xl font-bold tracking-tight">${laptopsCount} <span class="text-xs text-amber-400 ml-1 font-normal">Active Models</span></p>
                </div>
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-md">
                    <span class="text-xs font-semibold tracking-wider text-gray-400 uppercase block mb-2">Registered Buyers Directory</span>
                    <p class="text-2xl font-bold tracking-tight">${customersCount} <span class="text-xs text-blue-400 ml-1 font-normal">Profiles</span></p>
                </div>
            </div>

            <div class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden">
                <div class="px-6 py-4 border-b border-white/5 bg-gray-900/20">
                    <h3 class="font-bold text-sm uppercase text-gray-300">Warehouse Laptop Logs</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 border-b border-white/5">
                                <th class="p-4">ID</th>
                                <th class="p-4">Hardware Profile</th>
                                <th class="p-4">Processor Specs</th>
                                <th class="p-4">RAM / NVMe SSD</th>
                                <th class="p-4">Availability Level</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:forEach var="laptop" items="${allLaptops}">
                                <tr class="hover:bg-white/5 transition-colors">
                                    <td class="p-4 font-mono text-gray-500">${laptop.id}</td>
                                    <td class="p-4 font-medium text-blue-400">${laptop.brand} ${laptop.modelName}</td>
                                    <td class="p-4">${laptop.processor}</td>
                                    <td class="p-4 font-mono">${laptop.ramGb} GB / ${laptop.storageGb} GB</td>
                                    <td class="p-4">
                                        <span class="px-2 py-0.5 rounded text-[10px] ${laptop.stockQuantity > 0 ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 'bg-red-500/10 text-red-400 border border-red-500/20'}">
                                            Stock: ${laptop.stockQuantity}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden mt-6">
                <div class="px-6 py-4 border-b border-white/5 bg-gray-900/20">
                    <h3 class="font-bold text-sm uppercase text-gray-300">Customer Matrix (Read Only)</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 border-b border-white/5">
                                <th class="p-4">ID</th>
                                <th class="p-4">Full Legal Name</th>
                                <th class="p-4">Username Handle</th>
                                <th class="p-4">Secure Mail Address</th>
                                <th class="p-4">Contact Terminal</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:forEach var="customer" items="${allCustomers}">
                                <c:if test="${customer.role == 'CUSTOMER'}">
                                    <tr class="hover:bg-white/5 transition-colors">
                                        <td class="p-4 font-mono text-gray-500">${customer.customer_Id}</td>
                                        <td class="p-4 font-medium">${customer.first_Name} ${customer.last_Name}</td>
                                        <td class="p-4 font-mono text-amber-400">@${customer.user_Name}</td>
                                        <td class="p-4 text-gray-400">${customer.email_Id}</td>
                                        <td class="p-4 font-mono">${customer.mobile_No}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>