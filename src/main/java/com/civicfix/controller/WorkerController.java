package com.civicfix.controller;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.Notification;
import com.civicfix.entity.User;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.NotificationDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/worker")
public class WorkerController {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private NotificationDao notificationDao;



    @GetMapping("/schedule")
    public String showSchedule(HttpSession session, Model model) {
        User worker = (User) session.getAttribute("user");
        if (worker == null || worker.getRole() != User.UserRole.WORKER) return "redirect:/login";

        List<Complaint> assigned = complaintDao.findAll().stream()
            .filter(c -> c.getAssignedWorker() != null && c.getAssignedWorker().getId().equals(worker.getId()))
            .filter(c -> c.getStatus() == Complaint.Status.ASSIGNED)
            .collect(Collectors.toList());

        // Build JSON string of task locations for Leaflet.js map
        StringBuilder mapDataJson = new StringBuilder("[");
        for (int i = 0; i < assigned.size(); i++) {
            Complaint c = assigned.get(i);
            mapDataJson.append(String.format(
                "{\"id\":%d,\"lat\":%s,\"lng\":%s,\"category\":\"%s\",\"address\":\"%s\"}",
                c.getId(), c.getLatitude(), c.getLongitude(), c.getCategory(),
                c.getAddress() != null ? c.getAddress().replace("\"", "'") : ""
            ));
            if (i < assigned.size() - 1) mapDataJson.append(",");
        }
        mapDataJson.append("]");

        model.addAttribute("tasks", assigned);
        model.addAttribute("mapDataJson", mapDataJson.toString());
        model.addAttribute("title", "Work Schedule");
        return "worker/schedule";
    }

    @PostMapping("/complaint/{id}/resolve")
    public String resolve(@PathVariable Long id, @RequestParam("photo") String photoUrl, HttpSession session) {
        Complaint complaint = complaintDao.findById(id);
        if (complaint != null) {
            complaint.setStatus(Complaint.Status.RESOLVED);
            complaint.setResolutionPhotoUrl(photoUrl);
            complaint.setResolvedAt(LocalDateTime.now());
            complaint.setVerificationStatus(Complaint.VerificationStatus.PENDING);
            complaintDao.update(complaint);

            // Create notification for the citizen who filed the complaint
            if (complaint.getCitizen() != null) {
                Notification notification = new Notification();
                notification.setUser(complaint.getCitizen());
                notification.setMessage("Your complaint #CF-" + complaint.getId() +
                    " (" + complaint.getCategory() + ") has been resolved! Please verify the fix.");
                notificationDao.save(notification);
            }
        }
        return "redirect:/worker/schedule?success=Job marked as resolved";
    }

    @GetMapping("/history")
    public String showHistory(HttpSession session, Model model) {
        User worker = (User) session.getAttribute("user");
        if (worker == null || worker.getRole() != User.UserRole.WORKER) return "redirect:/login";

        List<Complaint> history = complaintDao.findAll().stream()
            .filter(c -> c.getAssignedWorker() != null && c.getAssignedWorker().getId().equals(worker.getId()))
            .filter(c -> c.getStatus() == Complaint.Status.RESOLVED || c.getStatus() == Complaint.Status.VERIFIED)
            .collect(Collectors.toList());

        model.addAttribute("history", history);
        model.addAttribute("title", "Task History");
        return "worker/history";
    }
}
