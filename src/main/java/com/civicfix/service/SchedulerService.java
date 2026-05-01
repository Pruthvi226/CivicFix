package com.civicfix.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class SchedulerService {

    @Autowired
    private WardHealthScoreService healthScoreService;

    @Autowired
    private PredictiveMaintenanceService predictiveService;

    @Autowired
    private SchedulingService autoAssignService;

    /**
     * Recalculate health scores every 24 hours at 1:00 AM
     */
    @Scheduled(cron = "0 0 1 * * ?")
    public void dailyHealthCleanup() {
        healthScoreService.recalculateDailyScores();
    }

    /**
     * Run predictive analysis every Sunday at 2:00 AM
     */
    @Scheduled(cron = "0 0 2 ? * SUN")
    public void weeklyPredictiveMaintenance() {
        predictiveService.generateAdvisories();
    }

    /**
     * Auto-assign new complaints every 30 minutes
     */
    @Scheduled(fixedDelay = 1800000)
    public void autoAssignTasks() {
        autoAssignService.autoAssignComplaints();
    }
}
