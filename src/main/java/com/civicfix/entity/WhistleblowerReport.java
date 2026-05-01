package com.civicfix.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "whistleblower_reports")
public class WhistleblowerReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tracking_token", nullable = false, unique = true, length = 64)
    private String trackingToken;

    @Column(name = "encrypted_details", columnDefinition = "TEXT", nullable = false)
    private String encryptedDetails;

    @Enumerated(EnumType.STRING)
    private ReportStatus status = ReportStatus.SUBMITTED;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum ReportStatus { SUBMITTED, UNDER_INVESTIGATION, RESOLVED, DISMISSED }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTrackingToken() { return trackingToken; }
    public void setTrackingToken(String trackingToken) { this.trackingToken = trackingToken; }

    public String getEncryptedDetails() { return encryptedDetails; }
    public void setEncryptedDetails(String encryptedDetails) { this.encryptedDetails = encryptedDetails; }

    public ReportStatus getStatus() { return status; }
    public void setStatus(ReportStatus status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
