create or replace package CUSTOMER_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUSTOMER_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2);

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUSTOMER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Pack_(rec_ IN CUSTOMER_TAB%ROWTYPE, attr_ IN OUT VARCHAR2);

  PROCEDURE Modify_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Check_Update_(newrec_ IN OUT CUSTOMER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Get_(customerId_ IN VARCHAR2,
                 old_rec_    IN OUT CUSTOMER_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2);

  PROCEDURE Delete_(customerId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUSTOMER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Insert_(newrec_ IN OUT CUSTOMER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2);

  PROCEDURE Check_Exist_(customerId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);

  PROCEDURE Get_Customer(description_   OUT VARCHAR2,
                         email_         OUT VARCHAR2,
                         phoneNo1_      OUT VARCHAR2,
                         phoneNo2_      OUT VARCHAR2,
                         contactPerson_ OUT VARCHAR2,
                         addressId_     OUT NUMBER,
                         companyId_     OUT VARCHAR2,
                         curr_          OUT VARCHAR2,
                         createdDate_   OUT DATE,
                         modifiedDate_  OUT DATE,
                         rowversion_    OUT DATE,
                         rslt_          OUT VARCHAR2,
                         customerId_    IN VARCHAR2);
                         
  PROCEDURE Check_Delete_(customer_id_ IN VARCHAR2, rslt_ IN OUT VARCHAR2);
  
  FUNCTION Is_Customer_Used(customer_id_ IN VARCHAR2) RETURN VARCHAR2;
  
  FUNCTION Get_Company_Currency(company_id_ IN VARCHAR2) RETURN VARCHAR2;

end CUSTOMER_API;
/
create or replace package body CUSTOMER_API is

  PROCEDURE New_(attr_ IN OUT VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    rec_ CUSTOMER_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Insert_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Insert_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully saved the customer.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END New_;

  PROCEDURE Unpack_(attr_ IN VARCHAR2,
                    rec_  IN OUT CUSTOMER_TAB%ROWTYPE,
                    rslt_ IN OUT VARCHAR2) IS
    ptr_   NUMBER;
    name_  VARCHAR2(30);
    value_ VARCHAR2(1000);
  BEGIN
    WHILE (System_API.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
      rslt_ := name_;
      IF name_ = 'CUSTOMER_ID' THEN
        rec_.customer_id := value_;
      ELSIF name_ = 'DESCRIPTION' THEN
        rec_.description := value_;
      ELSIF name_ = 'EMAIL' THEN
        rec_.email := value_;
      ELSIF name_ = 'PHONE_NO1' THEN
        rec_.phone_no1 := value_;
      ELSIF name_ = 'PHONE_NO2' THEN
        rec_.phone_no2 := value_;
      ELSIF name_ = 'CONTACT_PERSON' THEN
        rec_.contact_person := value_;
      ELSIF name_ = 'ADDRESS_ID' THEN
        rec_.address_id := TO_NUMBER(value_);
      ELSIF name_ = 'COMPANY_ID' THEN
        rec_.company_id := value_;
      ELSIF name_ = 'CURRENCY' THEN
        rec_.currency := value_;
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

  PROCEDURE Check_Insert_(newrec_ IN OUT CUSTOMER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    comp_curr_ VARCHAR2(3);
  BEGIN
    Check_Exist_(newrec_.customer_id, rslt_);
    IF rslt_ = 'TRUE' THEN
      rslt_ := 'Error: Customer ' || newrec_.customer_id ||
               ' already exists.';
    ELSE
      rslt_ := 'TRUE';
    END IF;
    IF newrec_.customer_id IS NULL THEN
      rslt_ := 'Error: Customer ID cannot be Empty.';
    END IF;
    IF (newrec_.company_id IS NOT NULL AND newrec_.currency IS NOT NULL) THEN
      comp_curr_ := Get_Company_Currency(newrec_.company_id);
      IF (comp_curr_ != newrec_.currency) THEN
        rslt_ := 'Customer Currency cannot be different than the Company Currency ' || comp_curr_ || '.';
      END IF;
    END IF;      
  
    --check exist for referrenced columns
    IF (newrec_.company_id IS NOT NULL) THEN
      company_api.Check_Exist(newrec_.company_id, rslt_);
      IF rslt_ = 'FALSE' THEN
        rslt_ := 'Error: Company does not exist.';
      END IF;
    END IF;
    /*IF (newrec_.address_id IS NOT NULL) THEN
      --ADDRESS_API check exist method need to be added here.
    END IF;*/
  
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Insert_;

  PROCEDURE Check_Exist_(customerId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    tmp_ NUMBER;
    CURSOR chk_customer IS
      SELECT 1 FROM CUSTOMER_TAB i WHERE i.customer_id = customerId_;
    --AND i.status != 'DELETED';
  BEGIN
    OPEN chk_customer;
    FETCH chk_customer
      INTO tmp_;
    IF chk_customer%FOUND THEN
      CLOSE chk_customer;
      rslt_ := 'TRUE';
    ELSE
      CLOSE chk_customer;
      rslt_ := 'FALSE';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Exist_;

  PROCEDURE Insert_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUSTOMER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    INSERT INTO CUSTOMER_TAB
      (CUSTOMER_ID,
       DESCRIPTION,
       EMAIL,
       PHONE_NO1,
       PHONE_NO2,
       CONTACT_PERSON,
       ADDRESS_ID,
       COMPANY_ID,
       CURRENCY)
    VALUES
      (newrec_.customer_id,
       newrec_.description,
       newrec_.email,
       newrec_.phone_no1,
       newrec_.phone_no2,
       newrec_.contact_person,
       newrec_.address_id,
       newrec_.company_id,
       newrec_.currency)
    RETURNING CREATED_DATE, MODIFIED_DATE, ROWVERSION INTO newrec_.created_date, newrec_.modified_date, newrec_.rowversion;
    COMMIT;
  
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Insert_;

  PROCEDURE Pack_(rec_ IN CUSTOMER_TAB%ROWTYPE, attr_ IN OUT VARCHAR2) IS
  BEGIN
    System_API.Add_To_Attr('CUSTOMER_ID', rec_.customer_id, attr_);
    System_API.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
    System_API.Add_To_Attr('EMAIL', rec_.email, attr_);
    System_API.Add_To_Attr('PHONE_NO1', rec_.phone_no1, attr_);
    System_API.Add_To_Attr('PHONE_NO2', rec_.phone_no2, attr_);
    System_API.Add_To_Attr('CONTACT_PERSON', rec_.contact_person, attr_);
    System_API.Add_To_Attr('ADDRESS_ID', to_char(rec_.address_id), attr_);
    System_API.Add_To_Attr('COMPANY_ID', rec_.company_id, attr_);
    System_API.Add_To_Attr('CURRENCY', rec_.currency, attr_);
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
    rec_ CUSTOMER_TAB%ROWTYPE;
  BEGIN
    Unpack_(attr_, rec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      Check_Update_(rec_, rslt_);
      IF rslt_ = 'TRUE' THEN
        Update_(attr_, rec_, rslt_);
        IF rslt_ = 'TRUE' THEN
          rslt_ := 'Successfully Updated the customer.';
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Modify_;

  PROCEDURE Check_Update_(newrec_ IN OUT CUSTOMER_TAB%ROWTYPE,
                          rslt_   IN OUT VARCHAR2) IS
    oldrec_ CUSTOMER_TAB%ROWTYPE;
    comp_curr_ VARCHAR2(3);
  BEGIN
    Get_(newrec_.customer_id, oldrec_, rslt_);
    IF rslt_ = 'TRUE' THEN
      IF newrec_.rowversion != oldrec_.rowversion THEN
        rslt_ := 'Error: Record has been updated by another user. Please refresh the window and try again.';
      END IF;
      IF (newrec_.company_id IS NOT NULL AND newrec_.currency IS NOT NULL) THEN
        comp_curr_ := Get_Company_Currency(newrec_.company_id);
        IF (comp_curr_ != newrec_.currency) THEN
          rslt_ := 'Customer Currency cannot be different than the Company Currency ' || comp_curr_ || '.';
        END IF;
      END IF; 
    
      --check exist for referrenced columns
      IF (newrec_.company_id IS NOT NULL) THEN
        company_api.Check_Exist(newrec_.company_id, rslt_);
        IF rslt_ = 'FALSE' THEN
          rslt_ := 'Error: Company does not exist.';
        END IF;
      END IF;
      /*IF (newrec_.address_id IS NOT NULL) THEN
        --ADDRESS_API check exist method need to be added here.
      END IF;*/
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Check_Update_;

  PROCEDURE Get_(customerId_ IN VARCHAR2,
                 old_rec_    IN OUT CUSTOMER_TAB%ROWTYPE,
                 rslt_       IN OUT VARCHAR2) IS
    check_flag VARCHAR2(10);
    CURSOR get_customer IS
      SELECT * FROM CUSTOMER_TAB i WHERE i.customer_id = customerId_;
  BEGIN
    Check_Exist_(customerId_, check_flag);
    IF check_flag = 'TRUE' THEN
      OPEN get_customer;
      FETCH get_customer
        INTO old_rec_;
      CLOSE get_customer;
      rslt_ := 'TRUE';
    ELSE
      rslt_ := 'Error: Cannot find the customer ' || customerId_ || '.';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Get_;

  PROCEDURE Update_(attr_   OUT VARCHAR2,
                    newrec_ IN OUT NOCOPY CUSTOMER_TAB%ROWTYPE,
                    rslt_   IN OUT VARCHAR2) IS
  BEGIN
    newrec_.rowversion := sysdate;
    UPDATE CUSTOMER_TAB i
       SET ROW = newrec_
     WHERE i.customer_id = newrec_.customer_id;
    COMMIT;
    rslt_ := 'TRUE';
    attr_ := '';
    Pack_(newrec_, attr_);
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
  END Update_;
  

  PROCEDURE Delete_(customerId_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
      
  BEGIN
    Check_Delete_(customerId_, rslt_);
    IF rslt_ = 'TRUE' THEN
      DELETE FROM CUSTOMER_TAB i where i.customer_id = customerId_;
      rslt_ := 'Successfully deleted the customer code.';
    END IF;
    
  EXCEPTION
    WHEN OTHERS THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
      
  END Delete_;
  

  PROCEDURE Get_Customer(description_   OUT VARCHAR2,
                         email_         OUT VARCHAR2,
                         phoneNo1_      OUT VARCHAR2,
                         phoneNo2_      OUT VARCHAR2,
                         contactPerson_ OUT VARCHAR2,
                         addressId_     OUT NUMBER,
                         companyId_     OUT VARCHAR2,
                         curr_          OUT VARCHAR2,
                         createdDate_   OUT DATE,
                         modifiedDate_  OUT DATE,
                         rowversion_    OUT DATE,
                         rslt_          OUT VARCHAR2,
                         customerId_    IN VARCHAR2) IS
    dummy number := 0;
    --stat_ varchar2(1000);
  BEGIN
    IF (customerId_ IS NULL) THEN
      RETURN;
    END IF;
    SELECT 1
      into dummy
      from CUSTOMER_TAB i
     where i.customer_id = customerId_;
  
    if dummy = 0 then
      raise no_data_found;
      return;
    end if;
  
    SELECT i.description,
           i.email,
           i.phone_no1,
           i.phone_no2,
           i.contact_person,
           i.address_id,
           i.company_id,
           i.currency,
           i.created_date,
           i.modified_date,
           i.rowversion
      INTO description_,
           email_,
           phoneNo1_,
           phoneNo2_,
           contactPerson_,
           addressId_,
           companyId_,
           curr_,
           createdDate_,
           modifiedDate_,
           rowversion_
      FROM CUSTOMER_TAB i
     WHERE i.customer_id = customerId_;
    rslt_ := 'TRUE';
    
  EXCEPTION
    WHEN no_data_found THEN
      rslt_ := 'No data found';
    WHEN others THEN
      rslt_ := 'Error: ' || SQLCODE || ' - ' || SQLERRM;
      
  END Get_Customer;
  
  
  FUNCTION Is_Customer_Used(customer_id_ IN VARCHAR2) RETURN VARCHAR2 IS
  
    rslt_  VARCHAR2(5) := 'FALSE';
    dummy_ NUMBER := 0;
  
    CURSOR cust_sla_exist IS
      SELECT 1 FROM cust_sla_tab WHERE customer_id = customer_id_;
  
    CURSOR cust_job_exist IS
      SELECT 1 FROM Job_Tab t WHERE customer_id = customer_id_;
  
  BEGIN
  
    OPEN cust_sla_exist;
    FETCH cust_sla_exist
      INTO dummy_;
    IF (cust_sla_exist%FOUND) THEN
      CLOSE cust_sla_exist;
      rslt_ := 'TRUE';
    ELSE
      CLOSE cust_sla_exist;
      rslt_ := 'FALSE';
    END IF;
  
    dummy_ := 0;
    OPEN cust_job_exist;
    FETCH cust_job_exist
      INTO dummy_;
     IF (cust_job_exist%FOUND) THEN
      CLOSE cust_job_exist; 
      rslt_ := 'TRUE';
    ELSE
      CLOSE cust_job_exist;
      rslt_ := 'FALSE';
    END IF;
  
    RETURN rslt_;
  
  END Is_Customer_Used;
  
  
  PROCEDURE Check_Delete_(customer_id_ IN VARCHAR2, rslt_ IN OUT VARCHAR2) IS
    
    rec_ CUSTOMER_TAB%ROWTYPE;
  
  BEGIN
  
    Get_(customer_id_, rec_, rslt_);
    IF (rslt_ = 'TRUE') THEN
      IF (Is_Customer_Used(customer_id_) = 'TRUE') THEN
        rslt_ := 'Error: Customer has connected jobs/SLA lines and hence cannot be deleted.';
      END IF;
    END IF;
    
  END Check_Delete_;
  
  
  FUNCTION Get_Company_Currency(company_id_ IN VARCHAR2) RETURN VARCHAR2 IS
    
    curr_ VARCHAR2(3) :=  '';
    
  BEGIN
    IF (company_id_ IS NOT NULL) THEN
      curr_ := company_api.Company_Curr_Code(company_id_);
    END IF;
    RETURN curr_;
  
  END Get_Company_Currency; 
      


end CUSTOMER_API;
/
