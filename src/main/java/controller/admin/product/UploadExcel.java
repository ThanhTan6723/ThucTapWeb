package controller.admin.product;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import dao.admin.ProductAdminDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.URL;
import java.nio.file.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "UploadExcel", value = "/UploadExcel")
public class UploadExcel extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int maxFileSize = 1024 * 1024 * 4; // 4 MB
    private static final int maxMemSize = 1024 * 1024 * 2; // 2 MB
    private static final String filePath = "D:\\nam3ki2\\TestTHUCTAPWEB";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/admin/uploadExcel.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("account");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(maxFileSize);

        try {
            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName();
                    String fileFullPath = filePath + File.separator + fileName;

                    // Sử dụng một tệp tạm thời để tránh xung đột
                    File uploadedFile = new File(filePath, UUID.randomUUID().toString() + ".tmp");
                    item.write(uploadedFile);

                    try (InputStream excelFileContent = new FileInputStream(uploadedFile)) {
                        List<Product> products = parseExcelFile(excelFileContent, loggedInUser);
                        ProductAdminDAO.insertProduct(products);
                        session.setAttribute("addedProducts", products);
                        response.sendRedirect("LoadProductsPage");
                    } catch (Exception e) {
                        e.printStackTrace();
                        throw new ServletException("Error processing uploaded file");
                    } finally {
                        // Xóa tệp tạm sau khi xử lý xong
                        uploadedFile.delete();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("File upload failed");
        }

    }

    private List<Product> parseExcelFile(InputStream excelFileContent, Account loggedInUser) throws IOException, ParseException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        List<Product> productList = new ArrayList<>();
        Workbook workbook = null;
        System.out.println("xin chao");
        try {
            workbook = new XSSFWorkbook(excelFileContent);
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();
            if (rowIterator.hasNext()) {
                rowIterator.next();
            }

            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                String productName = getCellValueAsString(row.getCell(0));
                System.out.println("ten "+productName);
                double productPrice = getCellValueAsDouble(row.getCell(1));
                System.out.println("giá "+productPrice);
                String productImageURL = getCellValueAsString(row.getCell(2));
                System.out.println("hinh anh "+productImageURL);
                String productDescription = getCellValueAsString(row.getCell(3));
                System.out.println("mo ta "+productDescription);
                int categoryId = (int) getCellValueAsDouble(row.getCell(4));
                System.out.println("mã loại "+categoryId);
                String imageListURLs = getCellValueAsString(row.getCell(5));
                System.out.println("danh sach hinh anh: "+imageListURLs);
                String batchName = getCellValueAsString(row.getCell(6));
                System.out.println("Tên lo "+batchName);
                Date manufacturingDate = dateFormat.parse(getCellValueAsString(row.getCell(7)));
                System.out.println("Ngày sản xuất "+manufacturingDate);
                Date expiryDate = dateFormat.parse(getCellValueAsString(row.getCell(8)));
                System.out.println("hạn sử dụng "+expiryDate);
                Date importingDate = dateFormat.parse(getCellValueAsString(row.getCell(9)));
                System.out.println("Ngày nhập "+importingDate);
                int batchQuantity = (int) getCellValueAsDouble(row.getCell(10));
                System.out.println("số lượng  "+batchQuantity);
                int remainingQuantity = (int) getCellValueAsDouble(row.getCell(11));
                System.out.println("số lượng còn lại " +remainingQuantity);
                double priceImport = getCellValueAsDouble(row.getCell(12));
                System.out.println("giá " +priceImport);
                String providerName = getCellValueAsString(row.getCell(13));
                System.out.println("tên nhà cung cấp "+providerName);
                String providerAddress = getCellValueAsString(row.getCell(14));
                System.out.println("địa chỉ nhà cung cấp "+providerAddress);

                // Tải và lưu hình ảnh từ URL
                String savedProductImagePath = downloadImage(productImageURL, filePath);
                Image productImage = new Image(0, savedProductImagePath); // Lưu hình ảnh với id = 0
                List<Image> savedImageList = new ArrayList<>();
                if (!imageListURLs.isEmpty()) {
                    String[] imageURLs = imageListURLs.split(",");
                    for (String imageURL : imageURLs) {
                        String savedImagePath = downloadImage(imageURL, filePath);
                        savedImageList.add(new Image(0, savedImagePath)); // Lưu danh sách hình ảnh với id = 0
                    }
                }

                // Tạo đối tượng Provider và Batch
                Provider provider = new Provider(providerName, providerAddress);
                Batch batch = new Batch(batchName, manufacturingDate, expiryDate, importingDate,
                        batchQuantity, remainingQuantity, priceImport, provider, loggedInUser);

                List<Batch> batches = new ArrayList<>();
                batches.add(batch);

                // Tạo đối tượng Product
                Product product = new Product(productName, productPrice, productImage.getUrl(),
                        productDescription, new Category(categoryId), savedImageList, batches);

                productList.add(product);
            }
        } finally {
            if (workbook != null) {
                workbook.close();
            }
        }
        return productList;
    }

    private String downloadImage(String imageUrl, String saveDirectory) throws IOException {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return "";
        }

        // Lấy tên file từ đường dẫn hình ảnh
        String fileName = Paths.get(imageUrl).getFileName().toString();

        // Đường dẫn đến thư mục lưu trữ trong dự án
        String projectImageDir = getServletContext().getRealPath("/images");

        // Tạo đường dẫn đến nơi lưu trữ trong dự án
        Path targetPath = Paths.get(projectImageDir, fileName);

        // Đọc hình ảnh từ đường dẫn và lưu vào thư mục images trong dự án
        try (InputStream inputStream = new FileInputStream(new File(imageUrl))) {
            Files.copy(inputStream, targetPath, StandardCopyOption.REPLACE_EXISTING);
        }

        // Trả về đường dẫn của hình ảnh trong thư mục images của dự án
        return "/images/" + fileName;
    }


    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("dd/MM/yyyy").format(cell.getDateCellValue());
                } else {
                    return String.valueOf(cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }

    private double getCellValueAsDouble(Cell cell) {
        if (cell == null) {
            return 0.0;
        }
        switch (cell.getCellType()) {
            case STRING:
                try {
                    return Double.parseDouble(cell.getStringCellValue());
                } catch (NumberFormatException e) {
                    return 0.0;
                }
            case NUMERIC:
                return cell.getNumericCellValue();
            case BOOLEAN:
                return cell.getBooleanCellValue() ? 1.0 : 0.0;
            case FORMULA:
                try {
                    return cell.getNumericCellValue();
                } catch (IllegalStateException e) {
                    return 0.0;
                }
            default:
                return 0.0;
        }
    }

    private Date getCellValueAsDate(Cell cell) {
        if (cell == null) {
            return null;
        }
        if (cell.getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(cell)) {
            return cell.getDateCellValue();
        }
        return null;
    }


}
