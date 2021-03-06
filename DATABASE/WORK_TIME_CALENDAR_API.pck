create or replace package WORK_TIME_CALENDAR_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_  IN WORK_TIME_CALENDAR_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(calendarId_ IN VARCHAR2,
                 old_rec_    IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2);

  PROCEDURE Delete_(calendarId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(calendarId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Calendar(description_  OUT VARCHAR2,
                         validFrom_    OUT DATE,
                         validTo_      OUT DATE,
                         status_       OUT NUMBER,
                         createdDate_  OUT DATE,
                         modifiedDate_ OUT DATE,
                         rowversion_   OUT DATE,
                         rslt_         OUT VARCHAR2,
                         calendarId_   IN VARCHAR2);

  FUNCTION Get_Cal_Desc(calendarId_ IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION Get_Cal_Status(calendarId_ IN VARCHAR2) RETURN NUMBER;

  FUNCTION Is_Cal_Valid(calendarId_ IN VARCHAR2, regDate_ IN DATE)
    RETURN VARCHAR2;

  FUNCTION Is_Cal_Used(calendarId_ IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE Check_Delete_(calendarId_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Status_Change_Allowed(from_status_ IN NUMBER,
                                  to_status_1  OUT VARCHAR2,
                                  to_status_2  OUT VARCHAR2,
                                  rslt_        IN OUT VARCHAR2);

end WORK_TIME_CALENDAR_API;
/
create or replace package body WORK_TIME_CALENDAR_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ WORK_TIME_CALENDAR_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the calendar.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'CALENDAR_ID' THEN
        rec_.calendar_id := value_;
      ELSIF name_ = 'DESCRIPTION' THEN
        rec_.description := value_;
      ELSIF name_ = 'VALID_FROM' THEN
        rec_.valid_from := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'VALID_TO' THEN
        rec_.valid_to := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'STATUS' THEN
        rec_.status := TO_NUMBER(value_);
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

  PROCEDURE Check_Insert_(newrec_ IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.calendar_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Calendar ' || newrec_.calendar_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
  
    IF newrec_.calendar_id IS NULL THEN
      rslt_ := 'Error: Calendar ID cannot be Empty.';
    END IF;
  
    IF (newrec_.valid_from > newrec_.valid_to) THEN
      rslt_ := 'Error: Valid From date cannot be later then Valid To date';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(calendarId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_cal IS
      SELECT 1
        FROM WORK_TIME_CALENDAR_TAB i
       WHERE i.calendar_id = calendarId_;
  
  BEGIN
    OPEN chk_cal;
    FETCH chk_cal
      INTO tmp_;
    IF chk_cal%FOUND THEN
      CLOSE chk_cal;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_cal;
      rslt_ := 'FALSE';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO WORK_TIME_CALENDAR_TAB
      (CALENDAR_ID, DESCRIPTION, VALID_FROM, VALID_TO, STATUS)
    VALUES
      (newrec_.calendar_id,
       newrec_.description,
       newrec_.valid_from,
       newrec_.valid_to,
       newrec_.status)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_  IN WORK_TIME_CALENDAR_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('CALENDAR_ID', rec_.calendar_id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
    System_API.Add_To_Attr('VALID_FROM',
                           to_char(rec_.valid_from, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('VALID_TO',
                           to_char(rec_.valid_to, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('STATUS', rec_.status, attr_);
    System_API.Add_To_Attr('STATUS_CLIENT',
                           calendar_status_enum.Get_CAL_STATUS_Desc(rec_.status),
                           attr_);
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
    rec_ WORK_TIME_CALENDAR_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the calendar.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  
    oldrec_ WORK_TIME_CALENDAR_TAB%ROWTYPE;
  
  BEGIN
  
    Get_(newrec_.calendar_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF (oldrec_.status IN (1, 2, 3)) THEN
        rslt_ := 'Only calendars in Planned status can be updated.';
      END IF;
      IF newrec_.rowversion = oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF (Is_Cal_Used(newrec_.calendar_id) = 'TRUE') THEN
        rslt_ := 'Error: Calendar ' || newrec_.calendar_id ||
                 ' has been used hence cannot be updated.';
      END IF;
    
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(calendarId_ IN VARCHAR2,
                 old_rec_    IN OUT WORK_TIME_CALENDAR_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
  
    CURSOR get_cal IS
      SELECT *
        FROM WORK_TIME_CALENDAR_TAB i
       WHERE i.calendar_id = calendarId_;
  
  BEGIN
  
    Check_Exist_(calendarId_, check_flag);
  
    IF check_flag = 'TRUE' THEN
      OPEN get_cal;
      FETCH get_cal
        INTO old_rec_;
      CLOSE get_cal;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the calendar ' || calendarId_ || '.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY WORK_TIME_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  
  BEGIN
  
    newrec_.rowversion := sysdate;
  
    UPDATE WORK_TIME_CALENDAR_TAB i
       SET ROW = newrec_
     WHERE i.calendar_id = newrec_.calendar_id
       AND i.status IN (0);
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(calendarId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(calendarId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM WORK_TIME_CALENDAR_TAB i
       WHERE i.calendar_id = calendarId_;
      rslt_ := 'Successfully deleted the calendar.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Calendar(description_  OUT VARCHAR2,
                         validFrom_    OUT DATE,
                         validTo_      OUT DATE,
                         status_       OUT NUMBER,
                         createdDate_  OUT DATE,
                         modifiedDate_ OUT DATE,
                         rowversion_   OUT DATE,
                         rslt_         OUT VARCHAR2,
                         calendarId_   IN VARCHAR2) IS
    dummy number := 0;
  
  BEGIN
    IF (calendarId_ IS NULL) THEN
      RETURN;
    END IF;
  
    SELECT 1
      into dummy
      from WORK_TIME_CALENDAR_TAB i
     where i.calendar_id = calendarId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description,
           i.valid_from,
           i.valid_to,
           i.status,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO description_,
           validFrom_,
           validTo_,
           status_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM WORK_TIME_CALENDAR_TAB i
     WHERE i.calendar_id = calendarId_;
    rslt_ := 'TRUE';
  
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Calendar;

  FUNCTION Get_Cal_Desc(calendarId_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    temp_ WORK_TIME_CALENDAR_TAB.DESCRIPTION%TYPE;
  BEGIN
    IF (calendarId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.description
      INTO temp_
      FROM WORK_TIME_CALENDAR_TAB s
     WHERE s.calendar_id = calendarId_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Cal_Desc;

  FUNCTION Get_Cal_Status(calendarId_ IN VARCHAR2) RETURN NUMBER IS
  
    temp_ WORK_TIME_CALENDAR_TAB.STATUS%TYPE;
  BEGIN
    IF (calendarId_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.status
      INTO temp_
      FROM WORK_TIME_CALENDAR_TAB s
     WHERE s.calendar_id = calendarId_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Cal_Status;

  FUNCTION Is_Cal_Valid(calendarId_ IN VARCHAR2, regDate_ IN DATE)
    RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
    CURSOR valid_calendar IS
      SELECT 1
        FROM WORK_TIME_CALENDAR_TAB s
       WHERE s.calendar_id = calendarId_
         AND regDate_ BETWEEN s.valid_from AND s.valid_to;
  
  BEGIN
    IF (calendarId_ IS NULL OR regDate_ IS NULL) THEN
      rslt_ := 'FALSE';
      RETURN rslt_;
    END IF;
  
    IF (calendarId_ IS NOT NULL AND regDate_ IS NOT NULL) THEN
      OPEN valid_calendar;
      FETCH valid_calendar
        INTO dummy;
      IF (valid_calendar%FOUND) THEN
        CLOSE valid_calendar;
        rslt_ := 'TRUE';
      ELSE
        CLOSE valid_calendar;
        rslt_ := 'FALSE';
      END IF;
    RETURN rslt_;
    END IF;
  
  END Is_Cal_Valid;

  FUNCTION Is_Cal_Used(calendarId_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
  
    CURSOR cal_company IS
      SELECT 1 FROM COMPANY_TAB WHERE calender_id = calendarId_;
  
    CURSOR cal_sla IS
      SELECT 1 FROM CUST_SLA_TAB WHERE calendar_id = calendarId_;
  
  BEGIN
  
    OPEN cal_company;
    FETCH cal_company
      INTO dummy;
    CLOSE cal_company;
    IF (cal_company%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    OPEN cal_sla;
    FETCH cal_sla
      INTO dummy;
    CLOSE cal_sla;
    IF (cal_company%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Is_Cal_Used;

  PROCEDURE Check_Delete_(calendarId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    rec_ WORK_TIME_CALENDAR_TAB%ROWTYPE;
  
  BEGIN
  
    Get_(calendarId_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (Is_Cal_Used(rec_.calendar_id) = 'TRUE') THEN
        rslt_ := 'Error: Calendar ' || rec_.calendar_id ||
                 ' has been used hence cannot be updated.';
      END IF;
      IF (Get_Cal_Status(rec_.calendar_id) NOT IN (0)) THEN
        rslt_ := 'Error: Calendars not in Planned status cannot be updated.';
      END IF;
    END IF;
  
  END Check_Delete_;

  PROCEDURE Status_Change_Allowed(from_status_ IN NUMBER,
                                  to_status_1  OUT VARCHAR2,
                                  to_status_2  OUT VARCHAR2,
                                  rslt_        IN OUT VARCHAR2) IS
  BEGIN
    CASE from_status_
      WHEN 0 THEN
        to_status_1 := 'Active';
        to_status_2 := '';
        rslt_       := 'TRUE';
      WHEN 1 THEN
        to_status_1 := 'Inactive';
        to_status_2 := 'Expired';
        rslt_       := 'TRUE';
      WHEN 2 THEN
        to_status_1 := 'Active';
        to_status_2 := 'Expired';
        rslt_       := 'TRUE';
      WHEN 3 THEN
        to_status_1 := '';
        to_status_2 := '';
        rslt_       := 'TRUE';
      ELSE
        to_status_1 := '';
        to_status_2 := '';
        rslt_       := 'Error: Invalid Calendar status.';
    END CASE;
  
  END Status_Change_Allowed;

END WORK_TIME_CALENDAR_API;
/
