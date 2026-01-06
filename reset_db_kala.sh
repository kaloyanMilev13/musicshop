#!/usr/bin/env bash
set -euo pipefail

DB_NAME="musicshop"
DB_USER="kala"
DB_PASS="kala"

echo "[1/3] Dropping old database and user (if they exist)..."
sudo mariadb <<SQL
-- Drop DB first (removes all tables/data)
DROP DATABASE IF EXISTS \`${DB_NAME}\`;

-- Drop user if exists
DROP USER IF EXISTS '${DB_USER}'@'localhost';
DROP USER IF EXISTS '${DB_USER}'@'127.0.0.1';

FLUSH PRIVILEGES;
SQL

echo "[2/3] Creating fresh database and user ${DB_USER}:${DB_PASS} ..."
sudo mariadb <<SQL
CREATE DATABASE \`${DB_NAME}\`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
CREATE USER '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASS}';

GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'127.0.0.1';

FLUSH PRIVILEGES;
SQL

echo "[3/3] Verifying access..."
mariadb -u "${DB_USER}" -p"${DB_PASS}" -h 127.0.0.1 -e "SHOW DATABASES; SHOW TABLES FROM \`${DB_NAME}\`;" >/dev/null 2>&1 || true

echo "Done. Fresh DB '${DB_NAME}' created and user '${DB_USER}' granted access."
echo "If you want to import your backup next:"
echo "  mariadb -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < /path/to/musicshop_backup.sql"

