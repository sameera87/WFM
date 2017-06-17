create or replace package DAY_TYPES_SCH_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN DAY_TYPES_SCH_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(dts_line_no_ IN NUMBER,
                 old_rec_     IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2);

  PROCEDURE Delete_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Day_Line(sch_id_       OUT VARCHAR2,
                         day_type_id_  OUT VARCHAR2,
                         day_no_       OUT NUMBER,
                         createdDate_  OUT DATE,
                         modifiedDate_ OUT DATE,
                         rowversion_   OUT DATE,
                         rslt_         OUT VARCHAR2,
                         dts_line_no_  IN NUMBER);

  PROCEDURE Get_NextLineId(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);
  
  PROCEDURE Check_Delete_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

end DAY_TYPES_SCH_API;
/
create or replace package body DAY_TYPES_SCH_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ DAY_TYPES_SCH_TAB%ROWTYPE;
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
                    rec_  IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'DTS_LINE_NO' THEN
        rec_.dts_line_no := TO_NUMBER(value_);
      ELSIF name_ = 'SCHEDULE_ID' THEN
        rec_.schedule_id := value_;
      ELSIF name_ = 'DAY_TYPE_ID' THEN
        rec_.day_type_id := value_;
      ELSIF name_ = 'DAY_NO' THEN
        rec_.day_no := TO_NUMBER(value_);
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
                    newrec_ IN OUT NOCOPY DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
  
    INSERT INTO DAY_TYPES_SCH_TAB
      (DTS_LINE_NO, SCHEDULE_ID, DAY_TYPE_ID, DAY_NO)
    VALUES
      (newrec_.dts_line_no,
       newrec_.schedule_id,
       newrec_.day_type_id,
       newrec_.day_no)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN DAY_TYPES_SCH_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('DTS_LINE_NO', to_char(rec_.dts_line_no), attr_);
    System_API.Add_To_Attr('SCHEDULE_ID', rec_.schedule_id, attr_);
    System_API.Add_To_Attr('DAY_TYPE_ID', rec_.day_type_id, attr_);
    System_API.Add_To_Attr('DAY_NO', to_char(rec_.day_no), attr_);
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
    rec_ DAY_TYPES_SCH_TAB%ROWTYPE;
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

  PROCEDURE Check_Update_(newrec_ IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ DAY_TYPES_SCH_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.dts_line_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion = oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    
      --check exist for referrenced columns
      day_type_api.Check_Exist_(newrec_.day_type_id, rslt_);
      IF (rslt_ = 'FALSE') THEN
        rslt_ := 'Error: Day Type does not exist.';
      END IF;
      schedule_api.Check_Exist_(newrec_.schedule_id, rslt_);
      IF (rslt_ = 'FALSE') THEN
        rslt_ := 'Error: Schedule does not exist.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(dts_line_no_ IN NUMBER,
                 old_rec_     IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                 rslt_        IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_line IS
      SELECT * FROM DAY_TYPES_SCH_TAB i WHERE i.dts_line_no = dts_line_no_;
  BEGIN
    Check_Exist_(dts_line_no_, check_flag);
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

  PROCEDURE Check_Exist_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_line IS
      SELECT 1 FROM DAY_TYPES_SCH_TAB i WHERE i.dts_line_no = dts_line_no_;
  
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

  PROCEDURE Delete_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(dts_line_no_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM DAY_TYPES_SCH_TAB where dts_line_no = dts_line_no_;
      rslt_ := 'Successfully deleted the day type line.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY DAY_TYPES_SCH_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
  
    UPDATE DAY_TYPES_SCH_TAB i
       SET ROW = newrec_
     WHERE i.dts_line_no = newrec_.dts_line_no;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Check_Insert_(newrec_ IN OUT DAY_TYPES_SCH_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.dts_line_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Schedule line already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.dts_line_no IS NULL THEN
      rslt_ := 'Error: Mandatory data missing.';
    END IF;
  
    --check exist for referrenced columns
    day_type_api.Check_Exist_(newrec_.day_type_id, rslt_);
    IF (rslt_ = 'FALSE') THEN
      rslt_ := 'Error: Day Type does not exist.';
    END IF;
    schedule_api.Check_Exist_(newrec_.schedule_id, rslt_);
    IF (rslt_ = 'FALSE') THEN
      rslt_ := 'Error: Schedule does not exist.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Get_Day_Line(sch_id_       OUT VARCHAR2,
                         day_type_id_  OUT VARCHAR2,
                         day_no_       OUT NUMBER,
                         createdDate_  OUT DATE,
                         modifiedDate_ OUT DATE,
                         rowversion_   OUT DATE,
                         rslt_         OUT VARCHAR2,
                         dts_line_no_  IN NUMBER) IS
  
    dummy number := 0;
  
  BEGIN
    IF (dts_line_no_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from DAY_TYPES_SCH_TAB i
     where i.dts_line_no = dts_line_no_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.schedule_id,
           i.day_type_id,
           i.day_no,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO sch_id_,
           day_type_id_,
           day_no_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM DAY_TYPES_SCH_TAB i
     WHERE i.dts_line_no = dts_line_no_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Day_Line;

  PROCEDURE Get_NextLineId(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := WFMS_DTS_LINE_NO_SEQ.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_NextLineId;

  PROCEDURE Check_Delete_(dts_line_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    rec_ DAY_TYPES_SCH_TAB%ROWTYPE;
  
    CURSOR get_used_cal IS
      SELECT *
        FROM SCH_PER_CALENDAR_TAB
       WHERE SCHEDULE_ID IN
             (SELECT schedule_id
                FROM DAY_TYPES_SCH_TAB
               WHERE DTS_LINE_NO = dts_line_no_);
  
  BEGIN
  
    Get_(dts_line_no_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      FOR cal_rec_ IN get_used_cal LOOP
        IF (work_time_calendar_api.Get_Cal_Status(cal_rec_.calendar_id) NOT IN (0)) THEN
          rslt_ := 'Error: Day line ' || rec_.dts_line_no ||
                   ' is used in one or more  schedules connected to calendars not in Planned status.';
          EXIT;
        END IF;
      END LOOP;
    END IF;
  
  END Check_Delete_;

end DAY_TYPES_SCH_API;
/
