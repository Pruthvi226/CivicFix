package com.civicfix.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import java.io.Serializable;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public abstract class BaseDaoImpl<T, ID extends Serializable> implements BaseDao<T, ID> {

    @Autowired
    protected SessionFactory sessionFactory;

    protected Class<T> entityClass;

    protected BaseDaoImpl(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public T findById(ID id) {
        return getSession().get(entityClass, id);
    }

    @Override
    public List<T> findAll() {
        return getSession().createQuery("from " + entityClass.getName(), entityClass).list();
    }

    @Override
    @Transactional
    @SuppressWarnings("unchecked")
    public ID save(T entity) {
        return (ID) getSession().save(entity);
    }

    @Override
    @Transactional
    public void update(T entity) {
        getSession().update(entity);
    }

    @Override
    @Transactional
    public void delete(T entity) {
        getSession().delete(entity);
    }

    @Override
    @Transactional
    public void deleteById(ID id) {
        T entity = findById(id);
        if (entity != null) {
            delete(entity);
        }
    }
}
