<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shipping | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .shipping {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>

            <div class="container mb-3">
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10" class="pull-center">
                        <br>
                        <img class="shipping" src="resources/images/shippingPolicy.png" alt="">

                        <br><br>
                        <p><b>1. NOTICE:</b></p><br>
                        <p>- After placing an order, within 12 working hours we will contact you to confirm and verify the information.</p>
                        <p>- Risks that may occur during the shipping process (impacts, moisture, accidents, etc.) may affect the goods. Therefore, please carefully check the goods before signing for receipt. We are not responsible for any discrepancies in the appearance of the goods after you have signed for receipt.</p>
                        <br>
                        <p><b>2. SHIPPING SERVICE PRICE LIST</b></p>
                        <br>

                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Order Value</th>
                                    <th>Free Km Distance</th>
                                    <th>Delivery Time</th>
                                    <th>Fees</th>
                                </tr> 
                            </thead>

                            <tbody>
                                <tr>
                                    <td>$8 - $21</td>
                                    <td></td>
                                    <td>Delivery within 3 hours</td>
                                    <td>Within 15km radius, a fee of $0.85 per delivery. From 16km, $0.26/km up to 45km.</td>
                                </tr>
                                <tr>
                                    <td>$21 - $43</td>
                                    <td>20 km</td>
                                    <td>Delivery within 3 hours</td>
                                    <td>From the 21st km, $0.26/km, maximum distance of 45km.</td>
                                </tr>

                                <tr>
                                    <td>$43 - $128</td>
                                    <td>25km</td>
                                    <td>Delivery within 3 hours</td>
                                    <td>From the 26th km, $0.26/km, maximum distance of 45km.</td>
                                </tr>
                                <tr>
                                    <td>Above $128</td>
                                    <td>35km</td>
                                    <td>Delivery within 4 hours; delivery within 24 hours (36km-45km)</td>
                                    <td>From the 36th km, $0.26/km, maximum distance of 45km.</td>
                                </tr>
                                <tr>
                                    <td>10 computers</td>
                                    <td>50km</td>
                                    <td>As agreed with customer</td>
                                    <td>From the 51st km, $0.43/km, maximum distance of 150km.</td>
                                </tr>

                                <tr>
                                    <td>11-20 computers</td>
                                    <td>100km</td>
                                    <td>As agreed with customer</td>
                                    <td>As agreed with customer</td>
                                </tr> 
                            </tbody>
                        </table>

                        <br>
                        <p>
                            - For customers exceeding the 46km distance limit, we will use a bus service (chosen by the customer) or express delivery. The customer is responsible for the shipping fees.
                        </p>

                        <br>
                        <p>
                            - For orders from $21 to $128 that are bulky and need to be delivered by car, the free distance applies as for motorcycle delivery, and beyond this, a car delivery fee of $0.43/km is applied.
                        </p>
                    </div>
                    <div class="col-md-1"></div>
                </div>
            </div>
            <hr/>
            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
