using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Windows.Forms;

namespace WFMS.Common.Classes
{
    class DbConnect
    {
        public static OracleConnection connection;
        private static string server;
        private static string uid;
        private static string password;

        public DbConnect()
        {
            Initialize();
        }

        //Initialize values
        private void Initialize()
        {

        }

        //open connection to database
        public static bool OpenConnection()
        {
            server = "13.67.119.3/xe";
            uid = "SYS";
            password = "admin";
            string connectionString;
            connectionString = "Data Source=" + server + ";User Id=" + uid + ";Password=" + password + ";DBA Privilege=SYSDBA";
            
            connection = new OracleConnection();
            connection.ConnectionString = connectionString;

            try
            {
                connection.Open();
                return true;
            }
            catch 
            {
                return false;
            }
        }

        //Close connection
        public static bool CloseConnection()
        {
            try
            {
                connection.Close();
                return true;
            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
        }

        public static OracleConnection GetConnection()
        {
            OpenConnection();
            return connection;
        }
    }
}