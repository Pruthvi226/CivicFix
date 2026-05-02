package com.civicfix.controller;

import com.civicfix.entity.User;
import com.civicfix.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "common/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            switch (user.getRole()) {
                case CITIZEN: return "redirect:/citizen/dashboard";
                case WORKER: return "redirect:/worker/schedule";
                case OFFICIAL: return "redirect:/official/dashboard";
                case ADMIN: return "redirect:/admin/dashboard";
                default: return "redirect:/";
            }
        }
        model.addAttribute("error", "Invalid username or password");
        return "common/login";
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "common/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model) {
        try {
            if (user.getRole() == null) {
                user.setRole(User.UserRole.CITIZEN);
            }
            userService.register(user);
            return "redirect:/login?success=Account created successfully";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "common/register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
