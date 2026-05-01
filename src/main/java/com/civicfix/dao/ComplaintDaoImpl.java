package com.civicfix.dao;

import com.civicfix.entity.Complaint;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class ComplaintDaoImpl extends BaseDaoImpl<Complaint, Long> implements ComplaintDao {

    public ComplaintDaoImpl() {
        super(Complaint.class);
    }

    @Override
    public List<Complaint> findByCitizenId(Long citizenId) {
        Query<Complaint> query = getSession().createQuery("from Complaint where citizen.id = :citizenId", Complaint.class);
        query.setParameter("citizenId", citizenId);
        return query.list();
    }

    @Override
    public List<Complaint> findRecentByCategory(Complaint.Category category, LocalDateTime since) {
        Query<Complaint> query = getSession().createQuery("from Complaint where category = :category and reportedAt >= :since", Complaint.class);
        query.setParameter("category", category);
        query.setParameter("since", since);
        return query.list();
    }
}
