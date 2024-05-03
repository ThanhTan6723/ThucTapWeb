package dao.client;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public abstract class AbsDAO<T extends IModel> implements IDAO<T> {

    @Override
    public int insert(T model) {
        Logging.insert(model);
        return 0;
    }

    @Override
    public int update(T model) {
        Logging.update(model);
        return 0;
    }

    @Override
    public int delete(T model) {
        Logging.delete(model);
        return 0;
    }
}
