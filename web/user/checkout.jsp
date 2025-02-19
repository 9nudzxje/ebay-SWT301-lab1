<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
        <jsp:include page="include/header.jsp"/>

        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h3 class="mb-4">Order Information</h3>
                    <form id="order-form" method="post">
                        <!-- Recipient Name -->
                        <div class="mb-3">
                            <label for="recipientName" class="form-label">Recipient Name</label>
                            <input type="text" class="form-control" id="name" placeholder="Enter recipient's name">
                        </div>

                        <!-- Delivery Address -->
                        <div class="mb-3">
                            <label for="deliveryAddress" class="form-label">Delivery Address</label>
                            <input type="text" class="form-control" id="address" placeholder="Enter delivery address">
                        </div>

                        <!-- Recipient Phone Number -->
                        <div class="mb-3">
                            <label for="recipientPhone" class="form-label">Recipient Phone Number</label>
                            <input type="tel" class="form-control" id="phone" placeholder="Enter phone number">
                        </div>

                        <!-- Delivery Note -->
                        <div class="mb-3">
                            <label for="note" class="form-label">Delivery Note</label>
                            <textarea class="form-control" id="note" rows="3" placeholder="Enter any notes (if any)"></textarea>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary">Proceed to Order</button>
                    </form>
                </div>

                <div class="col-md-5 order-md-last">
                    <h4 class="d-flex justify-content-between align-items-center mb-4">
                        <span>Shopping Cart</span>
                        <span class="badge bg-primary rounded-pill">${cart.size()}</span>
                    </h4>

                    <ul class="list-group mb-3">
                        <c:forEach items="${cart}" var="c">
                            <li class="list-group-item d-flex justify-content-between lh-sm">
                                <div>
                                    <h6 class="my-0">${c.product.productName}</h6>
                                    <small class="text-muted">Quantity: ${c.quantity}</small>
                                </div>
                                <span class="text-muted price item-price" data-item-price = "${c.product.price * c.quantity}">
                                    ${c.product.price * c.quantity}
                                </span>
                            </li> 
                        </c:forEach>

                        <li class="list-group-item d-flex justify-content-between">
                            <h6 class="my-0">Shipping Fee: </h6>
                            <span>0 VND</span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between">
                            <span>Total: </span>
                            <strong value="" id="sum" class="price"></strong>
                        </li>
                    </ul>
                    <p><strong>Payment Method:</strong> Cash on Delivery</p>
                </div>
            </div>
        </div>

        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script src="resources/script/script.js"></script>
        <script>
            $(document).ready(() => {

                function calculateSum() {
                    let total = 0;
                    $('.item-price').each(function () {
                        console.log($(this).data("item-price"));
                        let itemPrice = $(this).data("item-price");
                        total += itemPrice;
                    });
                    $('#sum').val(total);
                    $('#sum').text(total.toLocaleString('US') + ' USD');
                }

                calculateSum();
                $('#order-form').on('submit', (event) => {
                    event.preventDefault();

                    // Get data from form 
                    var orderInformation = {
                        name: $('#name').val(),
                        address: $('#address').val(),
                        phone: $('#phone').val(),
                        note: $('#note').val(),
                        totalPrice: $('#sum').val()
                    };

                    $.ajax({
                        url: 'checkout',
                        type: 'POST',
                        data: orderInformation,
                        success: function (response) {
                            if (response.success) {
                                alert("Order placed successfully, thank you.");
                                window.location.href = "./arigatou";
                            } else {
                                alert("Order failed");
                            }
                        },
                        error: function () {
                            alert('An error occurred, please try again later.');
                        }
                    });
                });
            });
        </script>
        </div>
    </body>
        <jsp:include page="include/footer.jsp"/>
</html>
