<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Accounts | Command Center</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="m-0 p-0 font-sans antialiased bg-gray-950 text-white min-h-screen flex relative overflow-x-hidden">

    <aside class="w-64 bg-gray-900 border-r border-white/10 flex flex-col justify-between hidden md:flex z-20">
        <div>
            <div class="px-6 py-5 flex items-center gap-2 border-b border-white/5">
                <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-indigo-500 flex items-center justify-center font-bold">P</div>
                <span class="text-lg font-bold tracking-wider bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">PRATHMESH</span>
            </div>
            
            <nav class="mt-6 px-4 space-y-1">
                <a href="/dashboard" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>📊</span> Console Overview
                </a>
                <a href="/dashboard#inventory-section" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>💻</span> Laptop Inventory
                </a>
                <a href="/add-laptops" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>➕</span> Add Laptop
                </a>
                <a href="/dashboard#orders-section" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>🛒</span> Orders Management
                </a>
                <a href="/manage-accounts" class="flex items-center gap-3 px-4 py-3 rounded-xl bg-blue-600 text-white font-medium shadow-lg shadow-blue-600/10 transition-all">
                    <span>👥</span> Accounts & Customers
                </a>
                <a href="#" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-400 hover:text-white hover:bg-white/5 transition-all">
                    <span>⚙️</span> System Settings
                </a>
            </nav>
        </div>
        <div class="p-4 border-t border-white/5 bg-gray-950/40">
            <p class="text-xs font-semibold truncate text-gray-200">${customerName}</p>
            <p class="text-[10px] text-emerald-400 font-medium tracking-wide">Administrator</p>
        </div>
    </aside>

    <div class="flex-1 flex flex-col min-w-0 overflow-y-auto">
        <header class="h-16 border-b border-white/5 bg-gray-900/40 backdrop-blur-md px-6 flex justify-between items-center z-10">
            <h1 class="text-lg font-bold text-gray-200 tracking-wide">Identity & Accounts Terminal</h1>
            <a href="/dashboard" class="text-xs font-semibold text-blue-400 hover:underline">← Back to Dashboard</a>
        </header>

        <main class="p-6 space-y-8 flex-1">
            
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl flex flex-col justify-between">
                    <div>
                        <h3 class="font-bold text-xs tracking-wider uppercase text-indigo-400 mb-3">✉️ Dispatch Staff Token Invite</h3>
                        <form action="/generateInviteLink" method="POST" class="space-y-3 text-xs">
                            <div>
                                <label class="block text-[10px] text-gray-400 uppercase font-mono mb-1">Candidate Email Address</label>
                                <input type="email" name="email" placeholder="candidate@email.com" required 
                                       class="w-full px-3 py-1.5 bg-gray-950 border border-white/10 rounded-xl text-xs text-gray-200 focus:outline-none focus:border-indigo-500 transition-all">
                            </div>
                            <div>
                                <label class="block text-[10px] text-gray-400 uppercase font-mono mb-1">Target Department Clearance</label>
                                <select name="role" required class="w-full px-3 py-1.5 bg-gray-950 border border-white/10 text-gray-300 rounded-xl text-xs focus:outline-none focus:border-indigo-500 transition-all">
                                    <option value="DELIVERY" class="bg-gray-900">Delivery Partner Role</option>
                                    <option value="STAFF" class="bg-gray-900">Warehouse Staff Executive</option>
                                    <option value="OWNER" class="bg-gray-900">Co-Owner Admin Privilege</option>
                                </select>
                            </div>
                            <button type="submit" class="w-full py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl font-bold uppercase tracking-wide transition-all cursor-pointer text-[11px]">
                                Generate Exclusivity Token ✨
                            </button>
                        </form>
                    </div>
                </div>

                <div class="lg:col-span-2 p-5 rounded-2xl bg-white/5 border border-white/10 shadow-xl flex flex-col justify-between">
                    <div>
                        <h3 class="font-bold text-xs tracking-wider uppercase text-emerald-400 mb-2">📡 Live Cryptographic Registry Monitor</h3>
                        <p class="text-[11px] text-gray-400 mb-4">Copy the tokenized onboarding gateway address generated below and send it directly to the designated candidate node parameters:</p>
                        
                        <c:choose>
                            <c:when test="${not empty sessionScope.latestInviteLink}">
                                <div class="p-3 rounded-xl bg-gray-950 border border-emerald-500/20 space-y-2">
                                    <p class="text-[10px] text-emerald-400 font-mono select-all break-all bg-emerald-500/5 p-2 rounded-lg border border-emerald-500/10">
                                        ${sessionScope.latestInviteLink}
                                    </p>
                                    <p class="text-[10px] text-gray-500 italic">💡 Send this temporary endpoint URL to the employee. Link remains alive for 24-hours cycles only.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="py-6 text-center text-gray-500 text-xs border border-dashed border-white/5 rounded-xl flex-1 flex items-center justify-center h-full min-h-[100px]">
                                    No active onboarding token invitation generated in current runtime thread session.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden">
                <div class="px-6 py-4 border-b border-white/5 bg-blue-950/20 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                    <h3 class="font-bold text-sm tracking-wide uppercase text-blue-400">👤 Registered Customer Directory</h3>
                    <div class="relative w-full sm:w-64">
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500 text-xs">🔍</span>
                        <input type="text" id="customerSearch" onkeyup="searchCustomers()" placeholder="Search customer name or username..." 
                               class="w-full pl-9 pr-4 py-1.5 bg-gray-950/60 border border-white/10 rounded-xl text-xs text-gray-200 focus:outline-none focus:border-blue-500 transition-all">
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse" id="customerTable">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 uppercase font-semibold tracking-wider border-b border-white/5">
                                <th class="p-4">Account ID</th>
                                <th class="p-4">Full Name</th>
                                <th class="p-4">Username Handle</th>
                                <th class="p-4">Email Terminal Address</th>
                                <th class="p-4 text-center">Account Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:choose>
                                <c:when test="${not empty customersList}">
                                    <c:forEach var="user" items="${customersList}">
                                        <tr class="hover:bg-white/5 transition-colors">
                                            <td class="p-4 font-mono text-gray-500">USR-${user.customer_Id}</td>
                                            <td class="p-4 font-medium">${user.first_Name} ${user.last_Name}</td>
                                            <td class="p-4 font-mono text-indigo-400">@${user.user_Name}</td>
                                            <td class="p-4 text-gray-400">${user.email_Id}</td>
                                            <td class="p-4 text-center">
                                                <form action="/deleteAccount" method="POST" onsubmit="return confirm('Are you sure you want to permanently purge this customer account?');">
                                                    <input type="hidden" name="accountId" value="${user.customer_Id}">
                                                    <button type="submit" class="px-2.5 py-1.5 bg-red-600/10 hover:bg-red-600 border border-red-500/20 text-red-400 hover:text-white rounded-lg text-[10px] font-bold tracking-wider uppercase transition-all cursor-pointer">
                                                        Purge Account 🗑️
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="p-8 text-center text-gray-500">No active client customer profiles registered in directory.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="rounded-2xl bg-white/5 border border-white/10 shadow-xl overflow-hidden">
                <div class="px-6 py-4 border-b border-white/5 bg-purple-950/20 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                    <h3 class="font-bold text-sm tracking-wide uppercase text-purple-400">🛠️ Active Warehouse Staff Officers</h3>
                    <div class="relative w-full sm:w-64">
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500 text-xs">🔍</span>
                        <input type="text" id="staffSearch" onkeyup="searchStaff()" placeholder="Search officer name or handle..." 
                               class="w-full pl-9 pr-4 py-1.5 bg-gray-950/60 border border-white/10 rounded-xl text-xs text-gray-200 focus:outline-none focus:border-purple-500 transition-all">
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse" id="staffTable">
                        <thead>
                            <tr class="bg-white/5 text-gray-400 uppercase font-semibold tracking-wider border-b border-white/5">
                                <th class="p-4">Staff ID</th>
                                <th class="p-4">Officer Name</th>
                                <th class="p-4">System Handle</th>
                                <th class="p-4">Privilege Role</th>
                                <th class="p-4 text-center">Account Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5 text-gray-300">
                            <c:choose>
                                <c:when test="${not empty staffList}">
                                    <c:forEach var="staff" items="${staffList}">
                                        <tr class="hover:bg-white/5 transition-colors">
                                            <td class="p-4 font-mono text-gray-500">STF-${staff.customer_Id}</td>
                                            <td class="p-4 font-medium">${staff.first_Name} ${staff.last_Name}</td>
                                            <td class="p-4 font-mono text-purple-400">@${staff.user_Name}</td>
                                            <td class="p-4">
                                                <span class="px-2 py-0.5 rounded text-[10px] bg-purple-500/10 text-purple-400 border border-purple-500/20 font-bold uppercase font-mono">
                                                    ${staff.role}
                                                </span>
                                            </td>
                                            <td class="p-4 text-center">
                                                <form action="/deleteAccount" method="POST" onsubmit="return confirm('Are you sure you want to revoke system privileges and delete this staff account?');">
                                                    <input type="hidden" name="accountId" value="${staff.customer_Id}">
                                                    <button type="submit" class="px-2.5 py-1.5 bg-red-600/10 hover:bg-red-600 border border-red-500/20 text-red-400 hover:text-white rounded-lg text-[10px] font-bold tracking-wider uppercase transition-all cursor-pointer">
                                                        Revoke Access 🗑️
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="p-8 text-center text-gray-500">No organizational staff profiles assigned yet.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
        <footer class="text-center py-4 text-xs text-gray-600 border-t border-white/5 bg-gray-950/40">
            &copy; 2026 Prathmesh L.S Systems Inc. Governance & Security Console.
        </footer>
    </div>

    <script>
        function searchCustomers() {
            let input = document.getElementById("customerSearch");
            let filter = input.value.toLowerCase();
            let table = document.getElementById("customerTable");
            let tr = table.getElementsByTagName("tr");

            for (let i = 1; i < tr.length; i++) {
                let row = tr[i];
                if (row.cells.length < 2) continue;

                let fullName = row.cells[1] ? row.cells[1].textContent.toLowerCase() : "";
                let username = row.cells[2] ? row.cells[2].textContent.toLowerCase() : "";

                if (fullName.includes(filter) || username.includes(filter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }

        function searchStaff() {
            let input = document.getElementById("staffSearch");
            let filter = input.value.toLowerCase();
            let table = document.getElementById("staffTable");
            let tr = table.getElementsByTagName("tr");

            for (let i = 1; i < tr.length; i++) {
                let row = tr[i];
                if (row.cells.length < 2) continue;

                let officerName = row.cells[1] ? row.cells[1].textContent.toLowerCase() : "";
                let handle = row.cells[2] ? row.cells[2].textContent.toLowerCase() : "";

                if (officerName.includes(filter) || handle.includes(filter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    </script>
</body>
</html>