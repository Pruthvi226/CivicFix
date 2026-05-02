package com.civicfix.service;

import com.civicfix.entity.WhistleblowerReport;
import com.civicfix.dao.WhistleblowerReportDao;
import com.civicfix.util.EncryptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class WhistleblowerService {

    @Autowired
    private WhistleblowerReportDao reportDao;

    public String submitReport(String details) throws Exception {
        if (details == null || details.trim().isEmpty()) {
            throw new IllegalArgumentException("Report details cannot be empty");
        }
        
        System.out.println("Submitting whistleblower report: " + details.substring(0, Math.min(20, details.length())) + "...");
        
        WhistleblowerReport report = new WhistleblowerReport();
        
        // Secure tracking token
        String token = UUID.randomUUID().toString();
        report.setTrackingToken(token);
        
        // Encrypt details
        report.setEncryptedDetails(EncryptionUtil.encrypt(details));
        report.setStatus(WhistleblowerReport.ReportStatus.SUBMITTED);
        
        if (reportDao == null) {
            System.err.println("CRITICAL: reportDao is NULL in WhistleblowerService!");
            throw new IllegalStateException("Database service unavailable");
        }
        
        reportDao.save(report);
        return token;
    }
}
