create or replace package COMPETENCY_LEVEL_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_  IN COMPETENCY_LEVEL_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(comp_level_no_ IN NUMBER,
                 old_rec_       IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                 rslt_          IN OUT VARCHAR2);

  PROCEDURE Delete_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Competency_Level(comp_level_name_ OUT VARCHAR2,
                                 comp_level_desc_ OUT VARCHAR2,
                                 createdDate_     OUT DATE,
                                 modifiedDate_    OUT DATE,
                                 rowversion_      OUT DATE,
                                 rslt_            OUT VARCHAR2,
                                 comp_level_no_   IN NUMBER);

  FUNCTION Get_Comp_Level_Name(comp_level_no_ IN NUMBER) RETURN VARCHAR2;

  FUNCTION Get_Comp_Level_Desc(comp_level_no_ IN NUMBER) RETURN VARCHAR2;

  PROCEDURE Check_Delete_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Next_Line_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2);

  FUNCTION Check_Comp_Level_Name_Exist(comp_level_name_ IN VARCHAR2)
    RETURN VARCHAR2;

end COMPETENCY_LEVEL_API;
/
create or replace package body COMPETENCY_LEVEL_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ COMPETENCY_LEVEL_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the competancy level.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'COMP_LEVEL_LINE_NO' THEN
        rec_.comp_level_line_no := TO_NUMBER(value_);
      ELSIF name_ = 'COMP_LEVEL_NAME' THEN
        rec_.comp_level_name := value_;
      ELSIF name_ = 'COMP_LEVEL_DESC' THEN
        rec_.comp_level_desc := value_;
      ELSIF name_ = 'CREATED_DATE' THEN
        rec_.created_date := TO_DATE(value_, 'dd-MM-yyyy');
      ELSIF name_ = 'MODIFIED_DATE' THEN
        rec_.Modified_Date := TO_DATE(value_, 'dd-MM-yyyy');
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

  PROCEDURE Check_Insert_(newrec_ IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Exist_(newrec_.comp_level_line_no, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Competancy Level ' || newrec_.comp_level_name ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.comp_level_line_no IS NULL THEN
      rslt_ := 'Error: Competancy Level Line No cannot be Empty.';
    END IF;
    IF (Check_Comp_Level_Name_Exist(newrec_.comp_level_name) = 'TRUE') THEN
      rslt_ := 'Error: The Competency Level already Exists.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    tmp_ NUMBER;
    CURSOR chk_competancy_level IS
      SELECT 1
        FROM COMPETENCY_LEVEL_TAB i
       WHERE i.comp_level_line_no = comp_level_no_;
  
  BEGIN
    OPEN chk_competancy_level;
    FETCH chk_competancy_level
      INTO tmp_;
    IF chk_competancy_level%FOUND THEN
      CLOSE chk_competancy_level;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_competancy_level;
      rslt_ := 'FALSE';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO COMPETENCY_LEVEL_TAB
      (COMP_LEVEL_LINE_NO, COMP_LEVEL_NAME, COMP_LEVEL_DESC)
    VALUES
      (newrec_.comp_level_line_no,
       newrec_.comp_level_name,
       newrec_.comp_level_desc)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_  IN COMPETENCY_LEVEL_TAB%ROWTYPE,
                  attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('COMP_LEVEL_LINE_NO',
                           to_char(rec_.comp_level_line_no),
                           attr_);
    System_API.Add_To_Attr('COMP_LEVEL_NAME', rec_.comp_level_name, attr_);
    System_API.Add_To_Attr('COMP_LEVEL_DESC', rec_.comp_level_desc, attr_);
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
    rec_ COMPETENCY_LEVEL_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the competancy level.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ COMPETENCY_LEVEL_TAB%ROWTYPE;
  BEGIN
    Get_(newrec_.comp_level_line_no, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF (Check_Comp_Level_Name_Exist(newrec_.comp_level_name) = 'TRUE') THEN
        rslt_ := 'Error: The Competency Level already Exists.';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(comp_level_no_ IN NUMBER,
                 old_rec_       IN OUT COMPETENCY_LEVEL_TAB%ROWTYPE,
                 rslt_          IN OUT VARCHAR2) IS
  
    check_flag VARCHAR2(10);
    CURSOR get_competancy_level IS
      SELECT *
        FROM COMPETENCY_LEVEL_TAB i
       WHERE i.comp_level_line_no = comp_level_no_;
  
  BEGIN
  
    Check_Exist_(comp_level_no_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_competancy_level;
      FETCH get_competancy_level
        INTO old_rec_;
      CLOSE get_competancy_level;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the competancy level ' || comp_level_no_ || '.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY COMPETENCY_LEVEL_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE COMPETENCY_LEVEL_TAB i
       SET ROW = newrec_
     WHERE i.comp_level_line_no = newrec_.comp_level_line_no;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;

  PROCEDURE Delete_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
  BEGIN
    Check_Delete_(comp_level_no_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM COMPETENCY_LEVEL_TAB i
       where i.comp_level_line_no = comp_level_no_;
      rslt_ := 'Successfully deleted the competancy level.';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Delete_;

  PROCEDURE Get_Competency_Level(comp_level_name_ OUT VARCHAR2,
                                 comp_level_desc_ OUT VARCHAR2,
                                 createdDate_     OUT DATE,
                                 modifiedDate_    OUT DATE,
                                 rowversion_      OUT DATE,
                                 rslt_            OUT VARCHAR2,
                                 comp_level_no_   IN NUMBER) IS
    dummy number := 0;
  
  BEGIN
    IF (comp_level_no_ IS NULL) THEN
      RETURN;
    END IF;
  
    SELECT 1
      into dummy
      from COMPETENCY_LEVEL_TAB i
     where i.comp_level_line_no = comp_level_no_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.comp_level_name,
           i.comp_level_desc,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO comp_level_name_,
           comp_level_desc_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM COMPETENCY_LEVEL_TAB i
     WHERE i.comp_level_line_no = comp_level_no_;
    rslt_ := 'TRUE';
  
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_Competency_Level;

  FUNCTION Get_Comp_Level_Name(comp_level_no_ IN NUMBER) RETURN VARCHAR2 IS
  
    temp_ COMPETENCY_LEVEL_TAB.COMP_LEVEL_NAME%TYPE;
  
  BEGIN
  
    IF (comp_level_no_ IS NULL) THEN
      RETURN NULL;
    END IF;
  
    SELECT s.comp_level_name
      INTO temp_
      FROM COMPETENCY_LEVEL_TAB s
     WHERE s.comp_level_line_no = comp_level_no_;
    RETURN temp_;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Comp_Level_Name;

  FUNCTION Get_Comp_Level_Desc(comp_level_no_ IN NUMBER) RETURN VARCHAR2 IS
  
    temp_ COMPETENCY_LEVEL_TAB.COMP_LEVEL_DESC%TYPE;
  
  BEGIN
  
    IF (comp_level_no_ IS NULL) THEN
      RETURN NULL;
    END IF;
  
    SELECT s.comp_level_desc
      INTO temp_
      FROM COMPETENCY_LEVEL_TAB s
     WHERE s.comp_level_line_no = comp_level_no_;
    RETURN temp_;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    
  END Get_Comp_Level_Desc;

  PROCEDURE Check_Delete_(comp_level_no_ IN NUMBER, rslt_ IN OUT VARCHAR2) IS
  
    temp_ NUMBER := 0;
  BEGIN
  
    Check_Exist_(comp_level_no_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (comp_level_no_ IS NULL) THEN
        rslt_ := 'Error: Competence Level No must have a value.';
      END IF;
      SELECT 1
        INTO temp_
        FROM EMP_COMPETANCY_TAB t
       WHERE t.comp_level_line_no = comp_level_no_;
    
      IF (temp_ IS NOT NULL) THEN
        rslt_ := 'Error: Competency Level ' ||
                 Get_Comp_Level_Name(comp_level_no_) ||
                 ' is dofened for employees and hence cannot be deleted.';
      ELSE
        rslt_ := 'TRUE';
      END IF;
    END IF;
  END Check_Delete_;

  FUNCTION Check_Comp_Level_Name_Exist(comp_level_name_ IN VARCHAR2)
    RETURN VARCHAR2 IS
  
    tmp_  NUMBER := 0;
    rslt_ VARCHAR2(10) := '';
    CURSOR dup_comp_level_name IS
      SELECT 1
        FROM COMPETENCY_LEVEL_TAB
       WHERE COMP_LEVEL_NAME = comp_level_name_;
  
  BEGIN
  
    OPEN dup_comp_level_name;
    FETCH dup_comp_level_name
      INTO tmp_;
    IF (dup_comp_level_name%FOUND) THEN
      CLOSE dup_comp_level_name;
      rslt_ := 'TRUE';
    ELSE
      CLOSE dup_comp_level_name;
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Check_Comp_Level_Name_Exist;

  PROCEDURE Get_Next_Line_Id(next_id_ OUT NUMBER, rslt_ OUT VARCHAR2) IS
  
  BEGIN
    next_id_ := WFMS_COMP_LEVEL_SEQ.NEXTVAL;
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
    
  END Get_Next_Line_Id;

end COMPETENCY_LEVEL_API;
/
