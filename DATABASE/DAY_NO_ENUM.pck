create or replace package DAY_NO_ENUM is

  SUBTYPE DAY_NO IS BINARY_INTEGER RANGE 0 .. 6;
  Sunday    CONSTANT DAY_NO := 0;
  Monday    CONSTANT DAY_NO := 1;
  Tuesday   CONSTANT DAY_NO := 2;
  Wednesday CONSTANT DAY_NO := 3;
  Thursday  CONSTANT DAY_NO := 4;
  Friday    CONSTANT DAY_NO := 5;
  Saturday  CONSTANT DAY_NO := 6;

  --get sting name for my "enum" type
  FUNCTION Get_Day_Name(enum_in DAY_NO) RETURN VARCHAR2;

end DAY_NO_ENUM;
/
create or replace package body DAY_NO_ENUM is

  FUNCTION Get_Day_Name(enum_in DAY_NO) RETURN VARCHAR2 IS
    DayName VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Sunday THEN
        DayName := 'Sunday';
      WHEN Monday THEN
        DayName := 'Monday';
      WHEN Tuesday THEN
        DayName := 'Tuesday';
      WHEN Wednesday THEN
        DayName := 'Wednesday';
      WHEN Thursday THEN
        DayName := 'Thursday';
      WHEN Friday THEN
        DayName := 'Friday';
      WHEN Saturday THEN
        DayName := 'Saturday';
      
      ELSE
        DayName := '';
    END CASE;
    RETURN DayName;
  END Get_Day_Name;

end DAY_NO_ENUM;
/
