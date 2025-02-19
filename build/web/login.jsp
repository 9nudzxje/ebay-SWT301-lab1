<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="h-screen">
        <div class=" flex justify-between items-center p-2">
            <a href="./user-home" class="">
            <img src="resources/images/logo.png" alt="eBay Logo" class="w-[150px] h-auto">
            </a>
        </div>
        <br></br>
        <br></br>
        <div  class="flex flex-col items-center justify-center mt-5 p-4 text-center">
            <h1 class="text-4xl font-bold mb-2 text-gray-800">Hello</h1>
            <p class="text-sm text-gray-600 mb-1">
                Sign in to eBay or
                <a href="register" class="text-blue-500">create an account</a>
            </p>
            <!-- Login Form -->
            <form action="login" method="post" id="loginForm" class="bg-white p-8 rounded-lg w-full max-w-sm">
                    <input value="${emailCookie}" name="email" type="email" class="w-full border border-gray-300 rounded-lg
                    py-2 px-4 mb-2 focus:outline-none focus:border-blue-500" id="email"
                           placeholder="Email" required>
                    <input value="${passwordCookie}" name="password" type="password" class="w-full border border-gray-300 rounded-lg
                    py-2 px-4 mb-3 focus:outline-none focus:border-blue-500"
                           id="password" placeholder="Password" required>
                    <p id="error-message" style="color:red;"></p>
                <button type="submit" class="btn btn-primary w-100">Login</button>
                <div class="flex items-center mt-3 justify-center">
                    <input type="checkbox" class="mr-2" id="rememberMe">
                    <label name="rememberMe" class="form-check-label text-sm text-gray-600" for="rememberMe">Stay signed in</label>
                </div>
            </form>
        </div>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(() => {
                $('#loginForm').on('submit', (event) => {
                    event.preventDefault();

                    //Get data from form 
                    var formData = {
                        email: $('#email').val(),
                        password: $('#password').val(),
                        rememberMe: $('#rememberMe').val()
                    };

                    $.ajax({
                        url: 'login',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            console.log("I'm in success function");
                            if (response.success) {
                                window.location.href = './home';
                            } else {
                                $('#error-message').text("Incorrect email or password, please try again");
                            }
                        },
                        error: function () {
                            alert('An error occurred');
                        }
                    });
                });
            });
        </script>
    </body>

</html>