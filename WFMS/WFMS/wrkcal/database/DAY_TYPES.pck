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
    
  --Search for all day types
PROCEDURE getDayTypeDetails(
   d_type_          IN  DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
   d_type_desc_     OUT DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE);
  
   --work_time_p_day_ OUT DAY_TYPES_TAB.WORK_TIME_PER_DAY%TYPE 
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
  COMMIT;
END removeDayType;

PROCEDURE updateDayType(
    d_type       DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
    d_type_desc  DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE)
IS
BEGIN
  UPDATE DAY_TYPES_TAB SET DAY_TYPE_DESCRIPTION=d_type_desc
  WHERE DAY_TYPE_ID=d_type;
  COMMIT;
  
END updateDayType;


  --Search for all day types
PROCEDURE getDayTypeDetails(
   d_type_          IN  DAY_TYPES_TAB.DAY_TYPE_ID%TYPE,
   d_type_desc_     OUT DAY_TYPES_TAB.DAY_TYPE_DESCRIPTION%TYPE)
IS
  CURSOR getDetails IS
  SELECT day_type_description --,  work_time_per_day
  FROM   DAY_TYPES_TAB
  WHERE  day_type_id = d_type_;
  
BEGIN
  OPEN getDetails;
  FETCH getDetails INTO d_type_desc_;
  --, work_time_p_day_;
  CLOSE getDetails;
END getDayTypeDetails;


end DAY_TYPES;
/
