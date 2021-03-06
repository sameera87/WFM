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
                 old_rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2);

  PROCEDURE Delete_(salaryId_ IN NUMBER,
                    rslt_     IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY SALARY_INFO_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT SALARY_INFO_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(salaryId_ IN NUMBER,
                         rslt_     IN OUT VARCHAR2);

  PROCEDURE Get_Salary_Info(value1_       OUT NUMBER,
                             value2_       OUT NUMBER,
                             deductions_   OUT NUMBER,
                             allowances_   OUT NUMBER,
                             empId_        OUT VARCHAR2,
                             createdDate_  OUT DATE,
                             modifiedDate_ OUT DATE,
                             rowversion_   OUT DATE,
                             rslt_         OUT VARCHAR2,
                             salaryId_     IN NUMBER);
                             
  PROCEDURE Check_Delete_(salaryId_ IN NUMBER, rslt_ IN OUT VARCHAR2);
  
  PROCEDURE Get_Next_Line_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);
  
  FUNCTION Get_Emp_Id(salary_id_ IN NUMBER) RETURN VARCHAR2;
  
  FUNCTION Check_Emp_Sal_Info_Exist(emp_id_ IN VARCHAR2) RETURN VARCHAR2;
  
  FUNCTION Get_Value1(emp_id_ IN VARCHAR2) RETURN NUMBER;
  
  FUNCTION Get_Value2(emp_id_ IN VARCHAR2) RETURN NUMBER;
  
  FUNCTION Calc_Epf(emp_id_ IN VARCHAR2, b_sal_ IN NUMBER) RETURN NUMBER;
  
  FUNCTION Get_Deductions(emp_id_ IN VARCHAR2) RETURN NUMBER;
  
  FUNCTION Get_Allowances(emp_id_ IN VARCHAR2) RETURN NUMBER;
  
  FUNCTION Calc_Net_Salary(emp_id_ IN VARCHAR2) RETURN NUMBER;

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
    Check_Exist_(newrec_.salary_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Salary info for employee ' || newrec_.employee_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.Salary_Id IS NULL THEN
      rslt_ := 'Error: Salary ID cannot be Empty.';
    END IF;
    IF newrec_.employee_id IS NULL THEN
      rslt_ := 'Error: Employee ID cannot be Empty.';
    END IF;
    IF (Check_Emp_Sal_Info_Exist(newrec_.employee_id) = 'TRUE') THEN
      rslt_ := 'Error: Salary information for Employee ' ||
               newrec_.employee_id || ' has already been defined.';
    END IF;
    IF (newrec_.employee_id IS NOT NULL AND (employee_api.Get_Employee_Type(newrec_.Employee_Id) NOT IN (0)) AND (newrec_.deductions IS NOT NULL OR newrec_.allowances IS NOT NULL)) THEN
      rslt_ := 'Error: Employee ' || newrec_.employee_id || ' is not a Full Time employee, hence cannot have values for Deductions and allowances.';
    END IF;
    
    --check exist for referrenced columns
    IF (newrec_.employee_id IS NOT NULL) THEN
      employee_api.Check_Exist_(newrec_.employee_id, rslt_);
      IF rslt_ = 'FALSE' THEN
        rslt_ := 'Error: Employee does not exist.';
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(salaryId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_empSalaryInfo IS
      SELECT 1 FROM SALARY_INFO_TAB i WHERE i.salary_id = salaryId_;
  
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
    Get_(newrec_.salary_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF newrec_.employee_id IS NULL THEN
        rslt_ := 'Error: Employee ID cannot be Empty.';
      END IF;
      IF (Check_Emp_Sal_Info_Exist(newrec_.employee_id) = 'TRUE') THEN
        rslt_ := 'Error: Salary information for Employee ' ||
                 newrec_.employee_id || ' has already been defined.';
      END IF;
      IF (newrec_.employee_id IS NOT NULL AND (employee_api.Get_Employee_Type(newrec_.Employee_Id) NOT IN (0)) AND (newrec_.deductions IS NOT NULL OR newrec_.allowances IS NOT NULL)) THEN
        rslt_ := 'Error: Employee ' || newrec_.employee_id || ' is not a Full Time employee, hence cannot have values for Deductions and allowances.';
      END IF;
    
      --check exist for referrenced columns
      IF (newrec_.employee_id IS NOT NULL) THEN
        employee_api.Check_Exist_(newrec_.employee_id, rslt_);
        IF rslt_ = 'FALSE' THEN
          rslt_ := 'Error: Employee does not exist.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(salaryId_ IN NUMBER,
                 old_rec_  IN OUT SALARY_INFO_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
    CURSOR get_empSalaryInfo IS
      SELECT * FROM SALARY_INFO_TAB i WHERE i.salary_id = salaryId_;
  
  BEGIN
    Check_Exist_(salaryId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_empSalaryInfo;
      FETCH get_empSalaryInfo
        INTO old_rec_;
      CLOSE get_empSalaryInfo;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the salary info of employee ' ||
               old_rec_.Employee_Id || '.';
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

  PROCEDURE Delete_(salaryId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(salaryId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM SALARY_INFO_TAB i where i.salary_id = salaryId_;
      rslt_ := 'Successfully deleted the salary info of employee.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Salary_Info(value1_       OUT NUMBER,
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
  END Get_Salary_Info;

  PROCEDURE Check_Delete_(salaryId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    temp_ NUMBER := 0;
  BEGIN
  
    Check_Exist_(salaryId_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (salaryId_ IS NULL) THEN
        rslt_ := 'Error: Salary ID must have a value.';
      END IF;
    
      SELECT 1
        INTO temp_
        FROM SAL_PER_EMP_TAB
       WHERE employee_id = Get_Emp_Id(salaryId_);
    
      IF (temp_ != 0) THEN
        rslt_ := 'Error: Employee ' || Get_Emp_Id(salaryId_) ||
                 ' has employee payments defined and hence cannot be deleted.';
      ELSE
        rslt_ := 'TRUE';
      END IF;
    END IF;
  
  END Check_Delete_;

  FUNCTION Get_Emp_Id(salary_id_ IN NUMBER) RETURN VARCHAR2 IS
  
    temp_id_ SALARY_INFO_TAB.EMPLOYEE_ID%type;
  BEGIN
  
    IF (salary_id_ IS NULL) THEN
      RETURN NULL;
    END IF;
    SELECT employee_id
      INTO temp_id_
      FROM SALARY_INFO_TAB
     WHERE salary_id = salary_id_;
    RETURN temp_id_;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Emp_Id;

  FUNCTION Check_Emp_Sal_Info_Exist(emp_id_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_ VARCHAR2(5) := 'FALSE';
    temp_ NUMBER;
    CURSOR emp_sal_exist IS
      SELECT 1 FROM SALARY_INFO_TAB WHERE EMPLOYEE_ID = emp_id_;
  
  BEGIN
    OPEN emp_sal_exist;
    FETCH emp_sal_exist
      INTO temp_;
    IF emp_sal_exist%FOUND THEN
      CLOSE emp_sal_exist;
      rslt_ := 'TRUE';
    ELSE
      CLOSE emp_sal_exist;
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Check_Emp_Sal_Info_Exist;

  FUNCTION Get_Value1(emp_id_ IN VARCHAR2) RETURN NUMBER IS
  
    value_ NUMBER := 0;
  BEGIN
  
    IF (emp_id_ IS NULL) THEN
      RETURN NULL;
    END IF;
  
    SELECT value1
      INTO value_
      FROM SALARY_INFO_TAB
     WHERE employee_id = emp_id_;
    RETURN value_;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Value1;

  FUNCTION Get_Value2(emp_id_ IN VARCHAR2) RETURN NUMBER IS
  
    value_ NUMBER := 0;
  BEGIN
  
    IF (emp_id_ IS NULL) THEN
      RETURN NULL;
    END IF;
  
    SELECT value2
      INTO value_
      FROM SALARY_INFO_TAB
     WHERE employee_id = emp_id_;
    RETURN value_;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Value2;

  FUNCTION Calc_Epf(emp_id_ IN VARCHAR2, b_sal_ IN NUMBER) RETURN NUMBER IS
    epf_ NUMBER := 0;
  BEGIN
    IF (emp_id_ IS NULL OR b_sal_ IS NULL) THEN
      RETURN NULL;
    ELSIF (b_sal_ > 0 AND employee_api.Get_Employee_Type(emp_id_) = 0) THEN
      epf_ := b_sal_ * 0.08;
    ELSE
      RETURN NULL;
    END IF;
  
    RETURN epf_;
  
  END Calc_Epf;

  FUNCTION Get_Deductions(emp_id_ IN VARCHAR2) RETURN NUMBER IS
  
    deduction_ NUMBER := 0;
  BEGIN
  
    IF (emp_id_ IS NULL) THEN
      RETURN NULL;
    END IF;
    IF (employee_api.Get_Employee_Type(emp_id_) = 0) THEN
      SELECT deductions
        INTO deduction_
        FROM SALARY_INFO_TAB
       WHERE employee_id = emp_id_;
      RETURN deduction_;
    ELSE
      RETURN NULL;
    END IF;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
  END Get_Deductions;

  FUNCTION Get_Allowances(emp_id_ IN VARCHAR2) RETURN NUMBER IS
  
    allowance_ NUMBER := 0;
  BEGIN
  
    IF (emp_id_ IS NULL) THEN
      RETURN NULL;
    END IF;
    IF (employee_api.Get_Employee_Type(emp_id_) = 0) THEN
      SELECT ALLOWANCES
        INTO allowance_
        FROM SALARY_INFO_TAB
       WHERE employee_id = emp_id_;
      RETURN allowance_;
    ELSE
      RETURN NULL;
    END IF;
  
  END Get_Allowances;

  FUNCTION Calc_Net_Salary(emp_id_ IN VARCHAR2) RETURN NUMBER IS
  
    net_sal_  NUMBER := 0;
    emp_type_ NUMBER;
  
  BEGIN
  
    emp_type_ := employee_api.Get_Employee_Type(emp_id_);
    CASE emp_type_
      WHEN 0 THEN
        net_sal_ := Get_Value1(emp_id_) - Get_Value2(emp_id_) +
                    Get_Allowances(emp_id_) - Get_Deductions(emp_id_);
      WHEN 1 THEN
        net_sal_ := Get_Value1(emp_id_) * Get_Value2(emp_id_);
      WHEN 2 THEN
        net_sal_ := Get_Value1(emp_id_) * Get_Value2(emp_id_);
      ELSE
        net_sal_ := 0;
    END CASE;
  
    RETURN net_sal_;
  
  END Calc_Net_Salary;
  
  PROCEDURE Get_Next_Line_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
    
  BEGIN
    
    next_id_ := wfms_salary_id_seq.NEXTVAL;
    
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
      
  END Get_Next_Line_Id;

end SALARY_INFO_API;
/
