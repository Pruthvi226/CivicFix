package com.civicfix.dto;

import com.civicfix.entity.Complaint;

public class ClassificationResponse {
    private Complaint.Category category;
    private Complaint.Severity severity;
    private int estimatedFixTime;

    public ClassificationResponse() {}

    public ClassificationResponse(Complaint.Category category, Complaint.Severity severity, int estimatedFixTime) {
        this.category = category;
        this.severity = severity;
        this.estimatedFixTime = estimatedFixTime;
    }

    // Getters and Setters
    public Complaint.Category getCategory() { return category; }
    public void setCategory(Complaint.Category category) { this.category = category; }

    public Complaint.Severity getSeverity() { return severity; }
    public void setSeverity(Complaint.Severity severity) { this.severity = severity; }

    public int getEstimatedFixTime() { return estimatedFixTime; }
    public void setEstimatedFixTime(int estimatedFixTime) { this.estimatedFixTime = estimatedFixTime; }
}
