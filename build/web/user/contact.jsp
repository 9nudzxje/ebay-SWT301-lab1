<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
    <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
        <jsp:include page="include/header.jsp"/>

        <div class="container mt-1">
            <h2 class=" mb-2 text-4xl font-semibold">Contact Us</h2>
            <br/>
            <p class=" mb-2 text-lg">How can we help you today?</p>
            <br/>
            <form id="contact" action ="contact" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Your email address</label>
                    <input value="${email}" name="email" type="email" class="form-control" id="email" placeholder="Enter you email" required>
                </div>
                <div class="mb-3">
                    <label for="message" class="form-label">Contact content</label>
                    <textarea name="content" class="form-control" id="message" rows="5" placeholder="Enter issues you strugle with" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary mb-2 px-[100px]">Sent</button>
            </form>
        </div>

        
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#contact').on('submit', function (event) {
                    event.preventDefault();

                    var data = {
                        email: $('#email').val(),
                        content: $('#message').val()
                    }

                    $.ajax({
                        url: 'contact',
                        type: 'POST',
                        data: data,
                        success: function (response) {
                            if (response.success) {
                                alert(response.message);
                                window.location.href = "./user-home";
                            } else {
                                alert('An error occur, try again');
                            }
                        },
                        error: function () {
                            alert('Time out, try again');
                        }
                    });
                });
            });
        </script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>

