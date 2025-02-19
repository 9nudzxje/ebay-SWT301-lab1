/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Jigger
 */
public class Contact {

    private int id;
    private String contactEmail;
    private Date contactDate;
    private Date replyDate;
    private String contactContent;
    private String replyContent;
    private String status;
    private User responderUser;
    private User senderUser;

    public Contact() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public Date getContactDate() {
        return contactDate;
    }

    public void setContactDate(Date contactDate) {
        this.contactDate = contactDate;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    public String getContactContent() {
        return contactContent;
    }

    public void setContactContent(String contactContent) {
        this.contactContent = contactContent;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getResponderUser() {
        return responderUser;
    }

    public void setResponderUser(User responderUser) {
        this.responderUser = responderUser;
    }

    public User getSenderUser() {
        return senderUser;
    }

    public void setSenderUser(User senderUser) {
        this.senderUser = senderUser;
    }

    @Override
    public String toString() {
        return "Contact{" + "id=" + id + ", contactEmail=" + contactEmail + ", contactDate=" + contactDate + ", replyDate=" + replyDate + ", contactContent=" + contactContent + ", replyContent=" + replyContent + ", status=" + status + ", responderUser=" + responderUser + ", senderUser=" + senderUser + '}';
    }

}
