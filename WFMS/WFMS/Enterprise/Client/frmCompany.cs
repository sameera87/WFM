using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.Common.Clients;
using WFMS.Common.Classes;
using Oracle.ManagedDataAccess.Client;
using WFMS.Enterprise.Business_Logic;

namespace WFMS.Enterprise.Client
{
    public partial class frmCompany : frmMasterDetail
    {
        Company compObj = new Company();
        public frmCompany()
        {
            InitializeComponent();
            wfmsCmbAutoSchUnit.SelectedIndex = 0;
            SearchATTR = "COMPANY_ID:VARCHAR2,DESCRIPTION:VARCHAR2,ADDRESS:VARCHAR2,PHONE_NO:VARCHAR2,CURRENCY_CODE:VARCHAR2";
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            wfmsTxtCompanyID.Text = "";
            wfmsTxtCompanyDesc.Text = "";
            wfmsTxtCompanyAddress.Text = "";
            wfmsTxtPhoneNo.Text = "";
            wfmsTxtAutoSchInterval.Text = "";
            wfmsCmbAutoSchUnit.SelectedIndex = 0;
            wfmsTxtCalendarID.Text = "";
            wfmsTxtCurrencyCode.Text = "";
        }

        private void Save()
        {
            if (DBevent == "N")
            {
                AddNew();
            }
            else if (DBevent == "M")
            {
                //bool value = Validate();
                //ModifyRec();
                UpdateCompany();
            }
            wfmsComboRecordPopulate.Items.Clear();
            onClickedPopulate();
        }

        private string checkInsertUpdate()
        {
            double tmp = 0;
            #region Actions
            if (String.IsNullOrEmpty(wfmsTxtCompanyID.Text))
                return "Error. Company ID should have a value.";
            else if (wfmsTxtCompanyID.Text.Length > 15)
                return "Error. User ID is too long. (Maximum 15)";
            else if (String.IsNullOrEmpty(wfmsTxtCompanyDesc.Text))
                return "Error. Description should have a value.";
            else if (String.IsNullOrEmpty(wfmsTxtCompanyAddress.Text))
                return "Error. Address should have value.";
            else if (!double.TryParse(wfmsTxtPhoneNo.Text, out tmp))
                return "Error. [Phone No] Invalid Value";
            else if (!double.TryParse(wfmsTxtAutoSchInterval.Text, out tmp))
                return "Error. [Auto Schedule Interval] Invalid Value";
            else if (Convert.ToDouble(wfmsTxtAutoSchInterval.Text) <= 0)
                return "Error. Auto Schedule Interval should be greater than 0.";
            else if (String.IsNullOrEmpty(wfmsTxtCalendarID.Text))
                return "Error. Calendar should have value.";
            else if (String.IsNullOrEmpty(wfmsTxtCurrencyCode.Text))
                return "Error. Currency Code should have value.";
            return "TRUE";
            #endregion
        }

        private string GenarateAttr()
        {
            String attr = "";
            #region Actions
            compObj.companyid = wfmsTxtCompanyID.Text;
            compObj.description = wfmsTxtCompanyDesc.Text;
            compObj.address = wfmsTxtCompanyAddress.Text;
            if (!String.IsNullOrEmpty(wfmsTxtPhoneNo.Text))
                compObj.phoneNo = wfmsTxtPhoneNo.Text;
            compObj.autoSchInt = Convert.ToDouble(wfmsTxtAutoSchInterval.Text);
            compObj.autoSchIntUnit = wfmsCmbAutoSchUnit.SelectedItem.ToString();
            compObj.workTimeCal = wfmsTxtCalendarID.Text;
            compObj.curencyCode = wfmsTxtCurrencyCode.Text;

            Client_SYS.Add_To_Attr(ref attr, "COMPANY_ID", compObj.companyid);
            Client_SYS.Add_To_Attr(ref attr, "DESCRIPTION", compObj.description);
            Client_SYS.Add_To_Attr(ref attr, "ADDRESS", compObj.address);
            if (!String.IsNullOrEmpty(wfmsTxtPhoneNo.Text))
                Client_SYS.Add_To_Attr(ref attr, "AUTO_SCH_INTERVAL", compObj.autoSchInt);
            Client_SYS.Add_To_Attr(ref attr, "AUTO_SCH_INT_UNIT", compObj.autoSchIntUnit);
            Client_SYS.Add_To_Attr(ref attr, "CALENDAR_ID", compObj.workTimeCal);
            Client_SYS.Add_To_Attr(ref attr, "CURRENCY_CODE", compObj.curencyCode);
            return attr;
            #endregion
        }

        private void setObjectToFields()
        {
            #region Actions
            wfmsTxtCompanyID.Text = compObj.companyid;
            wfmsTxtCompanyDesc.Text = compObj.description;
            wfmsTxtCompanyAddress.Text = compObj.address;

            if (String.IsNullOrEmpty(compObj.phoneNo))
                wfmsTxtPhoneNo.Text = "";
            else
                wfmsTxtPhoneNo.Text = compObj.phoneNo;

            wfmsTxtAutoSchInterval.Text = compObj.autoSchInt.ToString();


            if (compObj.autoSchIntUnit == "seconds")
            {
                wfmsCmbAutoSchUnit.SelectedIndex = 0;
            }
            else if (compObj.autoSchIntUnit == "minutes")
            {
                wfmsCmbAutoSchUnit.SelectedIndex = 1;
            }
            else if (compObj.autoSchIntUnit == "hours")
            {
                wfmsCmbAutoSchUnit.SelectedIndex = 2;
            }
            
            else //days
            {
                wfmsCmbAutoSchUnit.SelectedIndex = 3;
            }

            wfmsTxtCalendarID.Text = compObj.workTimeCal;
            wfmsTxtCurrencyCode.Text = compObj.curencyCode;
            wfmsDtpCreated.Value = compObj.createdDate;
            wfmsDtpModified.Value = compObj.modifiedDate;
            wfmsDate.Value = compObj.rowversion;
            #endregion
        }

