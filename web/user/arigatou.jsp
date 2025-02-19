<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Successful | eBay</title>
        <link rel="icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100">
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1200px] mx-auto">
            <jsp:include page="include/header.jsp"/>
            <br/>
            <div class="container text-center mt-10 py-10 bg-white rounded-lg shadow-lg">
                <div class="py-6">
                    <h1 class="text-4xl font-bold text-blue-600 mb-4">Thank You for Your Order!</h1> 
                    <p class="text-lg text-gray-700 mb-2">We are delighted to serve you. Your order has been received and will be processed shortly.</p> 
                    <p class="text-lg text-gray-700 mb-2">A confirmation email has been sent to your inbox.</p>
                    <p class="text-md text-gray-500 mt-4">If you need any assistance, please contact us via the phone number or email listed on our website.</p> 
                    <p class="text-md text-gray-500 mt-2">We are always ready to help!</p> 
                    <p class="text-md text-gray-500 mt-4">We hope you have a wonderful shopping experience and look forward to serving you again!</p>
                </div>

                <div class="flex justify-center mt-8 space-x-4">
                    <a href="./order" class="btn btn-info text-lg px-5 py-2">Track Your Delivery</a>
                    <a href="./user-home" class="btn btn-primary text-lg px-5 py-2">Return to Main Page</a>
                </div>
            </div>
            <br/>
            <br/>
            <jsp:include page="include/footer.jsp"/>
        </div>

        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
