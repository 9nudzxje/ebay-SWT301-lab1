/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Jigger
 */
public class CartItem {

    private int id;
    private Product product;
    private int quantity;
    private int cartId;
    private int isSelected;

    public CartItem() {
    }

    public CartItem(int id, Product product, int quantity, int cartId, int isSelected) {
        this.id = id;
        this.product = product;
        this.quantity = quantity;
        this.cartId = cartId;
        this.isSelected = isSelected;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getIsSelected() {
        return isSelected;
    }

    public void setIsSelected(int isSelected) {
        this.isSelected = isSelected;
    }

    @Override
    public String toString() {
        return "CartItem{" + "id=" + id + ", product=" + product + ", quantity=" + quantity + ", cartId=" + cartId + ", isSelected=" + isSelected + '}';
    }

}
