package com.civicfix.config;

import com.civicfix.dao.WardDao;
import com.civicfix.entity.Ward;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Component
public class DataInitializer implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    private WardDao wardDao;

    @Override
    @Transactional
    public void onApplicationEvent(@org.springframework.lang.NonNull ContextRefreshedEvent event) {
        if (wardDao.findAll().isEmpty()) {
            seedWards();
        }
    }

    private void seedWards() {
        String[] wardNames = {"North Ward", "Central Ward", "South Ward", "East Ward", "West Ward"};
        String[] zones = {"Zone A", "Zone B", "Zone C", "Zone D", "Zone E"};

        for (int i = 0; i < wardNames.length; i++) {
            Ward ward = new Ward();
            ward.setName(wardNames[i]);
            ward.setCityZone(zones[i]);
            ward.setHealthScore(new BigDecimal("100.00"));
            wardDao.save(ward);
        }
    }
}
