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
import java.io.PrintWriter;
import java.util.List;
import model.CartItem;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Jigger
 */
public class AddToCart extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        CartDAO cdao = new CartDAO();
        List<CartItem> cart = cdao.getCartByUserId(user.getId());
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("./user/cart.jsp").forward(request, response);
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
        PrintWriter out = response.getWriter();
        CartDAO cdao = new CartDAO();
        ProductDAO pdao = new ProductDAO();
        response.setContentType("application/json");
        JSONObject json = new JSONObject();
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int currentStockUnits = pdao.getCurrentStockUnits(productId);
            if (currentStockUnits == 0) {
                json.put("success", false);
                json.put("message", "Product is out of stock, try other stuffs");
            } else {
                cdao.addToCart(1, user.getId(), productId);
                json.put("success", true);
                json.put("message", "Add to cart successfully");
            }

        } catch (NumberFormatException ex) {
            System.out.println(ex);
            json.put("success", false);
        }

        out.write(json.toString());
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
