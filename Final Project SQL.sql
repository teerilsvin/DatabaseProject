DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS states CASCADE;
DROP TABLE IF EXISTS donors CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS bankinventory CASCADE;
DROP TABLE IF EXISTS hospital CASCADE;
DROP TABLE IF EXISTS blooddonated CASCADE;
DROP TABLE IF EXISTS hospitalinventory CASCADE;
DROP TABLE IF EXISTS hospitalorders CASCADE;
DROP TABLE IF EXISTS doctorsorders CASCADE;
DROP TABLE IF EXISTS hospitalbloodinfo CASCADE;
DROP VIEW IF EXISTS donors_to_patients;
DROP VIEW IF EXISTS patients_doctors;
DROP VIEW IF EXISTS change_in_id;

-- States --
CREATE TABLE states (
  zipCode	varchar(5) not null,
  city		text not null,
  state		char(2) not null,
 primary key(zipCode)
);

-- States Data --
INSERT INTO states(zipCode, city, state)
  VALUES('12601', 'Poughkeepsie', 'NY');
INSERT INTO states(zipCode, city, state)
  VALUES('11731', 'Huntington', 'NY');
INSERT INTO states(zipCode, city, state)
  VALUES('07675', 'Westwood', 'NJ');
INSERT INTO states(zipCode, city, state)
  VALUES('96826', 'Honolulu', 'HI');

Select *
From states;

-- People --
CREATE TABLE people (
  pid      	char(4) not null,
  firstName     text not null,
  lastName	text not null,
  age		integer not null,
  contactNum	varchar(10) not null, 
  sex		char(1),
  streetAddress	text not null,
  zipCode	varchar(5) not null references states(zipCode),
 primary key(pid)
);

--People Data --
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('dn01', 'Bill', 'Nye', 45, 6514567436, 'M', '123 Science Ln.', '12601');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('dn02', 'James', 'Bond', 26, 6317894312, 'M', '007 Badass Ave.', '12601');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('dn03', 'Frank', 'Zappa', 28, 2015789045, 'M', '84 Guitar St.', '11731');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('dn04', 'Olga', 'Janiak', 21, 6314593246, 'F', '3 Forest Dr.', '11731');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('do01', 'Bill', 'Murray', 68, 8475891245, 'M', '69 Beverly Hills', '96826');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('do02', 'Frank', 'Doyle', 53, 6318952547, 'M', '23 Meatloaf Ln.', '07675');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('pa01', 'Sean', 'Connery', 63, 7850327490, 'M', '85 Hollywood Blvd', '96826');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('pa02', 'Eli', 'Doris', 19, 7542368579, 'M', '15 Clare Dr.', '11731');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('pa03', 'Ashley', 'Delano', 20, 758203657, 'F', '851 Westwood Ave', '07675');
INSERT INTO people(pid, firstName, lastName, age, contactNum, sex, streetAddress, zipCode)
  VALUES('pa04', 'Laura', 'Nillon', 33, 7589340243, 'F', '3 Marriage St.', '12601');

Select *
From people;


-- Donors --
CREATE TABLE donors (
  donid		char(4) not null references people(pid),
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
 primary key(donid)
);

-- Donor Data --
INSERT INTO donors(donid, bloodtype)
  VALUES('dn01', 'A-');
INSERT INTO donors(donid, bloodtype)
  VALUES('dn02', 'O+');
INSERT INTO donors(donid, bloodtype)
  VALUES('dn03', 'AB+');
INSERT INTO donors(donid, bloodtype)
  VALUES('dn04', 'B+');

Select *
FROM donors;


--Doctors --
CREATE TABLE doctors (
  docid		char(4) not null references people(pid),
  yearsWorking	integer,
  type		text,
 primary key(docid)
);

--Doctor Data --
INSERT INTO doctors(docid, yearsWorking, type)
  VALUES('do01', 22, 'Surgeon');
INSERT INTO doctors(docid, yearsWorking, type)
  VALUES('do02', 15, 'Hematologist');

Select *
From doctors;


-- Patients --
CREATE TABLE patients (
  patid		char(4) not null references people(pid),
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
 primary key(patid)
);

-- Patient Data --
INSERT INTO patients(patid, bloodtype)
  VALUES('pa01', 'AB+');
INSERT INTO patients(patid, bloodtype)
  VALUES('pa02', 'O+');
INSERT INTO patients(patid, bloodtype)
  VALUES('pa03', 'B+');
INSERT INTO patients(patid, bloodtype)
  VALUES('pa04', 'A-');

Select *
From patients;

-- Bank Inventory --
CREATE TABLE bankinventory (
  bloodbankid	char(4) not null,
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
  amount	integer not null,
 primary key(bloodbankid)
);

