package com.civicfix.dao;

import com.civicfix.entity.Ward;
import org.springframework.stereotype.Repository;

@Repository
public class WardDaoImpl extends BaseDaoImpl<Ward, Long> implements WardDao {
    public WardDaoImpl() {
        super(Ward.class);
    }
}
