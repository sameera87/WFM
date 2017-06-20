create or replace package EMPLOYEE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT EMPLOYEE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY EMPLOYEE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN EMPLOYEE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(employeeId_ IN VARCHAR2,
                 old_rec_    IN OUT EMPLOYEE_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2);

  PROCEDURE Delete_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY EMPLOYEE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Employee(empName_       OUT VARCHAR2,
                         addressId_     OUT NUMBER,
                         email_         OUT VARCHAR2,
                         homePhoneNo_   OUT VARCHAR2,
                         mobilePhoneNo_ OUT VARCHAR2,
                         empType_       OUT NUMBER,
                         empStatus_     OUT NUMBER,
                         empStart_      OUT DATE,
                         empFinish_     OUT DATE,
                         validFrom_     OUT DATE,
                         validTo_       OUT DATE,
                         userId_        OUT VARCHAR2,
                         calendarId_    OUT VARCHAR2,
                         customerId_    OUT VARCHAR2,
                         createdDate_   OUT DATE,
                         modifiedDate_  OUT DATE,
                         rowversion_    OUT DATE,
                         rslt_          OUT VARCHAR2,
                         employeeId_    IN VARCHAR2);

  FUNCTION Get_Employee_Type(employeeId_ IN VARCHAR2) RETURN NUMBER;

  FUNCTION Get_Employee_Status(employeeId_ IN VARCHAR2) RETURN NUMBER;

  PROCEDURE Validate_items_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                            rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Delete_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  FUNCTION Is_Employee_Valid(employeeId_ IN VARCHAR2, regDate_ IN DATE) RETURN VARCHAR2;
  
  FUNCTION Get_Employee_Company(employeeId_ IN VARCHAR2) RETURN VARCHAR2;
  
  FUNCTION Get_Emp_Address_Id(employeeId_ IN VARCHAR2) RETURN NUMBER;

