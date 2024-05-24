package model;

import java.util.Date;

public class Review {
    private int id;
    private Account accountCreated;
    private Product productEvaluated;
    private int rating;
    private String comment;
    private Date dateCreated;

    public Review(int id, Account accountCreated, Product productEvaluated, int rating, String comment, Date dateCreated) {
        this.id = id;
        this.accountCreated = accountCreated;
        this.productEvaluated = productEvaluated;
        this.rating = rating;
        this.comment = comment;
        this.dateCreated = dateCreated;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccountCreated(Account accountCreated) {
        this.accountCreated = accountCreated;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getId() {
        return id;
    }

    public Account getAccountCreated() {
        return accountCreated;
    }

    public int getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public Product getProductEvaluated() {
        return productEvaluated;
    }

    public void setProductEvaluated(Product productEvaluated) {
        this.productEvaluated = productEvaluated;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", accountCreated=" + accountCreated +
                ", productEvaluated=" + productEvaluated +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", dateCreated=" + dateCreated +
                '}';
    }
}
