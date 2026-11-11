-- 1. Create the user with a strong password
CREATE USER app_user IDENTIFIED BY "InitialPass123!";

-- 2. Grant minimal privileges (Least Privilege Principle)
-- They need to log in (CREATE SESSION)
GRANT CREATE SESSION TO app_user;

-- They need to read the EMP table, but NOT update or delete it
GRANT SELECT ON SCOTT.EMP TO app_user;

-- 3. Security Feature: Alter the password (Simulating a mandatory reset)
ALTER USER app_user IDENTIFIED BY "NewSecurePass456!";