end EMPLOYEE_API;
/
create or replace package body EMPLOYEE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ EMPLOYEE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the employee.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT EMPLOYEE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'EMPLOYEE_ID' THEN
        rec_.employee_id := value_;
      ELSIF name_ = 'EMP_NAME' THEN
        rec_.emp_name := value_;
      ELSIF name_ = 'EMP_ADDRESS_ID' THEN
        rec_.emp_address_id := TO_NUMBER(value_);
      ELSIF name_ = 'EMP_EMAIL' THEN
        rec_.emp_email := value_;
      ELSIF name_ = 'HOME_PHONE_NO' THEN
        rec_.home_phone_no := value_;
      ELSIF name_ = 'MOBILE_PHONE_NO' THEN
        rec_.mobile_phone_no := value_;
      ELSIF name_ = 'EMPLOYEE_TYPE' THEN
        rec_.employee_type := TO_NUMBER(value_);
      ELSIF name_ = 'EMPLOYEE_STATUS' THEN
        rec_.employee_status := TO_NUMBER(value_);
      ELSIF name_ = 'EMP_START_DATE' THEN
        rec_.emp_start_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'EMP_FINISH_DATE' THEN
        rec_.emp_finish_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'VALID_FROM' THEN
        rec_.valid_from := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'VALID_TO' THEN
        rec_.valid_to := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'USER_ID' THEN
        rec_.user_id := value_;
      ELSIF name_ = 'CALENDAR_ID' THEN
        rec_.calendar_id := value_;
      ELSIF name_ = 'COMPANY_ID' THEN
        rec_.company_id := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.employee_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Employee ' || newrec_.employee_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.employee_id IS NULL THEN
      rslt_ := 'Error: Employee ID cannot be Empty.';
    END IF;
    IF (newrec_.emp_start_date > newrec_.emp_finish_date) THEN
      rslt_ := 'Error: Employee Start Date cannot be later than the Employee Finish Date';
    END IF;
    IF (newrec_.Valid_From > newrec_.Valid_To) THEN
      rslt_ := 'Error: Employee Valid From Date cannot be later than the Employee Valid To Date';
    END IF;
    IF (work_time_calendar_api.Is_Cal_Valid(newrec_.calendar_id,
                                            newrec_.created_date) =
       'FALSE') THEN
      rslt_ := 'Error: Calendar is invalid for ' || newrec_.created_date;
    END IF;
    IF (work_time_calendar_api.Get_Cal_Status(newrec_.calendar_id) NOT IN (1)) THEN
      rslt_ := 'Error: The Calendar ' || newrec_.calendar_id ||
               'is not Active.';
    END IF;
    IF (USER_API.User_Connected_To_Employee(newrec_.user_id) = 'TRUE') THEN
      rslt_ := 'Error: The User ' || newrec_.user_id ||
               'is already connected to an employee.';
    END IF;
    Validate_items_(newrec_, rslt_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_employee IS
      SELECT 1 FROM EMPLOYEE_TAB i WHERE i.employee_id = employeeId_;
  
  BEGIN
    OPEN chk_employee;
    FETCH chk_employee
      INTO tmp_;
    IF chk_employee%FOUND THEN
      CLOSE chk_employee;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_employee;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY EMPLOYEE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO EMPLOYEE_TAB
      (EMPLOYEE_ID,
       EMP_NAME,
       EMP_ADDRESS_ID,
       EMP_EMAIL,
       HOME_PHONE_NO,
       MOBILE_PHONE_NO,
       EMPLOYEE_TYPE,
       EMPLOYEE_STATUS,
       EMP_START_DATE,
       EMP_FINISH_DATE,
       VALID_FROM,
       VALID_TO,
       USER_ID,
       CALENDAR_ID,
       COMPANY_ID)
    VALUES
      (newrec_.employee_id,
       newrec_.emp_name,
       newrec_.emp_address_id,
       newrec_.emp_email,
       newrec_.home_phone_no,
       newrec_.mobile_phone_no,
       newrec_.employee_type,
       newrec_.employee_status,
       newrec_.emp_start_date,
       newrec_.emp_finish_date,
       newrec_.valid_from,
       newrec_.valid_to,
       newrec_.user_id,
       newrec_.calendar_id,
       newrec_.company_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN EMPLOYEE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('EMPLOYEE_ID', rec_.employee_id, attr_);
    System_API.Add_To_Attr('EMP_NAME', rec_.emp_name, attr_);
    System_API.Add_To_Attr('EMP_ADDRESS_ID',
                           to_char(rec_.emp_address_id),
                           attr_);
    System_API.Add_To_Attr('EMP_EMAIL', rec_.emp_email, attr_);
    System_API.Add_To_Attr('HOME_PHONE_NO', rec_.home_phone_no, attr_);
    System_API.Add_To_Attr('MOBILE_PHONE_NO', rec_.mobile_phone_no, attr_);
    System_API.Add_To_Attr('EMPLOYEE_TYPE',
                           to_char(rec_.employee_type),
                           attr_);
    System_API.Add_To_Attr('EMPLOYEE_STATUS',
                           to_char(rec_.employee_status),
                           attr_);
    System_API.Add_To_Attr('EMP_START_DATE',
                           to_char(rec_.emp_start_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('EMP_FINISH_DATE',
                           to_char(rec_.emp_finish_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('VALID_FROM',
                           to_char(rec_.valid_from, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('VALID_TO',
                           to_char(rec_.valid_to, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('USER_ID', rec_.user_id, attr_);
    System_API.Add_To_Attr('CALENDAR_ID', rec_.calendar_id, attr_);
    System_API.Add_To_Attr('COMPANY_ID', rec_.company_id, attr_);
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
    rec_ EMPLOYEE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the employee.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ EMPLOYEE_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.employee_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion = oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF newrec_.employee_id IS NULL THEN
        rslt_ := 'Error: Employee ID cannot be Empty.';
      END IF;
      IF (newrec_.emp_start_date > newrec_.emp_finish_date) THEN
        rslt_ := 'Error: Employee Start Date cannot be later than the Employee Finish Date';
      END IF;
      IF (newrec_.Valid_From > newrec_.Valid_To) THEN
        rslt_ := 'Error: Employee Valid From Date cannot be later than the Employee Valid To Date';
      END IF;
      IF (work_time_calendar_api.Is_Cal_Valid(newrec_.calendar_id,
                                              newrec_.created_date) =
         'FALSE') THEN
        rslt_ := 'Error: Calendar is invalid for ' || newrec_.created_date;
      END IF;
      IF (work_time_calendar_api.Get_Cal_Status(newrec_.calendar_id) NOT IN (1)) THEN
        rslt_ := 'Error: The Calendar ' || newrec_.calendar_id ||
                 'is not Active.';
      END IF;
      IF (USER_API.User_Connected_To_Employee(newrec_.user_id) = 'TRUE') THEN
        rslt_ := 'Error: The User ' || newrec_.user_id ||
                 'is already connected to an employee.';
      END IF;
      Validate_items_(newrec_, rslt_);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(employeeId_ IN VARCHAR2,
                 old_rec_    IN OUT EMPLOYEE_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_employee IS
      SELECT * FROM EMPLOYEE_TAB i WHERE i.employee_id = employeeId_;
  BEGIN
    Check_Exist_(employeeId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_employee;
      FETCH get_employee
        INTO old_rec_;
      CLOSE get_employee;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the employee ' || employeeId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY EMPLOYEE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE EMPLOYEE_TAB i
       SET ROW = newrec_
     WHERE i.employee_id = newrec_.employee_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(employeeId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM EMPLOYEE_TAB i where i.employee_id = employeeId_;
      rslt_ := 'Successfully deleted the employee.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Employee(empName_       OUT VARCHAR2,
                         addressId_     OUT NUMBER,
                         email_         OUT VARCHAR2,
                         homePhoneNo_   OUT VARCHAR2,
                         mobilePhoneNo_ OUT VARCHAR2,
                         empType_       OUT NUMBER,
                         empStatus_     OUT NUMBER,
                         empStart_      OUT DATE,
                         empFinish_     OUT DATE,
                         validFrom_     OUT DATE,
                         validTo_       OUT DATE,
                         userId_        OUT VARCHAR2,
                         calendarId_    OUT VARCHAR2,
                         customerId_    OUT VARCHAR2,
                         createdDate_   OUT DATE,
                         modifiedDate_  OUT DATE,
                         rowversion_    OUT DATE,
                         rslt_          OUT VARCHAR2,
                         employeeId_    IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (employeeId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from EMPLOYEE_TAB i
     where i.employee_id = employeeId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.emp_name,
           i.emp_address_id,
           i.emp_email,
           i.home_phone_no,
           i.mobile_phone_no,
           i.employee_type,
           i.employee_status,
           i.emp_start_date,
           i.emp_finish_date,
           i.valid_from,
           i.valid_to,
           i.user_id,
           i.calendar_id,
           i.company_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO empName_,
           addressId_,
           email_,
           homePhoneNo_,
           mobilePhoneNo_,
           empType_,
           empStatus_,
           empStart_,
           empFinish_,
           validFrom_,
           validTo_,
           userId_,
           calendarId_,
           customerId_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM EMPLOYEE_TAB i
     WHERE i.employee_id = employeeId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Employee;

  FUNCTION Get_Employee_Type(employeeId_ IN VARCHAR2) RETURN NUMBER IS
  
    temp_ EMPLOYEE_TAB.EMPLOYEE_TYPE%TYPE;
  BEGIN
    IF (employeeId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.employee_type
      INTO temp_
      FROM EMPLOYEE_TAB s
     WHERE s.employee_id = employeeId_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Employee_Type;

  FUNCTION Get_Employee_Status(employeeId_ IN VARCHAR2) RETURN NUMBER IS
  
    temp_ EMPLOYEE_TAB.EMPLOYEE_STATUS%TYPE;
  BEGIN
    IF (employeeId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.employee_status
      INTO temp_
      FROM EMPLOYEE_TAB s
     WHERE s.employee_id = employeeId_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Employee_Status;

  PROCEDURE Validate_items_(newrec_ IN OUT EMPLOYEE_TAB%ROWTYPE,
                            rslt_   IN OUT VARCHAR2) IS
    emailregexp_ CONSTANT VARCHAR2(1000) := '^[a-z0-9!#$%&''*+/=?^_`{|}~-]+(\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+([A-Z]{2}|arpa|biz|com|info|intww|name|net|org|pro|aero|asia|cat|coop|edu|gov|jobs|mil|mobi|museum|pro|tel|travel|post)$';
    phoneregexp  CONSTANT VARCHAR2(100) := '^[0-9]{3}-[0-9]{3}-[0-9]{4}$|^[0-9]{3}-?[0-9]{3}-?[0-9]{4}$|^[0-9]{3}-?[0-9]{3}-?[0-9]{4}$|^[0-9]{10}';
  BEGIN
    IF REGEXP_LIKE(newrec_.emp_email, emailregexp_, 'i') THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Invalid email address.';
    END IF;
  
    IF REGEXP_LIKE(newrec_.home_phone_no, phoneregexp, 'i') THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Invalid phone number.';
    END IF;
  
  END Validate_items_;

  PROCEDURE Check_Delete_(employeeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    temp_ NUMBER := 0;
  BEGIN
  
    Check_Exist_(employeeId_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (employeeId_ IS NULL) THEN
        rslt_ := 'Error: Employee iD must have a value.';
      END IF;
      SELECT 1 INTO temp_ FROM JOB_TAB WHERE EXECUTED_BY = employeeId_;
    
      IF (temp_ IS NOT NULL) THEN
        rslt_ := 'Error: Employee ' || employeeId_ ||
                 ' is connected to a job(s) and hence cannot be deleted.';
      ELSE
        rslt_ := 'TRUE';
      END IF;
    END IF;
  
  END Check_Delete_;

  FUNCTION Is_Employee_Valid(employeeId_ IN VARCHAR2, regDate_ IN DATE)
    RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
    CURSOR valid_employee IS
      SELECT 1
        FROM EMPLOYEE_TAB s
       WHERE s.employee_id = employeeId_
         AND regDate_ BETWEEN s.valid_from AND s.valid_to;
  
  BEGIN
    IF (employeeId_ IS NULL OR regDate_ IS NULL) THEN
      rslt_ := 'FALSE';
      RETURN rslt_;
    END IF;
  
    IF (employeeId_ IS NOT NULL AND regDate_ IS NOT NULL) THEN
      OPEN valid_employee;
      FETCH valid_employee
        INTO dummy;
      IF (valid_employee%FOUND) THEN
        CLOSE valid_employee;
        rslt_ := 'TRUE';
      ELSE
        CLOSE valid_employee;
        rslt_ := 'FALSE';
      END IF;
      RETURN rslt_;
    END IF;
  
  END Is_Employee_Valid;

  FUNCTION Get_Employee_Company(employeeId_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    company_ EMPLOYEE_TAB.COMPANY_ID%type;
  BEGIN
    IF (employeeId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT COMPANY_ID
      INTO company_
      FROM EMPLOYEE_TAB
     WHERE EMPLOYEE_ID = employeeId_;
    RETURN company_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Employee_Company;

  FUNCTION Get_Emp_Address_Id(employeeId_ IN VARCHAR2) RETURN NUMBER IS
  
    add_no_ Employee_Tab.Emp_Address_Id%TYPE;
  BEGIN
    IF (employeeId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT emp_address_id
      INTO add_no_
      FROM Employee_Tab
     WHERE employee_id = employeeId_;
    RETURN add_no_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Emp_Address_Id;

end EMPLOYEE_API;
/
