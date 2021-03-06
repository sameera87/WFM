create or replace package JOB_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT JOB_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN JOB_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(jobNo_   IN NUMBER,
                 old_rec_ IN OUT JOB_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2);

  PROCEDURE Delete_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Job(jobDesc_      OUT VARCHAR2,
                    companyId_    OUT VARCHAR2,
                    customerId_   OUT VARCHAR2,
                    objectId_     OUT VARCHAR2,
                    reqStart_     OUT DATE,
                    reqFinish_    OUT DATE,
                    slaId_        OUT VARCHAR2,
                    slaReqStart_  OUT DATE,
                    slaReqFinish_ OUT DATE,
                    compReq_      OUT VARCHAR2,
                    executedBy_   OUT VARCHAR2,
                    plannedHrs_   OUT NUMBER,
                    planStart_    OUT DATE,
                    planFinish_   OUT DATE,
                    cost_         OUT NUMBER,
                    costAmt_      OUT NUMBER,
                    markup_       OUT NUMBER,
                    autoSch_      OUT NUMBER,
                    jobScheduled_ OUT NUMBER,
                    status_       OUT NUMBER,
                    serialNo_      OUT VARCHAR2,
                    fautType_     OUT VARCHAR2,
                    jobAddressId_ OUT NUMBER,
                    createdDate_  OUT DATE,
                    modifiedDate_ OUT DATE,
                    rowversion_   OUT DATE,
                    rslt_         OUT VARCHAR2,
                    jobNo_        IN NUMBER);
                    
   PROCEDURE Get_Next_Job_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);
   
   FUNCTION Get_Job_Status(jobNo_ IN NUMBER) RETURN NUMBER;

