create or replace package CURRENCY_CODE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN CURRENCY_CODE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(currencyCode_ IN VARCHAR2,
                 old_rec_      IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                 rslt_         IN OUT VARCHAR2);

  PROCEDURE Delete_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Currency_Code(description_  OUT VARCHAR2,
                              createdDate_  OUT DATE,
                              modifiedDate_ OUT DATE,
                              rowversion_   OUT DATE,
                              rslt_         OUT VARCHAR2,
                              currencyCode_ IN VARCHAR2);

  FUNCTION Get_Description(currencyCode_ IN VARCHAR2) RETURN VARCHAR2;
  
  PROCEDURE Check_Delete_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

end CURRENCY_CODE_API;
/
create or replace package body CURRENCY_CODE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CURRENCY_CODE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the currency code.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'CURRENCY_CODE' THEN
        rec_.currency_code := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.currency_code, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Currency code ' || newrec_.currency_code ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.currency_code IS NULL THEN
      rslt_ := 'Error: Currency code cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_currCode IS
      SELECT 1
        FROM CURRENCY_CODE_TAB i
       WHERE i.currency_code = currencyCode_;

  BEGIN
    OPEN chk_currCode;
    FETCH chk_currCode
      INTO tmp_;
    IF chk_currCode%FOUND THEN
      CLOSE chk_currCode;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_currCode;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO CURRENCY_CODE_TAB
      (CURRENCY_CODE, DESCRIPTION)
    VALUES
      (newrec_.currency_code, newrec_.description)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN CURRENCY_CODE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('CURRENCY_CODE', rec_.currency_code, attr_);
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
    rec_ CURRENCY_CODE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the currency code.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ CURRENCY_CODE_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.currency_code, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion = oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(currencyCode_ IN VARCHAR2,
                 old_rec_      IN OUT CURRENCY_CODE_TAB%ROWTYPE,
                 rslt_         IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_object IS
      SELECT *
        FROM CURRENCY_CODE_TAB i
       WHERE i.currency_code = currencyCode_;
  BEGIN
    Check_Exist_(currencyCode_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_object;
      FETCH get_object
        INTO old_rec_;
      CLOSE get_object;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the currency code ' || currencyCode_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CURRENCY_CODE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE CURRENCY_CODE_TAB i
       SET ROW = newrec_
     WHERE i.currency_code = newrec_.currency_code;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    
  BEGIN
    Check_Delete_(currencyCode_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      DELETE FROM CURRENCY_CODE_TAB i
         where i.currency_code = currencyCode_;
      rslt_ := 'Successfully deleted the currency code.';  
    END IF;
    
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Currency_Code(description_  OUT VARCHAR2,
                              createdDate_  OUT DATE,
                              modifiedDate_ OUT DATE,
                              rowversion_   OUT DATE,
                              rslt_         OUT VARCHAR2,
                              currencyCode_ IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (currencyCode_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from CURRENCY_CODE_TAB i
     where i.currency_code = currencyCode_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description, i.created_date, i.modified_date, i.rowversion
      INTO description_, createdDate_, modifiedDate_, rowversion_
      FROM CURRENCY_CODE_TAB i
     WHERE i.currency_code = currencyCode_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Currency_Code;

  FUNCTION Get_Description(currencyCode_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ CURRENCY_CODE_TAB.DESCRIPTION%TYPE;
  BEGIN
    IF (currencyCode_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.description
      INTO temp_
      FROM CURRENCY_CODE_TAB s
     WHERE s.currency_code = currencyCode_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Description;
  
  
  PROCEDURE Check_Delete_(currencyCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    temp_ NUMBER := 0;
  BEGIN
    
    Check_Exist_(currencyCode_, rslt_);
    IF (rslt_ = 'TRUE') THEN 
      IF (currencyCode_ IS NULL) THEN
        rslt_ := 'Error: Currency code must have a value.';
      END IF;
      SELECT 1
        INTO temp_
        FROM COMPANY_TAB
       WHERE CURRENCY_CODE = currencyCode_;
    
      IF(temp_ IS NOT NULL) THEN
        rslt_ := 'Error: Currency Code ' || currencyCode_ || ' is used in a company and hence cannot be deleted.';
      ELSE
        rslt_ := 'TRUE';
      END IF;
    END IF;    
    
   END Check_Delete_;   

end CURRENCY_CODE_API;
/
