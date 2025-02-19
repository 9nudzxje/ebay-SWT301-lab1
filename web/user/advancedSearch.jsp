<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>            
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden mt-9 mb-9">
                <img src="resources/images/Jewelries.png" alt="Phone_ad" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute right-20 top-1/2
                     transform -translate-y-1/2 pl-20">
                    <p class="mt-4 text-lg text-white">
                        Up to 70% off top jewelries brands
                    </p>
                    <h2 class="text-4xl font-bold text-white">
                        EBAY REFURBISHED
                    </h2>
                    <a href="./search-product?categorySelect=25&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shop now
                    </a>
                </div>
            </div>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/food-banner-1.png" alt="" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute left-10 top-1/2
                     transform -translate-y-1/2 pl-20">
                    <h2 class="text-4xl font-bold text-white">
                        ORDER FOOD NOW
                    </h2>
                    <p class="mt-4 text-lg text-white">
                        New taste new taste!
                    </p>
                    <a href="./search-product?categorySelect=29&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shop now
                    </a>
                </div>
            </div>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/clothing-banner-1.png" alt="" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute left-[450px] top-1/2
                     transform -translate-y-1/2 pl-20">                    
                    <p class="mt-4 text-lg text-white">
                        Style of me
                    </p>
                    <h2 class="text-4xl font-bold text-white">
                        GET YOUR OWN FASHION
                    </h2>
                    <a href="./search-product?categorySelect=20&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shopping
                    </a>
                </div>
            </div>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/pet-banner.png" alt="" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute left-10 top-1/2
                     transform -translate-y-1/2 pl-20">
                    <h2 class="text-4xl font-bold text-white">
                        PET LIFE
                    </h2>
                    <p class="mt-4 text-lg text-white">
                        Cute car, cute doge, feed your budies
                    </p>
                    <a href="./search-product?categorySelect=23&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shop now
                    </a>
                </div>
            </div>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/toy-banner.png" alt="" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute left-[450px] top-1/2
                     transform -translate-y-1/2 pl-20">                    
                    <p class="mt-4 text-lg text-white">
                        Everything is here
                    </p>
                    <h2 class="text-4xl font-bold text-white">
                        TOYS SHOP, POOP
                    </h2>
                    <a href="./search-product?categorySelect=26&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shop now
                    </a>
                </div>
            </div>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/book-banner.png" alt="" 
                     class="absolute inset-0 w-full
                     h-full object-cover">
                <div class="absolute right-[200px] top-1/2
                     transform -translate-y-1/2 pl-20">
                    <h2 class="text-4xl font-bold text-white">
                        READING EXPERIENCE
                    </h2>
                    <p class="mt-4 text-lg text-white">
                        Simply way to study new knowledge
                    </p>
                    <a href="./search-product?categorySelect=19&searchKey=&brandSelect=0&priceRange=allRange" 
                       class="inline-block mt-6 px-6 py-2 bg-white
                       text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">
                        Shop now
                    </a>
                </div>
            </div>           
            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
            <script src = "resources/script/jquery-3.7.1.min.js"></script>
            <script src = "resources/script/script.js"></script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
