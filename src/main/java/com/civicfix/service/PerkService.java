package com.civicfix.service;

import com.civicfix.entity.Perk;
import com.civicfix.entity.User;
import com.civicfix.dao.PerkDao;
import com.civicfix.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PerkService {

    @Autowired
    private PerkDao perkDao;

    @Autowired
    private UserDao userDao;

    public List<Perk> getAvailablePerks() {
        return perkDao.findAll().stream()
            .filter(Perk::isActive)
            .collect(Collectors.toList());
    }

    @Transactional
    public boolean redeemPerk(Long userId, Long perkId) {
        User user = userDao.findById(userId);
        Perk perk = perkDao.findById(perkId);

        if (user != null && perk != null && user.getKarmaPoints() >= perk.getCostKarma()) {
            user.setKarmaPoints(user.getKarmaPoints() - perk.getCostKarma());
            userDao.update(user);
            return true;
        }
        return false;
    }
}
