package com.civicfix.service;

import com.civicfix.entity.Complaint;
import com.civicfix.dao.ComplaintDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class DuplicateRadarService {

    private static final double EARTH_RADIUS_KM = 6371.0;

    @Autowired
    private ComplaintDao complaintDao;

    /**
     * Finds existing complaints of the same category within 100m in the last 30 days.
     */
    public List<Complaint> findNearbyDuplicates(BigDecimal lat, BigDecimal lon, Complaint.Category category) {
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);
        List<Complaint> recentComplaints = complaintDao.findRecentByCategory(category, thirtyDaysAgo);
        
        List<Complaint> duplicates = new ArrayList<>();
        
        for (Complaint existing : recentComplaints) {
            double distance = calculateHaversineDistance(
                lat.doubleValue(), lon.doubleValue(),
                existing.getLatitude().doubleValue(), existing.getLongitude().doubleValue()
            );
            
            // 0.1 km = 100 meters
            if (distance <= 0.1) {
                duplicates.add(existing);
            }
        }
        return duplicates;
    }

    private double calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return EARTH_RADIUS_KM * c;
    }
}
