create or replace package CUST_PAYMENT_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN CUST_PAYMENT_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(custPaymentNo_ IN NUMBER,
                 old_rec_       IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                 rslt_          IN OUT VARCHAR2);

  PROCEDURE Delete_(custPaymentNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(custPaymentNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Customer_Payment(payMethodId_   OUT VARCHAR2,
                                 paymentAmt_    OUT NUMBER,
                                 notes_         OUT VARCHAR2,
                                 payStatus_     OUT NUMBER,
                                 invNo_         OUT NUMBER,
                                 createdDate_   OUT DATE,
                                 modifiedDate_  OUT DATE,
                                 rowversion_    OUT DATE,
                                 rslt_          OUT VARCHAR2,
                                 custPaymentNo_ IN NUMBER);

  PROCEDURE Get_Next_Payment_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);

  FUNCTION Get_Payment_Status(custPaymentNo_ IN NUMBER) RETURN NUMBER;

end CUST_PAYMENT_API;
/
create or replace package body CUST_PAYMENT_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_PAYMENT_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the customer payment.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'CUST_PAYMENT_NO' THEN
        rec_.cust_payment_no := TO_NUMBER(value_);
      ELSIF name_ = 'PAY_METHOD_ID' THEN
        rec_.pay_method_id := value_;
      ELSIF name_ = 'PAYMENT_AMOUNT' THEN
        rec_.payment_amount := TO_NUMBER(value_);
      ELSIF name_ = 'NOTES' THEN
        rec_.notes := value_;
      ELSIF name_ = 'PAY_STATUS' THEN
        rec_.pay_status := TO_NUMBER(value_);
      ELSIF name_ = 'CUST_INV_NO' THEN
        rec_.cust_inv_no := TO_NUMBER(value_);
      ELSIF name_ = 'CREATED_DATE' THEN
        rec_.created_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'MODIFIED_DATE' THEN
        rec_.modified_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'ROWVERSION' THEN
        rec_.rowversion := TO_DATE(value_, 'MM/DD/YYYY HH:MI:SS AM');
      ELSE
        rslt_ := 'Attr error: Unknown attribute found: ' || name_ || ' - ' ||
                 value_;
      END IF;
    END LOOP;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Unpack_;

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.cust_payment_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Customer payment ' || newrec_.cust_payment_no ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.cust_payment_no IS NULL THEN
      rslt_ := 'Error: Customer payment ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(custPaymentNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_custPayment IS
      SELECT 1
        FROM CUST_PAYMENT_TAB i
       WHERE i.cust_payment_no = custPaymentNo_;
  BEGIN
    OPEN chk_custPayment;
    FETCH chk_custPayment
      INTO tmp_;
    IF chk_custPayment%FOUND THEN
      CLOSE chk_custPayment;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_custPayment;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO CUST_PAYMENT_TAB
      (CUST_PAYMENT_NO,
       PAY_METHOD_ID,
       PAYMENT_AMOUNT,
       NOTES,
       PAY_STATUS,
       CUST_INV_NO)
    VALUES
      (newrec_.cust_payment_no,
       newrec_.pay_method_id,
       newrec_.payment_amount,
       newrec_.notes,
       newrec_.pay_status,
       newrec_.cust_inv_no)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN CUST_PAYMENT_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('CUST_PAYMENT_NO',
                           to_char(rec_.cust_payment_no),
                           attr_);
    System_API.Add_To_Attr('PAY_METHOD_ID', rec_.pay_method_id, attr_);
    System_API.Add_To_Attr('PAYMENT_AMOUNT',
                           to_char(rec_.payment_amount),
                           attr_);
    System_API.Add_To_Attr('NOTES', rec_.notes, attr_);
    System_API.Add_To_Attr('PAY_STATUS', to_char(rec_.pay_status), attr_);
    System_API.Add_To_Attr('CUST_INV_NO', to_char(rec_.cust_inv_no), attr_);
    System_API.Add_To_Attr('CREATED_DATE',
                           to_char(rec_.created_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('MODIFIED_DATE',
                           to_char(rec_.modified_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('ROWVERSION',
                           to_char(rec_.rowversion,
                                   'MM/DD/YYYY HH:MI:SS AM'),
                           attr_);
  
  END Pack_;

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_PAYMENT_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the customer payment.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ CUST_PAYMENT_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.cust_payment_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(custPaymentNo_ IN NUMBER,
                 old_rec_       IN OUT CUST_PAYMENT_TAB%ROWTYPE,
                 rslt_          IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_custPayment IS
      SELECT *
        FROM CUST_PAYMENT_TAB i
       WHERE i.cust_payment_no = custPaymentNo_;
  BEGIN
    Check_Exist_(custPaymentNo_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_custPayment;
      FETCH get_custPayment
        INTO old_rec_;
      CLOSE get_custPayment;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the customer payment ' || custPaymentNo_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_PAYMENT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE CUST_PAYMENT_TAB i
       SET ROW = newrec_
     WHERE i.cust_payment_no = newrec_.cust_payment_no;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(custPaymentNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_PAYMENT_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(custPaymentNo_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(custPaymentNo_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM CUST_PAYMENT_TAB i
         where i.cust_payment_no = custPaymentNo_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the customer payment.';
        END IF;
      ELSE
        rslt_ := 'Error: Customer payment has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the customer payment.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Customer_Payment(payMethodId_   OUT VARCHAR2,
                                 paymentAmt_    OUT NUMBER,
                                 notes_         OUT VARCHAR2,
                                 payStatus_     OUT NUMBER,
                                 invNo_         OUT NUMBER,
                                 createdDate_   OUT DATE,
                                 modifiedDate_  OUT DATE,
                                 rowversion_    OUT DATE,
                                 rslt_          OUT VARCHAR2,
                                 custPaymentNo_ IN NUMBER) IS
  
    dummy number := 0;
  BEGIN
    IF (custPaymentNo_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from CUST_PAYMENT_TAB i
     where i.cust_payment_no = custPaymentNo_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.pay_method_id,
           i.payment_amount,
           i.notes,
           i.pay_status,
           i.cust_inv_no,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO payMethodId_,
           paymentAmt_,
           notes_,
           payStatus_,
           invNo_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM CUST_PAYMENT_TAB i
     WHERE i.cust_payment_no = custPaymentNo_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Customer_Payment;

  PROCEDURE Get_Next_Payment_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := WFMS_CUST_PAYMENT_NO_SEQ.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Next_Payment_No;

  FUNCTION Get_Payment_Status(custPaymentNo_ IN NUMBER) RETURN NUMBER IS
  
    temp_ CUST_PAYMENT_TAB.PAY_STATUS%TYPE;
  BEGIN
    IF (custPaymentNo_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.pay_status
      INTO temp_
      FROM CUST_PAYMENT_TAB s
     WHERE s.cust_payment_no = custPaymentNo_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Payment_Status;

end CUST_PAYMENT_API;
/
