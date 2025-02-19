<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Brand Manager | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">
    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp"/>
            <div class="container mt-5">
                <h3>Brand manager page</h3>
                <br>
                <div class="container">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>Brand ID</th>
                                <th>Brand Name</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.brandList}" var="brand">
                                <tr>
                                    <td>${brand.id}</td>
                                    <td>${brand.brandName}</td>
                                    <td>
                                        <button class="btn btn-primary" data-bs-toggle="modal"
                                                data-bs-target="#updateBrandModal${brand.id}">Update</button>
                                        <form onsubmit="deleteAlert(event)" style="display: inline-block;" method="post" action="brand-manager">
                                            <input name="deleteId" type="hidden"
                                                   type="text" value="${brand.id}">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                <!-- Modal cập nhật tên nhãn hiệu -->
                            <form method="post" action="brand-manager">
                                <div class="modal fade" id="updateBrandModal${brand.id}" tabindex="-1"
                                     aria-labelledby="updateBrandModal${brand.id}Label" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="updateBrandModal${brand.id}">
                                                    Update</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>

                                            <div class="modal-body">
                                                <label class="form-label" for="id">ID</label>
                                                <input name="id" class="form-control" value="${brand.id}"
                                                       type="number" readonly id="id">

                                                <label class="form-label" for="brandName">Brand Name</label>
                                                <input value="${brand.brandName}" name="brandName"
                                                       class="form-control" type="text" id="brandName">
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Save Change</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </c:forEach>
                        </tbody>
                    </table>

                    <div  class="container mt-3">
                        <button data-bs-toggle="modal" data-bs-target="#addBrandModal" type="button" class="btn btn-success">Add new brand</button>
                    </div>

                    <!-- Modal thêm mới nhãn hiệu -->

                    <div class="modal fade" id="addBrandModal" tabindex="-1" aria-labelledby="addBrandModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="addBrandModalLabel">Add brand</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <form method="post" action="brand-manager">
                                    <div class="modal-body">
                                        <label class="form-label" for="brandName">Brand name</label>
                                        <input name="brandName"
                                               class="form-control" type="text" id="brandName">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Add new</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Làm phân trang -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}" tabindex="-1">Previous</a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>

                </div>
            </div>
        </main>
        <script src="resources/bootstrap-5.3.3-dist/js/sidebar.js"></script>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/script.js"></script>
    </body>
</html>