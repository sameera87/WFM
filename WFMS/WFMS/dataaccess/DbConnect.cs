using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Windows.Forms;

namespace WFMS.dataaccess
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
            server = "13.76.35.247";
            uid = "system";
            password = "admin";
            string connectionString;
            connectionString = "User Id=" + uid + ";Password=" + password + ";Data Source=" + server;

            connection = new OracleConnection();
            connection.ConnectionString = "User Id=" + uid + ";Password=" + password + ";Data Source=" + server;

            try
            {
                connection.Open();
                return true;
            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
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
