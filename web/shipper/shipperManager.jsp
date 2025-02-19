

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shipper infomation | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">

    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp"/>
            <div class="container mt-5">
                <h3>Account infomation</h3>
                <br>
                <c:set value="${sessionScope.user}" var="admin"/>
                <div class = "container">
                    <table>
                        <tbody>
                            <tr>
                                <td><strong>User name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                <td>${user.fullName}</td>
                            </tr>
                            <tr>
                                <td><strong>Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                <td>${user.email}</td>
                            </tr>  
                            <tr>
                                <td><strong>Address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                <td>${user.address}</td>
                            </tr>
                            <tr>
                                <td><strong>Phone number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                <td>${user.phoneNumber}</td>
                            </tr> 
                            <tr>
                                <td><strong>Role:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                <td>${user.role.roleName}</td>
                            </tr> 
                        </tbody>
                    </table>
                    <br>
                    <form method="post" action="shipper-manager">
                        <input name="changeInfo" value="changeInfo" type="hidden">
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal">
                            Change your personal info
                        </button>

                        <!-- Modal sửa thông tin cá nhân -->
                        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="editModalLabel">Change your personal info</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <label for="fullname" class="form-label">User name</label>
                                        <input value="${user.fullName}" type="text" class="form-control" id="fullname" name="fullname" placeholder="Nhập họ và tên" required>

                                        <label for="email" class="form-label">Email</label>
                                        <input value="${user.email}" type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>

                                        <label for="address" class="form-label">Adddress</label>
                                        <input value="${user.address}" type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ" required>

                                        <label for="phone" class="form-label">Phone number</label>
                                        <input value="${user.phoneNumber}" type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save Change</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>   
                    <br>

                    <form method="post" action="admin-manager" onsubmit="return validatePassword()">
                        <input name="changePwd" value="changePwd" type="hidden">
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#changePwdModal">
                            Change password
                        </button>

                        <!-- Modal đổi mật khẩu-->
                        <div class="modal fade" id="changePwdModal" tabindex="-1" aria-labelledby="changePwdModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="changePwdModalLabel">Change password</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>

                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>

                                        <p id="errorMessage" class="text-danger" style="display:none;">Password not match!</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save change</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>


            </div>
        </main>
        <script src="resources/bootstrap-5.3.3-dist/js/sidebar.js"></script>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/script.js"></script>
    </div>
</body>
</html>
