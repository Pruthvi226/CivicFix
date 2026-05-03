package com.civicfix.dao;

import com.civicfix.entity.Notification;
import java.util.List;

public interface NotificationDao extends BaseDao<Notification, Long> {
    List<Notification> findByUserId(Long userId);
    List<Notification> findUnreadByUserId(Long userId);
    void markAllReadForUser(Long userId);
}
