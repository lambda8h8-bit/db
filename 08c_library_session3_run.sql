SET SERVEROUTPUT ON;

-- 1. Simulate a user issuing a book (Should succeed)
EXEC issue_book(1001);

-- 2. Simulate another user trying to issue the same book (Should fail)
EXEC issue_book(1001);

-- 3. Generate a formatted SQL*Plus Report
SET PAGESIZE 50
SET FEEDBACK OFF
TTITLE '==============================' SKIP 1 -
       '    LIBRARY INVENTORY REPORT  ' SKIP 1 -
       '==============================' SKIP 2
COLUMN Book_ID FORMAT 9999 HEADING 'ID'
COLUMN Title FORMAT A30 HEADING 'Book Title'
COLUMN Author FORMAT A20 HEADING 'Author'
COLUMN Available FORMAT A3 HEADING 'Avl'

SELECT Book_ID, Title, Author, Available FROM Books;
