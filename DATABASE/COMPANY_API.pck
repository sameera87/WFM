create or replace package COMPANY_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COMPANY_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT COMPANY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPANY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN COMPANY_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT COMPANY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(companyid_ IN VARCHAR2,
                 old_rec_   IN OUT COMPANY_TAB%ROWTYPE,
                 rslt_      IN OUT VARCHAR2);

  PROCEDURE Delete_(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPANY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_Company(description_        OUT VARCHAR2,
                        phoneNo_            OUT VARCHAR2,
                        autoSchInt_         OUT NUMBER,
                        autoSchIntUnit_     OUT NUMBER,
                        calendarId_         OUT VARCHAR2,
                        addressId_          OUT NUMBER,
                        currencyCode_       OUT VARCHAR2,
                        defaultCompanyFlag_ OUT NUMBER,
                        autoSchedule_       OUT NUMBER,
                        createdDate_        OUT DATE,
                        modifiedDate_       OUT DATE,
                        rowversion_         OUT DATE,
                        rslt_               OUT VARCHAR2,
                        companyid_          IN VARCHAR2);
                        
   PROCEDURE Check_Delete_(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
   
   FUNCTION Has_Connected_Employees(companyid_ IN VARCHAR2) RETURN VARCHAR2;
   
   FUNCTION Has_Connected_Customers(companyid_ IN VARCHAR2) RETURN VARCHAR2;
   
   FUNCTION Has_Connected_Jobs(companyid_ IN VARCHAR2) RETURN VARCHAR2;
   
   FUNCTION Get_Auto_Sch_Interval_Secs(companyid_ IN VARCHAR2) RETURN NUMBER;
   
   FUNCTION Get_Default_Company RETURN VARCHAR2;
   
   FUNCTION Get_Address_Id(companyid_ IN VARCHAR2) RETURN NUMBER;
   
   FUNCTION Get_Calendar_Id(companyid_ IN VARCHAR2) RETURN VARCHAR2;   
   
   FUNCTION Check_Auto_Schedule(companyid_ IN VARCHAR2) RETURN VARCHAR2;
   
   FUNCTION Company_Curr_Code(companyid_ IN VARCHAR2) RETURN VARCHAR2;   

end COMPANY_API;
/
create or replace package body COMPANY_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ COMPANY_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Saved the Company.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COMPANY_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'COMPANY_ID' THEN
        rec_.company_id := value_;
      ELSIF name_ = 'DESCRIPTION' THEN
        rec_.Description := value_;
      ELSIF name_ = 'PHONE_NO' THEN
        rec_.phone_no := value_;
      ELSIF name_ = 'AUTO_SCH_INT' THEN
        rec_.auto_sch_int := TO_NUMBER(value_);
      ELSIF name_ = 'AUTO_SCH_INT_UNIT' THEN
        rec_.auto_sch_int_unit := TO_NUMBER(value_);
      ELSIF name_ = 'CALENDER_ID' THEN
        rec_.calender_id := value_;
      ELSIF name_ = 'ADDRESS_ID' THEN
        rec_.address_id := TO_NUMBER(value_);
      ELSIF name_ = 'CURRENCY_CODE' THEN
        rec_.currency_code := value_;
      ELSIF name_ = 'DEFAULT_COMPANY_FLAG' THEN
        rec_.default_company_flag := TO_NUMBER(value_);
      ELSIF name_ = 'AUTO_SCHEDULE' THEN
        rec_.Auto_Schedule := TO_NUMBER(value_);
      ELSIF name_ = 'CREATED_DATE' THEN
        rec_.created_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'MODIFIED_DATE' THEN
        rec_.modified_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'ROWVERSION' THEN
        rec_.rowversion := TO_DATE(value_, 'dd-MM-yyyy HH:MI:SS AM');
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

  PROCEDURE Check_Insert_(newrec_ IN OUT COMPANY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    dummy_ NUMBER := 0;
    count_ NUMBER := 0;
    CURSOR get_default_company IS
      SELECT 1 FROM COMPANY_TAB WHERE DEFAULT_COMPANY_FLAG = 1;
  
    CURSOR get_count IS
      SELECT count(*) FROM COMPANY_TAB;
  
  BEGIN
    Check_Exist(newrec_.company_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Company ' || newrec_.company_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.company_id IS NULL THEN
      rslt_ := 'Error: Company ID must have a value.';
    END IF;
    IF (newrec_.auto_sch_int <= 0) THEN
      rslt_ := 'Error: Auto Schedule Interval cannnot be 0 or less than 0.';
    END IF;
    IF (work_time_calendar_api.Is_Cal_Valid(newrec_.calender_id,
                                            newrec_.created_date) =
       'FALSE') THEN
      rslt_ := 'Error: Calendar is invalid for ' || newrec_.created_date;
    END IF;
    IF (work_time_calendar_api.Get_Cal_Status(newrec_.calender_id) NOT IN (1)) THEN
      rslt_ := 'Error: The Calendar ' || newrec_.calender_id ||
               'is not Active.';
    END IF;
  
    OPEN get_count;
    FETCH get_count
      INTO count_;
    CLOSE get_count;
  
    IF (newrec_.default_company_flag = 1 AND count_ != 0) THEN
      OPEN get_default_company;
      FETCH get_default_company
        INTO dummy_;
      IF get_default_company%FOUND THEN
        CLOSE get_default_company;
        rslt_ := 'Error: Only one default company may exist.';
      ELSE
        CLOSE get_default_company;
        rslt_ := 'TRUE';
      END IF;
    ELSIF (count_ = 0) THEN
      newrec_.default_company_flag := 1;
      rslt_                        := 'TRUE';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_comcpany IS
      SELECT 1 FROM COMPANY_TAB i WHERE i.company_id = companyid_;
  
  BEGIN
    OPEN chk_comcpany;
    FETCH chk_comcpany
      INTO tmp_;
    IF chk_comcpany%FOUND THEN
      CLOSE chk_comcpany;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_comcpany;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPANY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO COMPANY_TAB
      (COMPANY_ID,
       DESCRIPTION,
       PHONE_NO,
       AUTO_SCH_INT,
       AUTO_SCH_INT_UNIT,
       CALENDER_ID,
       ADDRESS_ID,
       CURRENCY_CODE,
       DEFAULT_COMPANY_FLAG,
       AUTO_SCHEDULE)
    VALUES
      (newrec_.company_id,
       newrec_.description,
       newrec_.phone_no,
       newrec_.auto_sch_int,
       newrec_.auto_sch_int_unit,
       newrec_.Calender_Id,
       newrec_.Address_Id,
       newrec_.Currency_Code,
       newrec_.Default_Company_Flag,
       newrec_.auto_schedule)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN COMPANY_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('COMPANY_ID', rec_.Company_Id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.Description, attr_);
    System_API.Add_To_Attr('PHONE_MO', rec_.phone_no, attr_);
    System_API.Add_To_Attr('AUTO_SCH_INT',
                           to_char(rec_.auto_sch_int),
                           attr_);
    System_API.Add_To_Attr('AUTO_SCH_INT_UNIT',
                           to_char(rec_.auto_sch_int_unit),
                           attr_);
    System_API.Add_To_Attr('CALENDER_ID', rec_.calender_id, attr_);
    System_API.Add_To_Attr('ADDRESS_ID', to_char(rec_.address_id), attr_);
    System_API.Add_To_Attr('CURRENCY_CODE', rec_.currency_code, attr_);
    System_API.Add_To_Attr('DEFAULT_COMPANY_FLAG',
                           to_char(rec_.default_company_flag),
                           attr_);
    System_API.Add_To_Attr('AUTO_SCHEDULE',
                           to_char(rec_.auto_schedule),
                           attr_);
    System_API.Add_To_Attr('CREATED_DATE',
                           to_char(rec_.created_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('MODIFIED_DATE',
                           to_char(rec_.modified_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('ROWVERSION',
                           to_char(rec_.rowversion, 'dd-MM-yyyy'),
                           attr_);
  END Pack_;

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ COMPANY_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the Company.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT COMPANY_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    dummy_ NUMBER := 0;
    count_ NUMBER := 0;
  
    CURSOR get_default_company IS
      SELECT 1 FROM COMPANY_TAB WHERE DEFAULT_COMPANY_FLAG = 1;
  
    CURSOR get_count IS
      SELECT count(*) FROM COMPANY_TAB;
  
    oldrec_ COMPANY_TAB%ROWTYPE;
  
  BEGIN
  
    OPEN get_count;
    FETCH get_count
      INTO count_;
    CLOSE get_count;
  
    Get_(newrec_.company_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF (newrec_.auto_sch_int <= 0) THEN
        rslt_ := 'Error: Auto Schedule Interval cannnot be 0 or less than 0.';
      END IF;
      IF (work_time_calendar_api.Is_Cal_Valid(newrec_.calender_id,
                                              newrec_.created_date) =
         'FALSE') THEN
        rslt_ := 'Error: Calendar is invalid for ' || newrec_.created_date;
      END IF;
      IF (work_time_calendar_api.Get_Cal_Status(newrec_.calender_id) NOT IN (1)) THEN
        rslt_ := 'Error: The Calendar ' || newrec_.calender_id ||
                 'is not Active.';
      END IF;
      IF (newrec_.default_company_flag = 1 AND count_ != 1) THEN
        OPEN get_default_company;
        FETCH get_default_company
          INTO dummy_;
        IF get_default_company%FOUND THEN
          CLOSE get_default_company;
          rslt_ := 'Error: Only one default company may exist.';
        ELSE
          CLOSE get_default_company;
          rslt_ := 'TRUE';
        END IF;
      ELSIF (count_ = 1 AND newrec_.default_company_flag = 0) THEN
        newrec_.default_company_flag := 1;
        rslt_                        := 'TRUE';
      END IF;
    
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(companyid_ IN VARCHAR2,
                 old_rec_   IN OUT COMPANY_TAB%ROWTYPE,
                 rslt_      IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_company IS
      SELECT * FROM COMPANY_TAB i WHERE i.Company_Id = companyid_;
  BEGIN
    Check_Exist(companyid_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_company;
      FETCH get_company
        INTO old_rec_;
      CLOSE get_company;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the COMPANY ' || companyid_;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Delete_(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(companyid_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM COMPANY_TAB where company_id = companyid_;
      rslt_ := 'Successfully deleted the company.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPANY_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE COMPANY_TAB i
       SET ROW = newrec_
     WHERE i.company_id = newrec_.company_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Get_Company(description_        OUT VARCHAR2,
                        phoneNo_            OUT VARCHAR2,
                        autoSchInt_         OUT NUMBER,
                        autoSchIntUnit_     OUT NUMBER,
                        calendarId_         OUT VARCHAR2,
                        addressId_          OUT NUMBER,
                        currencyCode_       OUT VARCHAR2,
                        defaultCompanyFlag_ OUT NUMBER,
                        autoSchedule_       OUT NUMBER,
                        createdDate_        OUT DATE,
                        modifiedDate_       OUT DATE,
                        rowversion_         OUT DATE,
                        rslt_               OUT VARCHAR2,
                        companyid_          IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (companyid_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from COMPANY_TAB i where i.company_id = companyid_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description,
           i.phone_no,
           i.auto_sch_int,
           i.auto_sch_int_unit,
           i.calender_id,
           i.address_id,
           i.currency_code,
           i.default_company_flag,
           i.auto_schedule,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO description_,
           phoneNo_,
           autoSchInt_,
           autoSchIntUnit_,
           calendarId_,
           addressId_,
           currencyCode_,
           defaultCompanyFlag_,
           autoSchedule_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM COMPANY_TAB i
     WHERE i.Company_Id = companyid_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Company;

  PROCEDURE Check_Delete_(companyid_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    old_rec_ COMPANY_TAB%ROWTYPE;
  
  BEGIN
    Get_(companyid_, old_rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (Has_Connected_Employees(companyid_) = 'TRUE') THEN
        rslt_ := 'Error: The company has employees connected and hence may not be deleted';
      END IF;
      IF (Has_Connected_Customers(companyid_) = 'TRUE') THEN
        rslt_ := 'Error: The company has customers connected and hence may not be deleted.';
      END IF;
      IF (Has_Connected_Jobs(companyid_) = 'TRUE') THEN
        rslt_ := 'Error: The company has jobs connected and hence cannot be deleted.';
      END IF;
      IF (old_rec_.default_company_flag = 1) THEN
        rslt_ := 'Error: Default company cannot be deleted.';
      END IF;
    END IF;
  
  END Check_Delete_;

  FUNCTION Has_Connected_Employees(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
  
    CURSOR get_employees IS
      SELECT 1 FROM EMPLOYEE_TAB WHERE COMPANY_ID = companyid_;
  
  BEGIN
  
    OPEN get_employees;
    FETCH get_employees
      INTO dummy;
    CLOSE get_employees;
    IF (get_employees%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Has_Connected_Employees;

  FUNCTION Has_Connected_Customers(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
  
    CURSOR get_customer IS
      SELECT 1 FROM CUSTOMER_TAB WHERE COMPANY_ID = companyid_;
  
  BEGIN
  
    OPEN get_customer;
    FETCH get_customer
      INTO dummy;
    CLOSE get_customer;
    IF (get_customer%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Has_Connected_Customers;

  FUNCTION Has_Connected_Jobs(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
  
    CURSOR get_jobs IS
      SELECT 1 FROM JOB_TAB WHERE COMPANY_ID = companyid_;
  
  BEGIN
  
    OPEN get_jobs;
    FETCH get_jobs
      INTO dummy;
    CLOSE get_jobs;
    IF (get_jobs%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Has_Connected_Jobs;

  FUNCTION Get_Auto_Sch_Interval_Secs(companyid_ IN VARCHAR2) RETURN NUMBER IS
  
    value_   NUMBER := 0;
    rslt_    VARCHAR2(1000) := '';
    old_rec_ COMPANY_TAB%ROWTYPE;
  
  BEGIN
    Get_(companyid_, old_rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      CASE old_rec_.auto_sch_int_unit
        WHEN 0 THEN
          value_ := old_rec_.auto_sch_int;
        WHEN 1 THEN
          value_ := old_rec_.auto_sch_int * 60;
        WHEN 2 THEN
          value_ := old_rec_.auto_sch_int * 60 * 60;
        WHEN 3 THEN
          value_ := old_rec_.auto_sch_int * 60 * 60 * 24;
        ELSE
          value_ := 0;
      END CASE;
    END IF;
  
    RETURN value_;
  
  END Get_Auto_Sch_Interval_Secs;

  FUNCTION Get_Default_Company RETURN VARCHAR2 IS
  
    default_ VARCHAR2(100) := '';
    CURSOR Get_Company IS
      SELECT company_id FROM COMPANY_TAB WHERE DEFAULT_COMPANY_FLAG = 1;
  
  BEGIN
  
    FOR company_rec_ IN Get_Company LOOP
      default_ := company_rec_.company_id;
    END LOOP;
    RETURN default_;
  
  END Get_Default_Company;

  FUNCTION Get_Address_Id(companyid_ IN VARCHAR2) RETURN NUMBER IS
  
    add_no_ COMPANY_TAB.ADDRESS_ID%TYPE;
  BEGIN
    IF (companyid_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT ADDRESS_ID
      INTO add_no_
      FROM COMPANY_TAB
     WHERE COMPANY_ID = companyid_;
    RETURN add_no_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Address_Id;

  FUNCTION Get_Calendar_Id(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    cal_id_ COMPANY_TAB.CALENDER_ID%type;
  BEGIN
    IF (companyid_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT calender_id
      INTO cal_id_
      FROM COMPANY_TAB t
     WHERE COMPANY_ID = companyid_;
    RETURN cal_id_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Calendar_Id;

  FUNCTION Check_Auto_Schedule(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    dummy NUMBER := 0;
  
    CURSOR get_auto_sch IS
      SELECT 1
        FROM COMPANY_TAB t
       WHERE Company_Id = companyid_
         AND auto_schedule = 1;
  BEGIN
  
    OPEN get_auto_sch;
    FETCH get_auto_sch
      INTO dummy;
    IF (get_auto_sch%FOUND) THEN
      CLOSE get_auto_sch;
      RETURN 'TRUE';
    ELSE
      CLOSE get_auto_sch;
      RETURN 'FALSE';
    END IF;
  
  END Check_Auto_Schedule;

  FUNCTION Company_Curr_Code(companyid_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    curr_code_ COMPANY_TAB.CURRENCY_CODE%type;
  BEGIN
    IF (companyid_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT CURRENCY_CODE
      INTO curr_code_
      FROM COMPANY_TAB t
     WHERE COMPANY_ID = companyid_;
    RETURN curr_code_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Company_Curr_Code;

END COMPANY_API;
/
