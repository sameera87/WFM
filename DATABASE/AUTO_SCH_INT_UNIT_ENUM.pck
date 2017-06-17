create or replace package AUTO_SCH_INT_UNIT_ENUM is

  SUBTYPE TIME_UNIT IS BINARY_INTEGER RANGE 0 .. 3;
  Seconds CONSTANT TIME_UNIT := 0;
  Minutes CONSTANT TIME_UNIT := 1;
  Hours   CONSTANT TIME_UNIT := 2;
  Days    CONSTANT TIME_UNIT := 3;

  --get sting name for my "enum" type
  FUNCTION Get_Time_Unit_Desc(enum_in TIME_UNIT) RETURN VARCHAR2;

end AUTO_SCH_INT_UNIT_ENUM;
/
create or replace package body AUTO_SCH_INT_UNIT_ENUM is

  FUNCTION Get_Time_Unit_Desc(enum_in TIME_UNIT) RETURN VARCHAR2 IS
    TimeUnitDesc VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Seconds THEN
        TimeUnitDesc := 'Seconds';
      WHEN Minutes THEN
        TimeUnitDesc := 'Minutes';
      WHEN Hours THEN
        TimeUnitDesc := 'Hours';
      WHEN Days THEN
        TimeUnitDesc := 'Days';
      
      ELSE
        TimeUnitDesc := '';
    END CASE;
    RETURN TimeUnitDesc;
  END Get_Time_Unit_Desc;

end AUTO_SCH_INT_UNIT_ENUM;
/
