/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Contact;

/**
 *
 * @author Jigger
 */
public class ContactDAO extends DBContext {

    public void addNewFeedback(int userId, String contactContent, String contactEmail) {
        String sql = """
                    INSERT INTO [dbo].[contact]
                               ([contact_email]
                               ,[contact_date]
                               ,[contact_content]
                               ,[status]
                               ,[sender_id])
                         VALUES
                               (?, ?, ?, ?, ?)
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, contactEmail);
            st.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            st.setString(3, contactContent);
            st.setString(4, "Pending");
            st.setInt(5, userId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void replyToFeedback(int adminId, String replyContent, int feedbackId) {
        String sql = """
                    UPDATE [dbo].[contact]
                    SET     [reply_date] = ?
                           ,[reply_content] = ?
                           ,[status] = ?
                           ,[responder_id] = ?
                    WHERE [id] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            st.setString(2, replyContent);
            st.setString(3, "Replied");
            st.setInt(4, adminId);
            st.setInt(5, feedbackId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteAFeedback(int contactId) {
        String sql = """
                     DELETE FROM [dbo].[contact]
                           WHERE [id] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, contactId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Contact> getContactsByUserId(int userId) {

        String sql = """
                SELECT * FROM [PJ].[dbo].[contact]
                WHERE [sender_id] = ?
                  """;
        List<Contact> allContacts = new ArrayList<>();
        UserDAO udao = new UserDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt("id"));
                contact.setContactEmail(rs.getString("contact_email"));
                contact.setContactDate(rs.getTimestamp("contact_date"));
                contact.setReplyDate(rs.getTimestamp("reply_date"));
                contact.setContactContent(rs.getString("contact_content"));
                contact.setReplyContent(rs.getString("reply_content"));
                contact.setStatus(rs.getString("status"));
                contact.setResponderUser(udao.getUserByID(rs.getInt("responder_id")));
                contact.setSenderUser(udao.getUserByID(rs.getInt("sender_id")));
                allContacts.add(contact);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allContacts;
    }

    public List<Contact> getAllFeedback(int offset, int recordsPerPage, String status) {
        String sql = """
                SELECT * FROM [PJ].[dbo].[contact] 
                WHERE [status] = ?
                  """;
        String pagination = """
                        ORDER BY [id]
                        OFFSET ? ROWS
                        FETCH NEXT ? ROWS ONLY;
			""";
        sql += pagination;
        List<Contact> allContacts = new ArrayList<>();
        UserDAO udao = new UserDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, offset);
            st.setInt(3, recordsPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt("id"));
                contact.setContactEmail(rs.getString("contact_email"));
                contact.setContactDate(rs.getTimestamp("contact_date"));
                contact.setReplyDate(rs.getTimestamp("reply_date"));
                contact.setContactContent(rs.getString("contact_content"));
                contact.setReplyContent(rs.getString("reply_content"));
                contact.setStatus(rs.getString("status"));
                contact.setResponderUser(udao.getUserByID(rs.getInt("responder_id")));
                contact.setSenderUser(udao.getUserByID(rs.getInt("sender_id")));
                allContacts.add(contact);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allContacts;
    }

    public int countAllFeedback(String status) {
        int count = 0;
        String sql = """
                     SELECT COUNT([id]) FROM [PJ].[dbo].[contact]
                     WHERE [status] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
