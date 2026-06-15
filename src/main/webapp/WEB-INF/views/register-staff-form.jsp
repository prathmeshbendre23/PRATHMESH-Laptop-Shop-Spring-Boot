<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Corporate Onboarding | Nexus Systems</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-950 text-white font-sans min-h-screen flex items-center justify-center p-4 m-0">

    <div class="w-full max-w-xl px-6 py-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl">
        
        <div class="flex items-center gap-3 mb-6 border-b border-white/5 pb-4">
            <div class="w-9 h-9 rounded-lg bg-gradient-to-tr from-indigo-600 to-purple-500 flex items-center justify-center font-black shadow-lg shadow-indigo-500/20">
                🚀
            </div>
            <div>
                <h2 class="text-xl font-bold tracking-wide">Prathmesh Onboarding Terminal</h2>
                <p class="text-xs text-gray-400">Deploy personal node parameters to activate organization profile</p>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="mb-4 p-3.5 rounded-xl bg-red-500/10 border border-red-500/20 text-xs text-red-400 shadow-md">
                ⚠️ ${error}
            </div>
        </c:if>

        <form action="/submitStaffOnboarding" method="POST" class="space-y-4 text-xs">
            
            <input type="hidden" name="token" value="${token}">

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 bg-gray-950/60 border border-white/5 p-4 rounded-xl">
                <div>
                    <label class="block text-[10px] text-gray-500 uppercase font-mono mb-1">Pre-Assigned Email</label>
                    <p class="text-sm font-semibold text-gray-300 truncate">${emailId}</p>
                </div>
                <div>
                    <label class="block text-[10px] text-gray-500 uppercase font-mono mb-1">Clearance Allocation</label>
                    <span class="inline-flex px-2 py-0.5 mt-0.5 rounded text-[10px] font-bold bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 uppercase tracking-wider">
                        🛡️ ${assignedRole}
                    </span>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-gray-400 font-medium mb-1">First Name</label>
                    <input type="text" name="first_Name" required placeholder="e.g. Amit" 
                           class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all">
                </div>
                <div>
                    <label class="block text-gray-400 font-medium mb-1">Last Name</label>
                    <input type="text" name="last_Name" required placeholder="e.g. Verma" 
                           class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all">
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-gray-400 font-medium mb-1">System Username Handle</label>
                    <input type="text" name="user_Name" required placeholder="e.g. amit_delivery" 
                           class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all font-mono">
                </div>
                <div>
                    <label class="block text-gray-400 font-medium mb-1">Secure Password</label>
                    <input type="password" name="password" required placeholder="Create a strong password" 
                           class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all">
                </div>
            </div>

            <div>
                <label class="block text-gray-400 font-medium mb-1">Contact Terminal (Mobile)</label>
                <input type="tel" name="mobile_No" required pattern="[0-9]{10}" placeholder="10-digit mobile number" 
                       class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all font-mono">
            </div>

            <div>
                <label class="block text-gray-400 font-medium mb-1">Base Operational Address Station</label>
                <textarea name="customer_Address" rows="2" required placeholder="Enter complete home or local station address details here..." 
                          class="w-full px-3.5 py-2.5 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-indigo-500 text-gray-200 transition-all"></textarea>
            </div>

            <button type="submit" class="w-full py-3 mt-2 rounded-xl font-bold uppercase tracking-wider bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-500 hover:to-purple-500 transition-all shadow-lg shadow-indigo-600/20 cursor-pointer text-center">
                Complete Onboarding & Activate ⚡
            </button>
        </form>
    </div>

</body>
</html>