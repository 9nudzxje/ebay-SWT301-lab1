/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.ContactDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Contact;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Jigger
 */
public class FeedbackManager extends HttpServlet {

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
        ContactDAO cdao = new ContactDAO();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        List<Contact> allFeedback = cdao.getAllFeedback(offset, recordsPerPage, status);
        int totalRecords = cdao.countAllFeedback(status);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        request.setAttribute("selectedStatus", status);
        request.setAttribute("feedbackList", allFeedback);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageName", "feedback-manager");
        request.getRequestDispatcher("./admin/feedbackManager.jsp").forward(request, response);
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
        JSONObject json = new JSONObject();
        response.setContentType("application/json");
        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        String replyContent = request.getParameter("replyContent");
        ContactDAO cdao = new ContactDAO();
        cdao.replyToFeedback(user.getId(), replyContent, feedbackId);
        json.put("success", true);
        json.put("message", "Answered");
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
