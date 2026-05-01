package com.civicfix.controller;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.User;
import com.civicfix.dao.ComplaintDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/worker")
public class WorkerController {

    @Autowired
    private ComplaintDao complaintDao;

    @GetMapping("/schedule")
    public String showSchedule(HttpSession session, Model model) {
        User worker = (User) session.getAttribute("user");
        if (worker == null || worker.getRole() != User.UserRole.WORKER) return "redirect:/login";

        List<Complaint> assigned = complaintDao.findAll().stream()
            .filter(c -> c.getAssignedWorker() != null && c.getAssignedWorker().getId().equals(worker.getId()))
            .filter(c -> c.getStatus() == Complaint.Status.ASSIGNED)
            .collect(Collectors.toList());

        model.addAttribute("tasks", assigned);
        model.addAttribute("title", "Work Schedule");
        return "worker/schedule";
    }

    @PostMapping("/complaint/{id}/resolve")
    public String resolve(@PathVariable Long id, @RequestParam("photo") String photoUrl) {
        Complaint complaint = complaintDao.findById(id);
        if (complaint != null) {
            complaint.setStatus(Complaint.Status.RESOLVED);
            complaint.setResolutionPhotoUrl(photoUrl); // Simplified: Assume a URL for now
            complaint.setResolvedAt(LocalDateTime.now());
            complaint.setVerificationStatus(Complaint.VerificationStatus.PENDING);
            complaintDao.update(complaint);
        }
        return "redirect:/worker/schedule?success=Job marked as resolved";
    }
}
