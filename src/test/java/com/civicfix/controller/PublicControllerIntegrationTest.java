package com.civicfix.controller;

import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.UserDao;
import com.civicfix.dao.WardDao;
import com.civicfix.entity.Complaint;
import com.civicfix.entity.User;
import com.civicfix.entity.Ward;
import com.civicfix.service.WhistleblowerService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class PublicControllerIntegrationTest {

    @Mock
    private WardDao wardDao;

    @Mock
    private UserDao userDao;

    @Mock
    private ComplaintDao complaintDao;

    @Mock
    private WhistleblowerService whistleblowerService;

    @InjectMocks
    private PublicController publicController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testLeaderboardIntegration() {
        Ward w1 = new Ward(); w1.setName("North"); w1.setHealthScore(new java.math.BigDecimal("90.00"));
        Ward w2 = new Ward(); w2.setName("South"); w2.setHealthScore(new java.math.BigDecimal("80.00"));
        when(wardDao.findAll()).thenReturn(Arrays.asList(w1, w2));

        User u1 = new User(); u1.setUsername("hero1"); u1.setRole(User.UserRole.CITIZEN); u1.setKarmaPoints(100);
        when(userDao.findAll()).thenReturn(Arrays.asList(u1));

        Model model = new ExtendedModelMap();
        String viewName = publicController.leaderboard(model);

        assertEquals("public/leaderboard", viewName);
        @SuppressWarnings("unchecked")
        List<Ward> wards = (List<Ward>) model.getAttribute("wards");
        assertNotNull(wards);
        assertEquals(2, wards.size());
        assertEquals("North", wards.get(0).getName());
    }

    @Test
    public void testTransparencyIntegration() {
        Complaint c1 = new Complaint(); 
        c1.setCategory(Complaint.Category.POTHOLE); 
        c1.setStatus(Complaint.Status.OPEN);
        
        Complaint c2 = new Complaint(); 
        c2.setCategory(Complaint.Category.DRAIN); 
        c2.setStatus(Complaint.Status.RESOLVED);

        when(complaintDao.findAll()).thenReturn(Arrays.asList(c1, c2));

        Model model = new ExtendedModelMap();
        String viewName = publicController.transparency(model);

        assertEquals("public/transparency", viewName);
        assertEquals(2L, model.getAttribute("totalComplaints"));
        assertEquals(1L, model.getAttribute("resolvedComplaints"));
        Object complaintsJson = model.getAttribute("complaintsJson");
        assertNotNull(complaintsJson);
        assertTrue(complaintsJson.toString().contains("POTHOLE"));
    }
}
