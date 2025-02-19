/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.CartDAO;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Jigger
 */
public class UpdateCart extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String itemIdStr = request.getParameter("itemId");
        String action = request.getParameter("action");
        int userId = user.getId();
        CartDAO cdao = new CartDAO();
        ProductDAO pdao = new ProductDAO();
        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        switch (action) {
            case "delete" -> {
                try {
                    int deleteItemId = Integer.parseInt(itemIdStr);
                    cdao.deleteItem(deleteItemId);
                    json.put("success", true);
                } catch (NumberFormatException ex) {
                    json.put("success", false);
                }
            }
            case "change-quantity" -> {
                try {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int currentStockUnits = pdao.getCurrentStockUnits(productId);

                    // Điều chỉnh quantity nếu vượt quá số lượng tồn kho
                    if (currentStockUnits < quantity) {
                        quantity = currentStockUnits; // Đặt quantity về mức tồn kho thực tế
                        json.put("success", false);
                        json.put("message", "Invalid product quantity due to exceeding warehouse unit");
                    } else {
                        json.put("success", true);
                    }

                    // Lưu quantity đã điều chỉnh vào database
                    cdao.changeQuantity(quantity, userId, productId);
                    json.put("stockUnits", quantity); // Trả về quantity đã điều chỉnh
                } catch (NumberFormatException ex) {
                    json.put("success", false);
                }
            }

            case "change-selected" -> {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int isSelected = Integer.parseInt(request.getParameter("isSelected"));
                cdao.changeSelected(isSelected, userId, productId);
                json.put("success", true);
            }
        }
        response.getWriter().write(json.toString());

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
