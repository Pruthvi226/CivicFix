package com.civicfix.service;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.PredictiveFlag;
import com.civicfix.entity.Ward;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.PredictiveFlagDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PredictiveMaintenanceService {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private PredictiveFlagDao predictiveDao;

    @Autowired
    private DuplicateRadarService radarService;

    @Transactional
    public void generateAdvisories() {
        LocalDateTime oneYearAgo = LocalDateTime.now().minusYears(1);
        
        // Group resolved complaints by category and proximity
        List<Complaint> history = complaintDao.findAll().stream()
            .filter(c -> c.getStatus() == Complaint.Status.VERIFIED)
            .filter(c -> c.getResolvedAt() != null && c.getResolvedAt().isAfter(oneYearAgo))
            .collect(Collectors.toList());

        // Simple pattern: If a ward has 3+ resolutions for same category in a small area
        // In this demo, we'll iterate and find clusters
        for (Complaint c : history) {
            List<Complaint> cluster = radarService.findNearbyDuplicates(
                c.getLatitude(), c.getLongitude(), c.getCategory());
            
            if (cluster.size() >= 3) {
                // Potential systemic failure!
                PredictiveFlag flag = new PredictiveFlag();
                flag.setWard(c.getWard());
                flag.setCategory(c.getCategory());
                flag.setLatitude(c.getLatitude());
                flag.setLongitude(c.getLongitude());
                flag.setRiskLevel(PredictiveFlag.RiskLevel.HIGH);
                flag.setAdvisoryMessage("Infrastructure at this spot has failed 3+ times in 12 months. Systemic replacement recommended.");
                predictiveDao.save(flag);
            }
        }
    }
}
