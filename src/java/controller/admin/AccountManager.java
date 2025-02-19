/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author Jigger
 */
public class AccountManager extends HttpServlet {
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
        UserDAO udao = new UserDAO();
        String roleIDStr = request.getParameter("selectRoleID");
        List<Role> roleList = udao.getAllRoles();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        try {
            int roleId = roleIDStr == null ? 0 : Integer.parseInt(roleIDStr);
            List<User> userList = udao.getUserListByRoleId(roleId, offset, recordsPerPage);
            int totalRecords = udao.totalUsersByRoleID(roleId);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("userList", userList);
            request.setAttribute("choosenRole", roleId);

        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        request.setAttribute("pageName", "account-manager");
        request.setAttribute("roleList", roleList);
        request.getRequestDispatcher("./admin/accountManager.jsp").forward(request, response);
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
        String deleteId = request.getParameter("deleteId");
        String add = request.getParameter("add");
        UserDAO udao = new UserDAO();
        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                udao.deleteUser(delId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
        }

        if (add != null) {
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String roleIdStr = request.getParameter("chooseRoleID");
            try {
                int roleId = Integer.parseInt(roleIdStr);
                udao.createNewAccount(address, email, fullName, password, phoneNumber, roleId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
        }

        doGet(request, response);
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
