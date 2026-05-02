package com.civicfix.controller;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.User;
import com.civicfix.entity.Ward;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.UserDao;
import com.civicfix.dao.WardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/official")
public class OfficialController {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private WardDao wardDao;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        List<Complaint> allComplaints = complaintDao.findAll();
        List<User> workers = userDao.findAll().stream()
            .filter(u -> u.getRole() == User.UserRole.WORKER)
            .collect(Collectors.toList());

        model.addAttribute("complaints", allComplaints);
        model.addAttribute("workers", workers);
        model.addAttribute("wards", wardDao.findAll());
        model.addAttribute("title", "Official Command Center");
        
        return "official/dashboard";
    }

    @GetMapping("/heatmap")
    public String showHeatmap(HttpSession session, Model model) {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        List<Ward> wards = wardDao.findAll();
        model.addAttribute("wards", wards);
        model.addAttribute("title", "City Health Heatmap");
        return "official/heatmap";
    }

    @PostMapping("/complaint/{id}/assign")
    public String assignWorker(@PathVariable Long id, @RequestParam Long workerId) {
        Complaint complaint = complaintDao.findById(id);
        User worker = userDao.findById(workerId);
        
        if (complaint != null && worker != null) {
            complaint.setAssignedWorker(worker);
            complaint.setStatus(Complaint.Status.ASSIGNED);
            complaintDao.update(complaint);
        }
        
        return "redirect:/official/dashboard?success=Task assigned to " + worker.getUsername();
    }
}
