package com.civicfix.controller;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.Ward;
import com.civicfix.entity.User;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.WardDao;
import com.civicfix.dao.UserDao;
import com.civicfix.service.WhistleblowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class PublicController {

    @Autowired
    private WardDao wardDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private WhistleblowerService whistleblowerService;

    @Autowired
    private ComplaintDao complaintDao;

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("title", "Home");
        return "public/index";
    }

    @GetMapping("/leaderboard")
    public String leaderboard(Model model) {
        List<Ward> wards = wardDao.findAll().stream()
            .sorted((w1, w2) -> w2.getHealthScore().compareTo(w1.getHealthScore()))
            .collect(Collectors.toList());

        List<User> topCitizens = userDao.findAll().stream()
            .filter(u -> u.getRole() == User.UserRole.CITIZEN)
            .sorted((u1, u2) -> u2.getKarmaPoints().compareTo(u1.getKarmaPoints()))
            .limit(10)
            .collect(Collectors.toList());

        model.addAttribute("wards", wards);
        model.addAttribute("topCitizens", topCitizens);
        model.addAttribute("title", "Leaderboard");
        return "public/leaderboard";
    }

    @GetMapping("/whistleblower")
    public String whistleblowerForm(Model model) {
        model.addAttribute("title", "Whistleblower Mode");
        return "public/whistleblower";
    }

    @PostMapping("/whistleblower/submit")
    public String submitWhistleblower(@RequestParam String details, Model model) {
        try {
            String token = whistleblowerService.submitReport(details);
            model.addAttribute("token", token);
            return "public/whistleblower_success";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to submit report. Please try again.");
            return "public/whistleblower";
        }
    }

    @GetMapping("/transparency")
    public String transparency(Model model) {
        List<Complaint> allComplaints = complaintDao.findAll();

        long totalCount = allComplaints.size();
        long resolvedCount = allComplaints.stream()
            .filter(c -> (c.getStatus() == Complaint.Status.RESOLVED || c.getStatus() == Complaint.Status.VERIFIED))
            .count();
        long openCount = allComplaints.stream()
            .filter(c -> (c.getStatus() == Complaint.Status.OPEN || c.getStatus() == Complaint.Status.REOPENED))
            .count();
        long assignedCount = allComplaints.stream()
            .filter(c -> c.getStatus() == Complaint.Status.ASSIGNED)
            .count();

        model.addAttribute("totalComplaints", totalCount);
        model.addAttribute("resolvedComplaints", resolvedCount);
        model.addAttribute("openComplaints", openCount);
        model.addAttribute("assignedComplaints", assignedCount);
        model.addAttribute("resolutionRate", totalCount == 0 ? 0 : (resolvedCount * 100 / totalCount));

        // Build simple map for Chart.js — avoids Hibernate lazy-load serialization issues
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            List<Map<String, String>> simpleComplaints = allComplaints.stream().map(c -> {
                Map<String, String> map = new HashMap<>();
                map.put("category", c.getCategory().name());
                map.put("status", c.getStatus().name());
                return map;
            }).collect(Collectors.toList());
            model.addAttribute("complaintsJson", mapper.writeValueAsString(simpleComplaints));
        } catch (Exception e) {
            model.addAttribute("complaintsJson", "[]");
        }

        model.addAttribute("title", "Public Transparency Portal");
        return "public/transparency";
    }

    @GetMapping("/ward/{id}")
    public String wardDetails(@PathVariable Long id, Model model) {
        Ward ward = wardDao.findById(id);
        if (ward == null) return "redirect:/leaderboard";
        
        List<Complaint> complaints = complaintDao.findAll().stream()
            .filter(c -> c.getWard() != null && c.getWard().getId().equals(id))
            .collect(Collectors.toList());
            
        model.addAttribute("ward", ward);
        model.addAttribute("complaints", complaints);
        model.addAttribute("title", "Ward Insights: " + ward.getName());
        return "public/ward_detail";
    }
}
