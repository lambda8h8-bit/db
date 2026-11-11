-- Create the core table
CREATE TABLE Books (
    Book_ID NUMBER PRIMARY KEY,
    Title VARCHAR2(100),
    Author VARCHAR2(50),
    Available CHAR(1) DEFAULT 'Y' CHECK (Available IN ('Y', 'N'))
);

-- Create a sequence for auto-generating IDs
CREATE SEQUENCE seq_book_id START WITH 1001;

-- Insert some initial data (Notice we don't provide Book_ID)
INSERT INTO Books (Title, Author) VALUES ('Oracle PL/SQL Programming', 'Steven Feuerstein');
INSERT INTO Books (Title, Author) VALUES ('Database System Concepts', 'Silberschatz');
COMMIT;