end JOB_API;
/
create or replace package body JOB_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ JOB_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the job.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT JOB_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'JOB_NO' THEN
        rec_.job_no := TO_NUMBER(value_);
      ELSIF name_ = 'JOB_DESC' THEN
        rec_.job_desc := value_;
      ELSIF name_ = 'COMPANY_ID' THEN
        rec_.company_id := value_;
      ELSIF name_ = 'CUSTOMER_ID' THEN
        rec_.customer_id := value_;
      ELSIF name_ = 'OBJECT_ID' THEN
        rec_.object_id := value_;
      ELSIF name_ = 'REQ_START' THEN
        rec_.req_start := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'REQ_FINISH' THEN
        rec_.Req_Finish := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'SLA_ID' THEN
        rec_.Sla_Id := value_;
      ELSIF name_ = 'SLA_REQ_START' THEN
        rec_.Sla_Req_Start := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'SLA_REQ_FINISH' THEN
        rec_.Sla_Req_Finish := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'COMPETANCY_REQ' THEN
        rec_.competancy_req := value_;
      ELSIF name_ = 'EXECUTED_BY' THEN
        rec_.Executed_By := value_;
      ELSIF name_ = 'PLANNED_HOURS' THEN
        rec_.Planned_Hours := TO_NUMBER(value_);
      ELSIF name_ = 'PLAN_START' THEN
        rec_.Plan_Start := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'PLAN_FINISH' THEN
        rec_.Plan_Finish := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'COST' THEN
        rec_.Cost := TO_NUMBER(value_);
      ELSIF name_ = 'COST_AMOUNT' THEN
        rec_.Cost_Amount := TO_NUMBER(value_);
      ELSIF name_ = 'MARKUP' THEN
        rec_.Markup := TO_NUMBER(value_);
      ELSIF name_ = 'AUTO_SCHEDULE' THEN
        rec_.Auto_Schedule := TO_NUMBER(value_);
      ELSIF name_ = 'JOB_SCHEDULED' THEN
        rec_.Job_Scheduled := TO_NUMBER(value_);
      ELSIF name_ = 'STATUS' THEN
        rec_.Status := TO_NUMBER(value_);
      ELSIF name_ = 'SERIAL_NO' THEN
        rec_.Serial_No := value_;
      ELSIF name_ = 'FAULT_TYPE' THEN
        rec_.Fault_Type := value_;
      ELSIF name_ = 'JOB_ADD_ID' THEN
        rec_.Job_Add_Id := TO_NUMBER(value_);
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

  PROCEDURE Check_Insert_(newrec_ IN OUT JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.Job_No, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Job ' || newrec_.Job_No || ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.job_no IS NULL THEN
      rslt_ := 'Error: Job No cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_job IS
      SELECT 1 FROM JOB_TAB i WHERE i.job_no = jobNo_;
  BEGIN
    OPEN chk_job;
    FETCH chk_job
      INTO tmp_;
    IF chk_job%FOUND THEN
      CLOSE chk_job;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_job;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO JOB_TAB
      (JOB_NO,
       JOB_DESC,
       COMPANY_ID,
       CUSTOMER_ID,
       OBJECT_ID,
       REQ_START,
       REQ_FINISH,
       SLA_ID,
       SLA_REQ_START,
       SLA_REQ_FINISH,
       COMPETANCY_REQ,
       EXECUTED_BY,
       PLANNED_HOURS,
       PLAN_START,
       PLAN_FINISH,
       COST,
       COST_AMOUNT,
       MARKUP,
       AUTO_SCHEDULE,
       JOB_SCHEDULED,
       STATUS,
       SERIAL_NO,
       FAULT_TYPE,
       JOB_ADD_ID)
    VALUES
      (newrec_.job_no,
       newrec_.job_desc,
       newrec_.company_id,
       newrec_.customer_id,
       newrec_.object_id,
       newrec_.req_start,
       newrec_.req_finish,
       newrec_.sla_id,
       newrec_.sla_req_start,
       newrec_.sla_req_finish,
       newrec_.competancy_req,
       newrec_.executed_by,
       newrec_.planned_hours,
       newrec_.plan_start,
       newrec_.plan_finish,
       newrec_.cost,
       newrec_.cost_amount,
       newrec_.markup,
       newrec_.auto_schedule,
       newrec_.job_scheduled,
       newrec_.status,
       newrec_.serial_no,
       newrec_.fault_type,
       newrec_.job_add_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN JOB_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('JOB_NO', to_char(rec_.job_no), attr_);
    System_API.Add_To_Attr('JOB_DESC', rec_.job_desc, attr_);
    System_API.Add_To_Attr('COMPANY_ID', rec_.company_id, attr_);
    System_API.Add_To_Attr('CUSTOMER_ID', rec_.customer_id, attr_);
    System_API.Add_To_Attr('OBJECT_ID', rec_.object_id, attr_);
    System_API.Add_To_Attr('REQ_START',
                           to_char(rec_.req_start, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('REQ_FINISH',
                           to_char(rec_.req_finish, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('SLA_ID', rec_.sla_id, attr_);
    System_API.Add_To_Attr('SLA_REQ_START',
                           to_char(rec_.sla_req_start, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('SLA_REQ_FINISH',
                           to_char(rec_.sla_req_finish, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('COMPETANCY_REQ', rec_.competancy_req, attr_);
    System_API.Add_To_Attr('EXECUTED_BY', rec_.executed_by, attr_);
    System_API.Add_To_Attr('PLANNED_HOURS',
                           to_char(rec_.planned_hours),
                           attr_);
    System_API.Add_To_Attr('PLAN_START',
                           to_char(rec_.plan_start, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('PLAN_FINISH',
                           to_char(rec_.plan_finish, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('COST', to_char(rec_.cost), attr_);
    System_API.Add_To_Attr('COST_AMOUNT', to_char(rec_.cost_amount), attr_);
    System_API.Add_To_Attr('MARKUP', to_char(rec_.markup), attr_);
    System_API.Add_To_Attr('AUTO_SCHEDULE',
                           to_char(rec_.auto_schedule),
                           attr_);
    System_API.Add_To_Attr('JOB_SCHEDULED',
                           to_char(rec_.job_scheduled),
                           attr_);
    System_API.Add_To_Attr('STATUS', to_char(rec_.status), attr_);
    System_API.Add_To_Attr('SERIAL_NO', rec_.serial_no, attr_);
    System_API.Add_To_Attr('FAULT_TYPE', rec_.fault_type, attr_);
    System_API.Add_To_Attr('JOB_ADD_ID', to_char(rec_.job_add_id), attr_);
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
    rec_ JOB_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the job.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ JOB_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.job_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(jobNo_   IN NUMBER,
                 old_rec_ IN OUT JOB_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
    CURSOR get_job IS
      SELECT * FROM JOB_TAB i WHERE i.job_no = jobNo_;
  BEGIN
    Check_Exist_(jobNo_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_job;
      FETCH get_job
        INTO old_rec_;
      CLOSE get_job;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the job ' || jobNo_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE JOB_TAB i SET ROW = newrec_ WHERE i.job_no = newrec_.job_no;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    rec_ JOB_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(jobNo_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(jobNo_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM JOB_TAB i where i.job_no = jobNo_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the job.';
        END IF;
      ELSE
        rslt_ := 'Error: Job has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the job.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Job(jobDesc_      OUT VARCHAR2,
                    companyId_    OUT VARCHAR2,
                    customerId_   OUT VARCHAR2,
                    objectId_     OUT VARCHAR2,
                    reqStart_     OUT DATE,
                    reqFinish_    OUT DATE,
                    slaId_        OUT VARCHAR2,
                    slaReqStart_  OUT DATE,
                    slaReqFinish_ OUT DATE,
                    compReq_      OUT VARCHAR2,
                    executedBy_   OUT VARCHAR2,
                    plannedHrs_   OUT NUMBER,
                    planStart_    OUT DATE,
                    planFinish_   OUT DATE,
                    cost_         OUT NUMBER,
                    costAmt_      OUT NUMBER,
                    markup_       OUT NUMBER,
                    autoSch_      OUT NUMBER,
                    jobScheduled_ OUT NUMBER,
                    status_       OUT NUMBER,
                    serialNo_      OUT VARCHAR2,
                    fautType_     OUT VARCHAR2,
                    jobAddressId_ OUT NUMBER,
                    createdDate_  OUT DATE,
                    modifiedDate_ OUT DATE,
                    rowversion_   OUT DATE,
                    rslt_         OUT VARCHAR2,
                    jobNo_        IN NUMBER) IS
  
    dummy number := 0;
  BEGIN
    IF (jobNo_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from JOB_TAB i where i.job_no = jobNo_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.job_desc,
           i.company_id,
           i.customer_id,
           i.object_id,
           i.req_start,
           i.req_finish,
           i.sla_id,
           i.sla_req_start,
           i.sla_req_finish,
           i.competancy_req,
           i.executed_by,
           i.planned_hours,
           i.plan_start,
           i.plan_finish,
           i.cost,
           i.cost_amount,
           i.markup,
           i.auto_schedule,
           i.job_scheduled,
           i.status,
           i.serial_no,
           i.fault_type,
           i.job_add_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO jobDesc_,
           companyId_,
           customerId_,
           objectId_,
           reqStart_,
           reqFinish_,
           slaId_,
           slaReqStart_,
           slaReqFinish_,
           compReq_,
           executedBy_,
           plannedHrs_,
           planStart_,
           planFinish_,
           cost_,
           costAmt_,
           markup_,
           autoSch_,
           jobScheduled_,
           status_,
           serialNo_,
           fautType_,
           jobAddressId_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM JOB_TAB i
     WHERE i.job_no = jobNo_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Job;
  
  PROCEDURE Get_Next_Job_No(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := WFMS_JOB_NO_SEQ.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Next_Job_No;
  
  FUNCTION Get_Job_Status(jobNo_ IN NUMBER) RETURN NUMBER IS
    
    temp_ Job_Tab.Status%TYPE;
  BEGIN
    IF (jobNo_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT s.Status
      INTO temp_
      FROM Job_Tab s
     WHERE s.job_no = jobNo_;
    RETURN temp_;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Job_Status;

end JOB_API;
/
