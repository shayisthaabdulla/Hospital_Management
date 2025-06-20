-- 1. Departments Table
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100),
  head_of_department VARCHAR(100)
);

-- 2. Doctors Table
CREATE TABLE doctors (
  doctor_id INT PRIMARY KEY,
  doctor_name VARCHAR(100),
  department_id INT,
  email VARCHAR(100),
  phone_number VARCHAR(20),
  active_flag BOOLEAN,
  hire_date DATE,
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. Patients Table
CREATE TABLE patients (
  patient_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender VARCHAR(10),
  birth_date DATE,
  phone_number VARCHAR(20),
  email VARCHAR(100),
  registration_date DATE
);

-- 4. Appointments Table
CREATE TABLE appointments (
  appointment_id INT PRIMARY KEY,
  patient_id INT,
  doctor_id INT,
  appointment_date DATE,
  appointment_status VARCHAR(20),
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 5. Treatments Table
CREATE TABLE treatments (
  treatment_id INT PRIMARY KEY,
  appointment_id INT,
  treatment_type VARCHAR(50),
  treatment_date DATE,
  outcome VARCHAR(20),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- 6. Billing Table
CREATE TABLE billing (
  bill_id INT PRIMARY KEY,
  patient_id INT,
  appointment_id INT,
  amount NUMERIC(10,2),
  billing_date DATE,
  payment_status VARCHAR(20),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- 1. Basic SELECT & Filtering--

-- 1.1 Write a SQL query to list all departments in the hospital.--

SELECT department_name
FROM departments;

--1.2. Write a SQL query to show all patients who registered in the last 6 months.--

SELECT *
FROM patients
WHERE registration_date >= CURRENT_DATE-INTERVAL '6 MONTHS';


--1.3. Write a SQL query to find all appointments with status 'Completed'.--

SELECT *
FROM appointments
WHERE appointment_status='Completed';

--1.4. Write a SQL query to retrieve all doctors who are currently inactive.--

SELECT *
FROM doctors
WHERE active_flag='false';

--1.5. Write a SQL query to show all treatments of type 'Surgery'.--

SELECT *
FROM treatments
WHERE treatment_type='Surgery';

--2. JOINs & Relationships--

--2.1. Write a SQL query to show patient names and their doctors for all appointments--

SELECT
  a.appointment_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  d.doctor_name,
  a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

--2.3. Write a SQL query to list doctor names with their department names.--

SELECT
  d.doctor_name,
  dept.department_name
FROM doctors AS d
JOIN departments AS dept ON d.department_id = dept.department_id;

--2.4. Write a SQL query to get appointment details along with patient and billing info.--

SELECT a.appointment_id,
	   p.first_name || '' || p.last_name AS patient_name,
	   b.amount,
	   b.payment_status
FROM appointments AS a
JOIN patients AS p ON p.patient_id=a.patient_id
JOIN billing AS b ON b.appointment_id=a.appointment_id;

--2.5. Write a SQL query to show each treatment with patient and doctor names.--

SELECT
  t.treatment_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  d.doctor_name,
  t.treatment_type,
  t.outcome
FROM treatments t
JOIN appointments AS a ON t.appointment_id = a.appointment_id
JOIN patients AS p ON a.patient_id = p.patient_id
JOIN doctors AS d ON a.doctor_id = d.doctor_id;

--2.6. Write a SQL query to list departments with the number of doctors in each.--

SELECT
  dept.department_name,
  COUNT(d.doctor_id) AS total_doctors
FROM departments dept
JOIN doctors d ON d.department_id = dept.department_id
GROUP BY dept.department_name
ORDER BY total_doctors;

--3. Aggregations & Metrics--

--3.1. Write a SQL query to count the total number of patients.--

SELECT COUNT (*) AS total_number_of_patients
FROM patients;

--3.2. Write a SQL query to find the average billing amount.--

SELECT AVG(amount) AS avg_bill
FROM BILLING;

--3.3. Write a SQL query to show the number of appointments per status.--

SELECT appointment_status, COUNT (*) AS no_of_appointments
FROM appointments
GROUP BY appointment_status;

--3.4. Write a SQL query to find the top 3 patients who had the highest total billing.--

SELECT
  p.patient_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  SUM(b.amount) AS total_billed
FROM billing b
JOIN patients p ON b.patient_id = p.patient_id
GROUP BY p.patient_id
ORDER BY total_billed DESC
LIMIT 3;


--3.5. Write a SQL query to count treatments by outcome.--

SELECT outcome, COUNT (*) AS treatments_by_outcome
FROM treatments
GROUP BY outcome

--4. Data Cleaning & Validation--

--4.1. Write a SQL query to find patients with duplicate emails.--

SELECT email, COUNT (*) 
FROM patients
GROUP BY email
HAVING COUNT (*)>1;

--4.2. Write a SQL query to detect billing records with zero or negative amounts.--

SELECT amount
FROM billing
WHERE amount <=0;

--4.3. Write a SQL query to find doctors assigned to non-existent departments.--

SELECT *
FROM doctors
WHERE department_id NOT IN (SELECT department_id
						    FROM departments);

--4.4. Write a SQL query to check for orphan treatments with invalid appointment references.

SELECT * 
FROM treatments 
WHERE appointment_id NOT IN (SELECT appointment_id 
							 FROM appointments);

-- 5. Subqueries & CASE--

--5.1. Write a SQL query to list patients who have had more than 3 appointments.--

SELECT patient_id, COUNT (*) AS no_of_appointments
FROM appointments
GROUP BY patient_id
HAVING COUNT (*) >3;

--5.2. Write a SQL query to show billing status along with a custom label using CASE.--

SELECT
bill_id,
amount,
payment_status,
CASE
	WHEN payment_status='Paid' THEN '✅ Cleared'
	WHEN payment_status='Pending' THEN '🕒 Awaiting'
	ELSE '⚠️ Follow Up'
END AS status_label
FROM billing;

--5.3. Write a SQL query to find doctors who haven’t had any appointments.

SELECT *
FROM doctors
WHERE doctor_id NOT IN (SELECT DISTINCT doctor_id FROM appointments);

--5.4. Write a SQL query to find how many appointments each doctor has handled.--

SELECT
  d.doctor_name,
  COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC;

--5.5. Write a SQL query to find the total billing amount for each patient--

SELECT
  p.patient_id,
  p.first_name || ' ' || p.last_name AS patient_name,
  SUM(b.amount) AS total_billed
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_billed DESC;


-- 6. Time-Based & Performance Queries==

--6.1 Write a SQL query to find the number of appointments in the past 30 days.--

SELECT COUNT(*) AS recent_appointments
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '30 days';

--6.2. Write a SQL query to find monthly revenue generated from billing.--

SELECT
  DATE_TRUNC('month', billing_date) AS billing_month,
  SUM(amount) AS total_revenue
FROM billing
GROUP BY billing_month
ORDER BY billing_month;

--6.3. Write a SQL query to find average treatment outcomes by type.--

SELECT treatment_type, outcome, COUNT(*) AS total
FROM treatments
GROUP BY treatment_type, outcome;

--6.4. Write a SQL query to calculate total revenue by department.--

SELECT
  dept.department_name,
  SUM(b.amount) AS department_revenue
FROM billing b
JOIN appointments a ON b.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
GROUP BY dept.department_name;

--6.5. Write a SQL query to get doctor-wise appointment counts for the last 90 days.--

SELECT
  d.doctor_name,
  COUNT(a.appointment_id) AS recent_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.appointment_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY d.doctor_name
ORDER BY recent_appointments DESC;