        private void AddNew()
        {
            String rslt_ = checkInsertUpdate();
            #region Actions
            if (rslt_ == "TRUE")
            {
                try
                {
                    String attr = GenarateAttr();
                    DbConnect.OpenConnection();
                    OracleCommand ora_cmd = new OracleCommand("COMPANY_API.New_", DbConnect.connection);
                    ora_cmd.BindByName = true;
                    ora_cmd.CommandType = CommandType.StoredProcedure;
                    OracleParameter op1 = new OracleParameter("attr_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op1.Size = 2000;
                    op1.Value = attr;
                    Console.Out.WriteLine(attr);
                    OracleParameter op2 = new OracleParameter("rslt_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op2.Size = 100;
                    ora_cmd.Parameters.Add(op1);
                    ora_cmd.Parameters.Add(op2);

                    if (ora_cmd.ExecuteNonQuery() != 0)
                    {
                        String msg = ora_cmd.Parameters["rslt_"].Value.ToString();
                        MetroFramework.MetroMessageBox.Show(this, msg);
                        if (msg.Substring(0, 5) == "TRUE")
                        {
                            attr = ora_cmd.Parameters["attr_"].Value.ToString(); ;
                            if (attr != "null")
                                compObj.Unpack_Attr(attr);
                            setObjectToFields();
                        }
                        else
                            btnSave_Disable();
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
            }
            else
            {
                MetroFramework.MetroMessageBox.Show(this, rslt_);
            }
            #endregion
        }

        private void UpdateCompany()
        {
            String rslt_ = checkInsertUpdate();
            #region Actions
            if (rslt_ == "TRUE")
            {
                try
                {
                    String attr = GenarateAttr();
                    DbConnect.OpenConnection();
                    OracleCommand ora_cmd = new OracleCommand("COMPANY_API.Modify_", DbConnect.connection);
                    ora_cmd.BindByName = true;
                    ora_cmd.CommandType = CommandType.StoredProcedure;
                    OracleParameter op1 = new OracleParameter("attr_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op1.Size = 2000;
                    op1.Value = attr;
                    Console.Out.WriteLine(attr);
                    OracleParameter op2 = new OracleParameter("rslt_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op2.Size = 100;
                    ora_cmd.Parameters.Add(op1);
                    ora_cmd.Parameters.Add(op2);

                    if (ora_cmd.ExecuteNonQuery() != 0)
                    {
                        String msg = ora_cmd.Parameters["rslt_"].Value.ToString();
                        MetroFramework.MetroMessageBox.Show(this, msg);
                        if (msg.Substring(0, 5) == "TRUE")
                        {
                            attr = ora_cmd.Parameters["attr_"].Value.ToString(); ;
                            if (attr != "null")
                                compObj.Unpack_Attr(attr);
                            setObjectToFields();
                        }
                        else
                            btnSave_Disable();
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
            }
            else
            {
                MetroFramework.MetroMessageBox.Show(this, rslt_);
            }
            #endregion
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            #region Actions
            Save();
            wfmsTxtCompanyID.Enabled = false;
            #endregion
        }

        private void wfmsComboRecordPopulate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string aa = dt.Rows[wfmsComboRecordPopulate.SelectedIndex][0].ToString();
            compObj.get(aa);
            setObjectToFields();
            btnSave_Disable();
            btnDelete_Enable();
        }

        private void DeleteCompany()
        {
            String rslt_ = checkInsertUpdate();
            #region Actions
            if (rslt_ == "TRUE")
            {
                try
                {
                    String attr = GenarateAttr();
                    DbConnect.OpenConnection();
                    OracleCommand ora_cmd = new OracleCommand("COMPANY_API.Delete_", DbConnect.connection);
                    ora_cmd.BindByName = true;
                    ora_cmd.CommandType = CommandType.StoredProcedure;
                    OracleParameter op1 = new OracleParameter("companyid_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op1.Size = 30;
                    op1.Value = wfmsTxtCompanyID.Text;
                    Console.Out.WriteLine(attr);
                    OracleParameter op2 = new OracleParameter("rslt_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op2.Size = 100;
                    ora_cmd.Parameters.Add(op1);
                    ora_cmd.Parameters.Add(op2);

                    if (ora_cmd.ExecuteNonQuery() != 0)
                    {
                        String msg = ora_cmd.Parameters["rslt_"].Value.ToString();
                        MetroFramework.MetroMessageBox.Show(this, msg);
                        if (msg == "TRUE")
                        {
                            MetroFramework.MetroMessageBox.Show(this, "Successfully deleted the user.");
                            onClickedPopulate();
                        }
                        else
                            btnSave_Disable();
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
            }
            else
            {
                MetroFramework.MetroMessageBox.Show(this, rslt_);
            }
            #endregion
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            #region Actions
            if (DBevent == "D")
            {
                DeleteCompany();
            }
            wfmsComboRecordPopulate.Items.Clear();
            onClickedPopulate();
            #endregion
        }

        private void btnAddress_Click(object sender, EventArgs e)
        {
            dlgAddressForCompany dialogObj = new dlgAddressForCompany();
            dialogObj.ShowDialog();
        }



    }
}
