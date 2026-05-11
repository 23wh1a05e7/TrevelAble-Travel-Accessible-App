-- ========================================
-- TravelAble Medical Assistance Project
-- MySQL Database Setup Guide
-- ========================================

-- Create database
CREATE DATABASE IF NOT EXISTS travelDB;
USE travelDB;

-- ========================================
-- 1. USERS TABLE (Enhanced with disability info)
-- ========================================
CREATE TABLE IF NOT EXISTS users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fullname VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15) NOT NULL,
  password VARCHAR(255) NOT NULL,
  disability_type VARCHAR(50),
  special_needs TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- 2. MEDICAL ASSISTANT REQUESTS TABLE (NEW)
-- ========================================
CREATE TABLE IF NOT EXISTS medical_assistant_requests (
  id INT PRIMARY KEY AUTO_INCREMENT,
  
  -- Traveler Information
  traveler_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  age INT NOT NULL,
  
  -- Travel Details
  travel_from VARCHAR(100) NOT NULL,
  travel_to VARCHAR(100) NOT NULL,
  travel_date DATE NOT NULL,
  transport_mode VARCHAR(50) NOT NULL,
  journey_duration INT NOT NULL,
  
  -- Medical Information
  disability_types TEXT NOT NULL,
  medical_details TEXT NOT NULL,
  medications VARCHAR(255),
  allergies VARCHAR(255),
  
  -- Assistance Requirements
  assistance_types TEXT NOT NULL,
  special_requirements TEXT,
  budget DECIMAL(10, 2),
  assistant_gender VARCHAR(20),
  
  -- Emergency Contact
  emergency_name VARCHAR(100) NOT NULL,
  emergency_phone VARCHAR(15) NOT NULL,
  emergency_relation VARCHAR(50),
  
  -- Status & Timestamps
  status ENUM('pending', 'approved', 'rejected', 'completed') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_email (email),
  INDEX idx_status (status),
  INDEX idx_travel_date (travel_date)
);

-- ========================================
-- 3. EXISTING TABLES (Reference)
-- ========================================

-- Hotel Table
CREATE TABLE IF NOT EXISTS hotel (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  location VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2),
  rating DECIMAL(3, 2),
  accessibility_features TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Train Table
CREATE TABLE IF NOT EXISTS train1 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  from_location VARCHAR(100) NOT NULL,
  to_location VARCHAR(100) NOT NULL,
  departure_time TIME,
  arrival_time TIME,
  price DECIMAL(10, 2),
  seats_available INT,
  wheelchair_accessible BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bus Table
CREATE TABLE IF NOT EXISTS bus1 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  from_location VARCHAR(100) NOT NULL,
  to_location VARCHAR(100) NOT NULL,
  departure_time TIME,
  arrival_time TIME,
  price DECIMAL(10, 2),
  seats_available INT,
  wheelchair_accessible BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 4. OPTIONAL: MEDICAL ASSISTANTS TABLE
-- ========================================
CREATE TABLE IF NOT EXISTS medical_assistants (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15) NOT NULL,
  qualifications TEXT,
  specializations TEXT,
  gender VARCHAR(20),
  availability_status ENUM('available', 'busy', 'unavailable') DEFAULT 'available',
  hourly_rate DECIMAL(10, 2),
  rating DECIMAL(3, 2),
  total_requests INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- 5. OPTIONAL: REQUEST ASSIGNMENTS TABLE
-- ========================================
CREATE TABLE IF NOT EXISTS request_assignments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  request_id INT NOT NULL,
  assistant_id INT NOT NULL,
  assignment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
  
  FOREIGN KEY (request_id) REFERENCES medical_assistant_requests(id),
  FOREIGN KEY (assistant_id) REFERENCES medical_assistants(id),
  INDEX idx_request (request_id),
  INDEX idx_assistant (assistant_id)
);

-- ========================================
-- 6. SAMPLE DATA (Optional - for testing)
-- ========================================

-- Sample User
INSERT INTO users (fullname, email, phone, password, disability_type, special_needs)
VALUES ('John Doe', 'john@example.com', '+919876543210', 'password123', 'mobility', 'Wheelchair accessibility needed');

-- Sample Hotels
INSERT INTO hotel (name, location, price, rating, accessibility_features)
VALUES 
('Hotel Sunny', 'Delhi', 5000, 4.5, 'Wheelchair accessible rooms, Accessible bathrooms'),
('Hotel Grand', 'Mumbai', 6000, 4.7, 'Elevators, Accessible parking, Medical assistance available');

-- Sample Trains
INSERT INTO train1 (name, from_location, to_location, departure_time, arrival_time, price, seats_available, wheelchair_accessible)
VALUES 
('Rajdhani Express', 'Delhi', 'Mumbai', '14:30:00', '08:30:00', 2500, 50, TRUE),
('Shatabdi Express', 'Delhi', 'Agra', '06:00:00', '09:30:00', 1200, 100, TRUE);

-- Sample Buses
INSERT INTO bus1 (name, from_location, to_location, departure_time, arrival_time, price, seats_available, wheelchair_accessible)
VALUES 
('Luxury Coach', 'Delhi', 'Gurgaon', '09:00:00', '10:30:00', 300, 45, FALSE),
('accessible Bus Ltd', 'Mumbai', 'Pune', '07:00:00', '13:00:00', 800, 30, TRUE);

-- ========================================
-- Notes:
-- 1. Update the password field with hashed passwords in production
-- 2. Add more accessibility fields as needed
-- 3. Create indexes for better query performance
-- 4. Consider adding triggers for automatic updates
-- ========================================
