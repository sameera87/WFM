create or replace package SYSTEM_api is

  
PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT VARCHAR2 );

PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 );

PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 );

PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 );

FUNCTION Remove_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2 ;

PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 );

PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 );

PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 );

FUNCTION Get_Next_From_Attr (
   attr_  IN     VARCHAR2,
   ptr_   IN OUT NUMBER,
   name_  IN OUT VARCHAR2,
   value_ IN OUT VARCHAR2 ) RETURN BOOLEAN;
   
FUNCTION Get_From_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2;
   
FUNCTION Get_From_Attr_Date (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN DATE;
   
FUNCTION Get_From_Attr_Number (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN NUMBER;
   
FUNCTION Get_From_Attr_Timestamp (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN TIMESTAMP;
   
FUNCTION Item_Exist (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2;



end SYSTEM_api;
/
create or replace package body SYSTEM_api is


PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT VARCHAR2 )
IS
BEGIN
   attr_ := attr_||name_|| CHR(031)||value_||CHR(030);
END Add_To_Attr;

PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_), attr_);
END Add_To_Attr;


PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_, 'YYYY/MM/DD'), attr_);
END Add_To_Attr;


PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_, 'YYYY/MM/DD HH:MI:SS'), attr_);
END Add_To_Attr;


FUNCTION Remove_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2 
IS
   index1_ NUMBER;
   index2_ NUMBER;
   
   FUNCTION Replace___ (
      string_ IN VARCHAR2 ) RETURN VARCHAR2 
   IS
   BEGIN     
      RETURN(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(string_, '\', '\\'), '|', '\|'), '^', '\^'), '$', '\$'), '*', '\*'), '+', '\+'), '?', '\?'), '[', '\['), ']', '\]'), '(', '\('), ')', '\)'));
   END Replace___;
   
BEGIN
   index1_ := instr(CHR(030)||attr_, CHR(030)||name_||CHR(031));
   IF (index1_ > 0) THEN
      index2_ := instr(CHR(030)||attr_, CHR(030), index1_ + 1, 1);
      /*REGEXP_REPLACE replaces the first occurence of the substring from the begining by NULL value*/
      RETURN(REGEXP_REPLACE( attr_, Replace___(substr(attr_, index1_-1, index2_ - index1_)), NULL, 1, 1));
   END IF;
   RETURN(attr_);
END Remove_Attr;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
   index1_ NUMBER;
   index2_ NUMBER;
BEGIN
   index1_ := instr(CHR(030)||attr_, CHR(030)||name_||CHR(031));
   IF (index1_ > 0) THEN
      index2_ := instr(CHR(030)||attr_, CHR(030), index1_ + 1, 1);
      IF index1_ = 1 THEN
         attr_ := name_||CHR(031)||value_||CHR(030)|| substr(attr_, index2_, LENGTH(attr_) - index2_ +1 );
      ELSE
         attr_ := REPLACE(attr_, substr(attr_, index1_-1, index2_ - index1_), CHR(030)||name_||CHR(031)||value_);
      END IF;
   ELSE
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Set_Item_Value;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Set_Item_Value(name_, to_char(value_), attr_);
END Set_Item_Value;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Set_Item_Value(name_, to_char(value_, 'YYYY/MM/DD'), attr_);
END Set_Item_Value;


FUNCTION Get_Next_From_Attr (
   attr_  IN     VARCHAR2,
   ptr_   IN OUT NUMBER,
   name_  IN OUT VARCHAR2,
   value_ IN OUT VARCHAR2 ) RETURN BOOLEAN
IS
   from_  NUMBER;
   to_    NUMBER;
   index_ NUMBER;
BEGIN
    from_ := nvl(ptr_, 1);
      to_   := instr(attr_, CHR(30), from_);
      IF (to_ > 0) THEN
         index_ := instr(attr_, CHR(31), from_);
         name_  := substr(attr_, from_, index_-from_);
         value_ := substr(attr_, index_+1, to_-index_-1);
         ptr_   := to_+1;
         RETURN(TRUE);
      ELSE
         RETURN(FALSE);
      END IF;
END Get_Next_From_Attr;

FUNCTION Get_From_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   from_ NUMBER;
   len_  NUMBER;
   to_   NUMBER;
BEGIN
   len_ := length(name_);
   from_ := instr(CHR(030)||attr_, CHR(030)||name_||CHR(031));
   IF (from_ > 0) THEN
     to_ := instr(attr_, CHR(030), from_ +1);
     IF (to_ > 0) THEN
       RETURN(substr(attr_, from_ + len_ + 1, to_ - from_ - len_ - 1));
     END IF;
   END IF;
   RETURN NULL;    
   
END Get_From_Attr;

FUNCTION Get_From_Attr_Date (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN DATE
IS
   value_ VARCHAR2(2000);
BEGIN
   value_ := Get_From_Attr(name_, attr_);
   RETURN(to_date(value_, 'YYYY/MM/DD'));
END Get_From_Attr_Date;   

FUNCTION Get_From_Attr_Number (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN NUMBER
IS
   value_ VARCHAR2(2000);
BEGIN
   value_ := Get_From_Attr(name_, attr_);
   RETURN(to_number(value_));
END Get_From_Attr_Number;

FUNCTION Get_From_Attr_Timestamp (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN TIMESTAMP
IS
   value_ VARCHAR2(2000);
BEGIN
   value_ := Get_From_Attr(name_, attr_);
   RETURN(to_date(value_, 'YYYY/MM/DD HH:MI:SS'));
END Get_From_Attr_Timestamp;   

FUNCTION Item_Exist (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   from_ NUMBER;
   len_  NUMBER;
BEGIN
   len_ := length(name_);
   from_ := instr(CHR(030)||attr_, CHR(030)||name_||CHR(031));
   IF (from_ > 0) THEN
      RETURN 'TRUE';
   ELSE
      RETURN 'FALSE';
   END IF;
END Item_Exist;

 
end SYSTEM_api;
/
