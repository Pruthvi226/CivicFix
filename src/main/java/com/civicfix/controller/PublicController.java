package com.civicfix.controller;

import com.civicfix.entity.Ward;
import com.civicfix.entity.User;
import com.civicfix.dao.WardDao;
import com.civicfix.dao.UserDao;
import com.civicfix.service.WhistleblowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class PublicController {

    @Autowired
    private WardDao wardDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private WhistleblowerService whistleblowerService;

    @GetMapping("/")
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
}
