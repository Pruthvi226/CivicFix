package com.civicfix.service;

import com.civicfix.entity.KarmaTransaction;
import com.civicfix.entity.User;
import com.civicfix.dao.KarmaTransactionDao;
import com.civicfix.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class KarmaEngineService {

    @Autowired
    private UserDao userDao;
    
    @Autowired
    private KarmaTransactionDao karmaDao;

    @Transactional
    public void awardPoints(Long citizenId, int points, String reason) {
        User citizen = userDao.findById(citizenId);
        if (citizen != null) {
            // Update aggregate points
            int currentPoints = citizen.getKarmaPoints() != null ? citizen.getKarmaPoints() : 0;
            citizen.setKarmaPoints(currentPoints + points);
            userDao.update(citizen);
            
            // Record audit transaction
            KarmaTransaction transaction = new KarmaTransaction();
            transaction.setCitizen(citizen);
            transaction.setPoints(points);
            transaction.setReason(reason);
            karmaDao.save(transaction);
        }
    }
}
