<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<form style="display:inline-block" action ="product-manager" method="post" enctype="multipart/form-data">
    <input name="updateOther" type="hidden" value="${param.id}"/>
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="editModalLabel${param.id}">Cập nhật</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-8">
                            <label class="form-label" for="newName">Tên sản phẩm</label>
                            <input value="${param.productName}" class="form-control" type="text" id="newName"
                                   name="newName">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label" for="newPrice">Đơn giá</label>
                            <input value="${param.price}" class="form-control" type="number" id="newPrice" name="newPrice">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="newBrand" class="form-label">Hãng sản xuất</label>
                            <select name="newBrand" id="newBrand" class="form-select">
                                <c:forEach items="${brandList}" var="b">
                                    <option ${b.id == param.brandId ? 'selected' : ''} value="${b.id}">${b.brandName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="newCategory" class="form-label">Hãng sản xuất</label>
                            <select name="newCategory" id="newCategory" class="form-select">
                                <c:forEach items="${categoryList}" var="c" begin="1">
                                    <option ${c.id == param.categoryId ? 'selected' : ''} value="${c.id}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <label for="newInfo" class="form-label">Thông tin chung</label>
                            <textarea id="newInfo" name="newInfo" class="form-control">${param.generalInfo}</textarea>	
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="newWarranty" class="form-label">Bảo hành</label>
                            <input value="${param.warrantyInfo}" type="text" id="newWarranty" name="newWarranty" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label for="newStockUnits" class="form-label">Đơn vị kho</label>
                            <input value="${param.stockUnits}" type="number" id="newStockUnits" name="newStockUnits" class="form-control">
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="newImg">Hình ảnh</label>
                            <input type="file" id="newImg" name="newImg" class="form-control-file">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </div>
        </div>
    </div>	
</form>
