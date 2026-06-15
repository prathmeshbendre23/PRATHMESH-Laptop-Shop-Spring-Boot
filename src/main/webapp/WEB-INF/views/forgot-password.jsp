<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Prathmesh Laptop Portal</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-900 text-white min-h-screen flex flex-col justify-between relative overflow-hidden">

    <div class="absolute inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1920&auto=format&fit=crop" alt="Background" class="w-full h-full object-cover">
        <div class="absolute inset-0 bg-gradient-to-b from-gray-950/80 via-gray-900/70 to-gray-950/90 backdrop-blur-xs"></div>
    </div>

    <main class="relative z-10 flex-1 flex items-center justify-center px-4">
        <div class="w-full max-w-md px-6 py-10 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl shadow-black/40">
            
            <div class="text-center mb-6">
                <h2 class="text-3xl font-extrabold tracking-tight bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">Reset Password</h2>
                <p class="text-xs text-gray-400 mt-1">Verify account details to apply modifications</p>
            </div>

            <c:if test="${not empty error}">
                <div class="mb-4 p-3 rounded-xl bg-red-500/10 border border-red-500/20 text-xs text-red-400 flex items-center gap-2">
                    <span class="w-1.5 h-1.5 rounded-full bg-red-400"></span>
                    ${error}
                </div>
            </c:if>

            <form action="/resetPassword" method="POST" class="space-y-4">
                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Account Username</label>
                    <input type="text" name="User_Name" required placeholder="Enter your username"
                           class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm">
                </div>

                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">Registered Email ID</label>
                    <input type="email" name="Email_Id" required placeholder="name@domain.com"
                           class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm">
                </div>

                <div>
                    <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-1">New Secure Password</label>
                    <input type="password" name="Password" required placeholder="••••••••"
                           class="w-full px-4 py-2.5 rounded-xl bg-white/5 border border-white/10 focus:border-blue-500 focus:outline-none transition-all text-sm">
                </div>

                <button type="submit" 
                        class="w-full py-3 mt-2 rounded-xl font-medium tracking-wide bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 transition-all duration-300 shadow-lg shadow-blue-600/20 hover:shadow-blue-500/40 hover:-translate-y-0.5 active:translate-y-0">
                    Update Credentials
                </button>
            </form>

            <div class="text-center mt-6">
                <p class="text-xs text-gray-400">Remember credentials? <a href="/login" class="text-blue-400 hover:underline ml-1">Sign In</a></p>
            </div>

        </div>
    </main>

    <footer class="relative z-10 w-full text-center py-4 text-xs text-gray-500 border-t border-white/5 bg-gray-950/20">
        &copy; 2026 Prathmesh L.S Inc. All rights reserved.
    </footer>

</body>
</html>