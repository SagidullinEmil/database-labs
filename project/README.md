Final Project
University Dormitory & Student Housing System

The final project is a PostgreSQL-based relational database designed to manage university dormitories, rooms, students, housing contracts, payments, and maintenance requests.

------

Environment

DBMS: PostgreSQL 17
Operating System: Windows 11
Interface: psql CLI (PowerShell / VS Code terminal)

------

Repository Structure

.
├── project/
│ ├── schema/
│ │ ├── 01_create_tables.sql
│ │ ├── 02_constraints_indexes.sql
│ │ ├── 03_views.sql
│ │ ├── 04_functions_triggers.sql
│ │ ├── 05_seed_data.sql
│ │ ├── 06_more_seed_data.sql
│ │ ├── 07_maintenance_resolved_trigger.sql
│ │ └── 99_run_all.sql
│ │
│ └── queries/
│ ├── 01_reports.sql
│ └── 02_analytics.sql
│
└── README.md

------

Core Features

1. Dormitories and rooms with capacity and occupancy tracking
2. Student records and housing contracts
3. Enforcement of one active contract per student
4. Automatic prevention of room overbooking
5. Payment history per student
6. Maintenance requests with staff assignment
7. Views for reporting and analytics
8. Triggers and functions enforcing business logic

------

Business Rules Enforced

1. A student may have only one active housing contract at a time
2. Room occupancy cannot exceed room capacity
3. Room occupancy updates automatically when contracts change
4. Maintenance resolved_on date is set automatically when status becomes resolved

------

How to Run the Project

1. Create the database
psql -U postgres -d postgres -c "CREATE DATABASE dormitory_db;"

2. Build schema, views, triggers, and seed data
psql -U postgres -d dormitory_db -v ON_ERROR_STOP=1 -f project\schema\99_run_all.sql

3. Verify setup
psql -U postgres -d dormitory_db -c "\dt"
psql -U postgres -d dormitory_db -c "\dv"

4. Run queries
psql -U postgres -d dormitory_db -f project\queries\01_reports.sql
psql -U postgres -d dormitory_db -f project\queries\02_analytics.sql

------

Author

Emil Sagidullin
Email: sagidullin_e@auca.kg

GitHub: https://github.com/SagidullinEmil