package model;

import dao.client.AccountDAO;

public class Account {
    private int id;
    private String name;
    private String password;
    private String email;
    private String telephone;
    private int isAdmin;

    public Account(int anInt) {
        // TODO Auto-generated constructor stub
        this.id = anInt;
    }

    public Account() {
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

    public static void main(String[] args) {
        Account c = new Account(14, "Capybara", "00000", "capybara@gamil.com", "256688924", 0);
       System.out.println(c.toString());
	//	CustomerDAO.getInstance().insert(c);

    /*    Account find = new Account(9, "ThanhTan", "6723", "thanhtan8900@gmail.com", "0865603890", 0);
        AccountDAO re = new AccountDAO();
        System.out.println(re.selectByName(find));
        re.checkEmail("thanhtan8900@gmail.com");
        re.checkLogin("ThanhTan", "6723");
*/
    }
}
