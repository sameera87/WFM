using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.dataaccess;
using Oracle.ManagedDataAccess.Client;
using WFMS.wrkcal.businesslogic;
using System.Data.SqlClient;

namespace WFMS.wrkcal.businesslogic
{
    public class DayType
    {
        private string dayTypeID;
        private string dayTypeDescription;
        private double workTimePerDay;

        public string DayTypeID 
        {
            set { this.dayTypeID = value; }
            get { return this.dayTypeID; }
        }

        public string DayTypeDescription
        {
            set { this.dayTypeDescription = value; }
            get { return this.dayTypeDescription; }
        }

        public double WorkTimePerDay
        {
            set { this.workTimePerDay = value; }
            get { return this.workTimePerDay; }
        }

        public DayType() { }
        public DayType(string did) 
        {
            this.dayTypeID = did;
        }
        public DayType(string did, string ddsec) 
        {
            this.dayTypeID = did;
            this.dayTypeDescription = ddsec;
        }
        public DayType(string did, string ddsec, double wtpd) 
        {
            this.dayTypeID = did;
            this.dayTypeDescription = ddsec;
            this.workTimePerDay = wtpd;
        }

        public bool addDayType(DayType dayTypeObj) 
        {
            if (dayTypeObj.dayTypeID != null)
            {
                DbConnect.OpenConnection();

                OracleCommand command = new OracleCommand("DAY_TYPES.addDayType", DbConnect.connection);
                command.BindByName = true;
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("d_type", OracleDbType.Varchar2, dayTypeObj.dayTypeID, ParameterDirection.Input);
                command.Parameters.Add("d_type_desc", OracleDbType.Varchar2, dayTypeObj.dayTypeDescription, ParameterDirection.Input);
                command.ExecuteNonQuery();

                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }

                return true;
            }
            else 
            {
                return false;
            }
        }

        public bool updateDayType(DayType dayTypeObj) 
        {
            if (dayTypeObj.dayTypeID != null)
            {
                DbConnect.OpenConnection();

                OracleCommand command = new OracleCommand("DAY_TYPES.updateDayType", DbConnect.connection);
                command.BindByName = true;
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("d_type", OracleDbType.Varchar2, dayTypeObj.dayTypeID, ParameterDirection.Input);
                command.Parameters.Add("d_type_desc", OracleDbType.Varchar2, dayTypeObj.dayTypeDescription, ParameterDirection.Input);
                command.ExecuteNonQuery();

                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }

                return true;
            }
            else 
            {
                return false;
            }
        }

        public bool deleteDayType(DayType dayTypeObj) 
        {
            if (dayTypeObj.dayTypeID != null)
            {
                DbConnect.OpenConnection();

                OracleCommand command = new OracleCommand("DAY_TYPES.removeDayType", DbConnect.connection);
                command.BindByName = true;
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("d_type", OracleDbType.Varchar2, dayTypeObj.dayTypeID, ParameterDirection.Input);
                command.ExecuteNonQuery();

                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }
                return true;
            }
            else 
            {
                return false;
            }
        }
    }
}
