package dao.client;

import model.Account;

public interface IDAO<T> {

    Account login(T t);

    int insert(T t);

    int update(T t);

    int delete(T t);


}
