create or replace package REPORT_JOB_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT REPORT_JOB_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY REPORT_JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN REPORT_JOB_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(jobNo_   IN NUMBER,
                 old_rec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2);

  PROCEDURE Delete_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY REPORT_JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Reported_Job(actualStart_   OUT DATE,
                             actualFinish_  OUT DATE,
                             workDone_      OUT VARCHAR2,
                             reportedHours_ OUT NUMBER,
                             --workDoneImage_ OUT BLOB,
                             empId_         OUT VARCHAR2,
                             createdDate_   OUT DATE,
                             modifiedDate_  OUT DATE,
                             rowversion_    OUT DATE,
                             rslt_          OUT VARCHAR2,
                             jobNo_         IN NUMBER);

end REPORT_JOB_API;
/
create or replace package body REPORT_JOB_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ REPORT_JOB_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully reported the job.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT REPORT_JOB_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'JOB_NO' THEN
        rec_.job_no := TO_NUMBER(value_);
      ELSIF name_ = 'ACTUAL_START' THEN
        rec_.actual_start := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'ACTUAL_FINISH' THEN
        rec_.actual_finish := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'WORK_DONE' THEN
        rec_.work_done := value_;
      ELSIF name_ = 'REPORTED_HOURS' THEN
        rec_.reported_hours := TO_NUMBER(value_);
      /*ELSIF name_ = 'WORK_DONE_IMAGE' THEN
        rec_.work_done_image := TO_BLOB(value_);*/
      ELSIF name_ = 'EMPLOYEE_ID' THEN
        rec_.employee_id := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.job_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Job ' || newrec_.job_no ||
               ' has already been reported.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.job_no IS NULL THEN
      rslt_ := 'Error: Job no cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_reportJob IS
      SELECT 1 FROM REPORT_JOB_TAB i WHERE i.job_no = jobNo_;
  BEGIN
    OPEN chk_reportJob;
    FETCH chk_reportJob
      INTO tmp_;
    IF chk_reportJob%FOUND THEN
      CLOSE chk_reportJob;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_reportJob;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY REPORT_JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO REPORT_JOB_TAB
      (JOB_NO,
       ACTUAL_START,
       ACTUAL_FINISH,
       WORK_DONE,
       REPORTED_HOURS,
       --WORK_DONE_IMAGE,
       EMPLOYEE_ID)
    VALUES
      (newrec_.job_no,
       newrec_.actual_start,
       newrec_.actual_finish,
       newrec_.work_done,
       newrec_.reported_hours,
       --newrec_.work_done_image,
       newrec_.employee_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN REPORT_JOB_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('JOB_NO', to_char(rec_.job_no), attr_);
    System_API.Add_To_Attr('ACTUAL_START',
                           to_char(rec_.actual_start, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('ACTUAL_FINISH',
                           to_char(rec_.actual_finish, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('WORK_DONE', rec_.work_done, attr_);
    System_API.Add_To_Attr('REPORTED_HOURS',
                           to_char(rec_.reported_hours),
                           attr_);
    --System_API.Add_To_Attr('WORK_DONE_IMAGE', rec_.work_done_image, attr_);
    System_API.Add_To_Attr('EMPLOYEE_ID', rec_.employee_id, attr_);
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
    rec_ REPORT_JOB_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the reported job.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ REPORT_JOB_TAB%ROWTYPE;
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
                 old_rec_ IN OUT REPORT_JOB_TAB%ROWTYPE,
                 rslt_    IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
    CURSOR get_reportJob IS
      SELECT * FROM REPORT_JOB_TAB i WHERE i.job_no = jobNo_;
  BEGIN
    Check_Exist_(jobNo_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_reportJob;
      FETCH get_reportJob
        INTO old_rec_;
      CLOSE get_reportJob;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the reported job ' || jobNo_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY REPORT_JOB_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE REPORT_JOB_TAB i
       SET ROW = newrec_
     WHERE i.job_no = newrec_.job_no;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(jobNo_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    rec_ REPORT_JOB_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(jobNo_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(jobNo_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM REPORT_JOB_TAB i where i.job_no = jobNo_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the job reporting.';
        END IF;
      ELSE
        rslt_ := 'Error: Reported job has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the reported job.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Reported_Job(actualStart_   OUT DATE,
                             actualFinish_  OUT DATE,
                             workDone_      OUT VARCHAR2,
                             reportedHours_ OUT NUMBER,
                             --workDoneImage_ OUT BLOB,
                             empId_         OUT VARCHAR2,
                             createdDate_   OUT DATE,
                             modifiedDate_  OUT DATE,
                             rowversion_    OUT DATE,
                             rslt_          OUT VARCHAR2,
                             jobNo_         IN NUMBER) IS
    dummy number := 0;
  BEGIN
    IF (jobNo_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1 into dummy from REPORT_JOB_TAB i where i.job_no = jobNo_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.actual_start,
           i.actual_finish,
           i.work_done,
           i.reported_hours,
           --i.work_done_image,
           i.employee_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO actualStart_,
           actualFinish_,
           workDone_,
           reportedHours_,
           --workDoneImage_,
           empId_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM REPORT_JOB_TAB i
     WHERE i.job_no = jobNo_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Reported_Job;

end REPORT_JOB_API;
/
