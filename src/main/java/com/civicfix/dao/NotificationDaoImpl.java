package com.civicfix.dao;

import com.civicfix.entity.Notification;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class NotificationDaoImpl extends BaseDaoImpl<Notification, Long> implements NotificationDao {

    public NotificationDaoImpl() {
        super(Notification.class);
    }

    @Override
    public List<Notification> findByUserId(Long userId) {
        Query<Notification> query = sessionFactory.getCurrentSession().createQuery(
                "FROM Notification WHERE user.id = :userId ORDER BY createdAt DESC", Notification.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public List<Notification> findUnreadByUserId(Long userId) {
        Query<Notification> query = sessionFactory.getCurrentSession().createQuery(
                "FROM Notification WHERE user.id = :userId AND isRead = false ORDER BY createdAt DESC", Notification.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    @Transactional
    public void markAllReadForUser(Long userId) {
        sessionFactory.getCurrentSession().createQuery(
                "UPDATE Notification SET isRead = true WHERE user.id = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
    }
}
