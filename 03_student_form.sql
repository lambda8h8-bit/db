-- 1. Create the table to store the form data
CREATE TABLE Student_Form (
    Student_ID NUMBER PRIMARY KEY,
    Student_Name VARCHAR2(50),
    Course VARCHAR2(20),
    Fee NUMBER
);

-- 2. The "Form" Code (Using Substitution Variables)
-- When this runs, SQL*Plus will prompt you for each '&' value.
PROMPT =========================================
PROMPT    STUDENT INFORMATION ENTRY FORM
PROMPT =========================================

INSERT INTO Student_Form (Student_ID, Student_Name, Course, Fee)
VALUES (
    &Student_ID,
    '&Student_Name',
    '&Course',
    &Fee
);

-- Act as the "Submit" button
COMMIT;
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Record successfully saved to the database!');
END;
/
