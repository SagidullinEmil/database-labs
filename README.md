# Database Course (PostgreSQL)

This repository contains completed laboratory works and the final project for a university **Database Systems** course.  
Each `LabN.txt` file is a real console transcript from **psql** (including prompts and outputs) showing exact SQL commands and PostgreSQL responses.  
The `project/` folder contains the final PostgreSQL database project developed for the course.

**Environment used:** PostgreSQL 17 on Ubuntu 22.04 (via psql CLI).

---

## Repository Structure

### 🧪 Laboratory Works
Each lab demonstrates specific SQL concepts and PostgreSQL features.

- **Lab03.txt** — Basic psql commands: list databases, connect, create/insert/select/drop a simple table  
- **Lab04.txt** — SQL Basics: primary keys, NOT NULL/UNIQUE, inserts, filtering, ordering, limiting  
- **Lab05.txt** — Database Management: create/drop databases, connect/disconnect workflow  
- **Lab06.txt** — Tables, Data Types & Constraints: ALTER TABLE, add/remove UNIQUE, rename columns/tables, TEMP tables  
- **Lab07.txt** — Primary Keys: inline and named constraints, composite PKs  
- **Lab08.txt** — Foreign Keys & Relationships: defining FKs, rebuilding tables, inner joins  
- **Lab09.txt** — Database Design & Normalization: 1NF → 3NF examples  
- **Lab10.txt** — Inspecting Database Structure: `\d`, `\dt`, `\l`, column info, constraints overview  
- **Lab11.txt** — Data Operations: INSERT, UPDATE, DELETE, bulk inserts  
- **Lab12.txt** — Querying Data: computed columns, aliases, LIKE/ILIKE/regex filters, CASE, EXISTS/IN, GROUP BY with CTEs  
- **Lab13.txt** — Aggregate Functions: COUNT, SUM, AVG, MAX, MIN, STRING_AGG, ARRAY_AGG, HAVING, window functions  
- **Lab14.txt** — Joins: INNER/LEFT/RIGHT/FULL/CROSS joins, self joins, multi-table joins, explicit vs implicit syntax  
- **Lab15.txt** — Advanced Querying: subqueries (scalar/correlated), recursive CTEs, UNION/INTERSECT/EXCEPT, window functions, conditional aggregation  
- **Lab16.txt** — Transactions & ACID: BEGIN/COMMIT/ROLLBACK, SAVEPOINT, isolation levels (READ COMMITTED / SERIALIZABLE)  
- **Lab17.txt** — Data Import/Export: COPY/\copy (CSV/TSV), pg_dump, pg_restore, schema-only/data-only backups  

---

### 🧩 Final Project — *University Dormitory & Student Housing System*

The **University Dormitory & Student Housing System** is a relational database built with PostgreSQL to manage student housing assignments, payments, maintenance requests, and dorm capacity.  
It aims to provide a structured view of how universities handle on-campus living logistics.

**Key Features:**
- Tracks dormitories, rooms, and available capacity  
- Manages student assignments, check-ins, and check-outs  
- Logs maintenance requests and staff responses  
- Stores payment records and generates occupancy reports  
- Enforces data consistency using primary and foreign key constraints  
- Demonstrates triggers, functions, and transaction control  

**Entities:**
- `students` — personal info, faculty, contact details  
- `dormitories` — dorm name, address, total capacity  
- `rooms` — room number, type, capacity, and current occupants  
- `assignments` — student-to-room relationships with dates  
- `payments` — rent and maintenance payments by student  
- `maintenance` — reported issues, staff assigned, resolution status  
- `staff` — maintenance and dorm administration personnel  

**Contents:**
- `schema/` — SQL scripts for creating tables, relationships, and inserting sample data  
- `queries/` — Analytical and reporting SQL queries  
- `triggers/` — Functions and triggers to automate updates  
- `diagram.png` — ER diagram of the schema  
- `README.md` — Project overview and explanation  

---

## Academic Honesty & Ownership

These are my **own laboratory works and project** completed for coursework at the **American University of Central Asia (AUCA)**.  
Do **not** copy or reuse for graded submissions where that would violate your institution’s policy.

---

## License

No license.  
All rights reserved — if you wish to reuse or reference any part of this work, please ask for permission first.

---

**Author:** Emil Sagidullin  
📧 Email: se12373@auca.kg  
🌐 GitHub: [SagidullinEmil](https://github.com/SagidullinEmil)