-- Bank Inventory Data --
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b001', 'O+', 12);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b002', 'A+', 10);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b003', 'B-', 10);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b004', 'AB-', 9);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b005', 'O-', 13);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b006', 'AB+', 12);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b007', 'O+', 10);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b008', 'A-', 10);
INSERT INTO bankinventory(bloodbankid, bloodtype, amount)
  VALUES('b009', 'B+', 10);

Select *
From bankinventory;


-- Hospital --
CREATE TABLE hospital (
  hosid		char(4) not null,
  name		text not null,
  streetAddress	text not null,
  zipCode	varchar(5) not null references states(zipCode),
 primary key(hosid)
);

--Hospital Data --
INSERT INTO hospital(hosid, name, streetAddress, zipCode)
  VALUES('h001', 'St. Francis', '108 North Rd.', '12601');
INSERT INTO hospital(hosid, name, streetAddress, zipCode)
  VALUES('h002', 'Huntington Hospital', '5 Main St.', '11731');
INSERT INTO hospital(hosid, name, streetAddress, zipCode)
  VALUES('h003', 'Hackensack Hospital', '16 Cherry Ln.', '07675');
INSERT INTO hospital(hosid, name, streetAddress, zipCode)
  VALUES('h004', 'Straub Clinic', '84 Volcano Ave.', '96826');

Select *
From hospital;
  

-- Blood Donated --
CREATE TABLE blooddonated (
  donid		char(4) not null references donors(donid),
  bloodbankid	char(4) not null references bankinventory(bloodbankid),
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
  amount	integer not null,
  date		date not null,
 primary key(donid, bloodbankid)
);

--Blood Donated Data --
INSERT INTO blooddonated(donid, bloodbankid, bloodtype, amount, date)
  VALUES('dn01', 'b008', 'A-', 10, '2014-04-19');
INSERT INTO blooddonated(donid, bloodbankid, bloodtype, amount, date)
  VALUES('dn02', 'b007', 'O+', 13, '2014-03-29');
INSERT INTO blooddonated(donid, bloodbankid, bloodtype, amount, date)
  VALUES('dn03', 'b006', 'AB+', 12, '2014-02-21');
INSERT INTO blooddonated(donid, bloodbankid, bloodtype, amount, date)
  VALUES('dn04', 'b009', 'B+', 10, '2014-04-20');

Select *
From blooddonated;


-- Hospital Inventory --
CREATE TABLE hospitalinventory (
  hosid		char(4) not null references hospital(hosid),
  hosbloodid	char(4) not null references hospitalbloodinfo(hosbloodid),
 primary key(hosid, hosbloodid)
);

INSERT INTO hospitalinventory(hosid, hosbloodid)
 VALUES('h001', 'h004');
INSERT INTO hospitalinventory(hosid, hosbloodid)
 VALUES('h002', 'h003');
INSERT INTO hospitalinventory(hosid, hosbloodid)
 VALUES('h003', 'h002');
INSERT INTO hospitalinventory(hosid, hosbloodid)
 VALUES('h004', 'h001');

Select *
From hospitalinventory;
 

-- Hospital Blood Info --
CREATE TABLE hospitalbloodinfo (
  hosbloodid	char(4) not null,
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
  amount	integer not null,
 primary key(hosbloodid)
);	

-- Hospital Blood Info Data --
INSERT INTO hospitalbloodinfo(hosbloodid, bloodtype, amount)
 VALUES('h001', 'AB+', 12);
INSERT INTO hospitalbloodinfo(hosbloodid, bloodtype, amount)
 VALUES('h002', 'O+', 1);
INSERT INTO hospitalbloodinfo(hosbloodid, bloodtype, amount)
 VALUES('h003', 'A-', 10);
INSERT INTO hospitalbloodinfo(hosbloodid, bloodtype, amount)
 VALUES('h004', 'B+', 10);

Select *
From hospitalbloodinfo;

-- Hospital Orders --
CREATE TABLE hospitalorders (
  hordno	char(4) not null,
  bloodbankid	char(4) not null references bankinventory(bloodbankid),
  hosid		char(4) not null references hospital(hosid),
  date		date not null,
  cost		numeric(10,2),
 primary key(hordno)
);

--Hospital Orders Data --
INSERT INTO hospitalorders(hordno, bloodbankid, hosid, date, cost)
  VALUES('o001', 'b006', 'h001', '2014-02-22', 635.00);
INSERT INTO hospitalorders(hordno, bloodbankid, hosid, date, cost)
  VALUES('o002', 'b007', 'h002', '2014-02-22', 635.00);
INSERT INTO hospitalorders(hordno, bloodbankid, hosid, date, cost)
  VALUES('o003', 'b008', 'h003', '2014-02-22', 635.00);
INSERT INTO hospitalorders(hordno, bloodbankid, hosid, date, cost)
  VALUES('o004', 'b009', 'h004', '2014-04-21', 784.00);

Select *
From hospitalorders;
  

