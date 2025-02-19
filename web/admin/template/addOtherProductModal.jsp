<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addOther">
    Add Product
</button>
<form style="display:inline-block" method="post" action="product-manager" enctype="multipart/form-data">
    <!-- Modal -->
    <input type="hidden" name="add" value="addOther"/>
    <div class="modal fade" id="addOther" tabindex="-1" aria-labelledby="addOtherLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="addOtherLabel">Add product</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label" for="otherName">Product name</label>
                            <input type="txt" class="form-control" id="otherName" name="otherName"/>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label" for="otherCategory">Category</label>
                            <select class="form-select" name="otherCategory" id="otherCategory">
                                <c:forEach items="${categoryList}" var="c" begin = "0">
                                    <option value="${c.id}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label" for="otherBrand">Brand</label>
                            <select class="form-select" id="otherBrand" name="otherBrand">
                                <c:forEach items="${brandList}" var="b">
                                    <option value="${b.id}">${b.brandName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label" for="otherPrice">price</label>
                            <input type="number" class="form-control" id="otherPrice" name="otherPrice"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <label class="form-label" for="otherDescription">Description</label>
                            <textarea class="form-control" id="otherDescription" name="otherDescription"></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label" for="otherWarranty">Warranty info</label>
                            <input type="text" class="form-control" id="otherWarranty" name="otherWarranty"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="otherStock">Depot</label>
                            <input type="number" class="form-control" id="otherStock" name="otherStock"/>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="otherImage">Image</label>
                            <input type="file" id="otherImage" name="otherImage" class="form-control-file">
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </div>
        </div>
    </div>
</form>