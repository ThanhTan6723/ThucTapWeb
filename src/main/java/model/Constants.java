package model;

public class Constants {
    public static String FACEBOOK_APP_ID = "359123991240252";
    public static String FACEBOOK_APP_SECRET = "d07e182d8495df6930665d6c39fbe8ac";
    public static String FACEBOOK_REDIRECT_URL = "https://localhost:8443/AccessFacebook/login-facebook";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";

    public static String GOOGLE_CLIENT_ID = "352140522561-vpmetjr6bjce1vod9b0cppihhbcgdesh.apps.googleusercontent.com";
    public static String GOOGLE_CLIENT_SECRET = "dujlslz823Da_oyjQ1JJtTbX";
    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/AccessGoogle/login-google";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
