package com.civicfix.service;

import com.civicfix.entity.Ward;
import com.civicfix.entity.Complaint;
import com.civicfix.dao.BaseDao;
import com.civicfix.dao.ComplaintDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
public class WardHealthScoreService {

    @Autowired
    private BaseDao<Ward, Long> wardDao;

    @Autowired
    private ComplaintDao complaintDao;

    @Transactional
    public void recalculateDailyScores() {
        List<Ward> wards = wardDao.findAll();
        for (Ward ward : wards) {
            double score = 100.0;
            
            // Negative weights
            long openCount = complaintDao.findAll().stream()
                .filter(c -> c.getWard() != null && c.getWard().getId().equals(ward.getId()))
                .filter(c -> c.getStatus() == Complaint.Status.OPEN || c.getStatus() == Complaint.Status.ASSIGNED)
                .count();
            
            score -= (openCount * 5.0); // Each open issue drops score by 5
            
            // Satisfaction weights (Verified resolutions)
            long verifiedCount = complaintDao.findAll().stream()
                .filter(c -> c.getWard() != null && c.getWard().getId().equals(ward.getId()))
                .filter(c -> c.getVerificationStatus() == Complaint.VerificationStatus.ACCEPTED)
                .count();
            
            score += (verifiedCount * 2.0); // Each happy citizen boosts score by 2
            
            // Clamp score between 0 and 100
            score = Math.max(0, Math.min(100, score));
            
            ward.setHealthScore(new BigDecimal(score).setScale(2, BigDecimal.ROUND_HALF_UP));
            wardDao.update(ward);
        }
    }
}
