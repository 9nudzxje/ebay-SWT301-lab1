/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.BrandDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author Jigger
 */
public class SearchProduct extends HttpServlet {

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
        BrandDAO bdao = new BrandDAO();
        ProductDAO pdao = new ProductDAO();
        List<Category> categoryList = cdao.getAllCategories();
        List<Brand> brandList = bdao.getAllBrands();
        String searchKey = request.getParameter("searchKey");
        String sortOrder = request.getParameter("sortOrder");
        String brandSelect = request.getParameter("brandSelect");
        String categorySelect = request.getParameter("categorySelect");
        String pageParam = request.getParameter("page");
        String priceRange = request.getParameter("priceRange");

        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int brandId = (brandSelect == null) ? 0 : Integer.parseInt(brandSelect);
            int categoryId = (categorySelect == null) ? 1 : Integer.parseInt(categorySelect);
            int recordsPerPage = 12;
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = pdao.countTotalRecords(brandId, categoryId, priceRange, searchKey);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            List<Product> productList = pdao.getProducts(
                    brandId, categoryId, offset, recordsPerPage, priceRange, searchKey, sortOrder);
            request.setAttribute("currentKey", searchKey);
            request.setAttribute("currentOrder", sortOrder);
            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentBrand", brandId);
            request.setAttribute("currentCategory", categoryId);
            request.setAttribute("currentPriceRange", priceRange);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        System.out.println(getServletContext().getRealPath(""));
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("brandList", brandList);
        request.setAttribute("pageName", "product-manager");
        request.getRequestDispatcher("./user/searchProduct.jsp").forward(request, response);
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
