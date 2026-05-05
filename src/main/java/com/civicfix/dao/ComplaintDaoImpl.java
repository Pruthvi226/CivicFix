package com.civicfix.dao;

import com.civicfix.entity.Complaint;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

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
    @Override
    public List<Complaint> findByCriteria(String status, String category, Long wardId, String severity) {
        CriteriaBuilder cb = getSession().getCriteriaBuilder();
        CriteriaQuery<Complaint> cr = cb.createQuery(Complaint.class);
        Root<Complaint> root = cr.from(Complaint.class);

        List<Predicate> predicates = new ArrayList<>();

        if (status != null && !status.isEmpty()) {
            predicates.add(cb.equal(root.get("status"), Complaint.Status.valueOf(status)));
        }
        if (category != null && !category.isEmpty()) {
            predicates.add(cb.equal(root.get("category"), Complaint.Category.valueOf(category)));
        }
        if (wardId != null && wardId > 0) {
            predicates.add(cb.equal(root.get("ward").get("id"), wardId));
        }
        if (severity != null && !severity.isEmpty()) {
            predicates.add(cb.equal(root.get("severity"), Complaint.Severity.valueOf(severity)));
        }

        cr.select(root).where(predicates.toArray(new Predicate[0]));
        cr.orderBy(cb.desc(root.get("reportedAt")));

        return getSession().createQuery(cr).getResultList();
    }
}
