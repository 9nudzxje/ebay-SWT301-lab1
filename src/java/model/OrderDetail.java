/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Jigger
 */
public class OrderDetail {

    private int id;
    private int unitPrice;
    private int quantity;
    private int orderId;
    private Product product;

    public OrderDetail() {
    }

    public OrderDetail(int id, int unitPrice, int quantity, int orderId, Product product) {
        this.id = id;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.orderId = orderId;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "id=" + id + ", unitPrice=" + unitPrice + ", quantity=" + quantity + ", orderId=" + orderId + ", product=" + product + '}';
    }

}
