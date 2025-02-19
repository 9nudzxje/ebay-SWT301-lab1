/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.util.List;
import model.CartItem;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import model.Order;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author Jigger
 */
public class OrderDAO extends DBContext {

    private void clearCart(int cartId) {
        String sql = """
                    DELETE FROM [dbo].[cart_item]
                    WHERE [cart_id] = ? AND [is_selected] = 1
                    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private int getInsertedOrderId() {
        String sql = """
                    SELECT [id] 
                    FROM [PJ].[dbo].[order]
                    ORDER BY [id] DESC
                    """;
        int id = -1;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    private void cartToOrderDetail(int userId) {
        int orderId = getInsertedOrderId();
        CartDAO cdao = new CartDAO();
        List<CartItem> cart = cdao.getSelectedCartItemByUserId(userId);
        String sql = """
                         INSERT INTO [dbo].[order_detail]
                                    ([unit_price]
                                    ,[quantity]
                                    ,[order_id]
                                    ,[product_id])
                              VALUES
                                    (?, ?, ?, ?)
					""";
        for (CartItem item : cart) {
            int quantity = item.getQuantity();
            int productId = item.getProduct().getId();
            long unitPrice = item.getProduct().getPrice();
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setLong(1, unitPrice);
                st.setInt(2, quantity);
                st.setInt(3, orderId);
                st.setInt(4, productId);
                st.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        clearCart(cart.get(0).getCartId());
    }

    public void createNewOrder(int userId, String address, String note, String recipientName, String recipientPhone, int total) {
        String sql = """
        INSERT INTO [dbo].[order]
                   ([delivery_address]
                   ,[note]
                   ,[recipient_name]
                   ,[order_date]
                   ,[delivery_date]	
                   ,[received_date]
                   ,[recipient_phone]
                   ,[order_status]
                   ,[customer_id]
                   ,[shipper_id]
                   ,[total])
             VALUES
                   (?, ?, ?, ?, NULL, NULL, ?, 'Pending', ?, NULL, ?)
        """;

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, address);
            stmt.setString(2, note);
            stmt.setString(3, recipientName);
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));// Assuming orderDate is non-null
            stmt.setString(5, recipientPhone);
            stmt.setInt(6, userId);
            stmt.setInt(7, total);
            stmt.executeUpdate();
            cartToOrderDetail(userId);
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private List<OrderDetail> getOrderDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetailList = new ArrayList<>();
        ProductDAO pdao = new ProductDAO();
        String sql = """
               SELECT [id]
                     ,[unit_price]
                     ,[quantity]
                     ,[order_id]
                     ,[product_id]
                FROM [PJ].[dbo].[order_detail]
                WHERE [order_id] = ? 
		""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int unitPrice = rs.getInt("unit_price");
                int quantity = rs.getInt("quantity");
                Product product = pdao.getProductsById(rs.getInt("product_id")).get(0);
                orderDetailList.add(new OrderDetail(id, unitPrice, quantity, orderId, product));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderDetailList;
    }

