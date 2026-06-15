<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prathmesh Laptop Store | Premium Laptops</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex flex-col justify-between">

    <header class="h-20 border-b border-white/5 bg-gray-900/60 backdrop-blur-md px-6 flex flex-col sm:flex-row justify-between items-center sticky top-0 z-50 gap-2 sm:gap-0 py-3">
        <div class="flex items-center gap-2">
            <div class="w-9 h-9 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-black shadow-lg shadow-blue-500/20">
                P
            </div>
            <span class="text-xl font-black tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH LAPTOP STORE</span>
        </div>
        
        <div class="flex items-center gap-3">
            <a href="/cart" class="inline-flex items-center gap-2 px-3.5 py-2 rounded-xl text-xs font-bold bg-emerald-500/10 hover:bg-emerald-600 border border-emerald-500/20 text-emerald-400 hover:text-white transition-all duration-300 shadow-md shadow-emerald-600/5">
                <span>🛒</span> View Cart 
                <span class="px-1.5 py-0.5 rounded-md bg-emerald-500 text-gray-950 text-[10px] font-black font-mono">
                    ${sessionScope.cartCount != null ? sessionScope.cartCount : 0}
                </span>
            </a>

            <a href="/my-orders" class="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-bold bg-blue-600/10 hover:bg-blue-600 border border-blue-500/20 text-blue-400 hover:text-white transition-all duration-300">
                📦 My Orders
            </a>
            
            <div class="h-5 w-px bg-white/10 hidden sm:block mx-1"></div>
            
            <span class="text-xs text-gray-400 hidden lg:inline">
                Welcome, <span class="text-gray-200 font-semibold">${customerName}</span>
            </span>
            
            <a href="/logout" class="text-xs font-bold text-red-400 hover:text-red-300 border border-red-500/20 px-3 py-1.5 rounded-xl bg-red-500/5 hover:bg-red-500/10 transition-all duration-300">
                Logout
            </a>
        </div>
    </header>

    <main class="p-6 max-w-7xl mx-auto w-full flex-1">
        
        <c:if test="${not empty message}">
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/20 text-sm text-emerald-400 shadow-lg flex items-center gap-2">
                <span>🎉</span> ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/20 text-sm text-red-400 shadow-lg flex items-center gap-2">
                <span>⚠️</span> ${error}
            </div>
        </c:if>

        <div class="mb-8">
            <h2 class="text-3xl font-extrabold tracking-tight">Explore Live Catalog</h2>
            <p class="text-xs text-gray-400 mt-1">Get the best tech deployed straight to your doorstep</p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 auto-rows-stretch">
            <c:choose>
                <c:when test="${not empty availableLaptops}">
                    <c:forEach var="laptop" items="${availableLaptops}">
                        
                        <div class="rounded-2xl bg-white/5 border border-white/10 p-5 flex flex-col justify-between hover:border-blue-500/40 hover:bg-white/8 transition-all duration-300 shadow-xl group relative overflow-hidden h-full">
                            <div class="absolute -right-10 -top-10 w-24 h-24 bg-blue-500/5 rounded-full blur-2xl group-hover:bg-blue-500/10 transition-all"></div>
                            
                            <div class="relative z-10 flex flex-col flex-1">
                                <div class="flex justify-between items-center mb-4">
                                    <span class="px-2.5 py-1 rounded-md bg-white/5 border border-white/10 text-[10px] font-bold uppercase tracking-wider text-blue-400">
                                        ${laptop.brand}
                                    </span>
                                    <span class="text-xs font-mono font-bold text-emerald-400 bg-emerald-500/5 border border-emerald-500/10 px-2 py-0.5 rounded">
                                        ₹${laptop.price}
                                    </span>
                                </div>

                                <div class="w-full h-48 rounded-xl bg-gray-900/60 border border-white/5 overflow-hidden flex items-center justify-center mb-4 p-4 relative group-hover:border-white/10 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-gray-900 to-gray-950 transition-all duration-300">
                                    <c:choose>
                                        <c:when test="${not empty laptop.imageUrl}">
                                            <img src="${laptop.imageUrl}" alt="${laptop.modelName}" 
                                                 class="max-w-full max-h-full object-contain mix-blend-lighten group-hover:scale-104 transition-transform duration-300">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-4xl filter drop-shadow-[0_0_8px_rgba(59,130,246,0.3)]">💻</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h3 class="text-base font-bold text-gray-100 group-hover:text-blue-400 transition-colors duration-300 line-clamp-1">${laptop.modelName}</h3>
                                
                                <div class="pt-4 space-y-2 text-xs text-gray-400 border-t border-white/5 mt-4 flex-1 flex flex-col justify-end">
                                    <p class="flex justify-between"><span>Processor:</span> <span class="text-gray-200 font-medium font-mono">${laptop.processor}</span></p>
                                    <p class="flex justify-between"><span>Memory Config:</span> <span class="text-gray-200 font-medium">${laptop.ramGb} GB RAM</span></p>
                                    <p class="flex justify-between"><span>Storage Drive:</span> <span class="text-gray-200 font-medium">${laptop.storageGb} GB NVMe SSD</span></p>
                                </div>
                            </div>

                            <div class="mt-6 pt-4 border-t border-white/5 relative z-10 space-y-3">
                                <c:choose>
                                    <c:when test="${laptop.stockQuantity > 0}">
                                        <div class="grid grid-cols-2 gap-2.5">
                                            <form action="/addToCart" method="POST">
                                                <input type="hidden" name="laptopId" value="${laptop.id}">
                                                <button type="submit" class="w-full py-2.5 rounded-xl font-bold text-[11px] uppercase tracking-wider bg-white/5 hover:bg-white/10 border border-white/10 active:scale-[0.98] transition-all duration-200 cursor-pointer text-center">
                                                    🛒 Add To Cart
                                                </button>
                                            </form>
                                            
                                            <form action="/purchaseLaptop" method="POST">
                                                <input type="hidden" name="laptopId" value="${laptop.id}">
                                                <button type="submit" class="w-full py-2.5 rounded-xl font-bold text-[11px] uppercase tracking-wider bg-blue-600 hover:bg-blue-500 active:scale-[0.98] transition-all duration-200 text-center cursor-pointer shadow-md shadow-blue-600/10">
                                                    ⚡ Buy Now
                                                </button>
                                            </form>
                                        </div>
                                        <p class="text-[10px] text-center text-gray-500 font-medium tracking-wide">Available Stock Level: ${laptop.stockQuantity} units</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full py-2.5 rounded-xl font-bold text-xs uppercase tracking-wider bg-gray-900 border border-white/5 text-red-400/60 bg-red-500/5 border-red-500/10 flex items-center justify-center gap-1">
                                            <span>🛑</span> Out of Stock
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-span-full py-16 text-center text-gray-500 rounded-2xl bg-white/5 border border-white/10 shadow-inner">
                        📦 No laptops are currently deployed in the market warehouse. Check back later!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950 mt-12">
        &copy; 2026 Prathmesh Systems Inc. All rights reserved.
    </footer>

</body>
</html>