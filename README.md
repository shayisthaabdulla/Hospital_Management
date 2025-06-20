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

## 📊 SQL Queries for Business Analysts

This section includes 30 SQL queries structured across key real-world Business Analyst use cases using the hospital management database.

### 1. 🩺 Basic SELECT & Filtering

1. Write a SQL query to list all departments in the hospital.

```sql
SELECT department_name
FROM departments;

2. Write a SQL query to show all patients who registered in the last 6 months

SELECT *
FROM patients
WHERE registration_date >= CURRENT_DATE - INTERVAL '6 MONTHS';

3. Write a SQL query to find all appointments with status 'Completed'.

SELECT *
FROM appointments
WHERE appointment_status = 'Completed';

4. Write a SQL query to retrieve all doctors who are currently inactive.

SELECT *
FROM doctors
WHERE active_flag = false;
```



### 3. Key Findings
- Some patients had missing emails or duplicate contact info.
- Appointments with missing notes or invalid billing values were identified.
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

