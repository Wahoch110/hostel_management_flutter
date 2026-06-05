-- ============================================================
-- HostelHub Database Setup
-- Run this file in MySQL Workbench or phpMyAdmin before starting
-- ============================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS hostel_hub_db;
USE hostel_hub_db;

-- ============================================================
-- Table: complaints
-- Fields match the Flutter ComplaintScreen form exactly
-- ============================================================
CREATE TABLE IF NOT EXISTS complaints (
  id          INT           AUTO_INCREMENT PRIMARY KEY,
  category    VARCHAR(50)   NOT NULL COMMENT 'Electricity | Water | Cleanliness | Internet | Noise | Other',
  description TEXT          NOT NULL,
  status      VARCHAR(20)   NOT NULL DEFAULT 'Pending' COMMENT 'Pending | In Progress | Resolved',
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: leaves
-- Fields match the Flutter LeaveRequestScreen form exactly
-- ============================================================
CREATE TABLE IF NOT EXISTS leaves (
  id                 INT          AUTO_INCREMENT PRIMARY KEY,
  leave_date         DATE         NOT NULL,
  return_date        DATE         NOT NULL,
  reason             VARCHAR(100) NOT NULL COMMENT 'Medical Issue | Family Emergency | Family Event | Academic Purpose | Personal Work | Other',
  additional_details TEXT,
  status             VARCHAR(20)  NOT NULL DEFAULT 'Pending' COMMENT 'Pending | Approved | Rejected',
  created_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================
-- Optional sample data for testing
-- ============================================================

INSERT INTO complaints (category, description) VALUES
  ('Electricity', 'The light in Room B-204 has not been working for 3 days.'),
  ('Water',       'Water supply is disrupted every morning from 6 AM to 8 AM.'),
  ('Internet',    'Wi-Fi signal is very weak on the second floor of Block B.');

INSERT INTO leaves (leave_date, return_date, reason, additional_details) VALUES
  ('2025-06-10', '2025-06-15', 'Medical Issue',     'Need to visit doctor in home city for a checkup.'),
  ('2025-06-20', '2025-06-22', 'Family Emergency',  'Sister wedding ceremony at home.'),
  ('2025-07-01', '2025-07-03', 'Academic Purpose',  'Attending an inter-university seminar.');
