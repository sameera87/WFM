create or replace package JOB_STATUS_ENUM is

  SUBTYPE STATUS IS BINARY_INTEGER RANGE 0 .. 7;
  Planned   CONSTANT STATUS := 0;
  Prepared  CONSTANT STATUS := 1;
  Assigned  CONSTANT STATUS := 2;
  Accepted  CONSTANT STATUS := 3;
  OnRoute   CONSTANT STATUS := 4;
  Started   CONSTANT STATUS := 5;
  Finished  CONSTANT STATUS := 6;
  Cancelled CONSTANT STATUS := 7;

  --get sting name for my "enum" type
  FUNCTION Get_Status_Desc(enum_in STATUS) RETURN VARCHAR2;

end JOB_STATUS_ENUM;
/
create or replace package body JOB_STATUS_ENUM is

  FUNCTION Get_Status_Desc(enum_in STATUS) RETURN VARCHAR2 IS
    StatusName VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Planned THEN
        StatusName := 'Planned';
      WHEN Prepared THEN
        StatusName := 'Prepared';
      WHEN Assigned THEN
        StatusName := 'Assigned';
      WHEN Accepted THEN
        StatusName := 'Accepted';
      WHEN OnRoute THEN
        StatusName := 'OnRoute';
      WHEN Started THEN
        StatusName := 'Started';
      WHEN Finished THEN
        StatusName := 'Finished';
      WHEN Cancelled THEN
        StatusName := 'Cancelled';
      
      ELSE
        StatusName := '';
    END CASE;
    RETURN StatusName;
  END Get_Status_Desc;

end JOB_STATUS_ENUM;
/
