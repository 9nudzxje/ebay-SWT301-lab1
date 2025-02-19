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
            <jsp:include page="include/carousel.jsp"/>
            <div class="container mt-3">
                <br/>
                <p class="display-6" style="font-weight: bold; font-size: 30px;">MOST POPULAR STUFFS</p>
                <p class="mb-2" style="color: rgba(0, 0, 0, 0.5);">Best seller</p>
                <div class ="row">
                    <c:forEach items="${Cards}" var="p">
                        <div class="col-md-3">
                            <jsp:include page="include/productCard.jsp">
                                <jsp:param name="id" value="${p.id}"/>
                                <jsp:param name="image" value="${p.image}"/>
                                <jsp:param name="price" value="${p.price}"/>
                                <jsp:param name="stockUnits" value="${p.stockUnits}"/>
                                <jsp:param name="productName" value="${p.productName}"/>
                            </jsp:include>
                        </div>
                    </c:forEach>
                </div>	
                <br/>
                <br/>
                <br/>
                <div class ="row">
                    <p class="display-6" style="font-weight: bold; font-size: 30px;">JUST FUMO</p>
                    <p class="mb-2" style="color: rgba(0, 0, 0, 0.5);">Best seller</p>
                    <c:forEach items="${Toys}" var="p">
                        <div class="col-md-3">
                            <jsp:include page="include/productCard.jsp">
                                <jsp:param name="id" value="${p.id}"/>
                                <jsp:param name="image" value="${p.image}"/>
                                <jsp:param name="price" value="${p.price}"/>
                                <jsp:param name="stockUnits" value ="${p.stockUnits}"/>
                                <jsp:param name="productName" value="${p.productName}"/>
                            </jsp:include>
                        </div>
                    </c:forEach>
                </div>
                <br/>
                <br/>
                <br/>
                <div class ="row">
                    <p class="display-6" style="font-weight: bold; font-size: 30px;">TOP MARVEL BOOKS SELLER</p>
                    <p class="mb-2" style="color: rgba(0, 0, 0, 0.5);">Recommended for you</p>
                    <c:forEach items="${Books}" var="p">
                        <div class="col-md-3">
                            <jsp:include page="include/productCard.jsp">
                                <jsp:param name="id" value="${p.id}"/>
                                <jsp:param name="image" value="${p.image}"/>
                                <jsp:param name="price" value="${p.price}"/>
                                <jsp:param name="stockUnits" value ="${p.stockUnits}"/>
                                <jsp:param name="productName" value="${p.productName}"/>
                            </jsp:include>
                        </div>
                    </c:forEach>
                </div>
                <br/>
                <br/>
                <br/>
            </div>
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
                <br/>
            </div>
            <br/>
            <div id="slide_ad" class="relative w-full h-[300px] bg-gray-200
                 rounded-lg overflow-hidden my-9">
                <img src="resources/images/food-banner.png" alt="" 
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
            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
            <script src = "resources/script/jquery-3.7.1.min.js"></script>
            <script src = "resources/script/script.js"></script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
