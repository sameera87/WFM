using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.Common.Classes;
using WFMS.Enterprise.Client;

namespace WFMS.Enterprise.Business_Logic
{
    class Company
    {
        #region class Variables
        public string companyid = "";
        public string description = "";
        public string address = "";
        public string phoneNo = "";
        public double autoSchInt = 0;
        public string autoSchIntUnit = "";
        public string workTimeCal = "";
        public string curencyCode = "";
        public DateTime createdDate = new DateTime();
        public DateTime modifiedDate = new DateTime();
        public DateTime rowversion = new DateTime();
        string rslt_ = "";
        #endregion

        public Company()
        {
            companyid = "";
            description = "";
            address = "";
            phoneNo = "";
            autoSchInt = 0;
            autoSchIntUnit = "";
            workTimeCal = "";
            curencyCode = "";
            createdDate = DateTime.Today;
            modifiedDate = DateTime.Today;
            rowversion = DateTime.Today;
        }

        public void Unpack_Attr(String attr)
        {
            Client_SYS.Get_From_Attr(attr, "COMPANY_ID", ref companyid);
            Client_SYS.Get_From_Attr(attr, "DESCRIPTION", ref description);
            Client_SYS.Get_From_Attr(attr, "ADDRESS", ref address);
            Client_SYS.Get_From_Attr(attr, "PHONE_NO", ref phoneNo);
            Client_SYS.Get_From_Attr(attr, "AUTO_SCH_INTERVAL", ref autoSchInt);
            Client_SYS.Get_From_Attr(attr, "AUTO_SCH_INT_UNIT", ref autoSchIntUnit);
            Client_SYS.Get_From_Attr(attr, "CALENDAR_ID", ref workTimeCal);
            Client_SYS.Get_From_Attr(attr, "CURRENCY_CODE", ref curencyCode);
            Client_SYS.Get_From_Attr(attr, "CREATED_DATE", ref createdDate);
            Client_SYS.Get_From_Attr(attr, "MODIFIED_DATE", ref modifiedDate);
            Client_SYS.Get_From_Attr(attr, "ROWVERSION", ref rowversion);
        }

        public void get(string company)
        {
            try
            {
                DbConnect.OpenConnection();
                /*********************Oracle Command**********************************************************************/
                OracleCommand ora_cmd = new OracleCommand("COMPANY_API.Get_Company", DbConnect.connection);
                ora_cmd.BindByName = true;
                ora_cmd.CommandType = CommandType.StoredProcedure;

                ora_cmd.Parameters.Add("description_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("address_", OracleDbType.Varchar2, 100, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("phoneNo_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("autoSchInt_", OracleDbType.Double, ParameterDirection.Output);
                ora_cmd.Parameters.Add("autoSchIntUnit_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("workTimeCal_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("curencyCode_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("createdDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("modifiedDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rowversion_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rslt_", OracleDbType.Varchar2, 2000, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("companyid_", OracleDbType.Varchar2, 30, company, ParameterDirection.Input);
                /*********************Oracle Command**********************************************************************/

                if (ora_cmd.ExecuteNonQuery() != 0)
                {
                    rslt_ = ora_cmd.Parameters["rslt_"].Value.ToString();
                    if (rslt_ != "TRUE")
                    {
                        //MetroFramework.MetroMessageBox.Show(new frmCompany,"Error while excecuting");
                        MessageBox.Show("Error while excecuting");
                    }
                    companyid = company;
                    description = ora_cmd.Parameters["description_"].Value.ToString();
                    address = ora_cmd.Parameters["address_"].Value.ToString();
                    phoneNo = ora_cmd.Parameters["phoneNo_"].Value.ToString();
                    autoSchInt = Convert.ToDouble(ora_cmd.Parameters["autoSchInt_"].Value.ToString());
                    autoSchIntUnit = ora_cmd.Parameters["autoSchIntUnit_"].Value.ToString();
                    workTimeCal = ora_cmd.Parameters["workTimeCal_"].Value.ToString();
                    curencyCode = ora_cmd.Parameters["curencyCode_"].Value.ToString();
                    createdDate = DateTime.ParseExact(ora_cmd.Parameters["createdDate_"].Value.ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                    modifiedDate = DateTime.ParseExact(ora_cmd.Parameters["modifiedDate_"].Value.ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                    rowversion = DateTime.ParseExact(ora_cmd.Parameters["rowversion_"].Value.ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                }
            }
            catch (Exception ex)
            {
                //MetroFramework.MetroMessageBox.Show(new frmCompany, ex.Message + "Cannot Find the record...");
                MessageBox.Show(ex.Message + "Cannot Find the record...");
            }
            finally
            {
                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }
            }
        }
    }
}
