package com.civicfix.dao;

import com.civicfix.entity.KarmaTransaction;

public interface KarmaTransactionDao extends BaseDao<KarmaTransaction, Long> {
    java.util.List<KarmaTransaction> findByCitizenId(Long citizenId);
}
