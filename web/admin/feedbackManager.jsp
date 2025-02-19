<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback management | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/sidebars.css">
    </head>
    <body>
        <main class="d-flex flex-nowrap">
            <jsp:include page="template/sidebar.jsp" />
            <div class="container mt-5">
                <h3>Feedback management</h3>
                <br>
                <div class="container">
                    <label class="form-label" for="status-select">Status filter</label>
                    <select class="form-select" id="status-select">
                        <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Wait for answer</option>
                        <option value="Replied" ${selectedStatus == 'Replied' ? 'selected' : ''}>Answered</option>
                    </select>
                </div>

                <div class="container mt-3">
                    <table class="table table-stripped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User Name</th>
                                <th>Email</th>
                                <th>Content</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${feedbackList}" var="c">

                                <tr>
                                    <td>${c.id}</td>
                                    <td>${c.senderUser.fullName}</td>
                                    <td>${c.senderUser.email}</td>
                                    <td>${c.contactContent}</td>
                                    <td>
                                        <c:if test="${c.status == 'Pending'}">
                                            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#reply${c.id}">Answer</button>
                                            <div class="modal fade" id="reply${c.id}" tabindex="-1" aria-labelledby="label${c.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="label${c.id}">Modal title</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form class="replyForm" method="post" action="feedback-manager">
                                                            <div class="modal-body">
                                                                <p><strong>User name: </strong> ${c.senderUser.fullName}</p>
                                                                <p><strong>Email: </strong>${c.senderUser.email}</p>
                                                                <p><strong>Contact Date: </strong>${c.contactDate}</p>
                                                                <p><strong>Content: </strong><br/>${c.contactContent}</p>
                                                                <hr/>
                                                                <label for="replyTo${c.id}">Reply Content: </label>
                                                                <textarea id="replyTo${c.id}" class="form-control reply-content"></textarea>
                                                                <input type="hidden" class="feedback-id" value="${c.id}"/>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary">Save Change</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>


                                        <c:if test="${c.status == 'Replied'}">
                                            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#detail${c.id}">Detail</button>
                                            <div class="modal fade" id="detail${c.id}" tabindex="-1" aria-labelledby="label${c.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="label${c.id}">Feedback detail</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p><strong>User name: </strong>${c.senderUser.fullName}</p>
                                                            <p><strong>Email: </strong>${c.senderUser.email}</p>
                                                            <p><strong>Contact date: </strong>${c.contactDate}</p>
                                                            <p><strong>Content: </strong><br/>${c.contactContent}</p>
                                                            <hr/>
                                                            <p><strong>User reply: </strong>${c.responderUser.fullName}</p>
                                                            <p><strong>Reply date: </strong>${c.replyDate}</p>
                                                            <p><strong>Reply content: </strong><br/>${c.replyContent}</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Làm phân trang -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}&status=${selectedStatus}" tabindex="-1">Previous</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&status=${selectedStatus}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}&status=${selectedStatus}">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>


        </main>
        <script src="resources/bootstrap-5.3.3-dist/js/sidebar.js"></script>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {

                $('#status-select').change(function () {
                    var status = $(this).val();
                    console.log(status);
                    window.location.href = "feedback-manager?status=" + status;
                });

                $('.replyForm').on('submit', function (event) {
                    event.preventDefault();
                    var feedbackId = $(this).find('.feedback-id').val();
                    var replyContent = $(this).find('.reply-content').val();
                    var formData = {
                        feedbackId: feedbackId,
                        replyContent: replyContent
                    };
                    $.ajax({
                        url: 'feedback-manager',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            if (response.success) {
                                alert(response.message);
                                window.location.href = "feedback-manager?status=Replied";
                            } else {
                                alert('An error occurred, please try again later');
                            }
                        },
                        error: function () {
                            alert('Error connecting to server, please send your feed back later');
                        }
                    })
                });
            });
        </script>
    </body>
</html>
