<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact history | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
        <jsp:include page="include/header.jsp"/>
        <div class="container">
            <ol class="flex space-x-4 mb-4 mt-4 text-xs">
                    <li class="">
                        <a href="./user-home" class="text-decoration-none">Home</a>
                    </li>
                    <li> > </li>
                    <li class="">
                        <a href="./contact-history" class="text-decoration-none">Contact history</a>
                    </li>
                </ol>
            <table class="mb-3 table table-stripped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>feedback content</th>
                        <th>Create date</th>
                        <th>Reply content</th>
                        <th>Status</th>
                        <th>Reply date</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${contactList}" var="c">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.contactContent}</td>
                            <td>${c.contactDate}</td>
                            <td>${c.replyContent}</td>
                            <td>${c.status}</td>
                            <td>${c.replyDate}</td>
                            <td><button data-contact-id="${c.id}" class="btn btn-danger delete-btn">Delete</button></td>
                        </tr> 
                    </c:forEach>

                </tbody>
            </table>
        </div>

        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.delete-btn').click(function () {
                    if (window.confirm('You want to delete this feedback ?')) {
                        var contactId = $(this).data("contact-id");
                        var thisCell = $(this).closest('tr');
                        $.ajax({
                            url: 'contact-history',
                            type: 'POST',
                            data: {
                                contactId: contactId
                            },
                            success: function (response) {
                                if (response.success) {
                                    alert(response.message);
                                    thisCell.hide();
                                } else {
                                    alert('An error occurred, please try again later');
                                }
                            },
                            error: function () {
                                alert("There was an error connecting to the server, please try again later");
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
