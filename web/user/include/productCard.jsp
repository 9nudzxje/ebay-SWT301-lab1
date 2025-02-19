<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="bg-white rounded-lg
     p-4 bg-white rounded-lg shadow-lg flex flex-col justify-between
     transition-transform duration-300 ease-in-out hover:shadow-x1 hover:-translate-y-2 w-auto h-100">
    <a href="product-detail?pid=${param.id}">
        <img class="w-[500px] h-[250px] object-cover rounded-md mb-4" src="${param.image}" alt="">
        <h4 class="text-lg mb-2"><a href="product-detail?pid=${p.id}" title="View Product">${param.productName}</a></h4>
        <c:if test = "${param.stockUnits != 0}">
            <p class="card-text"><span class="mt-12 font-bold text-xl"> $${param.price}</span> </p>  
        </c:if>
        <c:if test = "${param.stockUnits == 0}">
            <p class="card-text">
                <span class="mt-12 font-bold text-xl" style="text-decoration: line-through;"> $${param.price}</span>
            </p>  
            <span style="font-size: 1em; color: rgba(0, 0, 0, 0.5);">Sold Out</span>
        </c:if>    
    </a>
</div>



