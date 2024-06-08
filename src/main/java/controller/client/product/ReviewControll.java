//package controller.client.product;
//
//import dao.client.ProductDAO;
//import model.Account;
//import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.annotation.WebServlet;
//import model.Review;
//import net.coobird.thumbnailator.Thumbnails;
//
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.io.*;
//import java.time.LocalDateTime;
//
//
//@WebServlet(name = "ReviewControll", value = "/ReviewControll")
//@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB
//public class ReviewControll extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
//
//        HttpSession session = request.getSession();
//        String id = request.getParameter("id");
//        String ratingStr = request.getParameter("rating");
//        String comment = request.getParameter("comment");
//        String name = request.getParameter("name");
//        String phone = request.getParameter("phone");
//
//        if (id != null && ratingStr != null && comment != null) {
//            Account acc = (Account) session.getAttribute("account");
//            if (acc != null) {
//                int rating = Integer.parseInt(ratingStr);
//                Review review = new Review();
//                review.setNameCommenter(name);
//                review.setPhoneNumberCommenter(phone);
//                review.setRating(rating);
//                review.setComment(comment);
//                review.setDateCreated(String.valueOf(LocalDateTime.now()));
//                review.setProductEvaluated(ProductDAO.getProductById(Integer.parseInt(id)));
//
//                // Upload ảnh và nén trước khi lưu
//                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
//                File uploadDir = new File(uploadPath);
//                if (!uploadDir.exists()) {
//                    uploadDir.mkdir();
//                }
//
//                Part filePart = request.getPart("image");
//                String fileName = getFileName(filePart);
//
//                if (fileName != null && !fileName.isEmpty()) {
//                    String filePath = uploadPath + File.separator + fileName;
//                    try (InputStream fileContent = filePart.getInputStream()) {
//                        Thumbnails.of(fileContent)
//                                .size(300, 300)
//                                .outputQuality(0.5) // Chất lượng ảnh nén
//                                .toFile(new File(filePath));
//                    }
//                    String imageUrl = "images/" + fileName;
//                    review.setImage(imageUrl);
//                }
//
//                // Lưu đánh giá vào cơ sở dữ liệu
//                ProductDAO.saveReview(review);
//
//                // Chuyển hướng về trang chi tiết sản phẩm
//                response.sendRedirect("DetailControl?pid=" + id);
//            } else {
//                // Nếu không có tài khoản đăng nhập, chuyển hướng đến trang đăng nhập
//                response.sendRedirect("LoginControll");
//            }
//        } else {
//            // Nếu thiếu thông tin cần thiết, chuyển hướng về trang chi tiết sản phẩm
//            response.sendRedirect("DetailControl?pid=" + id);
//        }
//    }
//
//    // Phương thức lấy tên file từ một Part
//    private String getFileName(Part part) {
//        for (String content : part.getHeader("content-disposition").split(";")) {
//            if (content.trim().startsWith("filename")) {
//                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
//            }
//        }
//        return null;
//    }
//}
