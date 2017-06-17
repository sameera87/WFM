create or replace package PAYMENT_METHOD_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_  IN PAYMENT_METHOD_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(payMethodId_ IN VARCHAR2,
                 old_rec_     IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2);

  PROCEDURE Delete_(payMethodId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(payMethodId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Payment_Method(description_  OUT VARCHAR2,
                               createdDate_  OUT DATE,
                               modifiedDate_ OUT DATE,
                               rowversion_   OUT DATE,
                               rslt_         OUT VARCHAR2,
                               payMethodId_  IN VARCHAR2);

  FUNCTION Get_Payment_Method_Desc(payMethodId_ IN VARCHAR2) RETURN VARCHAR2;

end PAYMENT_METHOD_API;
/
create or replace package body PAYMENT_METHOD_API is

PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ PAYMENT_METHOD_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the payment method.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'PAY_METHOD_ID' THEN
        rec_.pay_method_id := value_;
      ELSIF name_ = 'DESCRIPTION' THEN
        rec_.description := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.pay_method_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Payment method ' || newrec_.pay_method_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.pay_method_id IS NULL THEN
      rslt_ := 'Error: Payment method cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(payMethodId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_payMethod IS
      SELECT 1 FROM PAYMENT_METHOD_TAB i WHERE i.pay_method_id = payMethodId_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_payMethod;
    FETCH chk_payMethod
      INTO tmp_;
    IF chk_payMethod%FOUND THEN
      CLOSE chk_payMethod;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_payMethod;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO PAYMENT_METHOD_TAB
      (PAY_METHOD_ID, DESCRIPTION)
    VALUES
      (newrec_.pay_method_id, newrec_.description)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN PAYMENT_METHOD_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('PAY_METHOD_ID', rec_.pay_method_id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
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
    rec_ PAYMENT_METHOD_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the payment method.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ PAYMENT_METHOD_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.pay_method_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(payMethodId_ IN VARCHAR2,
                 old_rec_     IN OUT PAYMENT_METHOD_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_payMethod IS
      SELECT * FROM PAYMENT_METHOD_TAB i WHERE i.pay_method_id = payMethodId_;
  BEGIN
    Check_Exist_(payMethodId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_payMethod;
      FETCH get_payMethod
        INTO old_rec_;
      CLOSE get_payMethod;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the payment method ' || payMethodId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY PAYMENT_METHOD_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE PAYMENT_METHOD_TAB i
       SET ROW = newrec_
     WHERE i.pay_method_id = newrec_.pay_method_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(payMethodId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ PAYMENT_METHOD_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(payMethodId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(payMethodId_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM PAYMENT_METHOD_TAB i where i.pay_method_id = payMethodId_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the payment method.';
        END IF;
      ELSE
        rslt_ := 'Error: Payment method has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the payment method.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Payment_Method(description_  OUT VARCHAR2,
                               createdDate_  OUT DATE,
                               modifiedDate_ OUT DATE,
                               rowversion_   OUT DATE,
                               rslt_         OUT VARCHAR2,
                               payMethodId_  IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (payMethodId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from PAYMENT_METHOD_TAB i
     where i.pay_method_id = payMethodId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description, i.created_date, i.modified_date, i.rowversion
      INTO description_, createdDate_, modifiedDate_, rowversion_
      FROM PAYMENT_METHOD_TAB i
     WHERE i.pay_method_id = payMethodId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Payment_Method;

  FUNCTION Get_Payment_Method_Desc(payMethodId_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ PAYMENT_METHOD_TAB.DESCRIPTION%TYPE;
  BEGIN
    IF (payMethodId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.description
      INTO temp_
      FROM PAYMENT_METHOD_TAB s
     WHERE s.pay_method_id = payMethodId_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Payment_Method_Desc;

end PAYMENT_METHOD_API;
/
