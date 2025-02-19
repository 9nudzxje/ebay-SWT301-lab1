<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AccountDetail | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>

            <div class="mt-5 mb-5 border-2 border-grey rounded-lg">
                <div class = "p-2">
                    <h3 class="text-2xl font-semibold">Your Account</h3>
                    <br>
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
                        </tbody>
                    </table>
                    <br>
                    <div class="flex space-x-4">
                        <form method="post" action="user-account">
                            <input name="changeInfo" value="changeInfo" type="hidden">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn w-[200px] bg-blue-600 text-white py-2
                                    rounded-full hover:bg-blue-700 focus:outline-none mb-6" data-bs-toggle="modal" data-bs-target="#editModal">
                                Edit information
                            </button>

                            <!-- Modal sửa thông tin cá nhân -->
                            <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="editModalLabel">Edit information</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <label for="fullname" class="form-label">User name</label>
                                            <input value="${user.fullName}" type="text" class="form-control" id="fullname" name="fullname" placeholder="User name" required>

                                            <label for="email" class="form-label">Email</label>
                                            <input value="${user.email}" type="email" class="form-control" id="email" name="email" placeholder="Email" required>

                                            <label for="address" class="form-label">Address</label>
                                            <input value="${user.address}" type="text" class="form-control" id="address" name="address" placeholder="Address" required>

                                            <label for="phone" class="form-label">Phone number</label>
                                            <input value="${user.phoneNumber}" type="tel" class="form-control" id="phone" name="phone" placeholder="Phone number" required>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Save change</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>   
                        <br>

                        <form method="post" action="user-account" onsubmit="return validatePassword()">
                            <input name="changePwd" value="changePwd" type="hidden">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn w-[200px] bg-blue-600 text-white py-2
                                    rounded-full hover:bg-blue-700 focus:outline-none mb-6" data-bs-toggle="modal" data-bs-target="#changePwdModal">
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
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>

                                            <label for="confirmPassword" class="form-label">Confirm password</label>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>

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
            </div>


            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
            <script src="resources/script/script.js"></script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
