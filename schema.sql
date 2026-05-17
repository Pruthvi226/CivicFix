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
    evidence_file_path VARCHAR(512),
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id),
    FOREIGN KEY (ward_id) REFERENCES wards(id),
    FOREIGN KEY (assigned_worker_id) REFERENCES users(id)
);
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_complaints_ward ON complaints(ward_id);
CREATE INDEX idx_complaints_category ON complaints(category);
CREATE INDEX idx_complaints_severity ON complaints(severity);

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

-- =====================================================
-- SEED INITIAL DATA
-- =====================================================

-- 7. PERKS
CREATE TABLE perks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cost_karma INT NOT NULL,
    icon_class VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

-- Insert Wards
INSERT INTO wards (name, city_zone) VALUES 
('North Ward', 'Zone A'),
('Central Ward', 'Zone B'),
('South Ward', 'Zone C'),
('East Ward', 'Zone D'),
('West Ward', 'Zone E');

-- Insert Default Admin User
-- Username: admin | Password: admin123
-- Password hash: L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ= (SHA-256 base64)
INSERT INTO users (username, password, email, phone, role, karma_points, ward_id) VALUES
('admin', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'admin@civicfix.local', '+91 9999999999', 'ADMIN', 0, 1);

-- Insert Sample Citizens with karma points
INSERT INTO users (username, password, email, phone, role, karma_points, ward_id) VALUES
('rajesh_kumar', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'rajesh@example.com', '+91 9876543210', 'CITIZEN', 450, 1),
('priya_sharma', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'priya@example.com', '+91 9876543211', 'CITIZEN', 320, 2),
('amit_singh', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'amit@example.com', '+91 9876543212', 'CITIZEN', 180, 1),
('neha_gupta', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'neha@example.com', '+91 9876543213', 'CITIZEN', 250, 3);

-- Insert Sample Workers
INSERT INTO users (username, password, email, phone, role, karma_points, ward_id) VALUES
('worker_ravi', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'ravi@workers.com', '+91 8765432100', 'WORKER', 0, 1),
('worker_deepak', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'deepak@workers.com', '+91 8765432101', 'WORKER', 0, 2),
('worker_vikram', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'vikram@workers.com', '+91 8765432102', 'WORKER', 0, 3);

-- Insert Sample Officials
INSERT INTO users (username, password, email, phone, role, karma_points, ward_id) VALUES
('official_sharma', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'sharma@officials.com', '+91 7654321000', 'OFFICIAL', 0, 1),
('official_verma', 'L2/YUK4pUSKiOlQaFBBZgUFvLkF3dU8x7n2g4OhVXqQ=', 'verma@officials.com', '+91 7654321001', 'OFFICIAL', 0, 2);

-- Insert Sample Complaints (Mix of statuses to showcase workflow)
INSERT INTO complaints (citizen_id, ward_id, category, severity, description, latitude, longitude, address, status, assigned_worker_id, estimated_fix_time) VALUES
(2, 1, 'POTHOLE', 'CRITICAL', 'Large pothole in middle of main street causing damage to vehicles', 28.7041, 77.1025, 'Main Street, North Ward', 'ASSIGNED', 6, 2),
(3, 2, 'DRAIN', 'HIGH', 'Drainage system overflowing during heavy rains', 28.6139, 77.2090, 'Water Street, Central Ward', 'OPEN', NULL, 3),
(4, 1, 'STREETLIGHT', 'MEDIUM', 'Street light not working for past 2 weeks', 28.7080, 77.1050, 'Park Avenue, North Ward', 'ASSIGNED', 7, 1),
(5, 3, 'GARBAGE', 'LOW', 'Garbage not collected from residential area', 28.5244, 77.1855, 'Residential Zone, South Ward', 'RESOLVED', 8, 1),
(2, 2, 'POTHOLE', 'HIGH', 'Multiple potholes on the connecting road', 28.6150, 77.2100, 'Connecting Road, Central Ward', 'VERIFIED', 6, 2),
(3, 1, 'OTHER', 'MEDIUM', 'Pavement broken and uneven', 28.7100, 77.1080, 'Sidewalk Street, North Ward', 'OPEN', NULL, 4);

-- Insert Sample Karma Transactions
INSERT INTO karma_transactions (citizen_id, points, reason) VALUES
(2, 100, 'Complaint POTHOLE-001 verified'),
(2, 50, 'Resolution photo provided'),
(3, 75, 'Multiple complaints filed'),
(4, 25, 'Complaint accepted'),
(5, 150, 'Complaint DRAIN-001 verified');

-- Insert Perks
INSERT INTO perks (name, description, cost_karma, icon_class, is_active) VALUES 
('Free Coffee', 'Get a free coffee at a local partner cafe.', 50, 'fa-coffee', TRUE),
('Public Transit Pass', 'One day free public transit pass.', 150, 'fa-bus', TRUE),
('VIP City Event Ticket', 'Exclusive ticket to the upcoming city festival.', 500, 'fa-ticket-alt', TRUE),
('Free Meal Voucher', 'Voucher for a meal at local restaurants.', 200, 'fa-utensils', TRUE);

-- Insert Predictive Flags (High-risk areas needing attention)
INSERT INTO predictive_flags (ward_id, category, latitude, longitude, risk_level, advisory_message, is_active) VALUES
(1, 'POTHOLE', 28.7050, 77.1100, 'HIGH', 'This area has history of potholes. Preventive maintenance recommended.', TRUE),
(2, 'DRAIN', 28.6145, 77.2095, 'IMMINENT_FAILURE', 'Drainage system is at critical condition. Immediate action required.', TRUE),
(3, 'STREETLIGHT', 28.5250, 77.1860, 'MODERATE', 'Several streetlights in this zone are aging. Plan replacement soon.', TRUE);
