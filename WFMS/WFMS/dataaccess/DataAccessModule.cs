using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using Oracle.ManagedDataAccess.Client;


namespace WFMS.dataaccess
{
    class DataAccessModule
    {
        private OracleConnection connection;
        private static string server;
        private static string uid;
        private static string password;

        private string getConnection()
        {
            server = "13.76.35.247";
            uid = "system";
            password = "admin";
            string connectionString;
            return connectionString = "User Id=" + uid + ";Password=" + password + ";Data Source=" + server;
        }
        
        
        public bool executeNonQuery(string query)
        {
            bool flag = false;
            OracleConnection connection = null;
            OracleCommand command = null;

            try
            {
                connection = new OracleConnection(this.getConnection());
                connection.Open();
                command = new OracleCommand(query,connection);
                command.BindByName = true;
                command.CommandType = CommandType.StoredProcedure;
                command.ExecuteNonQuery();
                flag = true;

                command.Dispose();
                connection.Close();                
            }
            catch (Exception ex)
            {
                flag = false;
            }
            finally 
            {

            }
            return flag;
        }

        /*public OracleDataReader executequery(string query)
        {
            DBConnect.GetConnection();
            try
            {
                OracleCommand command = new OracleCommand(query, DBConnect.connection);

                return command.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch
            {
                return null;
            }
            finally
            {

            }
        }*/
    }
}
