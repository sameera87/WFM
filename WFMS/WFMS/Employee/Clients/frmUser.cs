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
using WFMS.Employee.Business_Logic;
using Oracle.ManagedDataAccess.Client;

namespace WFMS.Employee.Clients
{
    public partial class frmUser : frmMasterDetail
    {
        User userObj = new User();
        public frmUser()
        {
            InitializeComponent();
            wfmsCmbUserType.SelectedIndex = 0;
            SearchATTR = "USER_ID:VARCHAR2,FIRST_NAME:VARCHAR2,LAST_NAME:VARCHAR2,PASSWORD:VARCHAR2,USER_TYPE:VARCHAR2";
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            wfmsTxtUserID.Text = "";
            wfmsTxtUserID.Enabled = true;
            wfmsTxtFirstName.Text = "";
            wfmsTxtLastName.Text = "";
            wfmsCmbUserType.SelectedIndex = 0;
            wfmsTxtPassword.Text = "";
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
                UpdateUser();
            }
            wfmsComboRecordPopulate.Items.Clear();
            onClickedPopulate();
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
                    OracleCommand ora_cmd = new OracleCommand("USER_API.New_", DbConnect.connection);
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
                                userObj.Unpack_Attr(attr);
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

        private void DeleteUser()
        {
            String rslt_ = checkInsertUpdate();
            #region Actions
            if (rslt_ == "TRUE")
            {
                try
                {
                    String attr = GenarateAttr();
                    DbConnect.OpenConnection();
                    OracleCommand ora_cmd = new OracleCommand("USER_API.Delete_", DbConnect.connection);
                    ora_cmd.BindByName = true;
                    ora_cmd.CommandType = CommandType.StoredProcedure;
                    OracleParameter op1 = new OracleParameter("userid_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op1.Size = 30;
                    op1.Value = wfmsTxtUserID.Text;
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

        private string checkInsertUpdate()
        {
            #region Actions
            if (String.IsNullOrEmpty(wfmsTxtUserID.Text))
                return "Error. User ID should have a value.";
            else if (wfmsTxtUserID.Text.Length > 15)
                return "Error. User ID is too long. (Maximum 15)";
            else if (String.IsNullOrEmpty(wfmsTxtFirstName.Text))
                return "Error. First Name should have a value.";
            else if (String.IsNullOrEmpty(wfmsTxtPassword.Text))
                return "Error. Password should have value.";
            else if (wfmsTxtPassword.Text.Length < 8)
                return "Error. Password should contsist of atleast 8 characters.";
            return "TRUE";
            #endregion
        }

        private string GenarateAttr()
        {
            String attr = "";
            #region Actions
            userObj.userid = wfmsTxtUserID.Text;
            userObj.firstName = wfmsTxtFirstName.Text;
            if (!String.IsNullOrEmpty(wfmsTxtLastName.Text))
                userObj.lastName = wfmsTxtLastName.Text;
            userObj.password = wfmsTxtPassword.Text;
            userObj.userType = wfmsCmbUserType.SelectedItem.ToString();

            Client_SYS.Add_To_Attr(ref attr, "USER_ID", userObj.userid);
            Client_SYS.Add_To_Attr(ref attr, "FIRST_NAME", userObj.firstName);
            if (!String.IsNullOrEmpty(wfmsTxtLastName.Text))
                Client_SYS.Add_To_Attr(ref attr, "LAST_NAME", userObj.lastName);
            Client_SYS.Add_To_Attr(ref attr, "PASSWORD", userObj.password);
            Client_SYS.Add_To_Attr(ref attr, "USER_TYPE", userObj.userType);
            return attr;
            #endregion
        }

        private void wfmsComboRecordPopulate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string aa = dt.Rows[wfmsComboRecordPopulate.SelectedIndex][0].ToString();
            userObj.get(aa);
            setObjectToFields();
            btnSave_Disable();
            btnDelete_Enable();
        }

        private void setObjectToFields()
        {
            #region Actions
            wfmsTxtUserID.Text = userObj.userid;
            wfmsTxtFirstName.Text = userObj.firstName;
            wfmsTxtPassword.Text = userObj.password;
            
            if (String.IsNullOrEmpty(userObj.lastName))
                wfmsTxtLastName.Text = "";
            else
                wfmsTxtLastName.Text = userObj.lastName;

            if (userObj.userType == "Field Service Engineer") 
            {
                wfmsCmbUserType.SelectedIndex = 0;
            }
            else if (userObj.userType == "Customer") 
            {
                wfmsCmbUserType.SelectedIndex = 1;
            }
            else if (userObj.userType == "Accountant")
            {
                wfmsCmbUserType.SelectedIndex = 2;
            }
            else if (userObj.userType == "Manager")
            {
                wfmsCmbUserType.SelectedIndex = 3;
            }
            else if (userObj.userType == "Senior Manager")
            {
                wfmsCmbUserType.SelectedIndex = 4;
            }
            else if (userObj.userType == "Executive")
            {
                wfmsCmbUserType.SelectedIndex = 5;
            }
            else //System Administrator
            {
                wfmsCmbUserType.SelectedIndex = 6;
            }
            
            wfmsDtpCreated.Value = userObj.createdDate;
            wfmsDtpModified.Value = userObj.modifiedDate;
            wfmsDate.Value = userObj.rowversion;
            #endregion
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            #region Actions
            Save();
            wfmsTxtUserID.Enabled = false;
            #endregion
        }

        public void UpdateUser()
        {
            #region Actions
            try
            {
                DbConnect.OpenConnection();
                OracleCommand oraCmd = new OracleCommand();
                oraCmd.BindByName = true;
                oraCmd.Connection = DbConnect.connection;
                oraCmd.CommandText = @"BEGIN
                                        UPDATE USER_TAB
                                        SET FIRST_NAME = :firstName,
                                            LAST_NAME = :lastName,
                                            PASSWORD = :password,
                                            MODIFIED_DATE = SYSDATE                                              
                                            WHERE USER_ID = :user;
                                        COMMIT;
                                 EXCEPTION
                                        WHEN OTHERS THEN
                                            ROLLBACK;
                                            RAISE;
                                 END;";
                oraCmd.Parameters.Add(new OracleParameter("firstName", wfmsTxtFirstName.Text));
                oraCmd.Parameters.Add(new OracleParameter("lastName", wfmsTxtLastName.Text));
                oraCmd.Parameters.Add(new OracleParameter("password", wfmsTxtPassword.Text));
                oraCmd.Parameters.Add(new OracleParameter("user", wfmsTxtUserID.Text));
                
                oraCmd.ExecuteNonQuery();

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

        private void wfmsTxtUserID_Enter(object sender, EventArgs e)
        {
            //if (String.IsNullOrEmpty(userObj.userid))
            //    wfmsTxtUserID.Enabled = true;
            //else
            //    wfmsTxtUserID.Enabled = false;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            #region Actions
            if (DBevent == "D")
            {
                DeleteUser();
            }
            wfmsComboRecordPopulate.Items.Clear();
            onClickedPopulate();
            #endregion
        }
    }
}
