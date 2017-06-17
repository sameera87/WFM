create or replace package CUST_PAYMENT_STATUS_ENUM is

  SUBTYPE STATUS IS BINARY_INTEGER RANGE 0 .. 1;
  Planned   CONSTANT STATUS := 0;
  Confirmed CONSTANT STATUS := 1;

  --get sting name for my "enum" type
  FUNCTION Get_Status_Desc(enum_in STATUS) RETURN VARCHAR2;

end CUST_PAYMENT_STATUS_ENUM;
/
create or replace package body CUST_PAYMENT_STATUS_ENUM is

  FUNCTION Get_Status_Desc(enum_in STATUS) RETURN VARCHAR2 IS
    StatusName VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Planned THEN
        StatusName := 'Planned';
      WHEN Confirmed THEN
        StatusName := 'Confirmed';
      
      ELSE
        StatusName := '';
    END CASE;
    RETURN StatusName;
  END Get_Status_Desc;

end CUST_PAYMENT_STATUS_ENUM;
/
