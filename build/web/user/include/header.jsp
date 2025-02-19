<%@page import="model.Brand"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="dal.CategoryDAO"%>
<%@page import="dal.BrandDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    CategoryDAO cdao = new CategoryDAO();
    List<Category> categoryList = cdao.getAllCategories();
    
    BrandDAO bdao = new BrandDAO();
    List<Brand> brandList = bdao.getAllBrands();
%>
<link rel="stylesheet" 
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<nav class="flex justify-between py-1 text-[14px]">
    <div class="">
        <ul class="flex space-x-4">
            <c:if test="${sessionScope.user == null}">
                <li>Hi!<a href="login" class="underline text-blue-500"> Sign in</a> or 
                    <a href="register" class="underline text-blue-500">register</a>
                </li>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <ul class="nav">
                    <li class="nav-item">
                        <a class="dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">Hi! ${user.fullName}</a>
                        <ul class="dropdown-menu">
                            <c:if test="${user.role.roleName == 'Admin'}">
                                <li class="nav-item"><a href="./admin-manager" class="dropdown-item">Admin manager</a></li>
                                </c:if>
                                <c:if test="${user.role.roleName == 'Customer'}">
                                <li><a class="dropdown-item" href="./user-account">Account setting</a></li>
                                </c:if>
                                <c:if test="${user.role.roleName == 'Shipper'}">
                                <li><a class="dropdown-item" href="./shipper-manager">Shipment</a></li>
                                </c:if>
                            <li><a class="dropdown-item" href ="logout">Sign out</a></li>
                        </ul>
                    </li>
                </ul>
            </c:if>
            <li class="nav-item"><a href="./contact" class="nav-link link-body-emphasis px-2">Help & Contact</a></li>
            <li class="nav-item"><a href="./guarantee" class="nav-link link-body-emphasis px-2">Guarantee information</a></li>
            <li class="nav-item"><a href="./shipping" class="nav-link link-body-emphasis px-2">Shipping policy</a></li>
        </ul>
    </div>        
    <ul class="flex space-x-4">
        <c:if test="${sessionScope.user != null}">
            <ul class="nav">
                <li class="nav-item">
                    <a class="dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">My Ebay</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="./order">My Order</a></li>
                        <li><a class="dropdown-item" href="./contact-history">Feedback History</a></li>
                    </ul>
                </li>
            </ul> 
        </c:if>
        <li><a  href="./contact-history" class="fa text-[20px]" title="Contact history">&#xf0f3;</a></li>
        <li><a href="./add-to-cart" class="fa text-[20px]" title="Your cart">&#xf07a;</a></li>
    </ul>
</nav>
<hr/>
<div class="flex items-center space-x-4 py-4 justify-center">
    <a href="./user-home" class="relative left-3">
        <img src="resources/images/logo.png" class="w-[120px] h-auto" alt="logo"/>
    </a>
    <form id="search" action="search-product" method="GET" class="flex items-center flex-grow max-w-7xl">
        <select class="relative inline-block flex space-x-2 rounded-full py-2 focus:outline-none mr-2
                transition-transform duration-200 ease-in-out hover:shadow-x1 hover:-translate-y-1 text-center" name="categorySelect" id="categorySelect">
            <option ${currentCategory == 0 ? 'selected' : ''} value="0">Shopping</option>
            <c:forEach items="<%= categoryList %>" var="c">
                <option ${currentCategory == c.id ? 'selected' : ''} value="${c.id}">${c.categoryName}</option>
            </c:forEach>
        </select>
        <div class="relative w-full ml-2"> 
            <!-- Search Icon -->
            <span class="absolute inset-y-0 left-3 flex items-center pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" 
                     class="h-5 w-5 text-gray-500" 
                     fill="none" 
                     viewBox="0 0 24 24" 
                     stroke="currentColor">
                <path stroke-linecap="round" 
                      stroke-linejoin="round" 
                      stroke-width="2" 
                      d="M8 12a4 4 0 108 0 4 4 0 00-8 0zm8 4l4 4" />
                </svg>
            </span>
            <!-- Search Bar -->
            <input value="${currentKey}" class="form-control w-full py-1 pl-10 border-1/2
                   border-black rounded-l-full focus:outline-none" type="text" placeholder="Search for anything" id="searchKey" name="searchKey"/>
        </div>
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle border-1/2 border-l-0 border-grey
                    rounded-none rounded-r-full text-[13px] bg-white text-black px-2 py-1/2 w-[150px]" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                Filter
            </button>
            <div class="dropdown-menu p-3" style="min-width: 300px;">
                <div class="mb-3">
                    <label class="form-label" for="brandSelect">Brand</label>
                    <select class="form-select" name="brandSelect" id="brandSelect">
                        <option ${currentBrand == 0 ? 'selected' : ''} value="0">All brand</option>
                        <c:forEach items="<%= brandList %>" var="b">
                            <option ${currentBrand == b.id ? 'selected' : ''} value="${b.id}">${b.brandName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="priceRange">Price</label>
                    <select class="form-select" name="priceRange" id="priceRange">
                        <option ${currentPriceRange == "allRange" ? 'selected' : ''} value="allRange">All price ranges</option>
                        <option ${currentPriceRange == "under10" ? 'selected' : ''} value="under10">Under 10$</option>
                        <option ${currentPriceRange == "10to25" ? 'selected' : ''} value="10to25">10$ to 25$</option>
                        <option ${currentPriceRange == "25to50" ? 'selected' : ''} value="25to50">25$ to 50$</option>
                        <option ${currentPriceRange == "50to100" ? 'selected' : ''} value="50to100">50$ to 100$</option>
                        <option ${currentPriceRange == "100to500" ? 'selected' : ''} value="100to500">100$ to 500$</option>
                        <option ${currentPriceRange == "500to1000" ? 'selected' : ''} value="500to1000">500$ to 1000$</option>
                        <option ${currentPriceRange == "1000to2000" ? 'selected' : ''} value="1000to2000">1000$ to 2000$</option>
                        <option ${currentPriceRange == "2000andUp" ? 'selected' : ''} value="2000andUp">Above 2000$</option>
                    </select>
                </div>     
                <div class="mb-3">
                    <label class="form-label" for="sortOrder">Sort price:</label>
                    <select class="form-select" name="sortOrder" id="sortOrder">
                        <option ${currentOrder == null ? 'selected' : ''} value=0>All order</option>
                        <option ${currentOrder == "asc" ? 'selected' : ''} value="asc">Increase</option>
                        <option ${currentOrder == "desc" ? 'selected' : ''} value="desc">Decrease</option>
                    </select>
                </div>   
                <button class="btn btn-outline-primary w-100" type="button" 
                        onclick="window.location.href = './search-product?categorySelect=0&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=0'">
                    Reset
                </button>
            </div>
        </div>
        <!-- Search Button -->
        <button type="submit" class="mx-3 px-9 py-2 bg-blue-600 text-white rounded-full hover:scale-95 transform transition duration-150">
            Search
        </button>
        <a href="./advanced-search" class="px-4 py-2 text-xs relative right-3 hover:opacity-50 transition-opacity duration-200">Advanced</a>
    </form>

</div>
<hr/>
<div id="menu2" class="item-center">
    <ul class="mb-6 flex space-x-7 py-2 text-[13px] justify-center">
        <c:forEach items="<%= categoryList %>" var="c">
            <a href="search-product?categorySelect=${c.id}&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=" class="${currentCategory == c.id ? 'text-bold underline' : ''}">
                ${c.categoryName}
            </a>
        </c:forEach>
    </ul>
</div>



