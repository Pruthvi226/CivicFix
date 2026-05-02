package com.civicfix.service;

import com.civicfix.entity.Ward;
import com.civicfix.entity.Complaint;
import com.civicfix.dao.WardDao;
import com.civicfix.dao.ComplaintDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.Collectors;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.time.LocalDateTime;

@Service
public class WardHealthScoreService {

    @Autowired
    private WardDao wardDao;

    @Autowired
    private ComplaintDao complaintDao;

    private final Map<Long, BigDecimal> scoreCache = new ConcurrentHashMap<>();
    private LocalDateTime lastFullUpdate = LocalDateTime.MIN;

    @Transactional
    public void recalculateDailyScores() {
        // Only run full recalculation every 10 minutes to save resources
        if (lastFullUpdate.isAfter(LocalDateTime.now().minusMinutes(10))) return;

        List<Ward> wards = wardDao.findAll();
        for (Ward ward : wards) {
            double score = 100.0;
            
            // Optimized query: Only count relevant complaints
            List<Complaint> wardComplaints = complaintDao.findAll().stream()
                .filter(c -> c.getWard() != null && c.getWard().getId().equals(ward.getId()))
                .collect(Collectors.toList());

            long openCount = wardComplaints.stream()
                .filter(c -> c.getStatus() == Complaint.Status.OPEN || c.getStatus() == Complaint.Status.ASSIGNED)
                .count();
            
            score -= (openCount * 5.0); 
            
            long verifiedCount = wardComplaints.stream()
                .filter(c -> c.getVerificationStatus() == Complaint.VerificationStatus.ACCEPTED)
                .count();
            
            score += (verifiedCount * 2.0); 
            
            score = Math.max(0, Math.min(100, score));
            BigDecimal finalScore = new BigDecimal(score).setScale(2, BigDecimal.ROUND_HALF_UP);
            
            ward.setHealthScore(finalScore);
            wardDao.update(ward);
            scoreCache.put(ward.getId(), finalScore);
        }
        lastFullUpdate = LocalDateTime.now();
    }

    public BigDecimal getCachedScore(Long wardId) {
        return scoreCache.getOrDefault(wardId, new BigDecimal("100.00"));
    }
}
