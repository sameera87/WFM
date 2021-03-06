create or replace package USER_API is

  PROCEDURE New_User(userid_    IN VARCHAR2,
                     firstName_ IN VARCHAR2,
                     lastName_  IN VARCHAR2,
                     password_  IN VARCHAR2,
                     userType_  IN VARCHAR2);

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT USER_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT USER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY USER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN USER_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT USER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(userid_  IN VARCHAR2,
                 old_rec_ IN OUT USER_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2);

  PROCEDURE Delete_(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY USER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_User(firstName_    OUT VARCHAR2,
                     lastName_     OUT VARCHAR2,
                     password_     OUT VARCHAR2,
                     userType_     OUT VARCHAR2,
                     createdDate_  OUT DATE,
                     modifiedDate_ OUT DATE,
                     rowversion_   OUT DATE,
                     rslt_         OUT varchar2,
                     userid_       IN VARCHAR2);

  FUNCTION Get_User_Type(userid_ IN VARCHAR2) RETURN VARCHAR2;
  
  PROCEDURE Check_Delete_(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  FUNCTION Get_Full_Name(userid_ IN VARCHAR2) RETURN VARCHAR2;
  
  FUNCTION User_Connected_To_Employee(userid_ IN VARCHAR2) RETURN VARCHAR2;
    

end USER_API;
/
create or replace package body USER_API is

  PROCEDURE New_User(userid_    IN VARCHAR2,
                     firstName_ IN VARCHAR2,
                     lastName_  IN VARCHAR2,
                     password_  IN VARCHAR2,
                     userType_  IN VARCHAR2) IS
  BEGIN
    INSERT INTO USER_TAB
      (USER_ID,
       FIRST_NAME,
       LAST_NAME,
       PASSWORD,
       USER_TYPE,
       CREATED_DATE,
       MODIFIED_DATE,
       ROWVERSION)
    VALUES
      (userid_,
       firstName_,
       lastName_,
       password_,
       userType_,
       sysdate,
       sysdate,
       sysdate);
  END New_User;

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ USER_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Saved the user.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT USER_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'USER_ID' THEN
        rec_.user_id := value_;
      ELSIF name_ = 'FIRST_NAME' THEN
        rec_.first_name := value_;
      ELSIF name_ = 'LAST_NAME' THEN
        rec_.Last_Name := value_;
      ELSIF name_ = 'PASSWORD' THEN
        rec_.Password := value_;
      ELSIF name_ = 'USER_TYPE' THEN
        rec_.User_Type := value_;
      ELSIF name_ = 'CREATED_DATE' THEN
        rec_.Created_Date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'MODIFIED_DATE' THEN
        rec_.Modified_Date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'ROWVERSION' THEN
        rec_.Rowversion := TO_DATE(value_, 'MM/DD/YYYY HH:MI:SS AM');
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

  PROCEDURE Check_Insert_(newrec_ IN OUT USER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist(newrec_.user_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: User ' || newrec_.user_id || ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.User_Id IS NULL THEN
      rslt_ := 'Error: User ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_user IS
      SELECT 1 FROM USER_TAB i WHERE i.User_Id = userid_;
  
  BEGIN
    OPEN chk_user;
    FETCH chk_user
      INTO tmp_;
    IF chk_user%FOUND THEN
      CLOSE chk_user;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_user;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY USER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO USER_TAB
      (USER_ID, FIRST_NAME, LAST_NAME, PASSWORD, USER_TYPE)
    VALUES
      (newrec_.User_Id,
       newrec_.First_Name,
       newrec_.Last_Name,
       newrec_.Password,
       newrec_.User_Type)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.Created_Date, newrec_.modified_date, newrec_.Rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN USER_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('USER_ID', rec_.User_Id, attr_);
    System_API.Add_To_Attr('FIRST_NAME', rec_.First_Name, attr_);
    System_API.Add_To_Attr('LAST_NAME', rec_.last_name, attr_);
    System_API.Add_To_Attr('PASSWORD', rec_.password, attr_);
    System_API.Add_To_Attr('USER_TYPE', rec_.User_Type, attr_);
    System_API.Add_To_Attr('CREATED_DATE',
                           to_char(rec_.Created_Date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('MODIFIED_DATE',
                           to_char(rec_.Modified_Date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('ROWVERSION',
                           to_char(rec_.Rowversion, 'dd-MM-yyyy'),
                           attr_);
  
  END Pack_;

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ USER_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the user.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT USER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ USER_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.User_Id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.Rowversion != oldrec_.Rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(userid_  IN VARCHAR2,
                 old_rec_ IN OUT USER_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_USER IS
      SELECT * FROM USER_TAB i WHERE i.user_id = userid_;
  BEGIN
    Check_Exist(userid_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_user;
      FETCH get_user
        INTO old_rec_;
      CLOSE get_user;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the user ' || userid_;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Delete_(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(userid_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      DELETE FROM USER_TAB where user_id = userid_;
      rslt_ := 'Successfully deleted the user.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY USER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.Rowversion := sysdate;
    UPDATE USER_TAB i SET ROW = newrec_ WHERE i.user_id = newrec_.User_Id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Get_User(firstName_    OUT VARCHAR2,
                     lastName_     OUT VARCHAR2,
                     password_     OUT VARCHAR2,
                     userType_     OUT VARCHAR2,
                     createdDate_  OUT DATE,
                     modifiedDate_ OUT DATE,
                     rowversion_   OUT DATE,
                     rslt_         OUT varchar2,
                     userid_       IN VARCHAR2) IS
    dummy number := 0;
  
  BEGIN
    IF (userid_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from USER_TAB i where i.User_Id = userid_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.FIRST_NAME,
           i.LAST_NAME,
           i.PASSWORD,
           i.USER_TYPE,
           trunc(i.CREATED_DATE),
           trunc(i.MODIFIED_DATE),
           trunc(i.ROWVERSION)
      INTO firstName_,
           lastName_,
           password_,
           userType_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM USER_TAB i
     WHERE i.User_Id = userid_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_User;

  FUNCTION Get_User_Type(userid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ USER_TAB.USER_TYPE%TYPE;
  BEGIN
    IF (userid_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.User_Type
      INTO temp_
      FROM USER_TAB s
     WHERE s.User_Id = userid_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_User_Type;

  PROCEDURE Check_Delete_(userid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    temp_ NUMBER := 0;
  BEGIN
  
    Check_Exist(userid_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (userid_ IS NULL) THEN
        rslt_ := 'Error: User ID must have a value.';
      END IF;
      SELECT 1 INTO temp_ FROM Employee_Tab WHERE user_id = userid_;
    
      IF (temp_ IS NOT NULL) THEN
        rslt_ := 'Error: User ' || userid_ ||
                 ' is connected to an employee and hence cannot be deleted.';
      ELSE
        rslt_ := 'TRUE';
      END IF;
    END IF;
  
  END Check_Delete_;
  
  FUNCTION Get_Full_Name(userid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rec_  USER_TAB%ROWTYPE;
    rslt_ VARCHAR2(100);
     
  BEGIN
    Get_(userid_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      rslt_ := rec_.first_name || ' ' || rec_.last_name;
      RETURN rslt_;
    END IF;
  
  END Get_Full_Name;
  
  
  FUNCTION User_Connected_To_Employee(userid_ IN VARCHAR2) RETURN VARCHAR2 IS
    
    dummy_ NUMBER := 0;
    rslt_ VARCHAR2(100) := '';
    
    CURSOR user_connected IS
    SELECT 1
    FROM EMPLOYEE_TAB
    WHERE USER_ID = userid_;
    
  BEGIN
    OPEN user_connected;
    FETCH user_connected INTO dummy_;
    IF (user_connected%FOUND) THEN
      CLOSE user_connected;
      rslt_ := 'TRUE';
    ELSE
      CLOSE user_connected;
      rslt_ := 'FALSE';
    END IF;
    
    RETURN rslt_;
    
  END User_Connected_To_Employee;    

end USER_API;
/
