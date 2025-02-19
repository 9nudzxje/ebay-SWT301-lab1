<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">
        <script>
            function onChangeSubmit() {
                document.getElementById("chooseAccountType").submit();
            }

            function validatePassword() {
                // Get values of both password and confirm password fields
                const password = document.getElementById("password").value;
                const confirmPassword = document.getElementById("confirmPassword").value;

                // Check if password and confirm password match
                if (password !== confirmPassword) {
                    document.getElementById("error-message").textContent = "Wrong password";

                    // Optionally clear both password fields
                    document.getElementById("password").value = "";
                    document.getElementById("confirmPassword").value = "";

                    return false; // Prevent form submission
                }

                document.getElementById("error-message").textContent = ""; // Clear any previous error
                return true; // Allow form submission
            }
        </script>
    </head>
    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp"/>
            <div class="container mt-5">
                <h3>Account Manager</h3>
                <br>
                <div class="container">
                    <form id="chooseAccountType" method="get" action="account-manager">
                        <label class="form-label" for="selectRoleID">Account type</label>
                        <select onchange="onChangeSubmit('chooseAccountType')" id="selectRoleID" name="selectRoleID" class="form-select">
                            <option value="0" ${choosenRole == 0 ? 'selected' : '' }>All</option>
                            <c:forEach items="${roleList}" var="role">
                                <option ${choosenRole == role.id ? 'selected' : '' } value="${role.id}">${role.roleName}</option>
                            </c:forEach>
                        </select>
                    </form>
                    <br>
                    <table class ="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.userList}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.address}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phoneNumber}</td>
                                    <td>${user.role.roleName}</td>
                                    <td>
                                        <form onsubmit="deleteAlert(event)" action ="account-manager" method="post" style ="display:inline-block">
                                            <input name="deleteId" value="${user.id}" type="hidden">
                                            <button class = "btn btn-danger">Delete</button> 
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <br>

                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        Add new user
                    </button>

                    <!-- Modal thêm người dùng -->
                    <form onsubmit="return validatePassword();" action = "account-manager" method = "post">
                        <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="addUserModalLabel">Thêm mới người dùng</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>

                                    <div class="modal-body">
                                        <input value="add" type="hidden" name="add">

                                        <label for="email" class="form-label">Email</label>
                                        <input name="email" type="email" class="form-control" id="email"
                                               placeholder="Email" required>

                                        <label for="fullName" class="form-label">Name</label>
                                        <input name="fullName" type="text" class="form-control" id="fullName"
                                               placeholder="Họ và tên" required>

                                        <label for="password" class="form-label">Password</label>
                                        <input name="password" type="password" class="form-control" id="password" placeholder="Password" required>

                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        <input name="confirmPassword" type="password" class="form-control" id="confirmPassword" placeholder="Confirm Password" required>

                                        <label for="address" class="form-label">Address</label>
                                        <input name="address" type="text" class="form-control" id="address"
                                               placeholder="Address" required>

                                        <label for="phoneNumber" class="form-label">Phone number</label>
                                        <input name="phoneNumber" type="tel" class="form-control" id="phoneNumber"
                                               placeholder="Phone number" required>

                                        <label class="form-label" for="chooseRoleID">Select Role</label>
                                        <select class="form-select" name="chooseRoleID" id="chooseRoleID">
                                            <c:forEach items="${roleList}" var="role">
                                                <option value="${role.id}">${role.roleName}</option>
                                            </c:forEach>
                                        </select>
                                        <p id="error-message" style="color: red;"></p>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Add </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Làm phân trang -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&selectRoleID=${choosenRole}" tabindex="-1">Previous</a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&selectRoleID=${choosenRole}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&selectRoleID=${choosenRole}">Next</a>
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
