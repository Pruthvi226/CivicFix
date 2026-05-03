-- CivicFix+ Database Schema
-- Run this in MySQL 8.x

CREATE DATABASE IF NOT EXISTS civicfix_db;
USE civicfix_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS whistleblower_reports;
DROP TABLE IF EXISTS predictive_flags;
DROP TABLE IF EXISTS karma_transactions;
DROP TABLE IF EXISTS complaints;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS wards;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. WARDS
CREATE TABLE wards (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    health_score DECIMAL(5,2) DEFAULT 100.00,
    city_zone VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. USERS
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role ENUM('CITIZEN', 'WORKER', 'OFFICIAL', 'ADMIN') NOT NULL,
    karma_points INT DEFAULT 0,
    ward_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ward_id) REFERENCES wards(id)
);

-- 3. COMPLAINTS
CREATE TABLE complaints (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    citizen_id BIGINT,
    ward_id BIGINT,
    category ENUM('POTHOLE', 'DRAIN', 'STREETLIGHT', 'GARBAGE', 'OTHER') NOT NULL,
    severity ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL') NOT NULL,
    description TEXT NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    address VARCHAR(255),
    status ENUM('OPEN', 'ASSIGNED', 'RESOLVED', 'VERIFIED', 'REOPENED') DEFAULT 'OPEN',
    estimated_fix_time INT,
    assigned_worker_id BIGINT,
    resolution_photo_url VARCHAR(255),
    resolved_at TIMESTAMP NULL,
    verification_status ENUM('PENDING', 'ACCEPTED', 'REJECTED') NULL,
    rejection_reason TEXT,
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id),
    FOREIGN KEY (ward_id) REFERENCES wards(id),
    FOREIGN KEY (assigned_worker_id) REFERENCES users(id)
);
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_complaints_ward ON complaints(ward_id);

-- 4. KARMA TRANSACTIONS
CREATE TABLE karma_transactions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    citizen_id BIGINT NOT NULL,
    points INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id)
);

-- 5. PREDICTIVE FLAGS
CREATE TABLE predictive_flags (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ward_id BIGINT NOT NULL,
    category ENUM('POTHOLE', 'DRAIN', 'STREETLIGHT', 'GARBAGE', 'OTHER') NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    risk_level ENUM('MODERATE', 'HIGH', 'IMMINENT_FAILURE') NOT NULL,
    advisory_message TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ward_id) REFERENCES wards(id)
);

-- 6. WHISTLEBLOWER REPORTS
CREATE TABLE whistleblower_reports (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tracking_token VARCHAR(64) UNIQUE NOT NULL,
    encrypted_details TEXT NOT NULL,
    status ENUM('SUBMITTED', 'UNDER_INVESTIGATION', 'RESOLVED', 'DISMISSED') DEFAULT 'SUBMITTED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 7. NOTIFICATIONS
CREATE TABLE notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Seed Initial Data
INSERT INTO wards (name, city_zone) VALUES ('North Ward', 'Zone A'), ('Central Ward', 'Zone B'), ('South Ward', 'Zone C');

-- 7. PERKS
CREATE TABLE perks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cost_karma INT NOT NULL,
    icon_class VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO perks (name, description, cost_karma, icon_class) VALUES 
('Free Coffee', 'Get a free coffee at a local partner cafe.', 50, 'fa-coffee'),
('Public Transit Pass', 'One day free public transit pass.', 150, 'fa-bus'),
('VIP City Event Ticket', 'Exclusive ticket to the upcoming city festival.', 500, 'fa-ticket-alt');
