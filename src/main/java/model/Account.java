package model;

import dao.client.IModel;

public class Account implements IModel {
    private int id;
    private String name;
    private String password;
    private String email;
    private String telephone;
    private int isAdmin;

    public Account() {
        // TODO Auto-generated constructor stub
    }

    public Account(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Account(int id, String name, String password, String email, String telephone) {
        super();
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.telephone = telephone;
    }

    public Account(int id, String name, String password, String email, String telephone, int isAdmin) {
        super();
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.telephone = telephone;
        this.isAdmin = isAdmin;
    }

    public Account(int anInt) {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    @Override
    public String toString() {
        return "Account: " + "id: " + id + ", " + name + ", " + password + ", " + email + ", " + telephone
                + ", isAdmin: " + isAdmin;
    }

    @Override
    public String getTable() {
        return "Accounts";
    }

    @Override
    public Object getBeforeData() {
        return new Account(id, name, password, email, telephone, isAdmin);
    }

    @Override
    public Object getAfterData() {
        return this;
    }

}
