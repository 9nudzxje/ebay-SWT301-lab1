<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product management | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">
    </head>
    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp"/>
            <div class="container mt-5">
                <h3>Product management page</h3>
                <br>
                <div class="container">
                    <form id="search" action="product-manager" method="get" class="row">
                        <div class="col-md-4">
                            <label class="form-label" for="categorySelect">By category:</label>
                            <select class="form-select" name="categorySelect" id="categorySelect" onchange="onChangeSubmit('search')">
                                <option ${currentCategory == 0 ? 'selected' : ''} value="0">All category</option>
                                <c:forEach items="${categoryList}" var="c">
                                    <option ${currentCategory == c.id ? 'selected' : ''} value="${c.id}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label" for="brandSelect">By brand:</label>
                            <select class="form-select" name="brandSelect" id="brandSelect" onchange="onChangeSubmit('search')">
                                <option ${currentBrand == 0 ? 'selected' : ''} value="0">All brand</option>
                                <c:forEach items="${brandList}" var="b">
                                    <option  ${currentBrand == b.id ? 'selected' : ''} value="${b.id}">${b.brandName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label" for="priceRange">By Price:</label>
                            <select class="form-select" name="priceRange" id="priceRange" onchange="onChangeSubmit('search')">
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
                    </form>
                    <br><!-- comment -->

                    <table class="table table-light">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Product name</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productList}" var="p">
                                <tr>
                                    <td><img src="${p.image}" width="40" height="40" alt="alt" /></td>
                                    <td>${p.productName}</td>
                                    <td>${p.category.categoryName}</td>
                                    <td>${p.brand.brandName}</td>
                                    <td class="price">${p.price}</td>
                                    <td>${p.stockUnits}</td>
                                    <td>
                                        <button type="button" class="btn btn-info" data-bs-toggle="modal"
                                                data-bs-target="#detailsModal${p.id}">Detail</button>
                                        <button  data-bs-toggle="modal" data-bs-target="#editModal${p.id}" class="btn btn-primary">Update</button>
                                        <jsp:include page="template/editOtherProductModal.jsp">
                                            <jsp:param name="id" value="${p.id}" />
                                            <jsp:param name="productName" value="${p.productName}" />
                                            <jsp:param name="brandId" value="${p.brand.id}" />
                                            <jsp:param name="categoryId" value="${p.category.id}" />
                                            <jsp:param name="generalInfo" value="${p.generalInfo}" />
                                            <jsp:param name="warrantyInfo" value="${p.warrantyInfo}" />
                                            <jsp:param name="price" value="${p.price}" />
                                            <jsp:param name="stockUnits" value="${p.stockUnits}" />
                                        </jsp:include>

                                        <form onsubmit="deleteAlert(event)" style="display:inline-block" method="post" action="product-manager">
                                            <input name="delete" type="hidden" value="${p.id}"/>
                                            <button type="submit" class ="btn btn-danger">Delete</button>
                                        </form>

                                    </td>
                                </tr>
                                <!-- Modal chi tiết sản phẩm -->
                                <!-- Modal -->
                            <div class="modal fade" id="detailsModal${p.id}" tabindex="-1"
                                 aria-labelledby="detailsModalLabel${p.id}" aria-hidden="true">
                                <div class="modal-dialog modal-xl">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="detailsModalLabel${p.id}">Product detail</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Clcpue"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-6"><img src="${p.image}" width="500" height="500" alt="alt" /></div>
                                                <div class="col-md-6">        
                                                        <p><strong>Product id: </strong>${p.id}</p>
                                                        <p><strong>Product name: </strong>${p.productName}</p>
                                                        <p><strong>Brand: </strong>${p.brand.brandName}</p>
                                                        <p><strong>Description: </strong>${p.generalInfo}</p>
                                                        <p><strong>Warranty: </strong>${p.warrantyInfo}</p>
                                                        <p><strong>Price: </strong> <span class="price">${p.price}</span></p>
                                                        <p><strong>Depot: </strong>${p.stockUnits}</p>
                                                        <p><strong>Sold: </strong>${p.unitsSold}</p>
                                             
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>

                    <!-- Thêm mới những sản phẩm khác -->
                    <jsp:include page="template/addOtherProductModal.jsp"/>

                    <!-- Làm phân trang -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}" 
                                   tabindex="-1">Previous</a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&brandSelect=${currentBrand}&categorySelect=${currentCategory}&priceRange=${currentPriceRange}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>
        <script src="resources/bootstrap-5.3.3-dist/js/sidebar.js"></script>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script src="resources/script/script.js"></script>
    </body>

</html>