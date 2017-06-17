create or replace package EMP_STATUS_ENUM is

  SUBTYPE EMP_STATUS IS BINARY_INTEGER RANGE 0 .. 3;
  New_     CONSTANT EMP_STATUS := 0;
  Active   CONSTANT EMP_STATUS := 1;
  Inactive CONSTANT EMP_STATUS := 2;
  Expired  CONSTANT EMP_STATUS := 3;

  --get sting name for my "enum" type
  FUNCTION Get_EMP_STATUS_Desc(enum_in EMP_STATUS) RETURN VARCHAR2;

end EMP_STATUS_ENUM;
/
create or replace package body EMP_STATUS_ENUM is

  FUNCTION Get_EMP_STATUS_Desc(enum_in EMP_STATUS) RETURN VARCHAR2 IS
    EmpStatusDesc VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN New_ THEN
        EmpStatusDesc := 'New';
      WHEN Active THEN
        EmpStatusDesc := 'Active';
      WHEN Inactive THEN
        EmpStatusDesc := 'Inactive';
      WHEN Expired THEN
        EmpStatusDesc := 'Expired';
      
      ELSE
        EmpStatusDesc := '';
    END CASE;
    RETURN EmpStatusDesc;
  END Get_EMP_STATUS_Desc;

end EMP_STATUS_ENUM;
/
