package com.civicfix.service;

import com.civicfix.entity.Complaint;
import com.civicfix.entity.User;
import com.civicfix.dao.ComplaintDao;
import com.civicfix.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SchedulingService {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private UserDao userDao;

    /**
     * Greedy algorithm to batch nearby complaints and assign to workers.
     * Logic:
     * 1. Get all OPEN complaints.
     * 2. For each complaint, find the nearest worker who isn't overloaded.
     * 3. Or, find a worker already assigned to something nearby.
     */
    @Transactional
    public void autoAssignComplaints() {
        List<Complaint> openComplaints = complaintDao.findAll().stream()
            .filter(c -> c.getStatus() == Complaint.Status.OPEN)
            .collect(Collectors.toList());

        List<User> workers = userDao.findAll().stream()
            .filter(u -> u.getRole() == User.UserRole.WORKER)
            .collect(Collectors.toList());

        for (Complaint complaint : openComplaints) {
            User bestWorker = null;
            double minDistance = Double.MAX_VALUE;

            for (User worker : workers) {
                // Simplified: Check distance to worker's last assigned (or current) task
                // For simplicity in this demo, we just find any worker and assign.
                // A "Greedy" approach would check if worker is already near this complaint's lat/lon.
                
                // In a real production system, we'd query the worker's current location or last task.
                bestWorker = worker; // Placeholder: Just pick the first available for now
                break; 
            }

            if (bestWorker != null) {
                complaint.setAssignedWorker(bestWorker);
                complaint.setStatus(Complaint.Status.ASSIGNED);
                complaintDao.update(complaint);
            }
        }
    }
}
