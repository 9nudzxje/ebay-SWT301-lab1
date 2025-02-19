package dal;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Contact;

public class ContactDAO extends DBContext {

    public void addNewFeedback(int userId, String contactContent, String contactEmail) {
        String sql = """
                INSERT INTO [dbo].[contact]
                           ([contact_email], [contact_date], [contact_content], [status], [sender_id])
                     VALUES (?, ?, ?, ?, ?)
                 """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
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
                SET [reply_date] = ?, [reply_content] = ?, [status] = ?, [responder_id] = ?
                WHERE [id] = ?
                 """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
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
        String sql = "DELETE FROM [dbo].[contact] WHERE [id] = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, contactId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Contact> getContactsByUserId(int userId) {
        String sql = "SELECT * FROM [dbo].[contact] WHERE [sender_id] = ?";
        List<Contact> allContacts = new ArrayList<>();
        UserDAO udao = new UserDAO();
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Contact contact = extractContact(rs, udao);
                    allContacts.add(contact);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allContacts;
    }

    public List<Contact> getAllFeedback(int offset, int recordsPerPage, String status) {
        String sql = """
                SELECT * FROM [dbo].[contact] 
                WHERE [status] = ? 
                ORDER BY [id]
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
                """;
        List<Contact> allContacts = new ArrayList<>();
        UserDAO udao = new UserDAO();
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, offset);
            st.setInt(3, recordsPerPage);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Contact contact = extractContact(rs, udao);
                    allContacts.add(contact);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allContacts;
    }

    public int countAllFeedback(String status) {
        String sql = "SELECT COUNT([id]) FROM [dbo].[contact] WHERE [status] = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    private Contact extractContact(ResultSet rs, UserDAO udao) throws SQLException {
        Contact contact = new Contact();
        contact.setId(rs.getInt("id"));
        contact.setContactEmail(rs.getString("contact_email"));
        contact.setContactDate(rs.getTimestamp("contact_date"));
        contact.setReplyDate(rs.getTimestamp("reply_date"));
        contact.setContactContent(rs.getString("contact_content"));
        contact.setReplyContent(rs.getString("reply_content"));
        contact.setStatus(rs.getString("status"));

        int responderId = rs.getInt("responder_id");
        if (!rs.wasNull()) {
            contact.setResponderUser(udao.getUserByID(responderId));
        }

        int senderId = rs.getInt("sender_id");
        if (!rs.wasNull()) {
            contact.setSenderUser(udao.getUserByID(senderId));
        }

        return contact;
    }
}
