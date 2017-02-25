using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MetroFramework.Forms;
using WFMS.Common.Controls;
using WFMS.Common.Classes;
using Oracle.ManagedDataAccess.Client;
using System;

namespace WFMS.Common.Clients
{
    public partial class dlgAddress : frmMasterDetail
    {
        private string entity = "";

        public dlgAddress()
        {
            InitializeComponent();
        }

        protected void checkDefaultAddressExist()
        {
            #region Actions
            try 
            {
                DbConnect.OpenConnection();

                OracleCommand newCmd = DbConnect.connection.CreateCommand();
                newCmd.Connection = DbConnect.connection;
                newCmd.CommandType = CommandType.Text;
                if (!String.IsNullOrEmpty(wfmsTxtCompanyID.Text))
                {
                    newCmd.CommandText = "select 1 from " + Table + " where DEF_ADDRESS = TRUE AND COMPANY_ID = " + wfmsTxtCompanyID.Text;
                    entity = "Company: " + wfmsTxtCompanyID.Text;
                }
                else if (!String.IsNullOrEmpty(wfmsTxtCustomerID.Text))
                {
                    newCmd.CommandText = "select 1 from " + Table + " where DEF_ADDRESS = TRUE AND CUSTOMER_ID = " + wfmsTxtCustomerID.Text;
                    entity = "Customer: " + wfmsTxtCustomerID.Text;
                }
                OracleDataReader dr = newCmd.ExecuteReader();

                
                if (dr.Read().ToString() == "1") 
                {
                    chkDefaultAddress.Checked = true;
                    MetroFramework.MetroMessageBox.Show(this, "Address has been set as the default for " + entity + ".");
                }
                else if (String.IsNullOrEmpty(dr.Read().ToString())) 
                {
                    MetroFramework.MetroMessageBox.Show(this, "A default address already exists for the " + entity + ".");
                }
            }

            catch (Exception ex)
            {
                MetroFramework.MetroMessageBox.Show(this, "Error: " + ex.Message, "Application Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }

            finally 
            {
                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }
            }
            #endregion
        }

        private void chkDefaultAddress_CheckedChanged(object sender, EventArgs e)
        {
            if (chkDefaultAddress.Checked == false)
            {
                checkDefaultAddressExist();
            }
        }

    }
}
