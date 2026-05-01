package com.civicfix.dao;

import com.civicfix.entity.User;

public interface UserDao extends BaseDao<User, Long> {
    User findByUsername(String username);
    User findByEmail(String email);
}
