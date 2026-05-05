package com.civicfix.dao;

import com.civicfix.entity.Complaint;
import java.time.LocalDateTime;
import java.util.List;

public interface ComplaintDao extends BaseDao<Complaint, Long> {
    List<Complaint> findByCitizenId(Long citizenId);
    List<Complaint> findRecentByCategory(Complaint.Category category, LocalDateTime since);
    
    // For JD Requirement: Efficient Data Retrieval via Hibernate Criteria API
    List<Complaint> findByCriteria(String status, String category, Long wardId, String severity);
}
