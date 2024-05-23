package model;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Batch {
    private int id;
    private int productId;
    private String name;
    private Date manufacturingDate;
    private Date expiryDate;
    private Date dateOfImporting; // Ngày nhập hàng
    private int quantity;
    private double priceImport;
    private Provider provider;
    private Account adminCreate;

    public Batch(int id, int productId, String name, Date manufacturingDate, Date expiryDate, Date dateOfImporting, int quantity, double priceImport, Provider provider) {
        this.id = id;
        this.productId = productId;
        this.name = name;
        this.manufacturingDate = manufacturingDate;
        this.expiryDate = expiryDate;
        this.dateOfImporting = dateOfImporting;
        this.quantity = quantity;
        this.priceImport = priceImport;
        this.provider = provider;
    }

    public Batch(int id, int productId, String name, Date manufacturingDate, Date expiryDate, Date dateOfImporting, int quantity, double priceImport, Provider provider, Account adminCreate) {
        this.id = id;
        this.productId = productId;
        this.name = name;
        this.manufacturingDate = manufacturingDate;
        this.expiryDate = expiryDate;
        this.dateOfImporting = dateOfImporting;
        this.quantity = quantity;
        this.priceImport = priceImport;
        this.provider = provider;
        this.adminCreate = adminCreate;

    }

    public Batch(int id, int productId, String name, Date manufacturingDate, Date expiryDate, Date dateOfImporting, int quantity, double priceImport) {
        this.id = id;
        this.productId = productId;
        this.name = name;
        this.manufacturingDate = manufacturingDate;
        this.expiryDate = expiryDate;
        this.dateOfImporting = dateOfImporting;
        this.quantity = quantity;
        this.priceImport = priceImport;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getManufacturingDate() {
        return manufacturingDate;
    }

    public void setManufacturingDate(Date manufacturingDate) {
        this.manufacturingDate = manufacturingDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Date getDateOfImporting() {
        return dateOfImporting;
    }

    public void setDateOfImporting(Date dateOfImporting) {
        this.dateOfImporting = dateOfImporting;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPriceImport() {
        return priceImport;
    }

    public void setPriceImport(double priceImport) {
        this.priceImport = priceImport;
    }

    public Account getAdminCreate() {
        return adminCreate;
    }

    public void setAdminCreate(Account adminCreate) {
        this.adminCreate = adminCreate;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    @Override
    public String toString() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return "Batch{" +
                "id=" + id +
                ", productId=" + productId +
                ", name='" + name + '\'' +
                ", manufacturingDate=" + (manufacturingDate != null ? dateFormat.format(manufacturingDate) : "null") +
                ", expiryDate=" + (expiryDate != null ? dateFormat.format(expiryDate) : "null") +
                ", dateOfImporting=" + (dateOfImporting != null ? dateFormat.format(dateOfImporting) : "null") +
                ", quantity=" + quantity +
                ", priceImport=" + priceImport +
                ", provider=" + provider +
                ", adminCreate=" + adminCreate +
                '}';
    }
}