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

    @GetMapping("/ping")
    @ResponseBody
    public String ping() { return "OfficialController is ACTIVE"; }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        System.err.println("OFFICIAL CONTROLLER ERROR: " + e.getMessage());
        e.printStackTrace();
        model.addAttribute("error", e.getMessage());
        return "error";
    }

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private WardDao wardDao;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        System.out.println("--- Entering Official Dashboard Mapping ---");
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        List<Complaint> allComplaints = complaintDao.findAll();
        List<User> workers = userDao.findAll().stream()
            .filter(u -> u != null && u.getRole() != null && u.getRole() == User.UserRole.WORKER)
            .collect(Collectors.toList());

        long pendingCount = allComplaints.stream()
            .filter(c -> c != null && c.getStatus() != null && (c.getStatus() == Complaint.Status.OPEN || c.getStatus() == Complaint.Status.REOPENED))
            .count();

        model.addAttribute("complaints", allComplaints);
        model.addAttribute("workers", workers);
        model.addAttribute("wards", wardDao.findAll());
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("title", "Official Command Center");
        
        return "official/dashboard";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String query, HttpSession session, Model model) {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        if (query == null || query.trim().isEmpty()) {
            return "redirect:/official/dashboard";
        }

        List<Complaint> results = complaintDao.findAll().stream()
            .filter(c -> (c.getDescription() != null && c.getDescription().toLowerCase().contains(query.toLowerCase())) ||
                         (c.getAddress() != null && c.getAddress().toLowerCase().contains(query.toLowerCase())) ||
                         c.getId().toString().equals(query))
            .collect(Collectors.toList());

        model.addAttribute("complaints", results);
        model.addAttribute("workers", userDao.findAll().stream().filter(u -> u.getRole() == User.UserRole.WORKER).collect(Collectors.toList()));
        model.addAttribute("wards", wardDao.findAll());
        model.addAttribute("title", "Search Results for: " + query);
        return "official/dashboard";
    }

    @GetMapping("/advancedSearch")
    public String advancedSearch(@RequestParam(required = false) String status,
                                 @RequestParam(required = false) String category,
                                 @RequestParam(required = false) Long wardId,
                                 @RequestParam(required = false) String severity,
                                 HttpSession session, Model model) {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        List<Complaint> results = complaintDao.findByCriteria(status, category, wardId, severity);

        model.addAttribute("complaints", results);
        model.addAttribute("workers", userDao.findAll().stream().filter(u -> u.getRole() == User.UserRole.WORKER).collect(Collectors.toList()));
        model.addAttribute("wards", wardDao.findAll());
        model.addAttribute("title", "Advanced Search Results");
        return "official/dashboard";
    }

    @GetMapping("/audit")
    public String cityAudit(HttpSession session, Model model) {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) return "redirect:/login";

        List<Ward> wards = wardDao.findAll();
        List<Complaint> all = complaintDao.findAll();

        // Calculate some audit metrics
        model.addAttribute("wards", wards);
        model.addAttribute("totalComplaints", all.size());
        model.addAttribute("resolvedCount", all.stream().filter(c -> c.getStatus() == Complaint.Status.VERIFIED).count());
        model.addAttribute("title", "City Performance Audit");
        
        return "official/audit";
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
            return "redirect:/official/dashboard?success=Task assigned to " + worker.getUsername();
        }
        
        return "redirect:/official/dashboard?error=Assignment failed";
    }
    @GetMapping("/export")
    public void exportCsv(HttpSession session, javax.servlet.http.HttpServletResponse response) throws java.io.IOException {
        User official = (User) session.getAttribute("user");
        if (official == null || official.getRole() != User.UserRole.OFFICIAL) {
            response.sendRedirect("/login");
            return;
        }

        List<Complaint> allComplaints = complaintDao.findAll();

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"civicfix_complaints.csv\"");

        java.io.PrintWriter writer = response.getWriter();
        writer.println("ID,Category,Severity,Status,Description,Address,Latitude,Longitude,Reported At");

        for (Complaint c : allComplaints) {
            writer.printf("%d,%s,%s,%s,\"%s\",\"%s\",%s,%s,%s%n",
                c.getId(),
                c.getCategory(),
                c.getSeverity(),
                c.getStatus(),
                c.getDescription() != null ? c.getDescription().replace("\"", "'") : "",
                c.getAddress() != null ? c.getAddress().replace("\"", "'") : "",
                c.getLatitude(),
                c.getLongitude(),
                c.getReportedAt()
            );
        }
        writer.flush();
    }
}
