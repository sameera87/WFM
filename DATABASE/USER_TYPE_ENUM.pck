create or replace package USER_TYPE_ENUM is

  SUBTYPE USER_TYPE IS BINARY_INTEGER RANGE 0 .. 6;
  FieldServiceEngineer CONSTANT USER_TYPE := 0;
  Customer             CONSTANT USER_TYPE := 1;
  Accountant           CONSTANT USER_TYPE := 2;
  Manager              CONSTANT USER_TYPE := 3;
  SeniorManager        CONSTANT USER_TYPE := 4;
  Executive            CONSTANT USER_TYPE := 5;
  SystemAdministrator  CONSTANT USER_TYPE := 6;

  --get sting name for my "enum" type
  FUNCTION Get_USER_TYPE_Desc(enum_in USER_TYPE) RETURN VARCHAR2;

end USER_TYPE_ENUM;
/
create or replace package body USER_TYPE_ENUM is

  FUNCTION Get_USER_TYPE_Desc(enum_in USER_TYPE) RETURN VARCHAR2 IS
    UserTypeDesc VARCHAR2(50);
  BEGIN
    CASE enum_in
      WHEN FieldServiceEngineer THEN
        UserTypeDesc := 'Field Service Engineer';
      WHEN Customer THEN
        UserTypeDesc := 'Customer';
      WHEN Accountant THEN
        UserTypeDesc := 'Accountant';
      WHEN Manager THEN
        UserTypeDesc := 'Manager';
      WHEN SeniorManager THEN
        UserTypeDesc := 'Senior Manager';
      WHEN Executive THEN
        UserTypeDesc := 'Executive';
      WHEN SystemAdministrator THEN
        UserTypeDesc := 'System Administrator';
      
      ELSE
        UserTypeDesc := '';
    END CASE;
    RETURN UserTypeDesc;
  END Get_USER_TYPE_Desc;

end USER_TYPE_ENUM;
/
