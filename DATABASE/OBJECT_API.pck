create or replace package OBJECT_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT OBJECT_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY OBJECT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN OBJECT_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT OBJECT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(objectId_ IN VARCHAR2,
                 old_rec_  IN OUT OBJECT_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2);

  PROCEDURE Delete_(objectId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY OBJECT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT OBJECT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(objectId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Object(description_  OUT VARCHAR2,
                       serialNo_     OUT VARCHAR2,
                       objType_      OUT VARCHAR2,
                       customerId_   OUT VARCHAR2,
                       createdDate_  OUT DATE,
                       modifiedDate_ OUT DATE,
                       rowversion_   OUT DATE,
                       rslt_         OUT VARCHAR2,
                       objectId_     IN VARCHAR2);

end OBJECT_API;
/
create or replace package body OBJECT_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ OBJECT_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the object.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT OBJECT_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'OBJECT_ID' THEN
        rec_.object_id := value_;
      ELSIF name_ = 'DESCRIPTION' THEN
        rec_.description := value_;
      ELSIF name_ = 'SERIAL_NO' THEN
        rec_.serial_no := value_;
      ELSIF name_ = 'OBJ_TYPE' THEN
        rec_.obj_type := value_;
      ELSIF name_ = 'CUSTOMER_ID' THEN
        rec_.customer_id := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT OBJECT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.object_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Object ' || newrec_.object_id || ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.object_id IS NULL THEN
      rslt_ := 'Error: Object ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(objectId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_object IS
      SELECT 1 FROM OBJECT_TAB i WHERE i.object_id = objectId_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_object;
    FETCH chk_object
      INTO tmp_;
    IF chk_object%FOUND THEN
      CLOSE chk_object;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_object;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY OBJECT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO OBJECT_TAB
      (OBJECT_ID, DESCRIPTION, SERIAL_NO, OBJ_TYPE, CUSTOMER_ID)
    VALUES
      (newrec_.object_id,
       newrec_.description,
       newrec_.serial_no,
       newrec_.obj_type,
       newrec_.customer_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN OBJECT_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('OBJECT_ID', rec_.object_id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
    System_API.Add_To_Attr('SERIAL_NO', rec_.Serial_No, attr_);
    System_API.Add_To_Attr('OBJ_TYPE', rec_.Obj_Type, attr_);
    System_API.Add_To_Attr('CUSTOMER_ID', rec_.Customer_Id, attr_);
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
    rec_ OBJECT_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the object.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT OBJECT_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ OBJECT_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.object_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(objectId_ IN VARCHAR2,
                 old_rec_  IN OUT OBJECT_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_object IS
      SELECT * FROM OBJECT_TAB i WHERE i.object_id = objectId_;
  BEGIN
    Check_Exist_(objectId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_object;
      FETCH get_object
        INTO old_rec_;
      CLOSE get_object;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the object ' || objectId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY OBJECT_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE OBJECT_TAB i
       SET ROW = newrec_
     WHERE i.object_id = newrec_.object_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(objectId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ OBJECT_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(objectId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(objectId_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM OBJECT_TAB i where i.object_id = objectId_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the object.';
        END IF;
      ELSE
        rslt_ := 'Error: day type has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the day type.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Object(description_  OUT VARCHAR2,
                       serialNo_     OUT VARCHAR2,
                       objType_      OUT VARCHAR2,
                       customerId_   OUT VARCHAR2,
                       createdDate_  OUT DATE,
                       modifiedDate_ OUT DATE,
                       rowversion_   OUT DATE,
                       rslt_         OUT VARCHAR2,
                       objectId_     IN VARCHAR2) IS
  dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (objectId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from OBJECT_TAB i
     where i.object_id = objectId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description,
           i.serial_no,
           i.obj_type,
           i.customer_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO description_,
           serialNo_,
           objType_,
           customerId_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM OBJECT_TAB i
     WHERE i.object_id = objectId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Object;

end OBJECT_API;
/
