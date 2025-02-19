/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jigger
 */
public class BrandDAO extends DBContext {

    public List<Brand> getAllBrands(int offset, int recordsPerPage) {
        List<Brand> brandList = new ArrayList<>();
        String sql = """
                        SELECT [id]
                              ,[manufacturer_name]
                        FROM [dbo].[manufacturer]
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
                Brand brand = new Brand(rs.getInt("id"), rs.getString("manufacturer_name"));
                brandList.add(brand);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return brandList;
    }

    public List<Brand> getAllBrands() {
        List<Brand> brandList = new ArrayList<>();
        String sql = """
                        SELECT [id]
                              ,[manufacturer_name]
                        FROM [dbo].[manufacturer]
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand(rs.getInt("id"), rs.getString("manufacturer_name"));
                brandList.add(brand);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return brandList;
    }

    public int totalBrandsCount() {
        String sql = """
                     SELECT COUNT([id]) 
                     FROM [dbo].[manufacturer]
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

    public void addBrand(String brandName) {
        String sql = """
                     INSERT INTO [dbo].[manufacturer]
                                ([manufacturer_name])
                          VALUES
                                (?)
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, brandName);
            st.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void updateBrand(int id, String brandName) {
        String sql = """
                     UPDATE [dbo].[manufacturer]
                        SET [manufacturer_name] = ?
                      WHERE [id] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, brandName);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void deleteBrand(int id) {
        String sql = """
                    DELETE FROM [dbo].[manufacturer]
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

    public Brand getBrandById(int bid) {
        String sql = """
                         SELECT [id]
                               ,[manufacturer_name]
                           FROM [PJ].[dbo].[manufacturer]
                         WHERE  [id] = ?
					""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, bid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String brandName = rs.getString("manufacturer_name");
                return new Brand(id, brandName);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }
}
