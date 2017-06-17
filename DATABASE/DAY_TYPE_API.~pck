create or replace package DAY_TYPE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT DAY_TYPE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);
  
  PROCEDURE Pack_(rec_ IN DAY_TYPE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);
  
  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Check_Update_(newrec_ IN OUT DAY_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);
  
  PROCEDURE Get_(dayTypeId_ IN VARCHAR2,
                 old_rec_   IN OUT DAY_TYPE_TAB%ROWTYPE,
                 rslt_      IN OUT VARCHAR2);
  
  PROCEDURE Delete_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);
  
  PROCEDURE Check_Insert_(newrec_ IN OUT DAY_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);
  
  PROCEDURE Check_Exist_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Get_Day_type(description_    OUT VARCHAR2,
                         workTimePerDay_ OUT NUMBER,
                         createdDate_    OUT DATE,
                         modifiedDate_   OUT DATE,
                         rowversion_     OUT DATE,
                         rslt_           OUT VARCHAR2,
                         dayTypeId_      IN VARCHAR2);
  
  FUNCTION Calc_Work_Time_Per_Day(dayTypeId_ IN VARCHAR2) RETURN NUMBER;
  
  PROCEDURE Check_Delete_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  FUNCTION Is_Day_Type_Used(dayTypeId_ IN VARCHAR2) RETURN VARCHAR2;

end DAY_TYPE_API;
/
create or replace package body DAY_TYPE_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ DAY_TYPE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the day type.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT DAY_TYPE_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'DAY_TYPE_ID' THEN
        rec_.day_type_id := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT DAY_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.day_type_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Day type ' || newrec_.day_type_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.day_type_id IS NULL THEN
      rslt_ := 'Error: Day Type ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_day IS
      SELECT 1 FROM DAY_TYPE_TAB i WHERE i.day_type_id = dayTypeId_;
  
  BEGIN
    OPEN chk_day;
    FETCH chk_day
      INTO tmp_;
    IF chk_day%FOUND THEN
      CLOSE chk_day;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_day;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO DAY_TYPE_TAB
      (DAY_TYPE_ID, DESCRIPTION)
    VALUES
      (newrec_.day_type_id, newrec_.description)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN DAY_TYPE_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('DAY_TYPE_ID', rec_.day_type_id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
    System_API.Add_To_Attr('WORK_TIME_PER_DAY',
                           to_char(rec_.work_time_per_day),
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
    rec_ DAY_TYPE_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the day type.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT DAY_TYPE_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ DAY_TYPE_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.day_type_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(dayTypeId_ IN VARCHAR2,
                 old_rec_   IN OUT DAY_TYPE_TAB%ROWTYPE,
                 rslt_      IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_dayType IS
      SELECT * FROM DAY_TYPE_TAB i WHERE i.day_type_id = dayTypeId_;
  BEGIN
    Check_Exist_(dayTypeId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_dayType;
      FETCH get_dayType
        INTO old_rec_;
      CLOSE get_dayType;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the day type ' || dayTypeId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPE_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE DAY_TYPE_TAB i
       SET ROW = newrec_
     WHERE i.day_type_id = newrec_.day_type_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(dayTypeId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM DAY_TYPE_TAB i where i.day_type_id = dayTypeId_;
      rslt_ := 'Successfully deleted the day type.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Day_type(description_    OUT VARCHAR2,
                         workTimePerDay_ OUT NUMBER,
                         createdDate_    OUT DATE,
                         modifiedDate_   OUT DATE,
                         rowversion_     OUT DATE,
                         rslt_           OUT VARCHAR2,
                         dayTypeId_      IN VARCHAR2) IS
  
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (dayTypeId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from DAY_TYPE_TAB i
     where i.day_type_id = dayTypeId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.Description,
           i.Work_Time_Per_Day,
           i.Created_Date,
           i.Modified_Date,
           i.Rowversion
      INTO description_,
           workTimePerDay_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM DAY_TYPE_TAB i
     WHERE i.day_type_id = dayTypeId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Day_type;

  FUNCTION Calc_Work_Time_Per_Day(dayTypeId_ IN VARCHAR2) RETURN NUMBER IS
  
    work_time_per_day_ NUMBER := 0;
    CURSOR get_work_lines IS
      SELECT * FROM WORK_TIME_LINE_TAB WHERE DAY_TYPE_ID = dayTypeId_;
  
  BEGIN
    FOR line_rec_ IN get_work_lines LOOP
      work_time_per_day_ := work_time_per_day_ + line_rec_.work_time_calc;
    END LOOP;
    RETURN work_time_per_day_;
  END Calc_Work_Time_Per_Day;

  FUNCTION Is_Day_Type_Used(dayTypeId_ IN VARCHAR2) RETURN VARCHAR2 is
  
    rslt_ VARCHAR2(5) := 'FALSE';
    dummy NUMBER := 0;
  
    CURSOR used_for_cal IS
      SELECT 1
        FROM SCH_PER_CALENDAR_TAB
       WHERE SCHEDULE_ID IN
             (SELECT schedule_id
                FROM DAY_TYPES_SCH_TAB
               WHERE day_type_id = dayTypeId_);
  
  BEGIN
  
    OPEN used_for_cal;
    FETCH used_for_cal
      INTO dummy;
    CLOSE used_for_cal;
    IF (used_for_cal%FOUND) THEN
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Is_Day_Type_Used;

  PROCEDURE Check_Delete_(dayTypeId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
  
    rec_ DAY_TYPE_TAB%ROWTYPE;
  
    CURSOR get_used_cal IS
      SELECT *
        FROM SCH_PER_CALENDAR_TAB
       WHERE SCHEDULE_ID IN
             (SELECT schedule_id
                FROM DAY_TYPES_SCH_TAB
               WHERE day_type_id = dayTypeId_);
  
  BEGIN
  
    Get_(dayTypeId_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      FOR cal_rec_ IN get_used_cal LOOP
        IF (work_time_calendar_api.Get_Cal_Status(cal_rec_.calendar_id) NOT IN (0)) THEN
          rslt_ := 'Error: Day Type ' || dayTypeId_ ||
                   ' is used in one or more  schedules connected to calendars not in Planned status.';
          EXIT;
        END IF;
      END LOOP;
    END IF;
  
  END Check_Delete_;

end DAY_TYPE_API;
/
