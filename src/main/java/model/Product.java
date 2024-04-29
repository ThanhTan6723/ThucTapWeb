package model;

import java.util.List;

//import dao.client.ProductDAO;

public class Product {
	private int id;
	private String name;
	private double price;
	private String image;
	private String description;
	private Category category;
	private int quantity;
	private double priceImport;
	private double weight;
	private Account adminCreate;
	private Provider provider;
	private String dateOfImporting;
	private String expriredDay;
	private List<Image> images;

	public Product() {
		super();
	}

	public Product(int id, String name, double price, String image, String description, Category category, int quantity, double priceImport, double weight, Account adminCreate, Provider provider, String dateOfImporting, String expriredDay, List<Image> images) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
		this.quantity = quantity;
		this.priceImport = priceImport;
		this.weight = weight;
		this.adminCreate = adminCreate;
		this.provider = provider;
		this.dateOfImporting = dateOfImporting;
		this.expriredDay = expriredDay;
		this.images = images;
	}

	public Product(int id, String name, double price, String image, String description, Category category, int quantity, double priceImport, double weight, Account adminCreate, Provider provider, String dateOfImporting, String expriredDay) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
		this.quantity = quantity;
		this.priceImport = priceImport;
		this.weight = weight;
		this.adminCreate = adminCreate;
		this.provider = provider;
		this.dateOfImporting = dateOfImporting;
		this.expriredDay = expriredDay;
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

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Category getCategory() {

		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
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

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
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

	public String getDateOfImporting() {
		return dateOfImporting;
	}

	public void setDateOfImporting(String dateOfImporting) {
		this.dateOfImporting = dateOfImporting;
	}

	public String getExpriredDay() {
		return expriredDay;
	}

	public void setExpriredDay(String expriredDay) {
		this.expriredDay = expriredDay;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	@Override
	public String toString() {
		return "Product{" +
				"id=" + id +
				", name='" + name + '\'' +
				", price=" + price +
				", image='" + image + '\'' +
				", description='" + description + '\'' +
				", category=" + category +
				", quantity=" + quantity +
				", priceImport=" + priceImport +
				", weight=" + weight +
				", adminCreate=" + adminCreate +
				", provider=" + provider +
				", dateOfImporting='" + dateOfImporting + '\'' +
				", expriredDay='" + expriredDay + '\'' +
				'}';
	}
}