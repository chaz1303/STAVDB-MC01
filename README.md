```markdown
# Ecommerce Data Warehouse

This project implements the STADVDB MCO1 requirements against the supplied MySQL dump.

## Structure

- `database/01_warehouse_schema.sql`: star-schema database, dimensions, fact table, and indexes
- `database/02_warehouse_views.sql`: analytical detail view
- `etl/run.php`: extract, clean, transform, and load process
- `olap/queries.sql`: roll-up, drill-down, slice, dice, pivot, and EXPLAIN queries
- `app/`: parameterized PHP web dashboard
- `tests/functional_tests.sql`: ETL and OLAP correctness checks
- `performance/benchmark.sql`: profiling and execution-plan checks
- `docs/technical-report-outline.md`: report structure matching the assignment
- `Dump20250923/`: supplied source tables

## Requirements

- MySQL 8.0+ or MariaDB (XAMPP)
- PHP 8.1+ with `pdo_mysql`

## Run

### 1. Start MySQL / Database Server
Ensure MySQL is running on port 3306 (e.g., via XAMPP Control Panel or standalone Windows service).

> **Note for XAMPP / MariaDB Users:** If you run into `ERROR 1273 (HY000): Unknown collation: 'utf8mb4_0900_ai_ci'`, perform a global find-and-replace in VS Code (`Ctrl + Shift + F`) across the `Dump20250923/` files to change `utf8mb4_0900_ai_ci` to `utf8mb4_general_ci` before importing.

### 2. Create Database
Create the `faker` target database:

```sql
CREATE DATABASE IF NOT EXISTS faker CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

```

### 3. Import Source Dump Files

Import parent tables sequentially before child tables (`OrderItems`). Run these commands one at a time from the project root directory.

**Option A: Using Command Prompt (`cmd`)**

```cmd
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_Users.sql
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_Products.sql
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_Couriers.sql
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_Riders.sql
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_Orders.sql
C:\xampp\mysql\bin\mysql -u root faker < Dump20250923/faker_OrderItems.sql

```

**Option B: Using PowerShell**

```powershell
Get-Content Dump20250923\faker_Users.sql | C:\xampp\mysql\bin\mysql -u root faker
Get-Content Dump20250923\faker_Products.sql | C:\xampp\mysql\bin\mysql -u root faker
Get-Content Dump20250923\faker_Couriers.sql | C:\xampp\mysql\bin\mysql -u root faker
Get-Content Dump20250923\faker_Riders.sql | C:\xampp\mysql\bin\mysql -u root faker
Get-Content Dump20250923\faker_Orders.sql | C:\xampp\mysql\bin\mysql -u root faker
Get-Content Dump20250923\faker_OrderItems.sql | C:\xampp\mysql\bin\mysql -u root faker

```

*(Note: Omit `C:\xampp\mysql\bin\` if `mysql` is already added to your system `PATH`).*

### 4. Verify Database Population

Confirm all 6 tables and row counts exist prior to executing ETL:

```cmd
C:\xampp\mysql\bin\mysql -u root -e "SELECT 'Users' AS Table_Name, COUNT(*) AS Total_Rows FROM faker.Users UNION ALL SELECT 'Products', COUNT(*) FROM faker.Products UNION ALL SELECT 'Couriers', COUNT(*) FROM faker.Couriers UNION ALL SELECT 'Riders', COUNT(*) FROM faker.Riders UNION ALL SELECT 'Orders', COUNT(*) FROM faker.Orders UNION ALL SELECT 'OrderItems', COUNT(*) FROM faker.OrderItems;"

```

### 5. Run the ETL Pipeline

From the project directory, run the PHP ETL script to extract, transform, and build `ecommerce_dw`:

```powershell
php etl/run.php --host=127.0.0.1 --port=3306 --user=root --password= --source=faker --warehouse=ecommerce_dw

```

### 6. Start Dashboard

Launch the PHP web application:

```powershell
php -S 127.0.0.1:8080 -t app

```

Open `http://127.0.0.1:8080` in your browser. Update `app/config.php` if using a non-default database user/password.

## SQL Checks

Run these post-ETL tests to verify data warehouse correctness and performance:

```powershell
C:\xampp\mysql\bin\mysql -u root ecommerce_dw < tests/functional_tests.sql
C:\xampp\mysql\bin\mysql -u root ecommerce_dw < performance/benchmark.sql

```

Use the SQL output along with `SHOW PROFILES` or `EXPLAIN ANALYZE` in your final technical report. Run reports multiple times across dates, categories, and countries to measure execution performance.

## Source Data & Processing

The source dataset contains ~3.1 million total records across 6 tables. The ETL script normalizes category and text casing, fills missing labels, parses multiple date formats, converts null/zero quantities to `1`, and calculates line item totals into the `ecommerce_dw` star schema.

```

```