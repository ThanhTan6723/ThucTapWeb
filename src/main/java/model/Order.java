package model;

import java.util.List;

public class Order {
    private int id;
    private String booking_date;
    private String dilivery_date;
    private Account account;
    private String consigneeName;
    private String consigneePhone;
    private double ship;
    private double totalMoney;
    private String address;
    private String orderNotes;
    private String orderStatus;

    public Order() {
        super();
    }

    public Order(int id, String booking_date, Account account, String consigneeName, String consigneePhone, double ship, double totalMoney, String address, String orderNotes, String orderStatus) {
        this.id = id;
        this.booking_date = booking_date;
        this.account = account;
        this.consigneeName = consigneeName;
        this.consigneePhone = consigneePhone;
        this.ship = ship;
        this.totalMoney = totalMoney;
        this.address = address;
        this.orderNotes = orderNotes;
        this.orderStatus = orderStatus;
    }

    public Order(int id, String booking_date, String dilivery_date, Account account, String consigneeName, String consigneePhone, double ship, double totalMoney, String address, String orderNotes, String orderStatus) {
        this.id = id;
        this.booking_date = booking_date;
        this.dilivery_date = dilivery_date;
        this.account = account;
        this.consigneeName = consigneeName;
        this.consigneePhone = consigneePhone;
        this.ship = ship;
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

    public String getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(String booking_date) {
        this.booking_date = booking_date;
    }

    public String getDilivery_date() {
        return dilivery_date;
    }

    public void setDilivery_date(String dilivery_date) {
        this.dilivery_date = dilivery_date;
    }

    public double getShip() {
        return ship;
    }

    public void setShip(double ship) {
        this.ship = ship;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", booking_date='" + booking_date + '\'' +
                ", dilivery_date='" + dilivery_date + '\'' +
                ", account=" + account +
                ", consigneeName='" + consigneeName + '\'' +
                ", consigneePhone='" + consigneePhone + '\'' +
                ", ship=" + ship +
                ", totalMoney=" + totalMoney +
                ", address='" + address + '\'' +
                ", orderNotes='" + orderNotes + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                '}';
    }
}
