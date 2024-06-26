package controller.client.AccessFacebook;

import java.io.IOException;

import controller.client.AccessGoogle.Constants;
import controller.client.AccessGoogle.GooglePojo;
import model.Account;
import org.apache.http.client.ClientProtocolException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import com.restfb.Version;
import regexodus.RETokenizer;

public class RestFB {

    public static String getToken(final String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.FACEBOOK_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.FACEBOOK_APP_ID)
                        .add("client_secret", Constants.FACEBOOK_APP_SECRET)
                        .add("redirect_uri",Constants.FACEBOOK_REDIRECT_URL)
                        .add("code", code)
                        .build()).execute().returnContent().asString();
        JsonObject jsonObject = new Gson().fromJson(response,JsonObject.class);
        String accessToken = jsonObject.get("action_token").toString().replaceAll("\"","");
        return accessToken;

//        String link = String.format(Constants.FACEBOOK_LINK_GET_TOKEN, Constants.FACEBOOK_APP_ID, Constants.FACEBOOK_APP_SECRET, Constants.FACEBOOK_REDIRECT_URL, code);
//        String response = Request.Get(link).execute().returnContent().asString();
//        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
//        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
//        return accessToken;
    }

    public static Account getUserInfo(String accessToken) throws IOException {
        String link = Constants.FACEBOOK_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        // Log the user info response for debugging
        System.out.println("User Info response: " + response);

        Account googlePojo = new Gson().fromJson(response, Account.class);
        System.out.println(googlePojo);
        return googlePojo;
    }

}