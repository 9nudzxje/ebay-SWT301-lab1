<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>
            <div class="container mx-auto p-4">
                <!-- Breadcrumb navigation -->
                <ol class="flex space-x-4 mb-6 text-sm text-gray-600">
                    <li class="">
                        <a href="./user-home">Home</a>
                    </li>
                    <li class="text-gray-400">></li>
                    <li class="">
                        <a href="./order">Orders</a>
                    </li>
                </ol>

                <!-- Orders Table -->
                <div class="overflow-x-auto">
                    <table class="table-auto w-full bg-white shadow-md rounded-lg border border-gray-200">
                        <thead class="bg-gray-100 text-gray-700">
                            <tr>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Order ID</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Order Date</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Delivery Date</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Arrival Date</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Product List</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Total Price</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Order Status</th>
                                <th class="py-3 px-4 border-b-2 text-center align-middle">Change</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-800">
                            <c:forEach items="${orderList}" var="o">
                                <tr class="text-center border-b hover:bg-gray-50">
                                    <td class="py-2 px-4">${o.id}</td>
                                    <td class="py-2 px-4">${o.orderDate}</td>
                                    <td class="py-2 px-4">${o.deliveryDate}</td>
                                    <td class="py-2 px-4">${o.receivedDate}</td>
                                    <td class="py-3 px-4 text-left">
                                        <c:forEach items="${o.orderDetailList}" var="d">
                                            <p>Product name: <span class="font-semibold">${d.product.productName}</span></p>
                                            <p>Quantity: <span class="font-semibold">${d.quantity}</span></p>
                                            <hr class="my-2 border-t-2 border-gray-200"/>
                                        </c:forEach>
                                    </td>
                                    <td class="py-2 px-4 text-green-500 font-bold">${o.total} USD</td>
                                    <td class="py-2 px-4">
                                        <span class="px-4 py-2 rounded-lg
                                              ${o.orderStatus == 'Delivered' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}">
                                            ${o.orderStatus}
                                        </span>
                                    </td>
                                    <td class="py-2 px-4">
                                        <c:if test = "${o.orderStatus != 'Completed'}">
                                            <button class="delete-order btn bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg" data-order-id="${o.id}" data-order-status="${o.orderStatus}">
                                                Delete
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
            <script src = "resources/script/jquery-3.7.1.min.js"></script>
            <script src = "resources/script/script.js"></script>
            <script>
                $(document).ready(function () {
                    $('.delete-order').click(function () {
                        var orderStatus = $(this).data('order-status');
                        if (orderStatus === 'Shipping') {
                            alert('The order has been given to the Delivery person for Delivering, for order acceptance');
                            return;
                        }
                        if (window.confirm('Do you want to delete this order?')) {
                            var orderId = $(this).data('order-id');
                            var orderRow = $(this).closest('tr');
                            $.ajax({
                                url: 'order',
                                type: 'POST',
                                data: {
                                    orderId: orderId
                                },
                                success: function (response) {
                                    if (response.success) {
                                        alert('Order deleted successfully');
                                        orderRow.hide();
                                    } else {
                                        alert('An error occurred, please try again later');
                                    }
                                },
                                error: function () {
                                    alert('Error connecting to server, please try again later');
                                }
                            });
                        }

                    });
                });
            </script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
