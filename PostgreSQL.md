
\l                       # List all databases
\c database_name         # Connect to database

<!-- Sequelize npm -->


DROP DATABASE database_name;
CREATE DATABASE database_name;

CREATE TABLE table_name (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drop table
DROP TABLE table_name;

\q                       # Quit Shell
