# 🏥 Hospital Management System (SQL Project)

## 📌 Project Overview

**Project Title**: Hospital Management System  
**Level**: Beginner – Intermediate  
**Database**: hospital_management  

This SQL project simulates a hospital’s digital record system with entities like patients, doctors, departments, appointments, treatments, and billing. It is structured to help Business Analysts practice key SQL operations such as data validation, joins, aggregations, and time-based reporting.

## 💡 Why This Project Matters

This project reflects common use cases a Business Analyst might face in healthcare, operations, or administrative tech systems. It demonstrates:

- How to validate and extract meaningful insights from interconnected hospital records  
- How to explore KPIs like appointment volume, revenue, and treatment outcomes  
- My ability to clean, transform, and analyze relational data using SQL  

## 🎯 Objectives

1. **Create a realistic hospital dataset** with clean, joinable tables  
2. **Practice all essential SQL query types**: SELECT, JOIN, GROUP BY, CASE, subqueries, filtering, validation, and date functions  
3. **Demonstrate real-world problem-solving** for common BA analytics needs  

## 🧱 Project Structure

### 🔸 1. Database Setup

## 🏗️ Project Structure

### 1. Database Setup

- **Database Name**: `hospital_management`
- This project simulates a fully functional hospital database system using PostgreSQL.

### 2. Table Creation

Six core tables are created to represent key hospital operations:

- `departments`: Stores hospital department information like department name and department head.
- `doctors`: Contains doctor records, linked to departments, including hire date and active flag.
- `patients`: Captures personal and registration details of patients.
- `appointments`: Tracks appointments between patients and doctors, with status and notes.
- `treatments`: Records medical treatments tied to appointments, with outcome classification.
- `billing`: Logs billing information including amount, payment status, and linked appointments/patients.

Each table is designed with **primary and foreign key constraints** to simulate realistic relationships across entities.

### 3. Sample Data Insertion

All tables are populated with realistic sample data, including:

- Clean relationships between tables to ensure JOINs work as expected
- Sample records that support data cleaning, KPI analysis, and reporting queries
- Date fields properly formatted for PostgreSQL

```sql
-- 1. Departments Table
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100),
  head_of_department VARCHAR(100));

-- 2. Doctors Table
CREATE TABLE doctors (
  doctor_id INT PRIMARY KEY,
  doctor_name VARCHAR(100),
  department_id INT,
  email VARCHAR(100),
  phone_number VARCHAR(20),
  active_flag BOOLEAN,
  hire_date DATE,
  FOREIGN KEY (department_id) REFERENCES departments(department_id));

-- 3. Patients Table
CREATE TABLE patients (
  patient_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender VARCHAR(10),
  birth_date DATE,
  phone_number VARCHAR(20),
  email VARCHAR(100),
  registration_date DATE);

-- 4. Appointments Table
CREATE TABLE appointments (
  appointment_id INT PRIMARY KEY,
  patient_id INT,
  doctor_id INT,
  appointment_date DATE,
  appointment_status VARCHAR(20),
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id));

-- 5. Treatments Table
CREATE TABLE treatments (
  treatment_id INT PRIMARY KEY,
  appointment_id INT,
  treatment_type VARCHAR(50),
  treatment_date DATE,
  outcome VARCHAR(20),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id));

-- 6. Billing Table
CREATE TABLE billing (
  bill_id INT PRIMARY KEY,
  patient_id INT,
  appointment_id INT,
  amount NUMERIC(10,2),
  billing_date DATE,
  payment_status VARCHAR(20),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id));
```

### 2. 📊 SQL Queries for Business Analysts
✅ Full query list with categories and numbered labels is included in [Hospital_SQL_Queries](https://github.com/shayisthaabdulla/Hospital_Management/blob/main/Hospital_SQL_Queries_README.md)

**Key areas covered**:

**1. Basic SELECT & Filtering**
Show departments, recent patients, completed appointments, etc.

**2. JOINs & Relationships**
Join appointments with patients/doctors, billing, treatments, and department mapping.

**3. Aggregations & Metrics**
Count appointments, total/avg billing, top spenders, treatment outcomes.

**4. Data Cleaning & Validation**
Check for missing values, duplicates, orphan records, mismatched relationships.

**5. Subqueries & CASE****
Show appointment frequency, unpaid bills with labels, and custom logic.

**6. Time-Based Performance****
Analyze monthly revenue, appointments in last 30/90 days, department-wise stats.

### 3. Key Findings
- Top 3 patients accounted for a significant portion of total revenue
- Revenue trends and appointment metrics helped evaluate operational efficiency.
- Doctor workload and department performance were measured using joins and aggregates.
- CASE statements helped simplify reporting logic directly in SQL.

### 4. Reports & Dashboards (Potential Extensions)
- Appointment Trend Dashboard
- Doctor Utilization Summary
- Departmental Billing Contribution
- Patient Engagement Scorecard
- Treatment Success Analysis

### About the Author
Microsoft Certified Dynamics 365 professional, Shayistha Abdulla is a Business Analyst with 9+ years of experience across Digital Marketing, CRM, PropTech, and IT Consulting. This project reflects her practical SQL expertise applied to healthcare and service industry scenarios, built using PostgreSQL.

📫 LinkedIn

