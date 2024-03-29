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

	public Product() {
		super();
	}

	public Product(int id, String name, double price, String image, String description, Category category) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
	}



	public Product(int id, String name, double price, String description, Category category) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.description = description;
		this.category = category;
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

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", description="
				+ description + ", category=" + category + "]";
	}

//	public static void main(String[] args) {
//		List<Product> products = ProductDAO.getListProducts();
//		System.out.println(products.get(0).getName());
//	}
}