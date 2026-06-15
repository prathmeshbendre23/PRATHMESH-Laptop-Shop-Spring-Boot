<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome | Prathmesh Laptop Shop</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <style>
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in { animation: fadeInDown 1s ease-out forwards; }
    </style>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-900 text-white min-h-screen flex flex-col justify-between relative overflow-hidden">

    <div class="absolute inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1920&auto=format&fit=crop" 
             alt="Background" 
             class="w-full h-full object-cover">
        <div class="absolute inset-0 bg-gradient-to-b from-gray-950/80 via-gray-900/70 to-gray-950/90 backdrop-blur-xs"></div>
    </div>

    <header class="relative z-10 w-full px-6 py-4 flex justify-between items-center bg-gray-950/30 backdrop-blur-md border-b border-white/10">
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-bold shadow-lg shadow-blue-500/20">
                P
            </div>
            <span class="text-xl font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">Prathmesh</span>
        </div>
        <div class="text-xs text-gray-400 tracking-wide uppercase hidden sm:block">
            Prathmesh Laptop Shop Management System
        </div>
    </header>

    <main class="relative z-10 flex-1 flex flex-col items-center justify-center px-4 text-center">
        <div class="max-w-2xl px-6 py-12 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl shadow-black/40 animate-fade-in">
            
            <%-- Check if session attribute 'loggedInUser' is NOT empty --%>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <div class="mb-4">
                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 mb-4">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span> Active Session
                        </span>
                        <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight mb-4">
                            Welcome Back, <span class="bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">${sessionScope.loggedInUser}</span>!
                        </h1>
                        <p class="text-gray-400 mb-8 max-w-md mx-auto">
                            You have successfully authenticated. Access your dashboard panel or securely log out.
                        </p>
                        <div class="flex flex-col sm:flex-row gap-4 justify-center">
                            <a href="/dashboard" class="px-8 py-3 rounded-xl font-semibold bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 transition-all duration-300 shadow-lg shadow-blue-600/30 hover:shadow-blue-500/50 hover:-translate-y-0.5">
                                Go to Dashboard
                            </a>
                            <a href="/logout" class="px-8 py-3 rounded-xl font-semibold bg-white/5 hover:bg-white/10 border border-white/10 transition-all duration-300 hover:-translate-y-0.5">
                                Logout
                            </a>
                        </div>
                    </div>
                </c:when>
                
                <%-- If user is NOT logged in, show login/register options --%>
                <c:otherwise>
                    <div>
                        <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight mb-4 bg-gradient-to-r from-white via-gray-200 to-gray-400 bg-clip-text text-transparent">
                            Streamline Your Inventory
                        </h1>
                        <p class="text-gray-400 mb-8 max-w-md mx-auto text-sm sm:text-base leading-relaxed">
                            Welcome to the central command hub. Securely manage your account profile, registration records, and platform system credentials.
                        </p>
                        
                        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                            <a href="/login" 
                               class="w-full sm:w-40 px-6 py-3 rounded-xl font-medium tracking-wide text-center bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white transition-all duration-300 shadow-lg shadow-blue-600/20 hover:shadow-blue-500/40 hover:-translate-y-0.5 active:translate-y-0">
                                Sign In
                            </a>
                            <a href="/register" 
                               class="w-full sm:w-40 px-6 py-3 rounded-xl font-medium tracking-wide text-center bg-white/5 hover:bg-white/10 text-white border border-white/10 hover:border-white/20 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 backdrop-blur-md">
                                Create Account
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

    <footer class="relative z-10 w-full text-center py-4 text-xs text-gray-500 border-t border-white/5 bg-gray-950/20">
        &copy; 2026 Prathmesh L.S Inc. All rights reserved.
    </footer>

</body>
</html>