package com.civicfix.service;

import com.civicfix.dao.KarmaTransactionDao;
import com.civicfix.dao.UserDao;
import com.civicfix.entity.KarmaTransaction;
import com.civicfix.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class KarmaEngineServiceTest {

    @Mock
    private UserDao userDao;

    @Mock
    private KarmaTransactionDao karmaDao;

    @InjectMocks
    private KarmaEngineService karmaEngineService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setUsername("testuser");
        testUser.setKarmaPoints(100);
    }

    @Test
    void testAwardPoints_Success() {
        // Arrange
        Long userId = 1L;
        int pointsToAward = 50;
        String reason = "Bug Report";
        when(userDao.findById(userId)).thenReturn(testUser);

        // Act
        karmaEngineService.awardPoints(userId, pointsToAward, reason);

        // Assert
        assertEquals(150, testUser.getKarmaPoints());
        verify(userDao, times(1)).update(testUser);
        
        ArgumentCaptor<KarmaTransaction> transactionCaptor = ArgumentCaptor.forClass(KarmaTransaction.class);
        verify(karmaDao, times(1)).save(transactionCaptor.capture());
        
        KarmaTransaction transaction = transactionCaptor.getValue();
        assertEquals(testUser, transaction.getCitizen());
        assertEquals(pointsToAward, transaction.getPoints());
        assertEquals(reason, transaction.getReason());
    }

    @Test
    void testAwardPoints_UserWithNullPoints() {
        // Arrange
        testUser.setKarmaPoints(null);
        when(userDao.findById(1L)).thenReturn(testUser);

        // Act
        karmaEngineService.awardPoints(1L, 10, "First Point");

        // Assert
        assertEquals(10, testUser.getKarmaPoints());
    }

    @Test
    void testAwardPoints_UserNotFound() {
        // Arrange
        when(userDao.findById(99L)).thenReturn(null);

        // Act
        karmaEngineService.awardPoints(99L, 10, "No User");

        // Assert
        verify(userDao, never()).update(any());
        verify(karmaDao, never()).save(any());
    }
}
