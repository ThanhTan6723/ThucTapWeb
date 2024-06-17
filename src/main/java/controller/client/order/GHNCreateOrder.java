package controller.client.order;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONArray;
import org.json.JSONObject;

public class GHNCreateOrder {
    public static void main(String[] args) {
        String url = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/create";
        String shopId = "5102261";  // ShopId của bạn
        String token = "88886949-1f43-11ef-a834-92c5c8e2c58a";  // Token của bạn

        // Dữ liệu yêu cầu
        JSONObject data = new JSONObject();
        data.put("payment_type_id", 2);
        data.put("note", "Tintest 123");
        data.put("required_note", "KHONGCHOXEMHANG");
        data.put("from_name", "TinTest124");
        data.put("from_phone", "0987654321");
        data.put("from_address", "72 Thành Thái, Phường 14, Quận 10, Hồ Chí Minh, Vietnam");
        data.put("from_ward_name", "Phường 14");
        data.put("from_district_name", "Quận 10");
        data.put("from_province_name", "HCM");
        data.put("return_phone", "0332190444");
        data.put("return_address", "39 NTT");
        data.put("return_district_id", JSONObject.NULL);
        data.put("return_ward_code", "");
        data.put("client_order_code", "");
        data.put("to_name", "TinTest124");
        data.put("to_phone", "0987654321");
        data.put("to_address", "72 Thành Thái, Phường 14, Quận 10, Hồ Chí Minh, Vietnam");
        data.put("to_ward_code", "20308");
        data.put("to_district_id", 1444);
        data.put("cod_amount", 200000);
        data.put("content", "Theo New York Times");
        data.put("weight", 200);
        data.put("length", 1);
        data.put("width", 19);
        data.put("height", 10);
        data.put("pick_station_id", 1444);
        data.put("deliver_station_id", JSONObject.NULL);
        data.put("insurance_value", 10000000);
        data.put("service_id", 0);
        data.put("service_type_id", 2);
        data.put("coupon", JSONObject.NULL);
        JSONArray pickShift = new JSONArray();
        pickShift.put(2);
        data.put("pick_shift", pickShift);

        JSONArray items = new JSONArray();
        JSONObject item = new JSONObject();
        item.put("name", "Áo Polo");
        item.put("code", "Polo123");
        item.put("quantity", 1);
        item.put("price", 200000);
        item.put("length", 12);
        item.put("width", 12);
        item.put("height", 12);
        item.put("weight", 1200);

        JSONObject category = new JSONObject();
        category.put("level1", "Áo");
        item.put("category", category);

        items.put(item);
        data.put("items", items);

        try {
            // Cấu hình HttpClient và HttpRequest
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(url))
                    .header("Content-Type", "application/json")
                    .header("ShopId", shopId)
                    .header("Token", token)
                    .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                    .build();

            // Gửi yêu cầu và xử lý phản hồi
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                System.out.println("Tạo đơn hàng thành công:");
                System.out.println(response.body());
            } else {
                System.out.println("Yêu cầu không thành công: " + response.statusCode());
                System.out.println(response.body());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
