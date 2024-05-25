package model;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

//import dao.client.ProductDAO;

public class Product {
	private int id;
	private String name;
	private double price;
	private String image;
	private String description;
	private Category category;
	private List<Image> images;
	private List<Batch> batches;

	public Product() {

		super();
	}
	public void addBatch(Batch batch) {
		if (batches == null) {
			batches = new ArrayList<>();
		}
		batches.add(batch);
	}
	public Product(int id, String name, double price, String image, String description, Category category) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
	}

	public Product(int id, String name, double price, String image, String description, Category category, List<Image> images, List<Batch> batches) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
		this.images = images;
		this.batches = batches;
	}

	public Product(int id, String name, double price, String image, String description, Category category,  List<Batch> batches) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.description = description;
		this.category = category;
		this.batches = batches;
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

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	public List<Batch> getBatches() {
		return batches;
	}

	public void setBatches(List<Batch> batches) {
		this.batches = batches;
	}

	@Override
	public String toString() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		StringBuilder builder = new StringBuilder();
		builder.append("Product{")
				.append("id=").append(id)
				.append(", name='").append(name).append('\'')
				.append(", price=").append(price)
				.append(", image='").append(image).append('\'')
				.append(", description='").append(description).append('\'')
				.append(", category=").append(category)
				.append(", images=").append(images)
				.append(", batches=[");
		if (batches != null && !batches.isEmpty()) {
			for (Batch batch : batches) {
				builder.append("Batch{id=").append(batch.getId())
						.append(", productId=").append(batch.getProductId())
						.append(", name='").append(batch.getName()).append('\'')
						.append(", manufacturingDate=").append(dateFormat.format(batch.getManufacturingDate()))
						.append(", expiryDate=").append(dateFormat.format(batch.getExpiryDate()))
						.append(", dateOfImporting=").append(dateFormat.format(batch.getDateOfImporting()))
						.append(", quantity=").append(batch.getQuantity())
						.append(", currentQuantity=").append(batch.getCurrentQuantity())
						.append(", priceImport=").append(batch.getPriceImport())
						.append(", adminCreate=").append(batch.getAdminCreate())
						.append(", provider=").append(batch.getProvider())
						.append('}');
			}
		}
		builder.append("]}");
		return builder.toString();
	}
}