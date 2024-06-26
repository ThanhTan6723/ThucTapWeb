package controller.client.AccessGoogle;

public class Constants {
    public static String FACEBOOK_APP_ID = "859487865990246";
    public static String FACEBOOK_APP_SECRET = "bcf92d07f6225b8c85b554d55e89a4c5";
    public static String FACEBOOK_REDIRECT_URL = "https://localhost:8080/login-facebook";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v19.0/dialog/oauth/access_token";
    public static String FACEBOOK_LINK_GET_USER_INFO = "https://graph.facebook.com/me?fields=id,name,email,picture&access_token=";

    public static String GOOGLE_CLIENT_ID = "103711909118-kj61sqe0bv8srccvmk7tire0ih1oi87o.apps.googleusercontent.com";
    public static String GOOGLE_CLIENT_SECRET = "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";
    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/login-google";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}