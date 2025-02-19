/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.Role;
import org.json.JSONObject;
import model.User;

/**
 *
 * @author Jigger
 */
public class LoginServlet extends HttpServlet {

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
        Cookie[] allCookies = request.getCookies();
        if (allCookies != null) {
            for (Cookie cookie : allCookies) {
                if (cookie.getName().equals("email")) {
                    request.setAttribute("emailCookie", cookie.getValue());
                }
                if (cookie.getName().equals("password")) {
                    request.setAttribute("passwordCookie", cookie.getValue());
                }
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();
        PrintWriter out = response.getWriter();
        UserDAO udao = new UserDAO();
        User user = udao.getUser(email, password);
        if (user == null) {
            jsonResponse.put("success", false);
            out.write(jsonResponse.toString());
        } else {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            jsonResponse.put("success", true);
            out.write(jsonResponse.toString());
            // if rememberMe is checked
            if (rememberMe != null) {
                Cookie emailCookie = new Cookie("email", email);
                Cookie passwordCookie = new Cookie("password", password);
                emailCookie.setMaxAge(60 * 60);
                passwordCookie.setMaxAge(60 * 60);
                response.addCookie(emailCookie);
                response.addCookie(passwordCookie);
            } else {
                Cookie[] allCookies = request.getCookies();
                for (Cookie cookie : allCookies) {
                    if (cookie.getName().equals("email")) {
                        cookie.setMaxAge(0);
                    }
                    if (cookie.getName().equals("password")) {
                        cookie.setMaxAge(0);
                    }
                }
            }
        }
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


