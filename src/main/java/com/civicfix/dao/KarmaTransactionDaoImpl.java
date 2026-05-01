package com.civicfix.dao;

import com.civicfix.entity.KarmaTransaction;
import org.springframework.stereotype.Repository;

@Repository
public class KarmaTransactionDaoImpl extends BaseDaoImpl<KarmaTransaction, Long> implements BaseDao<KarmaTransaction, Long> {
    public KarmaTransactionDaoImpl() {
        super(KarmaTransaction.class);
    }
}
