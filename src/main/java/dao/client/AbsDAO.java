package dao.client;

import model.Account;

public abstract class AbsDAO<T extends IModel> implements IDAO<T> {

    @Override
    public T login(T model) {
        Logging.login(model);
        return model;
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
