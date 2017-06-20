create or replace package SCH_PER_CALENDAR_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_  IN SCH_PER_CALENDAR_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(spc_line_no_ IN NUMBER,
                 old_rec_     IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2);

  PROCEDURE Delete_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Schedule_Line(sch_id_       OUT VARCHAR2,
                              start_date_   OUT DATE,
                              end_date_     OUT DATE,
                              cal_id_       OUT VARCHAR2,
                              createdDate_  OUT DATE,
                              modifiedDate_ OUT DATE,
                              rowversion_   OUT DATE,
                              rslt_         OUT VARCHAR2,
                              spc_line_no_  IN NUMBER);

  PROCEDURE Get_NextLineId(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);
  
  FUNCTION Overlapping_Schedule_Exist(cal_id_ IN VARCHAR2,day_ IN DATE) RETURN VARCHAR2;
  
  PROCEDURE Check_Delete_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);
  
  FUNCTION Get_Applied_Day_Type(cal_id_ IN VARCHAR2, date_ IN DATE) RETURN VARCHAR2;

end SCH_PER_CALENDAR_API;
/
create or replace package body SCH_PER_CALENDAR_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ SCH_PER_CALENDAR_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the schedule line.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'SPC_LINE_NO' THEN
        rec_.spc_line_no := TO_NUMBER(value_);
      ELSIF name_ = 'SCHEDULE_ID' THEN
        rec_.schedule_id := value_;
      ELSIF name_ = 'START_DATE' THEN
        rec_.start_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'END_DATE' THEN
        rec_.end_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'CALENDAR_ID' THEN
        rec_.calendar_id := value_;
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

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
  
    INSERT INTO SCH_PER_CALENDAR_TAB
      (SPC_LINE_NO, SCHEDULE_ID, START_DATE, END_DATE, CALENDAR_ID)
    VALUES
      (newrec_.spc_line_no,
       newrec_.schedule_id,
       newrec_.start_date,
       newrec_.end_date,
       newrec_.calendar_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_  IN SCH_PER_CALENDAR_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('SPC_LINE_NO', to_char(rec_.spc_line_no), attr_);
    System_API.Add_To_Attr('SCHEDULE_ID', rec_.schedule_id, attr_);
    System_API.Add_To_Attr('START_DATE',
                           to_char(rec_.start_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('END_DATE',
                           to_char(rec_.end_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('CALENDAR_ID', rec_.calendar_id, attr_);
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
    rec_ SCH_PER_CALENDAR_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the schedule line.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  
    oldrec_ SCH_PER_CALENDAR_TAB%ROWTYPE;
  
  BEGIN
    Get_(newrec_.spc_line_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion = oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF (work_time_calendar_api.Is_Cal_Used(newrec_.calendar_id) = 'TRUE') THEN
        rslt_ := 'Error: Calendar ' || newrec_.calendar_id ||
                 ' has been used hence cannot be updated.';
      END IF;
      IF (Overlapping_Schedule_Exist(newrec_.calendar_id,
                                     newrec_.start_date) = 'TRUE' OR
         Overlapping_Schedule_Exist(newrec_.calendar_id, newrec_.end_date) =
         'TRUE') THEN
        rslt_ := 'Error: Overlapping schedule lines exisit.';
      END IF;
      IF (work_time_calendar_api.Get_Cal_Status(newrec_.calendar_id) NOT IN (0)) THEN
        rslt_ := 'Error: Calendars not in Planned status cannot be updated.';
      END IF;
    
      --check exist for referrenced columns
      schedule_api.Check_Exist_(newrec_.schedule_id, rslt_);
      IF rslt_ = 'FALSE' THEN
        rslt_ := 'Error: Schedule does not exist.';
      END IF;
      work_time_calendar_api.Check_Exist_(newrec_.calendar_id, rslt_);
      IF rslt_ = 'FALSE' THEN
        rslt_ := 'Error: Calendar does not exist.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(spc_line_no_ IN NUMBER,
                 old_rec_     IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
  
    CURSOR get_line IS
      SELECT *
        FROM SCH_PER_CALENDAR_TAB i
       WHERE i.spc_line_no = spc_line_no_;
  
  BEGIN
  
    Check_Exist_(spc_line_no_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_line;
      FETCH get_line
        INTO old_rec_;
      CLOSE get_line;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the schedule line.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Check_Exist_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_line IS
      SELECT 1
        FROM SCH_PER_CALENDAR_TAB i
       WHERE i.spc_line_no = spc_line_no_;
  
  BEGIN
    OPEN chk_line;
    FETCH chk_line
      INTO tmp_;
    IF chk_line%FOUND THEN
      CLOSE chk_line;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_line;
      rslt_ := 'FALSE';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Delete_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(spc_line_no_, rslt_);
    IF rslt_ = 'TRUE' THEN
    
      DELETE FROM SCH_PER_CALENDAR_TAB WHERE spc_line_no = spc_line_no_;
      rslt_ := 'Successfully deleted the schedule line.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SCH_PER_CALENDAR_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
  
    newrec_.rowversion := sysdate;
  
    UPDATE SCH_PER_CALENDAR_TAB i
       SET ROW = newrec_
     WHERE i.spc_line_no = newrec_.spc_line_no;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Check_Insert_(newrec_ IN OUT SCH_PER_CALENDAR_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
  
    Check_Exist_(newrec_.spc_line_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Schedule line already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.spc_line_no IS NULL THEN
      rslt_ := 'Error: Mandatory data missing.';
    END IF;
    IF (Overlapping_Schedule_Exist(newrec_.calendar_id, newrec_.start_date) =
       'TRUE' OR
       Overlapping_Schedule_Exist(newrec_.calendar_id, newrec_.end_date) =
       'TRUE') THEN
      rslt_ := 'Error: Overlapping schedule lines exisit.';
    END IF;
    IF (work_time_calendar_api.Is_Cal_Used(newrec_.calendar_id) = 'TRUE') THEN
      rslt_ := 'Error: Calendar ' || newrec_.calendar_id ||
               ' has been used hence cannot be updated.';
    END IF;
    IF (work_time_calendar_api.Get_Cal_Status(newrec_.calendar_id) NOT IN (0)) THEN
      rslt_ := 'Error: Calendars not in Planned status cannot be updated.';
    END IF;
  
    --check exist for referrenced columns
    schedule_api.Check_Exist_(newrec_.schedule_id, rslt_);
    IF rslt_ = 'FALSE' THEN
      rslt_ := 'Error: Schedule does not exist.';
    END IF;
    work_time_calendar_api.Check_Exist_(newrec_.calendar_id, rslt_);
    IF rslt_ = 'FALSE' THEN
      rslt_ := 'Error: Calendar does not exist.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Get_Schedule_Line(sch_id_       OUT VARCHAR2,
                              start_date_   OUT DATE,
                              end_date_     OUT DATE,
                              cal_id_       OUT VARCHAR2,
                              createdDate_  OUT DATE,
                              modifiedDate_ OUT DATE,
                              rowversion_   OUT DATE,
                              rslt_         OUT VARCHAR2,
                              spc_line_no_  IN NUMBER) IS
  
    dummy number := 0;
  
  BEGIN
  
    IF (spc_line_no_ IS NULL) THEN
      RETURN;
    END IF;
  
    SELECT 1
      into dummy
      from SCH_PER_CALENDAR_TAB i
     where i.spc_line_no = spc_line_no_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.schedule_id,
           i.start_date,
           i.end_date,
           i.calendar_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO sch_id_,
           start_date_,
           end_date_,
           cal_id_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM SCH_PER_CALENDAR_TAB i
     WHERE i.spc_line_no = spc_line_no_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Schedule_Line;

  PROCEDURE Get_NextLineId(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := wfms_spc_line_no_seq.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_NextLineId;

  FUNCTION Overlapping_Schedule_Exist(cal_id_ IN VARCHAR2, day_ IN DATE)
    RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    CURSOR get_sch_lines IS
      SELECT * FROM SCH_PER_CALENDAR_TAB WHERE CALENDAR_ID = cal_id_;
  
  BEGIN
    FOR sch_rec_ IN get_sch_lines LOOP
      IF (day_ BETWEEN sch_rec_.start_date AND sch_rec_.end_date) THEN
        rslt_ := 'TRUE';
      END IF;
    END LOOP;
  
    RETURN rslt_;
  
  END overlapping_schedule_exist;

  PROCEDURE Check_Delete_(spc_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    rec_ SCH_PER_CALENDAR_TAB%ROWTYPE;
  
  BEGIN
  
    Get_(spc_line_no_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (work_time_calendar_api.Is_Cal_Used(rec_.calendar_id) = 'TRUE') THEN
        rslt_ := 'Error: Schedule line ' || rec_.spc_line_no ||
                 'is connected to Calendar ' || rec_.calendar_id ||
                 ' has been used hence cannot be deleted.';
      END IF;
      IF (work_time_calendar_api.Get_Cal_Status(rec_.calendar_id) NOT IN (0)) THEN
        rslt_ := 'Error: Calendars not in Planned status cannot be updated.';
      END IF;
    END IF;
  
  END Check_Delete_;

  --
  FUNCTION Get_Applied_Day_Type(cal_id_ IN VARCHAR2, date_ IN DATE)
    RETURN VARCHAR2 IS
  
    day_no_ NUMBER;
    day_type_ VARCHAR2(20);
    
    CURSOR get_day_type IS
      SELECT DAY_TYPE_ID
        FROM DAY_TYPES_SCH_TAB
       WHERE day_no = day_no_
         AND SCHEDULE_ID IN
             (SELECT schedule_id
                FROM SCH_PER_CALENDAR_TAB
               WHERE Calendar_Id = cal_id_
                 AND date_ BETWEEN START_DATE AND END_DATE);
  
  BEGIN
  
    SELECT to_number(to_char(sysdate, 'D')) INTO day_no_ FROM dual;
    
    OPEN get_day_type;
    FETCH get_day_type INTO day_type_;
    IF get_day_type%FOUND THEN
      CLOSE get_day_type;
      RETURN day_type_;
    ELSE
      CLOSE get_day_type;
      RETURN NULL;
    END IF;
  
  END Get_Applied_Day_Type;

end SCH_PER_CALENDAR_API;
/