-- Doctors Orders --
CREATE TABLE doctorsorders (
  dordno	char(4) not null,
  hosbloodid	char(4) not null references hospitalbloodinfo(hosbloodid),
  docid		char(4) not null references doctors(docid),
  bloodtype	text not null CHECK
	(bloodtype in ('A+' , 'A-' ,'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
  amount	integer not null,
  date		date not null,
  hosid		char(4) not null references hospital(hosid),
  patid		char(4) not null references patients(patid),
 primary key(dordno)
);

-- Doctors Orders Data --
INSERT INTO doctorsorders(dordno, hosbloodid, docid, bloodtype, amount, date, hosid, patid)
 VALUES('o001', 'h001', 'do02', 'AB+', 12, '4-02-2014', 'h001', 'pa01');
INSERT INTO doctorsorders(dordno, hosbloodid, docid, bloodtype, amount, date, hosid, patid)
 VALUES('o002', 'h002', 'do02', 'O+', 12, '4-06-2014', 'h002', 'pa02');
INSERT INTO doctorsorders(dordno, hosbloodid, docid, bloodtype, amount, date, hosid, patid)
 VALUES('o003', 'h004', 'do01', 'A-', 10, '4-09-2014', 'h004', 'pa04');
INSERT INTO doctorsorders(dordno, hosbloodid, docid, bloodtype, amount, date, hosid, patid)
 VALUES('o004', 'h003', 'do02', 'A-', 12, '4-15-2014', 'h003', 'pa03');

Select *
 From doctorsorders;

-- Patients Doctors View --
CREATE VIEW patients_doctors as
Select pat.lastName AS "patient_lastname", 
       pat.firstName AS "patient_firstname", 
       doc.lastName AS "doctor_lastname", 
       doc.firstName AS "doctor_firstname" 
From people pat, people doc ,patients p, doctors d, doctorsorders doco
Where pat.pid = p.patid
  and doc.pid = d.docid
  and d.docid = doco.docid
  and p.patid = doco.patid
Order by pat.lastName

 Select *
 From patients_doctors

-- Donors Patients View --
CREATE VIEW donors_to_patients as
Select don.lastName AS "donor_lastname",
       don.firstName AS "donor_firstname",
       pat.lastName AS "patient_lastname",
       pat.firstName AS "patient_firstname"
From people don, people pat, donors d, patients p, blooddonated bd, bankinventory bi, hospitalorders ho, hospital h, hospitalinventory hi, hospitalbloodinfo hbi, doctorsorders doco
Where don.pid = d.donid
  and pat.pid = p.patid
  and bd.donid = d.donid
  and bi.bloodbankid = bd.bloodbankid
  and ho.bloodbankid = bi.bloodbankid
  and h.hosid = ho.hosid
  and hi.hosid = h.hosid
  and hbi.hosbloodid = hi.hosbloodid
  and doco.hosbloodid = hbi.hosbloodid
  and doco.patid = p.patid
Order by don.lastName

Select *
From donors_to_patients

-- Change in ID View --
CREATE VIEW change_in_id as
Select hi.hosbloodid AS "hospital_id",
       bi.bloodbankid AS "blood_bank_id"
From bankinventory bi, hospitalorders ho, hospital h, hospitalinventory hi
Where bi.bloodbankid = ho.bloodbankid
  and h.hosid = ho.hosid
  and hi.hosid = h.hosid
Order by hi.hosbloodid

Select *
From change_in_id

-- Difference between donating and ordering --
Select bd.date - ho.date AS "days_sitting_in_bank", bd.date AS "donation_date", ho.date AS "order_date"
From blooddonated bd, hospitalorders ho , bankinventory bi
Where bd.bloodbankid = bi.bloodbankid
  and ho.bloodbankid = bi.bloodbankid

-- Difference between hospital order and doctor order --
Select doco.date - ho.date AS "days_sitting_in_hospital", ho.date AS "hos_order_date", doco.date AS "doc_order_date"
From hospitalorders ho, hospital h, hospitalinventory hi, hospitalbloodinfo hbi, doctorsorders doco
Where ho.hosid = h.hosid
  and hi.hosid = h.hosid
  and h.hosid = hbi.hosbloodid
  and doco.hosbloodid = hbi.hosbloodid

-- Table of patients in which hospitals --
CREATE or REPLACE function patients_in_hospitals(text, REFCURSOR) returns refcursor as
$$
DECLARE
  pat_lastName		text		:= $1;
  --pat_firstName		text	:= $2;
  resultset		REFCURSOR 	:= $2;
BEGIN
  open resultset for
    Select h.name AS "Hospital Name", p.lastName AS "Patient Last Name", p.firstName AS "Patient First Name"
    from hospital h, doctorsorders doco, people p, patients pat 
    where p.lastName = pat_lastName
      AND h.hosid = doco.hosid
      AND doco.patid = pat.patid
      AND pat.patid = p.pid
   ORDER BY h.name, p.lastName;
  return resultset;
END;
$$
language plpgsql;

Select patients_in_hospitals('Connery', 'results');
Fetch all from results;