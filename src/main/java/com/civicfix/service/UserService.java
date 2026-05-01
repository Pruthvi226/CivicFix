package com.civicfix.service;

import com.civicfix.entity.User;

public interface UserService {
    User register(User user);
    User login(String username, String password);
    User findById(Long id);
    User findByUsername(String username);
}
