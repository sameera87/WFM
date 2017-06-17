create or replace package COUNTRY_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COUNTRY_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COUNTRY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN COUNTRY_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT COUNTRY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(countryCode_ IN VARCHAR2,
                 old_rec_     IN OUT COUNTRY_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2);

  PROCEDURE Delete_(countryCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COUNTRY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT COUNTRY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(countryCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Country_Code(countryName_  OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             countryCode_  IN VARCHAR2);

  FUNCTION Get_Country_Name(countryCode_ IN VARCHAR2) RETURN VARCHAR2;

end COUNTRY_API;
/
create or replace package body COUNTRY_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ COUNTRY_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the country.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COUNTRY_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'COUNTRY_CODE' THEN
        rec_.country_code := value_;
      ELSIF name_ = 'COUNTRY_NAME' THEN
        rec_.country_name := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT COUNTRY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.country_code, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Country code ' || newrec_.country_code ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.country_code IS NULL THEN
      rslt_ := 'Error: Country code cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(countryCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_countryCode IS
      SELECT 1 FROM COUNTRY_TAB i WHERE i.country_code = countryCode_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_countryCode;
    FETCH chk_countryCode
      INTO tmp_;
    IF chk_countryCode%FOUND THEN
      CLOSE chk_countryCode;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_countryCode;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COUNTRY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO COUNTRY_TAB
      (COUNTRY_CODE, COUNTRY_NAME)
    VALUES
      (newrec_.country_code, newrec_.country_name)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN COUNTRY_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('COUNTRY_CODE', rec_.country_code, attr_);
    System_API.Add_To_Attr('COUNTRY_NAME', rec_.country_name, attr_);
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
    rec_ COUNTRY_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the country code.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT COUNTRY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ COUNTRY_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.country_code, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(countryCode_ IN VARCHAR2,
                 old_rec_     IN OUT COUNTRY_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_country IS
      SELECT * FROM COUNTRY_TAB i WHERE i.country_code = countryCode_;
  BEGIN
    Check_Exist_(countryCode_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_country;
      FETCH get_country
        INTO old_rec_;
      CLOSE get_country;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the country code ' || countryCode_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COUNTRY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE COUNTRY_TAB i
       SET ROW = newrec_
     WHERE i.country_code = newrec_.country_code;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(countryCode_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ COUNTRY_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(countryCode_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(countryCode_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM COUNTRY_TAB i where i.country_code = countryCode_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the country code.';
        END IF;
      ELSE
        rslt_ := 'Error: Country code has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the country code.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Country_Code(countryName_  OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             countryCode_  IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (countryCode_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from COUNTRY_TAB i
     where i.country_code = countryCode_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.country_name, i.created_date, i.modified_date, i.rowversion
      INTO countryName_, createdDate_, modifiedDate_, rowversion_
      FROM COUNTRY_TAB i
     WHERE i.country_code = countryCode_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Country_Code;

  FUNCTION Get_Country_Name(countryCode_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ COUNTRY_TAB.COUNTRY_NAME%TYPE;
  BEGIN
    IF (countryCode_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.country_name
      INTO temp_
      FROM COUNTRY_TAB s
     WHERE s.country_code = countryCode_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Country_Name;

end COUNTRY_API;
/
