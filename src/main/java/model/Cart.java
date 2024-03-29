package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<OrderDetail> items;

	public Cart() {
		items = new ArrayList<>();
	}

	public Cart(List<OrderDetail> items) {
		super();
		this.items = items;
	}

	public List<OrderDetail> getItems() {
		return items;
	}

	public void setItems(List<OrderDetail> items) {
		this.items = items;
	}

	private OrderDetail getItemById(int id) {
		for (OrderDetail i : items) {
			if (i.getProduct().getId() == id) {
				return i;
			}
		}
		return null;
	}

	public int getQuantityById(int id) {
		return getItemById(id).getQuantity();
	}

	// them vao gio
	public void addItem(OrderDetail t) {
		// có rồi
		if (getItemById(t.getProduct().getId()) != null) {
			OrderDetail m = getItemById(t.getProduct().getId());
			m.setQuantity(m.getQuantity() + t.getQuantity());
		} else {
			items.add(t);
		}
	}

	public void removeItem(int id) {
		if (getItemById(id) != null) {
			items.remove(getItemById(id));
		}
	}

	public double getTotalMoney() {
		double t = 0;
		for (OrderDetail i : items) {
			t += (i.getQuantity() * i.getProduct().getPrice());
		}
		return t;

	}

}
