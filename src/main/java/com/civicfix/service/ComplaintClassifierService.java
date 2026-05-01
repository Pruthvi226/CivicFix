package com.civicfix.service;

import com.civicfix.entity.Complaint;
import com.civicfix.dto.ClassificationResponse;
import org.springframework.stereotype.Service;

@Service
public class ComplaintClassifierService {

    public ClassificationResponse classify(String description) {
        String lowerDesc = description.toLowerCase();
        
        Complaint.Category category = Complaint.Category.OTHER;
        Complaint.Severity severity = Complaint.Severity.MEDIUM; 
        int estimatedFixTime = 72; 
        
        // 1. Keyword-based Category Detection
        if (lowerDesc.matches(".*\\b(pothole|road|crater|asphalt|tarmac|pavement)\\b.*")) {
            category = Complaint.Category.POTHOLE;
        } else if (lowerDesc.matches(".*\\b(drain|clogged|waterlogging|sewer|flood|overflow|stinking|choke)\\b.*")) {
            category = Complaint.Category.DRAIN;
        } else if (lowerDesc.matches(".*\\b(light|dark|streetlight|bulb|pole|electricity|blackout)\\b.*")) {
            category = Complaint.Category.STREETLIGHT;
        } else if (lowerDesc.matches(".*\\b(garbage|trash|smell|waste|dump|litter|bins|collection)\\b.*")) {
            category = Complaint.Category.GARBAGE;
        }
        
        // 2. Keyword-based Severity & Fix Time Detection
        if (lowerDesc.matches(".*\\b(accident|fatal|emergency|huge|deep|critical|blocked|danger|immediate|injury)\\b.*")) {
            severity = Complaint.Severity.CRITICAL;
            estimatedFixTime = 24; 
        } else if (lowerDesc.matches(".*\\b(big|dangerous|multiple|overflowing|spreading|severe|broken)\\b.*")) {
            severity = Complaint.Severity.HIGH;
            estimatedFixTime = 48;
        } else if (lowerDesc.matches(".*\\b(small|minor|slight|tiny|faint|beginning)\\b.*")) {
            severity = Complaint.Severity.LOW;
            estimatedFixTime = 168; 
        }
        
        return new ClassificationResponse(category, severity, estimatedFixTime);
    }
}
