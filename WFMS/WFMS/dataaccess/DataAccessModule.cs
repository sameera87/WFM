using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;


namespace WFMS.dataaccess
{
    class DataAccessModule
    {
        private string getConnection()
        {
            return ConfigurationManager.ConnectionStrings["OracleConnectionString"].ToString();
        }

        public bool executeNonQuery(string query)
        {
            bool flag = false;
            OracleConnection con = null;
            OracleCommand com = null;

            try
            {
                con = new OracleConnection(this.getConnection());
                con.Open();
                com = new OracleCommand(query, con);
                com.ExecuteNonQuery();
                com.Dispose();
                con.Close();
            }
            catch (Exception ex)
            {
                flag = false;
            }
            finally 
            {
                flag = true;
            }
            return flag;
        }

        public OracleDataReader executequery(string query)
        {
            OracleConnection con = null;
            OracleCommand com = null;

            try
            {
                con = new OracleConnection(this.getConnection());
                con.Open();
                com = new OracleCommand(query, con);

                return com.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch
            {
                return null;
            }
            finally
            {
                com.Dispose();
            }
        }
    }
}
