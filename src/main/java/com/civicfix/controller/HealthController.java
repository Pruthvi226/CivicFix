package com.civicfix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletResponse;

@Controller
public class HealthController {
    
    @GetMapping("/health")
    @ResponseBody
    public String health(HttpServletResponse response) {
        response.setStatus(HttpServletResponse.SC_OK);
        return "OK";
    }
}
