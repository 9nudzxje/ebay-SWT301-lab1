<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Order Management | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">
    </head>
    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp"/>
            <div class="container mt-5">
                <h3 class="mt-3">Order Management page</h3>
                <form class="container" action="order-manager" method="get">
                    <div class="row" >
                        <div class="col-md-12   ">
                            <label class="form-label" for="status">Status filter</label>
                            <select class="form-select" id="status" name="status">
                                <option ${currentStatus == 'Pending' ? 'selected' : ''} value="Pending">Pending</option>
                                <option ${currentStatus == 'Shipping' ? 'selected' : ''} value="Shipping">Delivering</option>
                                <option ${currentStatus == 'Completed' ? 'selected' : ''} value="Completed">Delivered</option>
                                <option ${currentStatus == 'Cancelled' ? 'selected' : ''} value="Cancelled">Canceled</option>
                            </select>
                        </div>
                    </div>
                    <button class="btn btn-primary mt-3" type="submit">Find order</button>
                </form>

                <div class="container mt-3">
                    <table class="table table-stripeed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Receiver</th>
                                <th>Status</th>
                                <th>Price</th>
                                <th>Order date</th>
                                <th>Delivery date</th>
                                <th>Arrive date</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderList}" var="o">
                                <tr>
                                    <td>${o.id}</td>
                                    <td>${o.recipientName}</td>
                                    <td>${o.orderStatus}</td>
                                    <td class="price">${o.total}</td>
                                    <td>${o.orderDate}</td>
                                    <td>${o.deliveryDate}</td>
                                    <td>${o.receivedDate}</td>
                                    <td>
                                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#order${o.id}">Detail</button>
                                        <!-- Modal chi tiết đơn hàng -->
                                        <div class="modal fade" id="order${o.id}" tabindex="-1" aria-labelledby="label${o.id}" aria-hidden="true">
                                            <div class="modal-dialog modal-xl">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="label${o.id}">Order detail</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <p><strong>Receiver info:</strong></p>
                                                                    <p>Receiver: ${o.recipientName}</p>
                                                                    <p>Address: ${o.deliveryAddress}</p>
                                                                    <p>Phone number: ${o.recipientPhone}</p>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <p><strong>Orderer info: </strong></p>
                                                                    <p>Orderer: ${o.customer.fullName}</p>
                                                                    <p>Email: ${o.customer.email}</p>
                                                                    <p>Phone number: ${o.customer.phoneNumber}</p>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <p><strong>Order info: </strong></p>
                                                                    <p>Order status: ${o.orderStatus}</p>
                                                                    <p>Order date: ${o.orderDate}</p>
                                                                    <p>Delivery date: ${o.deliveryDate}</p>
                                                                    <p>Arrive date: ${o.receivedDate}</p>
                                                                </div>
                                                            </div>	
                                                            <div class="row">
                                                                <table class="table table-stripped">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>STT</th>
                                                                            <th>Product name</th>
                                                                            <th>Price</th>
                                                                            <th>Quantity</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:set value="1" var="index"/>
                                                                        <c:forEach items="${o.orderDetailList}" var="od">
                                                                            <tr>
                                                                                <td>${index}</td>
                                                                                <td>${od.product.productName}</td>
                                                                                <td class="price">${od.unitPrice}</td>
                                                                                <td>${od.quantity}</td>
                                                                            </tr>
                                                                            <c:set value="${index + 1}" var="index"/>
                                                                        </c:forEach>
                                                                        <tr class="text-center">
                                                                            <td colspan="2"><strong>Total</strong></td>
                                                                            <td class="price" colspan="2">${o.total}</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                            <hr/>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <p>Note</p>
                                                                    <p>${o.note}</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <p><strong>delivery person info:</strong></p>
                                                                    <p>Name: ${o.shipper.fullName}</p>
                                                                    <p>Id: ${o.shipper.id}</p>
                                                                    <p>Phone number: ${o.shipper.phoneNumber}</p>
                                                                </div>
                                                            </div>	
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <button style="${currentStatus != 'Pending' ? 'display: none;' : ''}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#assign">Delivery attach</button>

                                        <div class="modal fade" id="assign" tabindex="-1" aria-labelledby="assignLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="assignLabel">delivery division</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <form id="choose-shipper" method="post" action="order-manager">
                                                        <div class="modal-body">
                                                            <input type="hidden" data-order-id = "${o.id}" class="orderId">
                                                            <label class="form-label" for="shipper-list">Choose a delivery person</label>
                                                            <select id="shipper-list" class="form-select">
                                                                <c:forEach items="${shipperList}" var="s">
                                                                    <option value="${s.id}">ID = ${s.id} - ${s.fullName}</option>
                                                                </c:forEach>
                                                            </select>


                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <button style="${(currentStatus == 'Pending' || currentStatus == 'Shipping') ? 'display: none;' : ''}" type="button" data-order-id="${o.id}" class="delete-order btn btn-danger">Delete order</button>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}" 
                               tabindex="-1">Previous</a>
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
        </main>
        <script src="resources/bootstrap-5.3.3-dist/js/sidebar.js"></script>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script src="resources/script/script.js"></script>
        <script>
            $(document).ready(function () {
                $('#choose-shipper').on('submit', function (event) {
                    event.preventDefault();
                    var shipperId = $('#shipper-list').val();
                    var orderId = $(this).find('.orderId').data('order-id');
                    var data = {
                        action: 'assign',
                        shipperId: shipperId,
                        orderId: orderId
                    };

                    $.ajax({
                        url: 'order-manager',
                        type: 'POST',
                        data: data,
                        success: function (response) {
                            console.log(data);
                            if (response.success) {
                                alert('The order has been successfully transferred to the delivery person, moving to the orders being delivered section for tracking');
                                window.location.href = './order-manager?status=Shipping';
                            } else {
                                alert(response.success ? "" : "An error occurred, please try again later");
                            }
                        },
                        error: function () {
                            alert("Error connecting to server");
                        }
                    });
                });

                $('.delete-order').click(function () {
                    var currentOrderCell = $(this).closest('td').closest('tr');
                    if (window.confirm('Do you want to delete this order?')) {
                        var orderId = $(this).data("order-id");

                        $.ajax({
                            url: 'order-manager',
                            type: 'POST',
                            data: {
                                action: 'delete',
                                orderId: orderId
                            },
                            success: function (response) {
                                if (response.success) {
                                    alert('Order deleted successfully');
                                    currentOrderCell.hide();
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

    </body>
</html>
