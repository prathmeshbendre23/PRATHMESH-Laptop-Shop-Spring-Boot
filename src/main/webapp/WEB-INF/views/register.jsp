<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Prathmesh Laptop Shop</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-900 text-white min-h-screen flex flex-col justify-between relative overflow-x-hidden">

    <div class="absolute inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1920&auto=format&fit=crop" alt="Background" class="w-full h-full object-cover">
        <div class="absolute inset-0 bg-gradient-to-b from-gray-950/80 via-gray-900/70 to-gray-950/90 backdrop-blur-xs"></div>
    </div>

    <main class="relative z-10 flex-1 flex items-center justify-center px-4 py-8">
        <div class="w-full max-w-xl px-6 py-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl shadow-black/40">
            
            <div class="text-center mb-6">
                <h2 class="text-3xl font-extrabold tracking-tight bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">Create Account</h2>
                <p class="text-xs text-gray-400 mt-1">Join the Laptop Store Client Network</p>
            </div>

            <c:if test="${not empty error}">
                <div class="mb-4 p-3 rounded-xl bg-red-500/10 border border-red-500/20 text-xs text-red-400 shadow-md">
                    ⚠️ ${error}
                </div>
            </c:if>

            <form action="/registerCustomer" method="POST" class="space-y-4">
                
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">First Name</label>
                        <input type="text" name="First_Name" required class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Last Name</label>
                        <input type="text" name="Last_Name" required class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200">
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Username</label>
                    <input type="text" name="User_Name" required class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200 font-mono">
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Email ID</label>
                        <input type="email" name="Email_Id" required class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Mobile No</label>
                        <input type="tel" name="Mobile_No" required pattern="[0-9]{10}" placeholder="10-digit number" class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200 font-mono">
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Password</label>
                    <input type="password" name="Password" required class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm text-gray-200">
                </div>

                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Shipping Address</label>
                    <textarea name="Customer_Address" rows="2" required placeholder="Enter complete home or drop-off address station" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm resize-none text-gray-200"></textarea>
                </div>
                
                <button type="submit" class="w-full py-3 mt-2 rounded-xl font-bold text-xs uppercase tracking-wider bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 transition-all duration-300 shadow-lg shadow-blue-600/20 hover:shadow-blue-500/40 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer">
                    Create Customer Account ⚡
                </button>
            </form>

            <div class="text-center mt-4">
                <p class="text-xs text-gray-400">Already have an account? <a href="/login" class="text-blue-400 hover:underline ml-1">Sign In</a></p>
            </div>

        </div>
    </main>

    <footer class="relative z-10 w-full text-center py-4 text-xs text-gray-500 border-t border-white/5 bg-gray-950/20">
        &copy; 2026 Prathmesh L.S Inc. All rights reserved.
    </footer>

</body>
</html>