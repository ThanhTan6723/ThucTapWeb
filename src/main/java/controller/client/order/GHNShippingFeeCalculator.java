package controller.client.order;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONObject;

public class GHNShippingFeeCalculator {
    public static void main(String[] args) {
        String apiKey = "88886949-1f43-11ef-a834-92c5c8e2c58a";  // Đảm bảo API Key là hợp lệ
        String url = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee";  // Sử dụng endpoint `fee`

        // Dữ liệu yêu cầu
        JSONObject data = new JSONObject();
        data.put("from_district_id", 1451);  // ID quận Bình Tân (Hồ Chí Minh)
        data.put("service_id", 53320);  // ID dịch vụ (lấy từ danh sách dịch vụ GHN cung cấp)
        data.put("to_district_id", 1730);  // ID Bến Tre
        data.put("weight", 1000);  // Trọng lượng đơn hàng (gram)
        data.put("insurance_value", 1000000);  // Giá trị khai báo của đơn hàng
        data.put("coupon", JSONObject.NULL);  // Mã giảm giá (nếu có)

        try {
            // Cấu hình HttpClient và HttpRequest
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(url))
                    .header("Content-Type", "application/json")
                    .header("Token", apiKey)
                    .header("ShopID","5102261")
                    .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                    .build();

            // Gửi yêu cầu và xử lý phản hồi
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                JSONObject responseBody = new JSONObject(response.body());
                int shippingFee = responseBody.getJSONObject("data").getInt("total");
                System.out.println("Phí vận chuyển: " + shippingFee);
            } else {
                System.out.println("Yêu cầu không thành công: " + response.statusCode());
                System.out.println(response.body());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
