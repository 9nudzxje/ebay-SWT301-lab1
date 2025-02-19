/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import java.io.File;
import dal.BrandDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author Jigger
 */
@MultipartConfig
public class ProductManager extends HttpServlet {

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
        String brandSelect = request.getParameter("brandSelect");
        String categorySelect = request.getParameter("categorySelect");
        String pageParam = request.getParameter("page");
        String priceRange = request.getParameter("priceRange");
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int brandId = (brandSelect == null) ? 0 : Integer.parseInt(brandSelect);
            int categoryId = (categorySelect == null) ? 0 : Integer.parseInt(categorySelect);
            int recordsPerPage = 6;
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = pdao.countTotalRecords(brandId, categoryId, priceRange, null);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            List<Product> productList = pdao.getProducts(brandId, categoryId, offset, recordsPerPage, priceRange, null, null);
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
        request.getRequestDispatcher("./admin/productManager.jsp").forward(request, response);
    }

    /**
     * This function will save a file to the images folder and return the
     * relative file path.
     *
     * @param filePart the uploaded file part
     * @return the relative path to the saved file
     * @throws IOException if an I/O error occurs during file writing
     */
    private String getAndSaveImg(Part filePart) throws IOException {
        // Define the path relative to the project
        String relativePath = "resources/images/";

        // Get the absolute path to the project directory
        String uploadPath = getServletContext().getRealPath("");  // Root of the web application
        String projectRoot = uploadPath.replace("build" + File.separator + "web", ""); // Adjust to get to project root

        // Full path to the images folder inside web/resources/images/
        String fileSavePath = projectRoot + "web" + File.separator + relativePath;

        // Create the directory if it doesn't exist
        File uploadDir = new File(fileSavePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the uploaded file name
        String fileName = filePart.getSubmittedFileName();
        // Combine the path and the file name
        String filePath = fileSavePath + File.separator + fileName;
        // Write the file to the specified path
        filePart.write(filePath);

        // Return the relative path for storing in the database
        return relativePath + fileName;
    }

    private boolean deleteFile(String relativeFilePath) {
        try {
            // Get the absolute path to the project directory
            String uploadPath = getServletContext().getRealPath("");  // Root of the web application
            String projectRoot = uploadPath.replace("build" + File.separator + "web", ""); // Adjust to get to project root

            // Combine the project root and the relative file path to get the absolute file path
            String absoluteFilePath = projectRoot + "web" + File.separator + relativeFilePath.replace("/", File.separator);

            // Create a File object for the file to be deleted
            File file = new File(absoluteFilePath);

            // Check if the file exists and delete it
            if (file.exists()) {
                return file.delete(); // Returns true if the file was successfully deleted
            } else {
                System.out.println("File not found: " + absoluteFilePath);
                return false;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
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
        String add = request.getParameter("add");
        ProductDAO pdao = new ProductDAO();
        String delete = request.getParameter("delete");
        String updateOther = request.getParameter("updateOther");
        if (add != null) {
            try {
                switch (add) {
                    case "addOther" -> {
                        String productName = request.getParameter("otherName");
                        int categoryId = Integer.parseInt(request.getParameter("otherCategory"));
                        int brandId = Integer.parseInt(request.getParameter("otherBrand"));
                        int price = Integer.parseInt(request.getParameter("otherPrice"));
                        String generalInfo = request.getParameter("otherDescription");
                        String warrantyInfo = request.getParameter("otherWarranty");
                        int stockUnits = Integer.parseInt(request.getParameter("otherStock"));
                        // Handling file upload
                        Part filePart = request.getPart("otherImage"); // "image" is the name of the input field in the form
                        String image = getAndSaveImg(filePart);
                        pdao.addProduct(productName, brandId, categoryId, price, generalInfo, warrantyInfo, stockUnits, image);
                        response.sendRedirect("product-manager?categorySelect=" + categoryId);
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        if (delete != null) {
            int deleteId = Integer.parseInt(delete);
            String imgPath = pdao.getProductsById(deleteId).get(0).getImage();
            deleteFile(imgPath);
            pdao.deleteProduct(deleteId);
        }

        if (updateOther != null) {
            try {
                int id = Integer.parseInt(updateOther);
                String productName = request.getParameter("newName");
                int price = Integer.parseInt(request.getParameter("newPrice"));
                int brandId = Integer.parseInt(request.getParameter("newBrand"));
                int categoryId = Integer.parseInt(request.getParameter("newCategory"));
                String generalInfo = request.getParameter("newInfo");
                String warrantyInfo = request.getParameter("newWarranty");
                int stockUnits = Integer.parseInt(request.getParameter("newStockUnits"));
                // For file upload (newImg)
                Part imagePart = request.getPart("newImg");
                String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);
                if (image != null) {
                    String imgPath = pdao.getProductsById(id).get(0).getImage();
                    deleteFile(imgPath);
                }
                pdao.updateOther(id, productName, brandId, categoryId, price, generalInfo, warrantyInfo, stockUnits, image);
                response.sendRedirect("product-manager?categorySelect=" + categoryId);
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
