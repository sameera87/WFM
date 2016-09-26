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

namespace WFMS.wrkcal.client
{
    public partial class dlgSearchDialog : MetroFramework.Forms.MetroForm
    {

        public dlgSearchDialog()
        {
            InitializeComponent();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSearchDayType_Click(object sender, EventArgs e)
        {
            if (txtDayTypeID_SD.Text != "")
            {
                try 
                {
                    DbConnect.OpenConnection();

                    OracleCommand command = new OracleCommand("DAY_TYPES.getDayTypeDetails", DbConnect.connection);
                    command.BindByName = true;
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.Add("d_type_", OracleDbType.Varchar2, txtDayTypeID_SD.Text, ParameterDirection.Input);
                    command.Parameters.Add("d_type_desc_", OracleDbType.Varchar2, ParameterDirection.Output);

                    OracleDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                    if (reader.Read()) 
                    {
                        DayType dayTypeObj1 = new DayType(reader["d_type_"].ToString(), reader["d_type_desc_"].ToString());
                        frmDayType frmObj = new frmDayType();
                        frmObj.populateOneRecord(dayTypeObj1);
                        frmObj.Show();
                    }
                }

                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    if (DbConnect.connection.State == ConnectionState.Open)
                    {
                        DbConnect.connection.Close();
                    }
                }
            }
            this.Close();
            
        }

        private void dlgSearchDialog_Load(object sender, EventArgs e)
        {

        }
    }
}
