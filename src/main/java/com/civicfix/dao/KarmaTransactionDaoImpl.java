package com.civicfix.dao;

import com.civicfix.entity.KarmaTransaction;
import org.springframework.stereotype.Repository;

@Repository
public class KarmaTransactionDaoImpl extends BaseDaoImpl<KarmaTransaction, Long> implements KarmaTransactionDao {
    public KarmaTransactionDaoImpl() {
        super(KarmaTransaction.class);
    }

    @Override
    public java.util.List<KarmaTransaction> findByCitizenId(Long citizenId) {
        org.hibernate.Session session = sessionFactory.getCurrentSession();
        org.hibernate.query.Query<KarmaTransaction> query = session.createQuery(
                "FROM KarmaTransaction WHERE citizen.id = :citizenId ORDER BY createdAt DESC", 
                KarmaTransaction.class);
        query.setParameter("citizenId", citizenId);
        return query.getResultList();
    }
}
