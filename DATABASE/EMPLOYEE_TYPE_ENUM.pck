create or replace package EMPLOYEE_TYPE_ENUM is

  SUBTYPE EMP_TYPE IS BINARY_INTEGER RANGE 0 .. 2;
  FullTime CONSTANT EMP_TYPE := 0;
  PartTime CONSTANT EMP_TYPE := 1;
  Intern   CONSTANT EMP_TYPE := 2;

  --get sting name for my "enum" type
  FUNCTION Get_Emp_Type_Desc(enum_in EMP_TYPE) RETURN VARCHAR2;

end EMPLOYEE_TYPE_ENUM;
/
create or replace package body EMPLOYEE_TYPE_ENUM is

  FUNCTION Get_Emp_Type_Desc(enum_in EMP_TYPE) RETURN VARCHAR2 IS
    EmpTypeDesc VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN FullTime THEN
        EmpTypeDesc := 'Full Time';
      WHEN PartTime THEN
        EmpTypeDesc := 'Part Time';
      WHEN Intern THEN
        EmpTypeDesc := 'Intern';
      
      ELSE
        EmpTypeDesc := '';
    END CASE;
    RETURN EmpTypeDesc;
  END Get_Emp_Type_Desc;

end EMPLOYEE_TYPE_ENUM;
/
