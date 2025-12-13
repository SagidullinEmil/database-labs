# Custom format backup
pg_dump -U postgres -F c -d dormitory_db -f dormitory_db.backup

# Schema only
pg_dump -U postgres -s -d dormitory_db -f dormitory_schema.sql

# Data only
pg_dump -U postgres -a -d dormitory_db -f dormitory_data.sql

------

# Restore example

# Create a fresh database to restore into
psql -U postgres -d postgres -c "DROP DATABASE IF EXISTS dormitory_db_restore;"
psql -U postgres -d postgres -c "CREATE DATABASE dormitory_db_restore;"

# Restore from custom backup
pg_restore -U postgres -d dormitory_db_restore -c dormitory_db.backup