create or replace package MAP_LOCATION_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT MAP_LOCATION_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY MAP_LOCATION_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN MAP_LOCATION_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT MAP_LOCATION_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(mapLocId_ IN NUMBER,
                 old_rec_  IN OUT MAP_LOCATION_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2);

  PROCEDURE Delete_(mapLocId_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY MAP_LOCATION_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT MAP_LOCATION_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(mapLocId_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Next_Map_Loc_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);

end MAP_LOCATION_API;
/
create or replace package body MAP_LOCATION_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ MAP_LOCATION_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the map location.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT MAP_LOCATION_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'MAP_LOC_ID' THEN
        rec_.map_loc_id := TO_NUMBER(value_);
      ELSIF name_ = 'LOC_LATITUDE' THEN
        rec_.loc_latitude := value_;
      ELSIF name_ = 'LOC_LONGITUDE' THEN
        rec_.loc_longitude := value_;
      ELSIF name_ = 'AD_ADDRESS_ID' THEN
        rec_.ad_address_id := TO_NUMBER(value_);
      ELSIF name_ = 'CREATED_DATE' THEN
        rec_.created_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'MODIFIED_DATE' THEN
        rec_.modified_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'ROWVERSION' THEN
        rec_.rowversion := TO_DATE(value_, 'MM/DD/YYYY HH:MI:SS AM');
      ELSE
        rslt_ := 'Attr error: Unknown attribute found: ' || name_ || ' - ' ||
                 value_;
      END IF;
    END LOOP;
    rslt_ := 'TRUE';
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Unpack_;

  PROCEDURE Check_Insert_(newrec_ IN OUT MAP_LOCATION_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  BEGIN
    Check_Exist_(newrec_.map_loc_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Map location ' || newrec_.map_loc_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.map_loc_id IS NULL THEN
      rslt_ := 'Error: Map location ID cannot be Empty.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(mapLocId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_mapLoc IS
      SELECT 1 FROM MAP_LOCATION_TAB i WHERE i.map_loc_id = mapLocId_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_mapLoc;
    FETCH chk_mapLoc
      INTO tmp_;
    IF chk_mapLoc%FOUND THEN
      CLOSE chk_mapLoc;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_mapLoc;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY MAP_LOCATION_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO MAP_LOCATION_TAB
      (MAP_LOC_ID, LOC_LATITUDE, LOC_LONGITUDE, AD_ADDRESS_ID)
    VALUES
      (newrec_.map_loc_id,
       newrec_.loc_latitude,
       newrec_.loc_longitude,
       newrec_.ad_address_id)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN MAP_LOCATION_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('MAP_LOC_ID', to_char(rec_.map_loc_id), attr_);
    System_API.Add_To_Attr('LOC_LATITUDE', rec_.loc_latitude, attr_);
    System_API.Add_To_Attr('LOC_LONGITUDE', rec_.loc_longitude, attr_);
    System_API.Add_To_Attr('AD_ADDRESS_ID',
                           to_char(rec_.ad_address_id),
                           attr_);
    System_API.Add_To_Attr('CREATED_DATE',
                           to_char(rec_.created_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('MODIFIED_DATE',
                           to_char(rec_.modified_date, 'dd-MM-yyyy'),
                           attr_);
    System_API.Add_To_Attr('ROWVERSION',
                           to_char(rec_.rowversion,
                                   'MM/DD/YYYY HH:MI:SS AM'),
                           attr_);
  
  END Pack_;

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ MAP_LOCATION_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the map location.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT MAP_LOCATION_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ MAP_LOCATION_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.map_loc_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(mapLocId_ IN NUMBER,
                 old_rec_  IN OUT MAP_LOCATION_TAB%ROWTYPE,
                 rslt_     IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_mapLoc IS
      SELECT * FROM MAP_LOCATION_TAB i WHERE i.map_loc_id = mapLocId_;
  BEGIN
    Check_Exist_(mapLocId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_mapLoc;
      FETCH get_mapLoc
        INTO old_rec_;
      CLOSE get_mapLoc;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the map location ' || mapLocId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY MAP_LOCATION_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE MAP_LOCATION_TAB i
       SET ROW = newrec_
     WHERE i.map_loc_id = newrec_.map_loc_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(mapLocId_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
    rec_ MAP_LOCATION_TAB%ROWTYPE;
  
  BEGIN
    Check_Exist_(mapLocId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Get_(mapLocId_, rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        DELETE FROM MAP_LOCATION_TAB i where i.map_loc_id = mapLocId_;
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully deleted the map location.';
        END IF;
      ELSE
        rslt_ := 'Error: Map location has been deleted. Please refresh the window.';
      END IF;
    ELSE
      rslt_ := 'Error: Cannot find the map location.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;
  
  PROCEDURE Get_Next_Map_Loc_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  BEGIN
    next_id_ := wfms_map_loc_id_seq.NEXTVAL;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Next_Map_Loc_Id;  
  

end MAP_LOCATION_API;
/
