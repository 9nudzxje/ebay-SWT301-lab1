/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.BrandDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Brand;

/**
 *
 * @author Jigger
 */
public class BrandManager extends HttpServlet {

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
        BrandDAO bdao = new BrandDAO();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        List<Brand> brandList = bdao.getAllBrands(offset, recordsPerPage);
        int totalRecords = bdao.totalBrandsCount();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("brandList", brandList);
        request.setAttribute("pageName", "brand-manager");
        request.getRequestDispatcher("./admin/brandManager.jsp").forward(request, response);

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
        String brandName = request.getParameter("brandName");
        String deleteIdStr = request.getParameter("deleteId");
        BrandDAO bdao = new BrandDAO();

        if (deleteIdStr != null) {
            try {
                int deleteId = Integer.parseInt(deleteIdStr);
                bdao.deleteBrand(deleteId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
            doGet(request, response);
            return;
        }
        // If id is null => add new brand name
        if (id == null && brandName != null) {
            bdao.addBrand(brandName);
            doGet(request, response);
            return;
        }

        try {
            int bid = Integer.parseInt(id);
            bdao.updateBrand(bid, brandName);
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
