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

namespace WFMS.Employee.Business_Logic
{
    class User
    {
        #region class Variables
        public string userid = "";
        public string firstName = "";
        public string lastName = "";
        public string password = "";
        public string userType = "";
        public DateTime createdDate = new DateTime();
        public DateTime modifiedDate = new DateTime();
        public DateTime rowversion = new DateTime();
        string rslt_ = "";
        #endregion

        public User() 
        {
            userid = "";
            firstName = "";
            lastName = "";
            password = "";
            userType = "";
            createdDate = DateTime.Today;
            modifiedDate = DateTime.Today;
            rowversion = DateTime.Today;
        }

        public void Unpack_Attr(String attr)
        {
            Client_SYS.Get_From_Attr(attr, "USER_ID", ref userid);
            Client_SYS.Get_From_Attr(attr, "FIRST_NAME", ref firstName);
            Client_SYS.Get_From_Attr(attr, "LAST_NAME", ref lastName);
            Client_SYS.Get_From_Attr(attr, "PASSWORD", ref password);
            Client_SYS.Get_From_Attr(attr, "USER_TYPE", ref userType);
            Client_SYS.Get_From_Attr(attr, "CREATED_DATE", ref createdDate);
            Client_SYS.Get_From_Attr(attr, "MODIFIED_DATE", ref modifiedDate);
            Client_SYS.Get_From_Attr(attr, "ROWVERSION", ref rowversion);
        }

        public void get(string user)
        {
            try
            {
                DbConnect.OpenConnection();
                /*********************Oracle Command**********************************************************************/
                OracleCommand ora_cmd = new OracleCommand("USER_API.Get_User", DbConnect.connection);
                ora_cmd.BindByName = true;
                ora_cmd.CommandType = CommandType.StoredProcedure;

                ora_cmd.Parameters.Add("firstName_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("lastName_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("password_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("userType_", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("createdDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("modifiedDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rowversion_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rslt_", OracleDbType.Varchar2, 2000, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("userid_", OracleDbType.Varchar2, 30, user, ParameterDirection.Input);
                /*********************Oracle Command**********************************************************************/

                if (ora_cmd.ExecuteNonQuery() != 0)
                {
                    rslt_ = ora_cmd.Parameters["rslt_"].Value.ToString();
                    if (rslt_ != "TRUE")
                    {
                        MessageBox.Show("Error while excecuting");
                    }
                    userid = user;
                    firstName = ora_cmd.Parameters["firstName_"].Value.ToString();
                    lastName = ora_cmd.Parameters["lastName_"].Value.ToString();
                    password = ora_cmd.Parameters["password_"].Value.ToString();
                    userType = ora_cmd.Parameters["userType_"].Value.ToString();
                    createdDate = DateTime.ParseExact(ora_cmd.Parameters["createdDate_"].Value.ToString(), "MM/dd/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                    modifiedDate = DateTime.ParseExact(ora_cmd.Parameters["modifiedDate_"].Value.ToString(), "MM/dd/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                    rowversion = DateTime.ParseExact(ora_cmd.Parameters["rowversion_"].Value.ToString(), "MM/dd/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                }
            }
            catch (Exception ex)
            {
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
