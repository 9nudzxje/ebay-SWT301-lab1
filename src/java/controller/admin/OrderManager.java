/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.OrderDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import model.Order;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Jigger
 */
public class OrderManager extends HttpServlet {

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
        String status = request.getParameter("status");
        if (status == null) {
            status = "Pending";
        }
        String fromDateStr = request.getParameter("date-from");
        String toDateStr = request.getParameter("date-to");
        String pageParam = request.getParameter("page");
        OrderDAO odao = new OrderDAO();
        UserDAO udao = new UserDAO();
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage = 6;
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = odao.countTotalOrders(status);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            List<Order> orderList = odao.getOrderByStatus(status, offset, recordsPerPage);
            List<User> shipperList = udao.getUserListByRoleId(3, 0, 100);
            request.setAttribute("shipperList", shipperList);
            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentStatus", status);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        request.setAttribute("pageName", "order-manager");
        request.getRequestDispatcher("./admin/orderManager.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        OrderDAO odao = new OrderDAO();
        JSONObject json = new JSONObject();
        response.setContentType("application/json");
        switch (action) {
            case "assign" -> {
                int shipperId = Integer.parseInt(request.getParameter("shipperId"));
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                odao.assignToShipper(orderId, shipperId);
                json.put("success", true);
            }
            case "delete" -> {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                odao.deleteAnOrder(orderId);
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
