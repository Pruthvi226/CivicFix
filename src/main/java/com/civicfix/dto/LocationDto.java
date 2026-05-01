package com.civicfix.dto;

import com.civicfix.entity.Complaint;
import java.math.BigDecimal;

public class LocationDto {
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Complaint.Category category;

    // Getters and Setters
    public BigDecimal getLatitude() { return latitude; }
    public void setLatitude(BigDecimal latitude) { this.latitude = latitude; }

    public BigDecimal getLongitude() { return longitude; }
    public void setLongitude(BigDecimal longitude) { this.longitude = longitude; }

    public Complaint.Category getCategory() { return category; }
    public void setCategory(Complaint.Category category) { this.category = category; }
}
