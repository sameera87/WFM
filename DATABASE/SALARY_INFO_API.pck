create or replace package SALARY_INFO_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SALARY_INFO_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN SALARY_INFO_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT SALARY_INFO_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(salaryId_ IN NUMBER,
                 empId_    IN VARCHAR2,
                 old_rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2);

  PROCEDURE Delete_(salaryId_ IN NUMBER,
                    empId_    IN VARCHAR2,
                    rslt_     IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SALARY_INFO_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT SALARY_INFO_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(empId_    IN VARCHAR2,
                         salaryId_ IN NUMBER,
                         rslt_     IN OUT VARCHAR2);

  PROCEDURE Get_Country_Code(value1_       OUT NUMBER,
                             value2_       OUT NUMBER,
                             deductions_   OUT NUMBER,
                             allowances_   OUT NUMBER,
                             empId_        OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             salaryId_     IN NUMBER);

end SALARY_INFO_API;
/
create or replace package body SALARY_INFO_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ SALARY_INFO_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the salary info.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'SALARY_ID' THEN
        rec_.salary_id := TO_NUMBER(value_);
      ELSIF name_ = 'VALUE1' THEN
        rec_.value1 := TO_NUMBER(value_);
      ELSIF name_ = 'VALUE2' THEN
        rec_.value2 := TO_NUMBER(value_);
      ELSIF name_ = 'DEDUCTIONS' THEN
        rec_.deductions := TO_NUMBER(value_);
      ELSIF name_ = 'ALLOWANCES' THEN
        rec_.allowances := TO_NUMBER(value_);
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

  PROCEDURE Check_Insert_(newrec_ IN OUT SALARY_INFO_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.employee_id, newrec_.salary_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Salary infor for employee ' || newrec_.employee_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.employee_id IS NULL THEN
      rslt_ := 'Error: Employee ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(empId_    IN VARCHAR2,
                         salaryId_ IN NUMBER,
                         rslt_     IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_empSalaryInfo IS
      SELECT 1
        FROM SALARY_INFO_TAB i
       WHERE i.employee_id = empId_
         AND i.salary_id = salaryId_;
  BEGIN
    OPEN chk_empSalaryInfo;
    FETCH chk_empSalaryInfo
      INTO tmp_;
    IF chk_empSalaryInfo%FOUND THEN
      CLOSE chk_empSalaryInfo;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_empSalaryInfo;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SALARY_INFO_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO SALARY_INFO_TAB
      (SALARY_ID, VALUE1, VALUE2, DEDUCTIONS, ALLOWANCES, EMPLOYEE_ID)
    VALUES
      (newrec_.salary_id,
       newrec_.value1,
       newrec_.value2,
       newrec_.deductions,
       newrec_.allowances,
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

  PROCEDURE Pack_(rec_ IN SALARY_INFO_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('SALARY_ID', to_char(rec_.salary_id), attr_);
    System_API.Add_To_Attr('VALUE1', to_char(rec_.value1), attr_);
    System_API.Add_To_Attr('VALUE2', to_char(rec_.value2), attr_);
    System_API.Add_To_Attr('DEDUCTIONS', to_char(rec_.deductions), attr_);
    System_API.Add_To_Attr('ALLOWANCES', to_char(rec_.allowances), attr_);
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
    rec_ SALARY_INFO_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the employee salary info.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT SALARY_INFO_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ SALARY_INFO_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.salary_id, newrec_.employee_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(salaryId_ IN NUMBER,
                 empId_    IN VARCHAR2,
                 old_rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
    CURSOR get_empSalaryInfo IS
      SELECT *
        FROM SALARY_INFO_TAB i
       WHERE i.salary_id = salaryId_
         AND i.employee_id = empId_;
  BEGIN
    Check_Exist_(empId_, salaryId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_empSalaryInfo;
      FETCH get_empSalaryInfo
        INTO old_rec_;
      CLOSE get_empSalaryInfo;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the salary info of employee ' || empId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SALARY_INFO_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE SALARY_INFO_TAB i
       SET ROW = newrec_
     WHERE i.salary_id = newrec_.salary_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(salaryId_ IN NUMBER,
                    empId_    IN VARCHAR2,
                    rslt_     IN OUT VARCHAR2) IS
    rec_ SALARY_INFO_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(empId_, salaryId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(salaryId_, empId_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM SALARY_INFO_TAB i where i.salary_id = salaryId_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the salary info of employee ' ||
                   empId_ || '.';
        END IF;
      ELSE
        rslt_ := 'Error: salary info of employee ' || empId_ ||
                 'has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the salary info of the employee ' ||
               empId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Country_Code(value1_       OUT NUMBER,
                             value2_       OUT NUMBER,
                             deductions_   OUT NUMBER,
                             allowances_   OUT NUMBER,
                             empId_        OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             salaryId_     IN NUMBER) IS
  
    dummy number := 0;
  BEGIN
    IF (salaryId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from SALARY_INFO_TAB i
     where i.salary_id = salaryId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.value1,
           i.value2,
           i.deductions,
           i.allowances,
           i.employee_id,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO value1_,
           value2_,
           deductions_,
           allowances_,
           empId_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM SALARY_INFO_TAB i
     WHERE i.salary_id = salaryId_;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Country_Code;

end SALARY_INFO_API;
/
