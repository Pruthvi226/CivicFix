package com.civicfix.dao;

import com.civicfix.entity.User;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl extends BaseDaoImpl<User, Long> implements UserDao {

    public UserDaoImpl() {
        super(User.class);
    }

    @Override
    public User findByUsername(String username) {
        Query<User> query = getSession().createQuery("from User where username = :username", User.class);
        query.setParameter("username", username);
        return query.uniqueResult();
    }

    @Override
    public User findByEmail(String email) {
        Query<User> query = getSession().createQuery("from User where email = :email", User.class);
        query.setParameter("email", email);
        return query.uniqueResult();
    }
}
