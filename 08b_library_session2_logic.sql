-- 1. Trigger to automatically assign the next Book_ID
CREATE OR REPLACE TRIGGER trg_book_id
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    IF :NEW.Book_ID IS NULL THEN
        :NEW.Book_ID := seq_book_id.NEXTVAL;
    END IF;
END;
/

-- 2. Stored Procedure to issue a book (with validation)
CREATE OR REPLACE PROCEDURE issue_book (p_book_id IN NUMBER) AS
    v_status CHAR(1);
BEGIN
    -- Check if book exists and get its status
    SELECT Available INTO v_status FROM Books WHERE Book_ID = p_book_id;

    -- Validation: Is it already issued?
    IF v_status = 'N' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Book is currently issued to someone else.');
    END IF;

    -- Update status to 'N' (Not Available)
    UPDATE Books SET Available = 'N' WHERE Book_ID = p_book_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Book ' || p_book_id || ' has been issued.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Book ID ' || p_book_id || ' does not exist.');
END;
/
