SELECT 'CREATE DATABASE labs_dev'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'labs_dev')\gexec

SELECT 'CREATE DATABASE labs_test'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'labs_test')\gexec
