/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jigger
 */
public class CategoryDAO extends DBContext {

    public List<Category> getAllCategories(int offset, int recordsPerPage) {
        List<Category> allCategories = new ArrayList<>();
        String sql = """
                        SELECT *
                        FROM [dbo].[category]
                        ORDER BY [id]
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY;
                     """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, offset);
            st.setInt(2, recordsPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt("id"), rs.getString("category_name"));
                allCategories.add(c);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return allCategories;
    }

    public List<Category> getAllCategories() {
        List<Category> allCategories = new ArrayList<>();
        String sql = """
                        SELECT *
                        FROM [dbo].[category]
                        ORDER BY [id]
                     """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt("id"), rs.getString("category_name"));
                allCategories.add(c);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return allCategories;
    }

    public int totalCategoriesCount() {
        String sql = """
                     SELECT COUNT([id]) 
                     FROM [dbo].[category]
                     """;
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
    }

    public void addCategory(String categoryName) {
        String sql = """
                     INSERT INTO [dbo].[category]
                                ([category_name])
                          VALUES
                                (?)
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, categoryName);
            st.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void updateCategory(int id, String categoryName) {
        String sql = """
                     UPDATE [dbo].[category]
                        SET [category_name] = ?
                      WHERE [id] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, categoryName);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void deleteCategory(int id) {
        String sql = """
                    DELETE FROM [dbo].[category]
                    WHERE [id] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public Category getCategoryById(int cid) {
        String sql = """
                         SELECT [id]
                               ,[category_name]
                           FROM [PJ].[dbo].[category]
                         WHERE [id] = ?
					""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String categoryName = rs.getString("category_name");
                return new Category(id, categoryName);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