    public List<Order> getOrderByUserId(int userId) {
        String sql = """    
            SELECT [id]
                  ,[delivery_address]
                  ,[note]
                  ,[recipient_name]
                  ,[order_date]
                  ,[delivery_date]
                  ,[received_date]
                  ,[recipient_phone]
                  ,[order_status]
                  ,[customer_id]
                  ,[shipper_id]
                  ,[total]
              FROM [PJ].[dbo].[order]
              WHERE customer_id = ?
            """;
        List<Order> orderList = new ArrayList<>();
        UserDAO udao = new UserDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("id");
                order.setId(orderId);
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setNote(rs.getString("note"));
                order.setRecipientName(rs.getString("recipient_name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setDeliveryDate(rs.getTimestamp("delivery_date"));
                order.setReceivedDate(rs.getTimestamp("received_date"));
                order.setRecipientPhone(rs.getString("recipient_phone"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setCustomer(udao.getUserByID(userId));
                order.setShipper(udao.getUserByID(rs.getInt("shipper_id")));
                order.setTotal(rs.getInt("total"));
                List<OrderDetail> orderDetailList = getOrderDetailByOrderId(orderId);
                order.setOrderDetailList(orderDetailList);
                orderList.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return orderList;
    }

    public List<Order> getOrderByStatus(String status, int offset, int recordsPerPage) {
        String sql = """    
            SELECT [id]
                  ,[delivery_address]
                  ,[note]
                  ,[recipient_name]
                  ,[order_date]
                  ,[delivery_date]
                  ,[received_date]
                  ,[recipient_phone]
                  ,[order_status]
                  ,[customer_id]
                  ,[shipper_id]
                  ,[total]
              FROM [PJ].[dbo].[order]
              WHERE [order_status] = ?
            """;
        List<Order> orderList = new ArrayList<>();
        UserDAO udao = new UserDAO();
        String pagination = """
                        ORDER BY [id]
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY;
			""";
        sql += pagination;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, offset);
            st.setInt(3, recordsPerPage);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("id");
                order.setId(orderId);
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setNote(rs.getString("note"));
                order.setRecipientName(rs.getString("recipient_name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setDeliveryDate(rs.getTimestamp("delivery_date"));
                order.setReceivedDate(rs.getTimestamp("received_date"));
                order.setRecipientPhone(rs.getString("recipient_phone"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setCustomer(udao.getUserByID(rs.getInt("customer_id")));
                order.setShipper(udao.getUserByID(rs.getInt("shipper_id")));
                order.setTotal(rs.getInt("total"));
                List<OrderDetail> orderDetailList = getOrderDetailByOrderId(orderId);
                order.setOrderDetailList(orderDetailList);
                orderList.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return orderList;
    }

    public int countTotalOrders(String status) {
        String sql = """
                        SELECT COUNT([id])
			FROM [PJ].[dbo].[order]
                        WHERE [order_status] = ?
                    """;
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public void assignToShipper(int orderId, int shipperId) {
        String sql = """
                    UPDATE [dbo].[order]
                    SET [order_status] = ?,	
                        [shipper_id] = ?,
                        [delivery_date] = ?
                    WHERE [id] = ?
		""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "Shipping");
            st.setInt(2, shipperId);
            st.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            st.setInt(4, orderId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void completeSellingProducts(int orderId) {
        String sql = """
                    UPDATE [dbo].[product]
                    SET
                        [units_sold] = [units_sold] + ?,
                        [stock_units] = [stock_units] - ?
                    WHERE [id] = ?
                    """;
        List<OrderDetail> orderDetailList = getOrderDetailByOrderId(orderId);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (OrderDetail orderDetail : orderDetailList) {
                int sold = orderDetail.getQuantity();
                int productId = orderDetail.getProduct().getId();
                st.setInt(1, sold); 
                st.setInt(2, sold); 
                st.setInt(3, productId);
                st.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertIntoIncome() {
        String sql = """
                        INSERT INTO income (date, total)
                        SELECT TOP 1 received_date, total
                        FROM [order]
                        WHERE [order_status] = 'Completed' 
                        ORDER BY [id] DESC;
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateOrderStatus(int orderId, String note, String status) {
        String sql = """
			UPDATE [dbo].[order]
			SET [order_status] = ?,	
			[received_date] = ?,
                        [note] = ?
			WHERE [id] = ?
                    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            if (status.equals("Completed")) {
                st.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                completeSellingProducts(orderId);
            } else {
                st.setTimestamp(2, null);
            }
            st.setString(3, note);
            st.setInt(4, orderId);
            st.executeUpdate();
            insertIntoIncome();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void deleteAnOrder(int orderId) {
        String sql = """
                DELETE FROM [dbo].[order_detail]
                WHERE [order_id] = ?

                DELETE FROM [dbo].[order]
                WHERE [id] = ?
                """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Order> getOrderByShipperId(int shipperId, int offset, int recordsPerPage, String status) {
        List<Order> orderList = new ArrayList<>();
        UserDAO udao = new UserDAO();
        String sql = """
                        SELECT * FROM [PJ].[dbo].[order]
                        WHERE [shipper_id] = ? AND [order_status] = ?
                    """;
        String pagination = """
                        ORDER BY [id]
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY;
                                """;
        sql += pagination;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, shipperId);
            st.setString(2, status);
            st.setInt(3, offset);
            st.setInt(4, recordsPerPage);
            System.out.println(st.toString());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("id");
                order.setId(orderId);
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setNote(rs.getString("note"));
                order.setRecipientName(rs.getString("recipient_name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setDeliveryDate(rs.getTimestamp("delivery_date"));
                order.setReceivedDate(rs.getTimestamp("received_date"));
                order.setRecipientPhone(rs.getString("recipient_phone"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setCustomer(udao.getUserByID(rs.getInt("customer_id")));
                order.setShipper(udao.getUserByID(rs.getInt("shipper_id")));
                order.setTotal(rs.getInt("total"));
                List<OrderDetail> orderDetailList = getOrderDetailByOrderId(orderId);
                order.setOrderDetailList(orderDetailList);
                orderList.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderList;
    }

    public int countTotalOrderByShipperId(int shipperId, String status) {
        String sql = """
                        SELECT COUNT([id])
                        FROM [PJ].[dbo].[order]
                        WHERE [shipper_id] = ? AND [order_status] = ?
                    """;
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, shipperId);
            st.setString(2, status);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }


    public static void main(String[] args) {
        new OrderDAO().insertIntoIncome();
    }
}
