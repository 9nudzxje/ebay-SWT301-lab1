/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jigger
 */
public class ProductDAO extends DBContext {

    private String getPriceRange(String priceRange) {
        String result = "";
        if (priceRange == null) {
            return " AND 1=1";
        }
        switch (priceRange) {
            case "allRange" -> {
                result = " AND 1=1";
            }
            case "under10" -> {
                result = " AND [price] < 10";
            }
            case "10to25" -> {
                result = " AND [price] >= 10 AND [price] <= 25";
            }
            case "25to50" -> {
                result = " AND [price] > 25 AND [price] <= 50";
            }
            case "50to100" -> {
                result = " AND [price] > 50 AND [price] <= 100";
            }
            case "100to500" -> {
                result = " AND [price] >= 100 AND [price] <= 500";
            }
            case "500to1000" -> {
                result = " AND [price] >= 500 AND [price] <= 1000";
            }
            case "1000to2000" -> {
                result = " AND [price] >= 1000 AND [price] <= 2000";
            }
            case "2000andUp" -> {
                result = " AND [price] >= 2000";
            }
        }
        return result;
    }

    public List<Product> getProducts(int brandId, int categoryId, int offset, int recordsPerPage, String priceRange, String searchKey, String sortOrder) {
        List<Product> listProduct = new ArrayList<>();
        String sql = """
                    SELECT *
                    FROM [PJ].[dbo].[product]
                    WHERE 1=1
                     """;

        // Tìm kiếm theo brandId nếu có
        if (brandId != 0) {
            sql += " AND [manufacturer_id] = " + brandId;
        }

        // Tìm kiếm theo categoryId nếu có
        if (categoryId != 0) {
            sql += " AND [category_id] = " + categoryId;
        }

        // Tìm kiếm theo tên sản phẩm nếu có
        if (searchKey != null && !searchKey.isEmpty()) {
            sql += " AND [product_name] LIKE '%" + searchKey + "%'";
        }

        // Thêm điều kiện lọc giá nếu có
        sql += getPriceRange(priceRange);

        // Sắp xếp giá theo thứ tự tăng hoặc giảm
        if ("asc".equalsIgnoreCase(sortOrder)) {
            sql += " ORDER BY [price] ASC ";
        } else if ("desc".equalsIgnoreCase(sortOrder)) {
            sql += " ORDER BY [price] DESC ";
        } else {
            sql += " ORDER BY [id]"; // Mặc định nếu không chỉ định sắp xếp
        }
        // Phân trang
        String pagination = """
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY;
                        """;
        sql += pagination;

        try {
            BrandDAO bdao = new BrandDAO();
            CategoryDAO cdao = new CategoryDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, offset);
            st.setInt(2, recordsPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int price = rs.getInt("price");
                int unitsSold = rs.getInt("units_sold");
                int stockUnits = rs.getInt("stock_units");
                String productName = rs.getString("product_name");
                String warrantyInfo = rs.getString("warranty_info");
                String generalInfo = rs.getString("general_info");
                int cid = rs.getInt("category_id");
                int bid = rs.getInt("manufacturer_id");
                String image = rs.getString("image");
                Product p = new Product(
                        id, price, unitsSold, stockUnits, productName, warrantyInfo, generalInfo,
                        bdao.getBrandById(bid), cdao.getCategoryById(cid), image);
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return listProduct;
    }

    public List<Product> getTop4Products(int categoryId) {
        List<Product> listProduct = new ArrayList<>();
        String sql = """
                SELECT TOP 4 [id],
                              [price],
                              [units_sold],
                              [stock_units],
                              [product_name],
                              [warranty_info],
                              [general_info],
                              [category_id],
                              [manufacturer_id],
                              [image]
                FROM [PJ].[dbo].[product]
                WHERE category_id = ?
                ORDER BY [units_sold] DESC;
                 """;
        try (
                PreparedStatement st = connection.prepareStatement(sql);) {
            st.setInt(1, categoryId);
            try (ResultSet rs = st.executeQuery()) {
                BrandDAO bdao = new BrandDAO();
                CategoryDAO cdao = new CategoryDAO();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int price = rs.getInt("price");
                    int unitsSold = rs.getInt("units_sold");
                    int stockUnits = rs.getInt("stock_units");
                    String productName = rs.getString("product_name");
                    String warrantyInfo = rs.getString("warranty_info");
                    String generalInfo = rs.getString("general_info");
                    int bid = rs.getInt("manufacturer_id");
                    String image = rs.getString("image");
                    Product p = new Product(id, price, unitsSold, stockUnits, productName, warrantyInfo, generalInfo,
                            bdao.getBrandById(bid), cdao.getCategoryById(categoryId), image);
                    listProduct.add(p);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return listProduct;
    }

    public int countTotalRecords(int brandId, int categoryId, String priceRange, String searchKey) {
        String sql = """
                        SELECT COUNT(*)
                        FROM [PJ].[dbo].[product]
                        WHERE 1=1
                     """;
        int count = 0;
        String range = getPriceRange(priceRange);
        if (brandId != 0) {
            sql += " AND [manufacturer_id] = " + brandId;
        }
        if (categoryId != 0) {
            sql += " AND [category_id] = " + categoryId;
        }
        if (searchKey != null && !searchKey.isEmpty()) {
            sql += " AND [product_name] LIKE '%" + searchKey + "%'";
        }
        sql += range;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public void addProduct(String productName, int brandId, int categoryId, int price, String generalInfo, String warrantyInfo, int stockUnits, String image) {
        String sql = """
                 INSERT INTO [dbo].[product]
                            ([price]
                            ,[units_sold]
                            ,[stock_units]
                            ,[product_name]
                            ,[warranty_info]
                            ,[general_info]
                            ,[category_id]
                            ,[manufacturer_id]
                            ,[image])
                      VALUES
                            (?,?,?,?,?,?,?,?,?)
                """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, price);
            st.setInt(2, 0);  // units_sold = 0
            st.setInt(3, stockUnits);
            st.setString(4, productName);
            st.setString(5, warrantyInfo);
            st.setString(6, generalInfo);
            st.setInt(7, categoryId);
            st.setInt(8, brandId);
            st.setString(9, image);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteProduct(int productId) {
        String sql = """
                    DELETE FROM [dbo].[product]
                    WHERE [id] = ?
		""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            st.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateOther(int id, String productName, int brandId, int categoryId, int price, String generalInfo, String warrantyInfo, int stockUnits, String image) {
        String sql = """
                UPDATE [dbo].[product]
                   SET 
                       [price] = ?,
                       [stock_units] = ?,
                       [product_name] = ?,
                       [warranty_info] = ?,
                       [general_info] = ?,
                       [category_id] = ?,
                       [manufacturer_id] = ?,
                       [image] = COALESCE(?, [image])
                   WHERE [id] = ?
                    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, price);
            st.setInt(2, stockUnits);
            st.setString(3, productName);
            st.setString(4, warrantyInfo);
            st.setString(5, generalInfo);
            st.setInt(6, categoryId);
            st.setInt(7, brandId);
            st.setString(8, image);
            st.setInt(9, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getCurrentStockUnits(int productId) {
        String sql = """
               SELECT [stock_units]
                 FROM [dbo].[product]
               WHERE [id] = ?
		""";
        int result = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Product> getProductsById(int... idList) {
        List<Product> listProduct = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM [PJ].[dbo].[product] WHERE ");

        for (int i = 0; i < idList.length; i++) {
            query.append("[id] = ").append(idList[i]);
            if (i < idList.length - 1) {
                query.append(" OR ");
            }
        }
        String sql = query.toString();

        BrandDAO bdao = new BrandDAO();
        CategoryDAO cdao = new CategoryDAO();

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int price = rs.getInt("price");
                int unitsSold = rs.getInt("units_sold");
                int stockUnits = rs.getInt("stock_units");
                String productName = rs.getString("product_name");
                String warrantyInfo = rs.getString("warranty_info");
                String generalInfo = rs.getString("general_info");
                int cid = rs.getInt("category_id");
                int bid = rs.getInt("manufacturer_id");
                String image = rs.getString("image");
                Product p = new Product(
                        id, price, unitsSold, stockUnits, productName, warrantyInfo, generalInfo,
                        bdao.getBrandById(bid), cdao.getCategoryById(cid), image);
                listProduct.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }  

}
