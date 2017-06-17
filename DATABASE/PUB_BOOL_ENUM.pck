create or replace package PUB_BOOL_ENUM is

  SUBTYPE BOOL IS BINARY_INTEGER RANGE 0 .. 1;
  Yes CONSTANT BOOL := 0;
  No  CONSTANT BOOL := 1;

  --get sting name for my "enum" type
  FUNCTION Get_Bool_Desc(enum_in BOOL) RETURN VARCHAR2;

end PUB_BOOL_ENUM;
/
create or replace package body PUB_BOOL_ENUM is

  FUNCTION Get_Bool_Desc(enum_in BOOL) RETURN VARCHAR2 IS
    BoolValue VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Yes THEN
        BoolValue := 'Yes';
      WHEN No THEN
        BoolValue := 'No';
      
      ELSE
        BoolValue := '';
    END CASE;
    RETURN BoolValue;
  END Get_Bool_Desc;
end PUB_BOOL_ENUM;
/
