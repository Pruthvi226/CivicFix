package com.civicfix.service;

import com.civicfix.entity.WhistleblowerReport;
import com.civicfix.dao.BaseDao;
import com.civicfix.util.EncryptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class WhistleblowerService {

    @Autowired
    private BaseDao<WhistleblowerReport, Long> reportDao;

    public String submitReport(String details) throws Exception {
        WhistleblowerReport report = new WhistleblowerReport();
        
        // Secure tracking token
        String token = UUID.randomUUID().toString();
        report.setTrackingToken(token);
        
        // Encrypt details
        report.setEncryptedDetails(EncryptionUtil.encrypt(details));
        report.setStatus(WhistleblowerReport.ReportStatus.SUBMITTED);
        
        reportDao.save(report);
        return token;
    }
}
