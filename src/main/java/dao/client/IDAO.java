package dao.client;

public interface IDAO<T extends IModel> {

    public T login(T t);
    public  int insert(T t);
    public int update(T t);
    public int delete(T t);



}
