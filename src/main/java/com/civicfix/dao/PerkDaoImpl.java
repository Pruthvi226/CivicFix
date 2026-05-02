package com.civicfix.dao;

import com.civicfix.entity.Perk;
import org.springframework.stereotype.Repository;

@Repository
public class PerkDaoImpl extends BaseDaoImpl<Perk, Long> implements PerkDao {
    public PerkDaoImpl() {
        super(Perk.class);
    }
}
