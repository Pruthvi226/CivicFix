package com.civicfix.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T, ID extends Serializable> {
    T findById(ID id);
    List<T> findAll();
    ID save(T entity);
    void update(T entity);
    void delete(T entity);
    void deleteById(ID id);
}
