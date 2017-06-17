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
    class DayType
    {
        #region class Variables
        public string dayTypeId = "";
        public string description = "";
        public double workTimePerDay = 0;
        public DateTime createdDate = new DateTime();
        public DateTime modifiedDate = new DateTime();
        public DateTime rowversion = new DateTime();
        string rslt_ = "";
        #endregion

        public DayType() 
        {
            dayTypeId = "";
            description = "";
            workTimePerDay = 0;
            createdDate = DateTime.Now.Date;
            modifiedDate = DateTime.Now.Date;
            rowversion = DateTime.Now.Date;
        }

        public void Unpack_Attr(String attr)
        {
            Client_SYS.Get_From_Attr(attr, "DAY_TYPE_ID", ref dayTypeId);
            Client_SYS.Get_From_Attr(attr, "DESCRIPTION", ref description);
            Client_SYS.Get_From_Attr(attr, "WORK_TIME_PER_DAY", ref workTimePerDay);
            Client_SYS.Get_From_Attr(attr, "CREATED_DATE", ref createdDate);
            Client_SYS.Get_From_Attr(attr, "MODIFIED_DATE", ref modifiedDate);
            Client_SYS.Get_From_Attr(attr, "ROWVERSION", ref rowversion);
        }

        public void get(string dayType)
        {
            try
            {
                DbConnect.OpenConnection();
                /*********************Oracle Command**********************************************************************/
                OracleCommand ora_cmd = new OracleCommand("DAY_TYPE_API.Get_Day_type", DbConnect.connection);
                ora_cmd.BindByName = true;
                ora_cmd.CommandType = CommandType.StoredProcedure;

                ora_cmd.Parameters.Add("description_", OracleDbType.Varchar2, 100, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("workTimePerDay_", OracleDbType.Double, ParameterDirection.Output);
                ora_cmd.Parameters.Add("createdDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("modifiedDate_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rowversion_", OracleDbType.Date, ParameterDirection.Output);
                ora_cmd.Parameters.Add("rslt_", OracleDbType.Varchar2, 2000, "", ParameterDirection.Output);
                ora_cmd.Parameters.Add("dayTypeId_", OracleDbType.Varchar2, 20, dayType, ParameterDirection.Input);
                /*********************Oracle Command**********************************************************************/

                if (ora_cmd.ExecuteNonQuery() != 0)
                {
                    rslt_ = ora_cmd.Parameters["rslt_"].Value.ToString();
                    if (rslt_ != "TRUE")
                    {
                        //MetroFramework.MetroMessageBox.Show(new frmUser,"Error while excecuting");
                        MessageBox.Show("Error while excecuting");
                    }
                    dayTypeId = dayType;
                    description = ora_cmd.Parameters["description_"].Value.ToString();
                    workTimePerDay = Convert.ToDouble(ora_cmd.Parameters["workTimePerDay_"].Value.ToString());
                    createdDate = DateTime.ParseExact(ora_cmd.Parameters["createdDate_"].Value.ToString(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None);
                    modifiedDate = DateTime.ParseExact(ora_cmd.Parameters["modifiedDate_"].Value.ToString(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None);
                    rowversion = DateTime.ParseExact(ora_cmd.Parameters["rowversion_"].Value.ToString(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None);
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
