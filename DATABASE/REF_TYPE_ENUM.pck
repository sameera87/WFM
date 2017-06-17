create or replace package REF_TYPE_ENUM is

  SUBTYPE REF_TYPE IS BINARY_INTEGER RANGE 0 .. 2;
  Company  CONSTANT REF_TYPE := 0;
  Customer CONSTANT REF_TYPE := 1;
  Job      CONSTANT REF_TYPE := 2;

  --get sting name for my "enum" type
  FUNCTION Get_Ref_Type(enum_in REF_TYPE) RETURN VARCHAR2;

end REF_TYPE_ENUM;
/
create or replace package body REF_TYPE_ENUM is

  FUNCTION Get_Ref_Type(enum_in REF_TYPE) RETURN VARCHAR2 IS
    RefType VARCHAR2(10);
  BEGIN
    CASE enum_in
      WHEN Company THEN
        RefType := 'Company';
      WHEN Customer THEN
        RefType := 'Customer';
      WHEN Job THEN
        RefType := 'Job';
      
      ELSE
        RefType := '';
    END CASE;
    RETURN RefType;
  END Get_Ref_Type;

end REF_TYPE_ENUM;
/
