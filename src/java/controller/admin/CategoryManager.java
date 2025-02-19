/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;

/**
 *
 * @author Jigger
 */
public class CategoryManager extends HttpServlet {

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
        CategoryDAO cdao = new CategoryDAO();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        
        
        List<Category> categoryList = cdao.getAllCategories(offset, recordsPerPage);
        int totalRecords = cdao.totalCategoriesCount();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageName", "category-manager");
        request.getRequestDispatcher("./admin/categoryManager.jsp").forward(request, response);
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
        String id = request.getParameter("id");
        String categoryName = request.getParameter("categoryName");
        String deleteIdStr = request.getParameter("deleteId");
        CategoryDAO cdao = new CategoryDAO();
        // If id is null => add new category name
        if (deleteIdStr != null) {
            try {
                int deleteId = Integer.parseInt(deleteIdStr);
                cdao.deleteCategory(deleteId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
            doGet(request, response);
            return;
        }
        if (id == null && categoryName != null) {
            cdao.addCategory(categoryName);
            doGet(request, response);
            return;
        }

        try {
            int cid = Integer.parseInt(id);
            cdao.updateCategory(cid, categoryName);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
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
