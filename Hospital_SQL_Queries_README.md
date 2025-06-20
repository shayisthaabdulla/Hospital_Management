# 🏥 Hospital Management SQL Project

## 📊 SQL Queries for Business Analysts

This section includes 29 SQL queries structured across key real-world Business Analyst use cases using the hospital management database.

---

### 1. 🩺 Basic SELECT & Filtering

**1.** Write a SQL query to list all departments in the hospital.
```sql
SELECT department_name
FROM departments;
```

**2.** Write a SQL query to show all patients who registered in the last 6 months.
```sql
SELECT *
FROM patients
WHERE registration_date >= CURRENT_DATE - INTERVAL '6 MONTHS';
```

**3.** Write a SQL query to find all appointments with status 'Completed'.
```sql
SELECT *
FROM appointments
WHERE appointment_status = 'Completed';
```

**4.** Write a SQL query to retrieve all doctors who are currently inactive.
```sql
SELECT *
FROM doctors
WHERE active_flag = false;
```

**5.** Write a SQL query to show all treatments of type 'Surgery'.
```sql
SELECT *
FROM treatments
WHERE treatment_type = 'Surgery';
```

---

### 2. 🔗 JOINs & Relationships

**6.** Write a SQL query to show patient names and their doctors for all appointments.
```sql
SELECT
  a.appointment_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  d.doctor_name,
  a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;
```

**7.** Write a SQL query to list doctor names with their department names.
```sql
SELECT
  d.doctor_name,
  dept.department_name
FROM doctors AS d
JOIN departments AS dept ON d.department_id = dept.department_id;
```

**8.** Write a SQL query to get appointment details along with patient and billing info.
```sql
SELECT 
  a.appointment_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  b.amount,
  b.payment_status
FROM appointments AS a
JOIN patients AS p ON p.patient_id = a.patient_id
JOIN billing AS b ON b.appointment_id = a.appointment_id;
```

**9.** Write a SQL query to show each treatment with patient and doctor names.
```sql
SELECT
  t.treatment_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  d.doctor_name,
  t.treatment_type,
  t.outcome
FROM treatments t
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;
```

**10.** Write a SQL query to list departments with the number of doctors in each.
```sql
SELECT
  dept.department_name,
  COUNT(d.doctor_id) AS total_doctors
FROM departments dept
JOIN doctors d ON d.department_id = dept.department_id
GROUP BY dept.department_name
ORDER BY total_doctors;
```

---

### 3. 🧮 Aggregations & Metrics

**11.** Write a SQL query to count the total number of patients.
```sql
SELECT COUNT(*) AS total_number_of_patients
FROM patients;
```

**12.** Write a SQL query to find the average billing amount.
```sql
SELECT AVG(amount) AS avg_bill
FROM billing;
```

**13.** Write a SQL query to show the number of appointments per status.
```sql
SELECT appointment_status, COUNT(*) AS no_of_appointments
FROM appointments
GROUP BY appointment_status;
```

**14.** Write a SQL query to find the top 3 patients who had the highest total billing.
```sql
SELECT
  p.patient_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  SUM(b.amount) AS total_billed
FROM billing b
JOIN patients p ON b.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_billed DESC
LIMIT 3;
```

**15.** Write a SQL query to count treatments by outcome.
```sql
SELECT outcome, COUNT(*) AS treatments_by_outcome
FROM treatments
GROUP BY outcome;
```

---

### 4. 🧼 Data Cleaning & Validation

**16.** Write a SQL query to find patients with duplicate emails.
```sql
SELECT email, COUNT(*) 
FROM patients
GROUP BY email
HAVING COUNT(*) > 1;
```

**17.** Write a SQL query to detect billing records with zero or negative amounts.
```sql
SELECT *
FROM billing
WHERE amount <= 0;
```

**18.** Write a SQL query to find doctors assigned to non-existent departments.
```sql
SELECT *
FROM doctors
WHERE department_id NOT IN (SELECT department_id FROM departments);
```

**19.** Write a SQL query to check for orphan treatments with invalid appointment references.
```sql
SELECT * 
FROM treatments 
WHERE appointment_id NOT IN (SELECT appointment_id FROM appointments);
```

---

### 5. 🧠 Subqueries & CASE Logic

**20.** Write a SQL query to list patients who have had more than 3 appointments.
```sql
SELECT patient_id, COUNT(*) AS no_of_appointments
FROM appointments
GROUP BY patient_id
HAVING COUNT(*) > 3;
```

**21.** Write a SQL query to show billing status along with a custom label using CASE.
```sql
SELECT
  bill_id,
  amount,
  payment_status,
  CASE
    WHEN payment_status = 'Paid' THEN '✅ Cleared'
    WHEN payment_status = 'Pending' THEN '🕒 Awaiting'
    ELSE '⚠️ Follow Up'
  END AS status_label
FROM billing;
```

**22.** Write a SQL query to find doctors who haven’t had any appointments.
```sql
SELECT *
FROM doctors
WHERE doctor_id NOT IN (SELECT DISTINCT doctor_id FROM appointments);
```

**23.** Write a SQL query to find how many appointments each doctor has handled.
```sql
SELECT
  d.doctor_name,
  COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC;
```

**24.** Write a SQL query to find the total billing amount for each patient.
```sql
SELECT
  p.patient_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  SUM(b.amount) AS total_billed
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_billed DESC;
```

---

### 6. 📅 Time-Based & Performance Queries

**25.** Write a SQL query to find the number of appointments in the past 30 days.
```sql
SELECT COUNT(*) AS recent_appointments
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '30 days';
```

**26.** Write a SQL query to find monthly revenue generated from billing.
```sql
SELECT
  DATE_TRUNC('month', billing_date) AS billing_month,
  SUM(amount) AS total_revenue
FROM billing
GROUP BY billing_month
ORDER BY billing_month;
```

**27.** Write a SQL query to find average treatment outcomes by type.
```sql
SELECT treatment_type, outcome, COUNT(*) AS total
FROM treatments
GROUP BY treatment_type, outcome;
```

**28.** Write a SQL query to calculate total revenue by department.
```sql
SELECT
  dept.department_name,
  SUM(b.amount) AS department_revenue
FROM billing b
JOIN appointments a ON b.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
GROUP BY dept.department_name;
```

**29.** Write a SQL query to get doctor-wise appointment counts for the last 90 days.
```sql
SELECT
  d.doctor_name,
  COUNT(a.appointment_id) AS recent_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.appointment_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY d.doctor_name
ORDER BY recent_appointments DESC;
```
