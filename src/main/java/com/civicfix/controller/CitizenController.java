package com.civicfix.controller;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.User;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.WardDao;
import com.civicfix.service.ComplaintClassifierService;
import com.civicfix.service.DuplicateRadarService;
import com.civicfix.service.KarmaEngineService;
import com.civicfix.dto.ClassificationResponse;
import com.civicfix.dto.LocationDto;
import com.civicfix.service.PerkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/citizen")
public class CitizenController {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private WardDao wardDao;

    @Autowired
    private ComplaintClassifierService classifierService;

    @Autowired
    private DuplicateRadarService duplicateRadarService;

    @Autowired
    private KarmaEngineService karmaEngineService;

    @Autowired
    private PerkService perkService;

    @Autowired
    private com.civicfix.dao.KarmaTransactionDao karmaTransactionDao;

    @Autowired
    private com.civicfix.dao.NotificationDao notificationDao;

    @GetMapping("/karma-history")
    public String karmaHistory(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("transactions", karmaTransactionDao.findByCitizenId(user.getId()));
        model.addAttribute("userKarma", user.getKarmaPoints());
        model.addAttribute("title", "Karma Ledger");
        return "citizen/karma-history";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.CITIZEN) return "redirect:/login";
        
        List<Complaint> myComplaints = complaintDao.findByCitizenId(user.getId());
        java.util.List<com.civicfix.entity.Notification> notifications = notificationDao.findUnreadByUserId(user.getId());
        
        model.addAttribute("complaints", myComplaints);
        model.addAttribute("notifications", notifications);
        model.addAttribute("notificationCount", notifications.size());
        model.addAttribute("title", "Citizen Dashboard");
        return "citizen/dashboard";
    }

    @GetMapping("/complaint/new")
    public String showNewComplaintForm(Model model) {
        model.addAttribute("wards", wardDao.findAll());
        model.addAttribute("title", "Report New Issue");
        return "citizen/new_complaint";
    }

    @PostMapping("/complaint/submit")
    public String submitComplaint(@ModelAttribute Complaint complaint, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        
        complaint.setCitizen(user);
        complaint.setStatus(Complaint.Status.OPEN);
        complaintDao.save(complaint);
        
        return "redirect:/citizen/dashboard?success=Report submitted successfully";
    }

    @PostMapping("/api/classify")
    @ResponseBody
    public ClassificationResponse classify(@RequestBody String description) {
        return classifierService.classify(description);
    }

    @PostMapping("/api/check-duplicates")
    @ResponseBody
    public List<Complaint> checkDuplicates(@RequestBody LocationDto location) {
        return duplicateRadarService.findNearbyDuplicates(
            location.getLatitude(), 
            location.getLongitude(), 
            location.getCategory()
        );
    }

    @GetMapping("/complaint/{id}/verify")
    public String showVerificationPage(@PathVariable Long id, Model model) {
        Complaint complaint = complaintDao.findById(id);
        model.addAttribute("complaint", complaint);
        model.addAttribute("title", "Verify Resolution");
        return "citizen/verify_resolution";
    }

    @PostMapping("/complaint/{id}/verify")
    public String verify(@PathVariable Long id, @RequestParam boolean accepted, @RequestParam(required = false) String reason, HttpSession session) {
        Complaint complaint = complaintDao.findById(id);
        if (complaint != null) {
            if (accepted) {
                complaint.setStatus(Complaint.Status.VERIFIED);
                complaint.setVerificationStatus(Complaint.VerificationStatus.ACCEPTED);
                karmaEngineService.awardPoints(complaint.getCitizen().getId(), 15, "Resolution Verified");
            } else {
                complaint.setStatus(Complaint.Status.REOPENED);
                complaint.setVerificationStatus(Complaint.VerificationStatus.REJECTED);
                complaint.setRejectionReason(reason);
            }
            complaintDao.update(complaint);
        }
        return "redirect:/citizen/dashboard?success=Verification completed";
    }

    @GetMapping("/perks")
    public String showPerks(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("perks", perkService.getAvailablePerks());
        model.addAttribute("userKarma", user.getKarmaPoints());
        model.addAttribute("title", "Karma Marketplace");
        return "citizen/perks";
    }

    @PostMapping("/perks/redeem/{id}")
    public String redeemPerk(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        if (perkService.redeemPerk(user.getId(), id)) {
            return "redirect:/citizen/perks?success=Perk redeemed successfully!";
        } else {
            return "redirect:/citizen/perks?error=Insufficient Karma points.";
        }
    }
}
