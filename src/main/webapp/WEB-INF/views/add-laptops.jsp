<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Inventory | Prathmesh L.S Command</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-950 text-white font-sans min-h-screen flex flex-col justify-between">

    <main class="flex-1 flex items-center justify-center p-6">
        <div class="w-full max-w-lg px-6 py-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-xl shadow-2xl">
            <div class="mb-6">
                <h2 class="text-2xl font-bold tracking-tight">Add New Laptop Product</h2>
                <p class="text-xs text-gray-400">Log item specification directly to inventory records</p>
            </div>

            <form action="/saveLaptop" method="POST" class="space-y-4">
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">Brand</label>
                        <input type="text" name="brand" required placeholder="e.g. Dell, ASUS" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">Model Name</label>
                        <input type="text" name="modelName" required placeholder="e.g. Inspiron 15" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                </div>

                <div>
                    <label class="block text-xs text-gray-400 mb-1">Processor</label>
                    <input type="text" name="processor" required placeholder="e.g. Intel i7 13th Gen" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">RAM (GB)</label>
                        <input type="number" name="ramGb" required placeholder="16" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">Storage (GB)</label>
                        <input type="number" name="storageGb" required placeholder="512" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">Price (₹)</label>
                        <input type="number" step="0.01" name="price" required placeholder="65000" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs text-gray-400 mb-1">Stock Quantity</label>
                        <input type="number" name="stockQuantity" required placeholder="10" class="w-full px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500">
                    </div>
                </div>
                <div>
                       <label class="block text-[11px] text-gray-400 font-medium mb-1 uppercase font-mono">Laptop Image URL</label>
                       <input type="url" name="imageUrl" placeholder="https://images.unsplash.com/... or Amazon image link" required
                        class="w-full px-3.5 py-2 rounded-xl bg-white/5 border border-white/10 text-sm focus:outline-none focus:border-blue-500 transition-all text-gray-200">
               </div>

                <button type="submit" class="w-full py-3 mt-2 rounded-xl font-medium bg-blue-600 hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/20">
                    Save to Store Inventory
                </button>
            </form>
        </div>
    </main>

</body>
</html>