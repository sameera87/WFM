create or replace package FAULT_TYPE_API is

PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT FAULT_TYPE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY FAULT_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN FAULT_TYPE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT FAULT_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(faultType_ IN VARCHAR2,
                 old_rec_     IN OUT FAULT_TYPE_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2);

  PROCEDURE Delete_(faultType_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY FAULT_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT FAULT_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(faultType_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Fault_Type(description_  OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             faultType_  IN VARCHAR2);

  FUNCTION Get_Fault_Type_Desc(faultType_ IN VARCHAR2) RETURN VARCHAR2;

end FAULT_TYPE_API;
/
create or replace package body FAULT_TYPE_API is

 PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ FAULT_TYPE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the fault type.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT FAULT_TYPE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'FAULT_TYPE' THEN
        rec_.fault_type := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT FAULT_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.fault_type, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Fault type ' || newrec_.fault_type ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.fault_type IS NULL THEN
      rslt_ := 'Error: Fault type cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(faultType_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_faultType IS
      SELECT 1 FROM FAULT_TYPE_TAB i WHERE i.fault_type = faultType_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_faultType;
    FETCH chk_faultType
      INTO tmp_;
    IF chk_faultType%FOUND THEN
      CLOSE chk_faultType;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_faultType;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY FAULT_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO FAULT_TYPE_TAB
      (FAULT_TYPE, DESCRIPTION)
    VALUES
      (newrec_.fault_type, newrec_.description)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN FAULT_TYPE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('FAULT_TYPE', rec_.fault_type, attr_);
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
    rec_ FAULT_TYPE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the fault type.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT FAULT_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ FAULT_TYPE_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.fault_type, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(faultType_ IN VARCHAR2,
                 old_rec_     IN OUT FAULT_TYPE_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_faultType IS
      SELECT * FROM FAULT_TYPE_TAB i WHERE i.fault_type = faultType_;
  BEGIN
    Check_Exist_(faultType_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_faultType;
      FETCH get_faultType
        INTO old_rec_;
      CLOSE get_faultType;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the fault type ' || faultType_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY FAULT_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE FAULT_TYPE_TAB i
       SET ROW = newrec_
     WHERE i.fault_type = newrec_.fault_type;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(faultType_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ FAULT_TYPE_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(faultType_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(faultType_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM FAULT_TYPE_TAB i where i.fault_type = faultType_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the fault type.';
        END IF;
      ELSE
        rslt_ := 'Error: Fault type has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the fault type.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Fault_Type(description_  OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             faultType_  IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (faultType_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from FAULT_TYPE_TAB i
     where i.fault_type = faultType_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.fault_type, i.created_date, i.modified_date, i.rowversion
      INTO description_, createdDate_, modifiedDate_, rowversion_
      FROM FAULT_TYPE_TAB i
     WHERE i.fault_type = faultType_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Fault_Type;

  FUNCTION Get_Fault_Type_Desc(faultType_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ FAULT_TYPE_TAB.DESCRIPTION%TYPE;
  BEGIN
    IF (faultType_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.description
      INTO temp_
      FROM FAULT_TYPE_TAB s
     WHERE s.fault_type = faultType_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Fault_Type_Desc;

end FAULT_TYPE_API;
/
