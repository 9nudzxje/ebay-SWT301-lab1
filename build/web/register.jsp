<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>        
        <div class="h-screen">
            <div class="mb-8 flex justify-between items-center mx-10">
                <a href = "./user-home" class =""><img src="resources/images/logo.png" alt="eBay Logo" class="w-[150px] h-auto"></a>

                <div class="text-lg text-gray cursor-pointer">
                    Already have an account?
                    <a href="login" class="underline">Sign in</a>
                </div>
            </div>
            <br></br>
            <div class="flex justify-center items-center space-x-0">
                <div class="relative left-2">
                    <img src="resources/images/buyer_dweb_individual.jpg" alt="eBay Register" 
                         class="object-cover w-[600px] h-auto rounded-xl">
                </div>
                <div class="p-8 flex flex-col justify-center items-center w-50">
                    <div class="font-bold text-3xl my-3">
                        Create an account
                    </div>
                    <form action="register" method="post" id="signUpForm" class="max-w-[350px]">
                        <input name="signUpEmail" type="email" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="signUpEmail"
                               placeholder="Email" required>
                        <input name="fullName" type="text" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="fullName"
                               placeholder="Username" required>
                        <!-- Password -->
                        <input name="signUpPassword" type="password" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="signUpPassword" placeholder="Password" required>

                        <!-- Confirm Password -->
                        <input name="confirmPassword" type="password" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="confirmPassword" placeholder="Confirm password" required>

                        <input name="address" type="text" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="address"
                               placeholder="Address" required>
                        <input name="phoneNumber" type="tel" class="w-full border border-gray-300 rounded-lg
                               py-2 px-2 mb-3 focus:outline-none focus:border-blue-500" id="phoneNumber"
                               placeholder="Phone number" required>
                        <p id="error-message" style="color: red;"></p>
                        <button type="submit" class="mt-2 w-full bg-blue-600 text-white py-3
                                rounded-full hover:bg-blue-700 focus:outline-none mb-6">Register</button>
                    </form>
                </div>
            </div>
        </div>

        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#signUpForm').on('submit', function (event) {
                    event.preventDefault();
                    var signUpEmail = $('#signUpEmail');
                    var fullName = $('#fullName');
                    var signUpPassword = $('#signUpPassword');
                    var confirmPassword = $('#confirmPassword');
                    var address = $('#address');
                    var phoneNumber = $('#phoneNumber');
                    var formData = {
                        signUpEmail: signUpEmail.val(),
                        fullName: fullName.val(),
                        signUpPassword: signUpPassword.val(),
                        address: address.val(),
                        phoneNumber: phoneNumber.val()
                    };
                    console.log(formData);
                    if (signUpPassword.val() !== confirmPassword.val()) {
                        $('#error-message').text('Mật khẩu không khớp, vui lòng kiểm tra lại');
                        signUpPassword.text("");
                        confirmPassword.text("");
                        return;
                    }

                    $.ajax({
                        url: 'register',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            if (response.success) {
                                alert('Đăng kí thành công, chuyển sang trang đăng nhập để đăng nhập và bắt đầu mua hàng');
                                window.location.href = "login";
                            } else {
                                $('#error-message').text(response.message);
                            }
                        },
                        error: function () {
                            alert('Lỗi kết nối đến server');
                        }
                    });
                }
                );
            });
        </script>
    </body>
</html>
