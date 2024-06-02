package dao.client;

public interface IDAO<T> {

    public T login(String field, String value, String password,T t);
    public  int insert(T t);
    public int update(T t);
    public int delete(T t);



}
