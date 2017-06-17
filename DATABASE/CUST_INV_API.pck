create or replace package CUST_INV_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_INV_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_INV_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN CUST_INV_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_INV_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(invNo_   IN NUMBER,
                 old_rec_ IN OUT CUST_INV_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2);

  PROCEDURE Delete_(invNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_INV_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_INV_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(invNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Cust_Invoice(invDesc_            OUT VARCHAR2,
                             invStatus_          OUT NUMBER,
                             salesPriceAmt_      OUT NUMBER,
                             discount_           OUT NUMBER,
                             grossSalesPriceAmt_ OUT NUMBER,
                             pendingPaymentFlag_ OUT NUMBER,
                             customerId_         OUT VARCHAR2,
                             custEmailAdd_       OUT VARCHAR2,
                             notes_              OUT VARCHAR2,
                             jobNo_              OUT NUMBER,
                             createdDate_        OUT DATE,
                             modifiedDate_       OUT DATE,
                             rowversion_         OUT DATE,
                             rslt_               OUT VARCHAR2,
                             invNo_              IN NUMBER);

  PROCEDURE Get_Next_Inv_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);

  FUNCTION Get_Inv_Status(invNo_ IN NUMBER) RETURN NUMBER;

end CUST_INV_API;
/
create or replace package body CUST_INV_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_INV_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the customer invoice.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_INV_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'CUST_INV_NO' THEN
        rec_.cust_inv_no := TO_NUMBER(value_);
      ELSIF name_ = 'INV_DESC' THEN
        rec_.inv_desc := value_;
      ELSIF name_ = 'INV_STATUS' THEN
        rec_.inv_status := TO_NUMBER(value_);
      ELSIF name_ = 'SALES_PRICE_AMOUNT' THEN
        rec_.sales_price_amount := TO_NUMBER(value_);
      ELSIF name_ = 'DISCOUNT' THEN
        rec_.discount := TO_NUMBER(value_);
      ELSIF name_ = 'GROSS_SALES_PRICE_AMT' THEN
        rec_.gross_sales_price_amt := TO_NUMBER(value_);
      ELSIF name_ = 'PENDING_PAYMENT_FLAG' THEN
        rec_.pending_payment_flag := TO_NUMBER(value_);
      ELSIF name_ = 'CUSTOMER_ID' THEN
        rec_.customer_id := value_;
      ELSIF name_ = 'CUST_EMAIL_ADD' THEN
        rec_.cust_email_add := value_;
      ELSIF name_ = 'NOTES' THEN
        rec_.notes := value_;
      ELSIF name_ = 'JOB_NO' THEN
        rec_.job_no := TO_NUMBER(value_);
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

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_INV_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.cust_inv_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Customer invoice ' || newrec_.cust_inv_no ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.cust_inv_no IS NULL THEN
      rslt_ := 'Error: Invoice No cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(invNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_invoice IS
      SELECT 1 FROM CUST_INV_TAB i WHERE i.cust_inv_no = invNo_;
  BEGIN
    OPEN chk_invoice;
    FETCH chk_invoice
      INTO tmp_;
    IF chk_invoice%FOUND THEN
      CLOSE chk_invoice;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_invoice;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_INV_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO CUST_INV_TAB
      (CUST_INV_NO,
       INV_DESC,
       INV_STATUS,
       SALES_PRICE_AMOUNT,
       DISCOUNT,
       GROSS_SALES_PRICE_AMT,
       PENDING_PAYMENT_FLAG,
       CUSTOMER_ID,
       CUST_EMAIL_ADD,
       NOTES,
       JOB_NO)
    VALUES
      (newrec_.cust_inv_no,
       newrec_.inv_desc,
       newrec_.inv_status,
       newrec_.sales_price_amount,
       newrec_.discount,
       newrec_.gross_sales_price_amt,
       newrec_.pending_payment_flag,
       newrec_.customer_id,
       newrec_.cust_email_add,
       newrec_.notes,
       newrec_.job_no)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN CUST_INV_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('CUST_INV_NO', to_char(rec_.cust_inv_no), attr_);
    System_API.Add_To_Attr('INV_DESC', rec_.inv_desc, attr_);
    System_API.Add_To_Attr('INV_STATUS', to_char(rec_.inv_status), attr_);
    System_API.Add_To_Attr('SALES_PRICE_AMOUNT',
                           to_char(rec_.sales_price_amount),
                           attr_);
    System_API.Add_To_Attr('DISCOUNT', to_char(rec_.discount), attr_);
    System_API.Add_To_Attr('GROSS_SALES_PRICE_AMT',
                           to_char(rec_.gross_sales_price_amt),
                           attr_);
    System_API.Add_To_Attr('PENDING_PAYMENT_FLAG',
                           to_char(rec_.pending_payment_flag),
                           attr_);
    System_API.Add_To_Attr('CUSTOMER_ID', rec_.customer_id, attr_);
    System_API.Add_To_Attr('CUST_EMAIL_ADD', rec_.cust_email_add, attr_);
    System_API.Add_To_Attr('NOTES', rec_.notes, attr_);
    System_API.Add_To_Attr('JOB_NO', to_char(rec_.job_no), attr_);
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
    rec_ CUST_INV_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the customer invoice.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_INV_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ CUST_INV_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.cust_inv_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(invNo_   IN NUMBER,
                 old_rec_ IN OUT CUST_INV_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_invoice IS
      SELECT * FROM CUST_INV_TAB i WHERE i.cust_inv_no = invNo_;
  BEGIN
    Check_Exist_(invNo_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_invoice;
      FETCH get_invoice
        INTO old_rec_;
      CLOSE get_invoice;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the invoice ' || invNo_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_INV_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE CUST_INV_TAB i
       SET ROW = newrec_
     WHERE i.cust_inv_no = newrec_.cust_inv_no;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(invNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    rec_    CUST_INV_TAB%ROWTYPE;
    status_ NUMBER;
  
  BEGIN
    Check_Exist_(invNo_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(invNo_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        status_ := Get_Inv_Status(invNo_);
        IF (status_ = 0) THEN
          DELETE FROM CUST_INV_TAB i where i.cust_inv_no = invNo_;
          rslt_ := 'Successfully deleted the customer invoice.';
        ELSE
          rslt_ := 'Error: Customer invoices only in planned state can be deleted.';
        END IF;
      ELSE
        rslt_ := 'Error: Customer invoice has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the customer invoice.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Cust_Invoice(invDesc_            OUT VARCHAR2,
                             invStatus_          OUT NUMBER,
                             salesPriceAmt_      OUT NUMBER,
                             discount_           OUT NUMBER,
                             grossSalesPriceAmt_ OUT NUMBER,
                             pendingPaymentFlag_ OUT NUMBER,
                             customerId_         OUT VARCHAR2,
                             custEmailAdd_       OUT VARCHAR2,
                             notes_              OUT VARCHAR2,
                             jobNo_              OUT NUMBER,
                             createdDate_        OUT DATE,
                             modifiedDate_       OUT DATE,
                             rowversion_         OUT DATE,
                             rslt_               OUT VARCHAR2,
                             invNo_              IN NUMBER) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (invNo_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from CUST_INV_TAB i where i.cust_inv_no = invNo_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.inv_desc,
           i.inv_status,
           i.sales_price_amount,
           i.discount,
           i.gross_sales_price_amt,
           i.pending_payment_flag,
           i.customer_id,
           i.cust_email_add,
           i.notes,
           i.job_no,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO invDesc_,
           invStatus_,
           salesPriceAmt_,
           discount_,
           grossSalesPriceAmt_,
           pendingPaymentFlag_,
           customerId_,
           custEmailAdd_,
           notes_,
           jobNo_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM CUST_INV_TAB i
     WHERE i.Cust_Inv_No = invNo_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Cust_Invoice;

  PROCEDURE Get_Next_Inv_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := WFMS_CUST_INV_NO.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Next_Inv_No;

  FUNCTION Get_Inv_Status(invNo_ IN NUMBER) RETURN NUMBER IS
  
    temp_ CUST_INV_TAB.INV_STATUS%TYPE;
  BEGIN
    IF (invNo_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.inv_status
      INTO temp_
      FROM CUST_INV_TAB s
     WHERE s.cust_inv_no = invNo_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Inv_Status;

end CUST_INV_API;
/
