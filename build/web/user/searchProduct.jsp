<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>
            <nav class="">
                <ol class="flex space-x-4 mb-4 mt-4 text-xs">
                    <li class="">
                        <a href="./user-home" class="text-decoration-none">Home</a>
                    </li>
                    <li> > </li>
                    <li class="">
                        <a href="./search-product?categorySelect=0&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=" class="text-decoration-none">Category</a>
                    </li>
                </ol>
            </nav>
            <div class ="container mt-4 flex space-x-4">
                <div>
                    <ul class="mb-4">
                        <li class="relative inline-block text-left">
                            <nav>
                                Sort by name :
                            </nav>
                            <div id="dropdownSortMenu" class="left-1">
                                <label class="block px-4 py-2">
                                    <input type="radio" name="sortName" value="A-Z" class="mr-2"> Name: A-Z
                                </label>
                                <label class="block px-4 py-2">
                                    <input type="radio" name="sortName" value="Z-A" class="mr-2"> Name: Z-A
                                </label>
                            </div>
                        </li>
                    </ul>
                </div>    
                <br/>
                <div class="max-w-[1420px] mx-auto">
                    <div id="productList" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                        <c:forEach items="${productList}" var="p">
                            <div class="bg-white rounded-lg
                                 p-4 bg-white rounded-lg shadow-lg flex flex-col justify-between
                                 transition-transform duration-300 ease-in-out hover:shadow-x1 hover:-translate-y-2 w-auto h-auto" data-name="${p.productName}" data-price="${p.price}">
                                <a href="product-detail?pid=${p.id}">
                                    <img class="w-[500px] h-[250px] object-cover rounded-md mb-4" src="${p.image}" alt="">
                                    <h4 class="text-lg mb-2"><a href="product-detail?pid=${p.id}" title="View Product">${p.productName}</a></h4>
                                    <p class="text-2xl font-bold mb-4">$ ${p.price}</p>
                                </a>
                            </div>
                        </c:forEach> 
                    </div>
                </div>
            </div>
            <br/>
            <nav aria-label="Page navigation" class="mb-3">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}&searchKey=${currentKey}&sortOrder=${currentOrder}" 
                           tabindex="-1">Previous</a>
                    </li>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}&searchKey=${currentKey}&sortOrder=${currentOrder}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}&searchKey=${currentKey}&sortOrder=${currentOrder}">Next</a>
                    </li>
                </ul>
            </nav>

            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
            <script src = "resources/script/jquery-3.7.1.min.js"></script>
            <script src="resources/script/script.js"></script>
            <script>
                $(document).ready(function () {
                    $('#reset-button').click(function () {
                        let currentCategory = $(this).data('current-category');
                        window.location.href = "search-product?categorySelect=" + currentCategory;
                    });
                });
            </script>
            <script>
                function sortProducts() {
                    const products = Array.from(document.querySelectorAll("#productList > div"));  // Select all product cards
                    const sortPrice = document.querySelector('input[name="sortPrice"]:checked');
                    const sortName = document.querySelector('input[name="sortName"]:checked');

                    if (sortPrice) {
                        if (sortPrice.value === "low-to-high") {
                            products.sort((a, b) => parseFloat(a.dataset.price) - parseFloat(b.dataset.price));
                        } else if (sortPrice.value === "high-to-low") {
                            products.sort((a, b) => parseFloat(b.dataset.price) - parseFloat(a.dataset.price));
                        }
                    }

                    if (sortName) {
                        if (sortName.value === "A-Z") {
                            products.sort((a, b) => a.dataset.name.localeCompare(b.dataset.name));
                        } else if (sortName.value === "Z-A") {
                            products.sort((a, b) => b.dataset.name.localeCompare(a.dataset.name));
                        }
                    }

                    // Update the DOM with the sorted products
                    const productList = document.getElementById("productList");
                    productList.innerHTML = "";
                    products.forEach(product => productList.appendChild(product));
                }

                // Event listeners for sorting options
                document.querySelectorAll('input[name="sortPrice"]').forEach(radio => {
                    radio.addEventListener('change', sortProducts);
                });

                document.querySelectorAll('input[name="sortName"]').forEach(radio => {
                    radio.addEventListener('change', sortProducts);
                });
            </script>

        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
