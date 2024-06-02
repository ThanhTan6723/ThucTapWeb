package dao.client;

import model.Account;
import model.Log;

public abstract class AbsDAO<T extends IModel> implements IDAO<T> {

    @Override
    public T login(String field, String value, String password) {
        Log log = new Log();
        log.setAccount(AccountDAO.getAccountByField());
        Logging.login(log);
        return ;
    }

    @Override
    public int insert(T model) {
        Logging.insert(model);
        return 1;
    }

    @Override
    public int update(T model) {
        Logging.update(model);
        return 1;
    }

    @Override
    public int delete(T model) {
        Logging.delete(model);
        return 1;
    }
}
