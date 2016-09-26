create or replace package DAY_TYPES is

  -- Author  : SWIMLK
  -- Created : 8/31/2016 7:47:02 AM
  -- Purpose : Hnadling Day Types related codes
  
  --Add a day type
  PROCEDURE addDayType(
    d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
    d_type_desc DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE);
    
  --Remove a day type
  PROCEDURE removeDayType(
    d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE);
    
  --Update a day type
  PROCEDURE updateDayType(
    d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
    d_type_desc DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE);
    
  --Query for all day types
  --PROCEDURE queryAllDayTypes;
  
  --Query for a day type by day_type_id
  --FUNCTION queryDayType(
    --d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE);

end DAY_TYPES;
/
create or replace package body DAY_TYPES is
  
PROCEDURE addDayType(
  d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
  d_type_desc DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE)
IS
BEGIN
  INSERT INTO DAY_TYPES_TAB(DAY_TYPE_ID,DAY_TYPE_DESCRIPTION) VALUES (d_type, d_type_desc);
  COMMIT;
  
END addDayType;
  
PROCEDURE removeDayType(
  d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE)
IS
BEGIN
  DELETE FROM DAY_TYPES_TAB WHERE DAY_TYPE_ID=d_type;
END removeDayType;

PROCEDURE updateDayType(
    d_type DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
    d_type_desc DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE)
IS
BEGIN
  UPDATE DAY_TYPES_TAB SET DAY_TYPE_DESCRIPTION=d_type_desc
  WHERE DAY_TYPE_ID=d_type;
  
END updateDayType;  
  
end DAY_TYPES;
/
