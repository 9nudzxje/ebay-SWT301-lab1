/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function validatePassword() {
    // Get password and confirm password values
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    // Check if passwords match
    if (password !== confirmPassword) {
        // Show error message and prevent form submission
        document.getElementById('errorMessage').style.display = 'block';
        return false; // Prevent form submission
    }
    // If passwords match, hide error message (just in case it was previously shown)
    document.getElementById('errorMessage').style.display = 'none';
    return true; // Allow form submission
}

function onChangeSubmit(formId) {
    document.getElementById(formId).submit();
}

function deleteAlert(event) {
    if (window.confirm("Do you want to delete this entry?")) {
        return true;
    } else {
        event.preventDefault();
        return false;
    }
}


$('.price').each(function () {
    let currentPrice = $(this).text().replace(/[^\d]/g, ''); // Loại bỏ tất cả ký tự không phải số
    let priceNumber = parseInt(currentPrice, 10); // Chuyển đổi sang số nguyên
    $(this).text(priceNumber.toLocaleString('US') + ' USD'); // Hiển thị giá với định dạng và thêm 'VNĐ'
});





$(document).ready(function () {
    $('.cart').click(function () {
        var productId = $(this).data('product-id');
        console.log(productId);

        $.ajax({
            url: 'add-to-cart',
            type: 'POST',
            data: {productId: productId},
            success: function (response) {
                alert(response.message);
            },
            error: function () {
                alert("Please login to perform this function");
                window.location.href = "./login";
            }
        });
    });

    $('#send-feedback').click(function () {
        let email = $(this).closest('div').find('input').val();
        if (email === "") {
            alert('Please select your email that we know');
            return;
        }
        window.location.href = "contact?email=" + email;
    });
});


