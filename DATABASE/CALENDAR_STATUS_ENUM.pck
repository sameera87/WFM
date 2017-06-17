create or replace package CALENDAR_STATUS_ENUM is

  SUBTYPE CAL_STATUS IS BINARY_INTEGER RANGE 0 .. 3;
  Planned  CONSTANT CAL_STATUS := 0;
  Active   CONSTANT CAL_STATUS := 1;
  Inactive CONSTANT CAL_STATUS := 2;
  Expired  CONSTANT CAL_STATUS := 3;

  --get sting name for my "enum" type
  FUNCTION Get_CAL_STATUS_Desc(enum_in CAL_STATUS) RETURN VARCHAR2;

end CALENDAR_STATUS_ENUM;
/
create or replace package body CALENDAR_STATUS_ENUM is

FUNCTION Get_CAL_STATUS_Desc(enum_in CAL_STATUS) RETURN VARCHAR2 IS
    CalStatusDesc VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Planned THEN
        CalStatusDesc := 'Planned';
      WHEN Active THEN
        CalStatusDesc := 'Active';
      WHEN Inactive THEN
        CalStatusDesc := 'Inactive';
      WHEN Expired THEN
        CalStatusDesc := 'Expired';
      
      ELSE
        CalStatusDesc := '';
    END CASE;
    RETURN CalStatusDesc;
  END Get_CAL_STATUS_Desc;

end CALENDAR_STATUS_ENUM;
/
