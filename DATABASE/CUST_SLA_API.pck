create or replace package CUST_SLA_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_SLA_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_SLA_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN CUST_SLA_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(slaId_   IN VARCHAR2,
                 old_rec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2);

  PROCEDURE Delete_(slaId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_SLA_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(slaId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_SLA(slaDesc_      OUT VARCHAR2,
                    responseH_    OUT NUMBER,
                    responseM_    OUT NUMBER,
                    resolutionH_  OUT NUMBER,
                    resolutionM_  OUT NUMBER,
                    cutOffH_      OUT NUMBER,
                    cutOffM_      OUT NUMBER,
                    calendarId_   OUT VARCHAR2,
                    customerId_   OUT VARCHAR2,
                    defaultSla_   OUT NUMBER,
                    createdDate_  OUT DATE,
                    modifiedDate_ OUT DATE,
                    rowversion_   OUT DATE,
                    rslt_         OUT VARCHAR2,
                    slaId_        IN VARCHAR2);

end CUST_SLA_API;
/
create or replace package body CUST_SLA_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_SLA_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the service level agreement.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUST_SLA_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'SLA_ID' THEN
        rec_.sla_id := value_;
      ELSIF name_ = 'SLA_DESC' THEN
        rec_.sla_desc := value_;
      ELSIF name_ = 'RESPONSE_TIME_H' THEN
        rec_.response_time_h := TO_NUMBER(value_);
      ELSIF name_ = 'RESPONSE_TIME_M' THEN
        rec_.response_time_m := TO_NUMBER(value_);
      ELSIF name_ = 'RESOLUTION_TIME_H' THEN
        rec_.resolution_time_h := TO_NUMBER(value_);
      ELSIF name_ = 'RESOLUTION_TIME_M' THEN
        rec_.resolution_time_m := TO_NUMBER(value_);
      ELSIF name_ = 'CUT_OFF_TIME_H' THEN
        rec_.cut_off_time_h := TO_NUMBER(value_);
      ELSIF name_ = 'CUT_OFF_TIME_M' THEN
        rec_.cut_off_time_m := TO_NUMBER(value_);
      ELSIF name_ = 'CALENDAR_ID' THEN
        rec_.calendar_id := value_;
      ELSIF name_ = 'CUSTOMER_ID' THEN
        rec_.customer_id := value_;
      ELSIF name_ = 'DEFAULT_SLA' THEN
        rec_.default_sla := TO_NUMBER(value_);
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

  PROCEDURE Check_Insert_(newrec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.sla_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Service level agreement ' || newrec_.sla_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.sla_id IS NULL THEN
      rslt_ := 'Error: SLA ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(slaId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_sla IS
      SELECT 1 FROM CUST_SLA_TAB i WHERE i.sla_id = slaId_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_sla;
    FETCH chk_sla
      INTO tmp_;
    IF chk_sla%FOUND THEN
      CLOSE chk_sla;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_sla;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_SLA_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO CUST_SLA_TAB
      (SLA_ID,
       SLA_DESC,
       RESPONSE_TIME_H,
       RESPONSE_TIME_M,
       RESOLUTION_TIME_H,
       RESOLUTION_TIME_M,
       CUT_OFF_TIME_H,
       CUT_OFF_TIME_M,
       CALENDAR_ID,
       CUSTOMER_ID,
       DEFAULT_SLA)
    VALUES
      (newrec_.sla_id,
       newrec_.sla_desc,
       newrec_.response_time_h,
       newrec_.response_time_m,
       newrec_.resolution_time_h,
       newrec_.resolution_time_m,
       newrec_.cut_off_time_h,
       newrec_.cut_off_time_m,
       newrec_.calendar_id,
       newrec_.customer_id,
       newrec_.default_sla)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN CUST_SLA_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('SLA_ID', rec_.sla_id, attr_);
    System_API.Add_To_Attr('SLA_DESC', rec_.sla_desc, attr_);
    System_API.Add_To_Attr('RESPONSE_TIME_H',
                           to_char(rec_.response_time_h),
                           attr_);
    System_API.Add_To_Attr('RESPONSE_TIME_M',
                           to_char(rec_.response_time_m),
                           attr_);
    System_API.Add_To_Attr('RESOLUTION_TIME_H',
                           to_char(rec_.resolution_time_h),
                           attr_);
    System_API.Add_To_Attr('RESOLUTION_TIME_M',
                           to_char(rec_.resolution_time_m),
                           attr_);
    System_API.Add_To_Attr('CUT_OFF_TIME_H',
                           to_char(rec_.cut_off_time_h),
                           attr_);
    System_API.Add_To_Attr('CUT_OFF_TIME_M',
                           to_char(rec_.cut_off_time_m),
                           attr_);
    System_API.Add_To_Attr('CALENDAR_ID', rec_.calendar_id, attr_);
    System_API.Add_To_Attr('CUSTOMER_ID', rec_.customer_id, attr_);
    System_API.Add_To_Attr('DEFAULT_SLA', to_char(rec_.default_sla), attr_);
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
    rec_ CUST_SLA_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the service level agreement.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ CUST_SLA_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.sla_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(slaId_   IN VARCHAR2,
                 old_rec_ IN OUT CUST_SLA_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_sla IS
      SELECT * FROM CUST_SLA_TAB i WHERE i.sla_id = slaId_;
  BEGIN
    Check_Exist_(slaId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_sla;
      FETCH get_sla
        INTO old_rec_;
      CLOSE get_sla;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the service level agreement ' || slaId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUST_SLA_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE CUST_SLA_TAB i
       SET ROW = newrec_
     WHERE i.sla_id = newrec_.sla_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(slaId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUST_SLA_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(slaId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(slaId_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM CUST_SLA_TAB i where i.sla_id = slaId_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the service level agreement.';
        END IF;
      ELSE
        rslt_ := 'Error: Service level agreement has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the service level agreement.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_SLA(slaDesc_      OUT VARCHAR2,
                    responseH_    OUT NUMBER,
                    responseM_    OUT NUMBER,
                    resolutionH_  OUT NUMBER,
                    resolutionM_  OUT NUMBER,
                    cutOffH_      OUT NUMBER,
                    cutOffM_      OUT NUMBER,
                    calendarId_   OUT VARCHAR2,
                    customerId_   OUT VARCHAR2,
                    defaultSla_   OUT NUMBER,
                    createdDate_  OUT DATE,
                    modifiedDate_ OUT DATE,
                    rowversion_   OUT DATE,
                    rslt_         OUT VARCHAR2,
                    slaId_        IN VARCHAR2) IS
  
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (slaId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from CUST_SLA_TAB i where i.sla_id = slaId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.sla_desc,
           i.response_time_h,
           i.response_time_m,
           i.resolution_time_h,
           i.resolution_time_m,
           i.cut_off_time_h,
           i.cut_off_time_m,
           i.calendar_id,
           i.customer_id,
           i.default_sla,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO slaDesc_,
           responseH_,
           responseM_,
           resolutionH_,
           resolutionM_,
           cutOffH_,
           cutOffM_,
           calendarId_,
           customerId_,
           defaultSla_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM CUST_SLA_TAB i
     WHERE i.sla_id = slaId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_SLA;

end CUST_SLA_API;
/
