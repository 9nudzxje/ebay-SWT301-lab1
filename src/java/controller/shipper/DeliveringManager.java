/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.shipper;

import dal.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Jigger
 */
public class DeliveringManager extends HttpServlet {

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
        User shipper = (User) session.getAttribute("user");
        OrderDAO odao = new OrderDAO();
        int shipperId = shipper.getId();
        String status = request.getParameter("status");
        String pageParam = request.getParameter("page");
        if (status == null) {
            status = "Shipping";
        }
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        int totalRecords = odao.countTotalOrderByShipperId(shipperId, status);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        List<Order> orderList = odao.getOrderByShipperId(shipperId, offset, recordsPerPage, status);
        request.setAttribute("orderList", orderList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageName", "delivering-manager");
        request.setAttribute("currentStatus", status);
        request.getRequestDispatcher("./shipper/home.jsp").forward(request, response);
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
        JSONObject json = new JSONObject();
        response.setContentType("application/json");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String note = request.getParameter("note");
        String status = request.getParameter("status");
        OrderDAO odao = new OrderDAO();
        odao.updateOrderStatus(orderId, note, status);
        json.put("success", true);
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
