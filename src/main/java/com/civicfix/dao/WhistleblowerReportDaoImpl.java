package com.civicfix.dao;

import com.civicfix.entity.WhistleblowerReport;
import org.springframework.stereotype.Repository;

@Repository
public class WhistleblowerReportDaoImpl extends BaseDaoImpl<WhistleblowerReport, Long> implements WhistleblowerReportDao {
    public WhistleblowerReportDaoImpl() {
        super(WhistleblowerReport.class);
    }
}
