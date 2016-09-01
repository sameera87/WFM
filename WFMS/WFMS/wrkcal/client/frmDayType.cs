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

namespace WFMS.wrkcal.client
{
    public partial class frmDayType : Form
    {
        public frmDayType()
        {
            InitializeComponent();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (txtDayTypeID.Text != null)
            {
                try
                {
                    DbConnect.OpenConnection();

                    OracleCommand command = new OracleCommand("DAY_TYPES.addDayType",DbConnect.connection);
                    command.BindByName = true;
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("d_type", OracleDbType.Varchar2, txtDayTypeID.Text, ParameterDirection.Input);
                    command.Parameters.Add("d_type_desc", OracleDbType.Varchar2, txtDayTypeDesc.Text, ParameterDirection.Input);

                    if (command.ExecuteNonQuery() != 0)
                    {
                        MessageBox.Show("Successfully added the emplyee.");
                        txtDayTypeID.Enabled = false;
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
            else
            {
                MessageBox.Show("Error in Transaction");
            }
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            txtDayTypeID.Clear();
            txtDayTypeDesc.Clear();
            txtWorkTimeCalendar.Clear();
            
            txtDayTypeID.Enabled = true;
            txtDayTypeDesc.Enabled = true;
            txtDayTypeID.Focus();

            btnSave.Enabled = true;
        }

        private void frmDayType_Load(object sender, EventArgs e)
        {

        }
    }
}
