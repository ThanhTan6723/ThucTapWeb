package model;

import java.util.List;

public class Order {
    private int id;
    private String date;
    private Account account;
    private String consigneeName;
    private String consigneePhone;
    private double totalMoney;
    private String address;
    private String orderNotes;
    private String orderStatus;

    public Order() {
        super();
    }

    public Order(int id, String date, Account account, String consigneeName, String consigneePhone, double totalMoney, String address, String orderNotes, String orderStatus) {
        this.id = id;
        this.date = date;
        this.account = account;
        this.consigneeName = consigneeName;
        this.consigneePhone = consigneePhone;
        this.totalMoney = totalMoney;
        this.address = address;
        this.orderNotes = orderNotes;
        this.orderStatus = orderStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getConsigneeName() {
        return consigneeName;
    }

    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }

    public String getConsigneePhone() {
        return consigneePhone;
    }

    public void setConsigneePhone(String consigneePhone) {
        this.consigneePhone = consigneePhone;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOrderNotes() {
        return orderNotes;
    }

    public void setOrderNotes(String orderNotes) {
        this.orderNotes = orderNotes;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", date='" + date + '\'' +
                ", account=" + account +
                ", consigneeName='" + consigneeName + '\'' +
                ", consigneePhone='" + consigneePhone + '\'' +
                ", totalMoney=" + totalMoney +
                ", address='" + address + '\'' +
                ", orderNotes='" + orderNotes + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                '}';
    }
}
