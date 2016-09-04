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
            if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled==true)
            {
                try
                {
                    DbConnect.OpenConnection();

                    OracleCommand command = new OracleCommand("DAY_TYPES.addDayType",DbConnect.connection);
                    command.BindByName = true;
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("d_type", OracleDbType.Varchar2, cmbDayTypeID.Text, ParameterDirection.Input);
                    command.Parameters.Add("d_type_desc", OracleDbType.Varchar2, txtDayTypeDesc.Text, ParameterDirection.Input);

                    if (command.ExecuteNonQuery() != 0)
                    {
                        MessageBox.Show("Successfully added the Day Type.");
                        cmbDayTypeID.Enabled = false;
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

            else if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled==false) //To Update any changes done for the Day Type
            {
                try
                {
                    DbConnect.OpenConnection();

                    OracleCommand command = new OracleCommand("DAY_TYPES.updateDayType", DbConnect.connection);
                    command.BindByName = true;
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("d_type", OracleDbType.Varchar2, cmbDayTypeID.Text, ParameterDirection.Input);
                    command.Parameters.Add("d_type_desc", OracleDbType.Varchar2, txtDayTypeDesc.Text, ParameterDirection.Input);

                    if (command.ExecuteNonQuery() != 0)
                    {
                        MessageBox.Show("Successfully updated the Day Type.");
                        cmbDayTypeID.Enabled = false;
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
            //cmbDayTypeID.Clear();
            txtDayTypeDesc.Clear();
            txtWorkTimeCalendar.Clear();

            cmbDayTypeID.Enabled = true;
            txtDayTypeDesc.Enabled = true;
            cmbDayTypeID.Focus();

            btnSave.Enabled = true;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled == false)
            {
                try
                {
                    DbConnect.OpenConnection();

                    OracleCommand command = new OracleCommand("DAY_TYPES.removeDayType", DbConnect.connection);
                    command.BindByName = true;
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("d_type", OracleDbType.Varchar2, cmbDayTypeID.Text, ParameterDirection.Input);

                    if (command.ExecuteNonQuery() != 0)
                    {
                        MessageBox.Show("Successfully deleted the Day Type.");
                        cmbDayTypeID.Enabled = false;
                        txtDayTypeDesc.Enabled = false;


                        //cmbDayTypeID.Clear();
                        txtDayTypeDesc.Clear();
                        txtWorkTimeCalendar.Clear();
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
        }
    }
}
