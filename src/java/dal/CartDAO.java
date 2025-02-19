/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Product;

/**
 *
 * @author Jigger
 */
public class CartDAO extends DBContext {

    private int getCartId(int userId) {
        String sql = """
                    SELECT [id]
                    FROM [dbo].[cart]
                    WHERE [user_id] = ?
                    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt(1);
                return cartId;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return -1;
    }

    /**
     * This function is called from addToCart function, to check whether the
     * product is in cart or not
     *
     * @param cartId
     * @param productId
     * @return
     */
    private int addMoreExisted(int quantity, int cartId, int productId) {
        String sql = """
		UPDATE [dbo].[cart_item]
                SET [quantity] = [quantity] + ?
                WHERE [cart_id] = ? AND [product_id] = ?
                    """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, cartId);
            st.setInt(3, productId);
            return st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void changeSelected(int isSelected, int userId, int productId) {
        int cartId = getCartId(userId);
        String sql = """
		UPDATE [dbo].[cart_item]
                SET [is_selected] = ?
                WHERE [cart_id] = ? AND [product_id] = ?
		""";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, isSelected);
            st.setInt(2, cartId);
            st.setInt(3, productId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeQuantity(int quantity, int userId, int productId) {
        int cartId = getCartId(userId);
        String sql = """
		UPDATE [dbo].[cart_item]
                SET [quantity] = ?
                WHERE [cart_id] = ? AND [product_id] = ?
		""";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, cartId);
            st.setInt(3, productId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addToCart(int quantity, int userId, int productId) {
        int cartId = getCartId(userId);
        if (addMoreExisted(quantity, cartId, productId) != 0) {
            return;
        }
        String sql = """
			INSERT INTO [dbo].[cart_item]
                                   ([quantity]
                                   ,[cart_id]
                                   ,[product_id]
                                   ,[is_selected])
                             VALUES
                                   (?, ?, ?, ?)
                    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, cartId);
            st.setInt(3, productId);
            st.setInt(4, 1);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<CartItem> getCartByUserId(int userId) {
        List<CartItem> cart = new ArrayList<>();
        int cartId = getCartId(userId);
        ProductDAO pdao = new ProductDAO();
        String sql = """
                    SELECT [id]
                          ,[quantity]
                          ,[cart_id]
                          ,[product_id]
                          ,[is_selected]
                      FROM [PJ].[dbo].[cart_item]  
                    WHERE [cart_id] = ?
                    """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int quantity = rs.getInt("quantity");
                Product product = pdao.getProductsById(rs.getInt("product_id")).get(0);
                int isSelected = rs.getByte("is_selected");
                cart.add(new CartItem(id, product, quantity, cartId, isSelected));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return cart;
    }

    public List<CartItem> getSelectedCartItemByUserId(int userId) {
        List<CartItem> cart = new ArrayList<>();
        int cartId = getCartId(userId);
        ProductDAO pdao = new ProductDAO();
        String sql = """
                    SELECT [id]
                          ,[quantity]
                          ,[cart_id]
                          ,[product_id]
                          ,[is_selected]
                      FROM [PJ].[dbo].[cart_item]  
                    WHERE [cart_id] = ? AND [is_selected] = 1
                    """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int quantity = rs.getInt("quantity");
                Product product = pdao.getProductsById(rs.getInt("product_id")).get(0);
                int isSelected = rs.getByte("is_selected");
                cart.add(new CartItem(id, product, quantity, cartId, isSelected));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return cart;
    }

    public void deleteItem(int cartItemId) {
        String sql = """
                    DELETE FROM [dbo].[cart_item]
                    WHERE [id] = ?
					""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartItemId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
