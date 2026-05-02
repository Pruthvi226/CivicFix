package com.civicfix.dao;

import com.civicfix.entity.PredictiveFlag;
import org.springframework.stereotype.Repository;

@Repository
public class PredictiveFlagDaoImpl extends BaseDaoImpl<PredictiveFlag, Long> implements PredictiveFlagDao {
    public PredictiveFlagDaoImpl() {
        super(PredictiveFlag.class);
    }
}
