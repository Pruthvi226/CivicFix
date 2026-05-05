package com.civicfix.service;

import com.civicfix.dto.ClassificationResponse;
import com.civicfix.entity.Complaint;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ComplaintClassifierServiceTest {

    private final ComplaintClassifierService classifier = new ComplaintClassifierService();

    @Test
    public void testPotholeClassification() {
        ClassificationResponse response = classifier.classify("There is a massive pothole on the main road.");
        assertEquals(Complaint.Category.POTHOLE, response.getCategory());
        assertEquals(Complaint.Severity.HIGH, response.getSeverity()); // "massive" matches "big" patterns in classifier? Wait, let's check.
    }

    @Test
    public void testDrainCriticalClassification() {
        ClassificationResponse response = classifier.classify("The drain is overflowing and it's a danger to pedestrians and may cause injury.");
        assertEquals(Complaint.Category.DRAIN, response.getCategory());
        assertEquals(Complaint.Severity.CRITICAL, response.getSeverity());
        assertEquals(24, response.getEstimatedFixTime());
    }

    @Test
    public void testStreetlightMinorClassification() {
        ClassificationResponse response = classifier.classify("A small streetlight bulb is flickering slightly.");
        assertEquals(Complaint.Category.STREETLIGHT, response.getCategory());
        assertEquals(Complaint.Severity.LOW, response.getSeverity());
        assertEquals(168, response.getEstimatedFixTime());
    }

    @Test
    public void testGarbageHighClassification() {
        ClassificationResponse response = classifier.classify("Huge piles of garbage and waste are spreading everywhere.");
        assertEquals(Complaint.Category.GARBAGE, response.getCategory());
        assertEquals(Complaint.Severity.CRITICAL, response.getSeverity()); // "huge" matches critical
    }

    @Test
    public void testOtherCategory() {
        ClassificationResponse response = classifier.classify("The park bench is broken.");
        assertEquals(Complaint.Category.OTHER, response.getCategory());
        assertEquals(Complaint.Severity.HIGH, response.getSeverity()); // "broken" matches high
    }
}
