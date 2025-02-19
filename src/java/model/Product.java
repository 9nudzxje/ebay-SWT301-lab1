/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Jigger
 */
public class Product {
    private int id;
    private long price;
    private int unitsSold;
    private int stockUnits;
    private String productName;
    private String warrantyInfo;
    private String generalInfo;
    private Brand brand;
    private Category category;
    private String image;
    public Product() {
    }

    public Product(int id, long price, int unitsSold, int stockUnits, String productName, String warrantyInfo, String generalInfo, Brand brand, Category category, String image) {
        this.id = id;
        this.price = price;
        this.unitsSold = unitsSold;
        this.stockUnits = stockUnits;
        this.productName = productName;
        this.warrantyInfo = warrantyInfo;
        this.generalInfo = generalInfo;
        this.brand = brand;
        this.category = category;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public int getUnitsSold() {
        return unitsSold;
    }

    public void setUnitsSold(int unitsSold) {
        this.unitsSold = unitsSold;
    }

    public int getStockUnits() {
        return stockUnits;
    }

    public void setStockUnits(int stockUnits) {
        this.stockUnits = stockUnits;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getWarrantyInfo() {
        return warrantyInfo;
    }

    public void setWarrantyInfo(String warrantyInfo) {
        this.warrantyInfo = warrantyInfo;
    }

    public String getGeneralInfo() {
        return generalInfo;
    }

    public void setGeneralInfo(String generalInfo) {
        this.generalInfo = generalInfo;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

 
}
