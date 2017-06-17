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
    public partial class frmDayType : frmMasterDetail
    {
        DayType dayTypeObj = new DayType();

        public frmDayType()
        {
            InitializeComponent();
            SearchATTR = "DAY_TYPE_ID:VARCHAR2,DESCRIPTION:VARCHAR2";
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            wfmsTxtDayTypeID.Text = "";
            wfmsTxtDayTypeID.Enabled = true;
            wfmsTxtDayTypeDesc.Text = "";
            wfmsTxtWorkTimePerDay.Text = "0";
        }

        private void Save()
        {
            if (DBevent == "N")
            {
                AddNew();
            }
            else if (DBevent == "M")
            {
                UpdateDayType();
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
                    OracleCommand ora_cmd = new OracleCommand("DAY_TYPE_API.New_", DbConnect.connection);
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
                                dayTypeObj.Unpack_Attr(attr);
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

        private void DeleteDayType()
        {
            String rslt_ = checkInsertUpdate();
            #region Actions
            if (rslt_ == "TRUE")
            {
                try
                {
                    String attr = GenarateAttr();
                    DbConnect.OpenConnection();
                    OracleCommand ora_cmd = new OracleCommand("DAY_TYPE_API.Delete_", DbConnect.connection);
                    ora_cmd.BindByName = true;
                    ora_cmd.CommandType = CommandType.StoredProcedure;
                    OracleParameter op1 = new OracleParameter("dayTypeId_", OracleDbType.Varchar2, ParameterDirection.InputOutput);
                    op1.Size = 20;
                    op1.Value = wfmsTxtDayTypeID.Text;
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
                            MetroFramework.MetroMessageBox.Show(this, "Successfully deleted the day type.");
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
            if (String.IsNullOrEmpty(wfmsTxtDayTypeID.Text))
                return "Error. Day Type ID should have a value.";
            else if (wfmsTxtDayTypeID.Text.Length > 15)
                return "Error. Day Type ID is too long. (Maximum 15)";
            else if (String.IsNullOrEmpty(wfmsTxtDayTypeDesc.Text))
                return "Error. Description should have a value.";
            return "TRUE";
            #endregion
        }

        private string GenarateAttr()
        {
            String attr = "";
            #region Actions
            dayTypeObj.dayTypeId = wfmsTxtDayTypeID.Text;
            dayTypeObj.description = wfmsTxtDayTypeDesc.Text;

            Client_SYS.Add_To_Attr(ref attr, "DAY_TYPE_ID", dayTypeObj.dayTypeId);
            Client_SYS.Add_To_Attr(ref attr, "DESCRIPTION", dayTypeObj.description);
            return attr;
            #endregion
        }

        private void wfmsComboRecordPopulate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string aa = dt.Rows[wfmsComboRecordPopulate.SelectedIndex][0].ToString();
            dayTypeObj.get(aa);
            setObjectToFields();
            btnSave_Disable();
            btnDelete_Enable();
        }

        private void setObjectToFields()
        {
            #region Actions
            wfmsTxtDayTypeID.Text = dayTypeObj.dayTypeId;
            wfmsTxtDayTypeDesc.Text = dayTypeObj.description;
            wfmsTxtWorkTimePerDay.Text = Convert.ToString(dayTypeObj.workTimePerDay);
            wfmsDtpCreated.Value = dayTypeObj.createdDate;
            wfmsDtpModified.Value = dayTypeObj.modifiedDate;
            wfmsDate.Value = dayTypeObj.rowversion;
            #endregion
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            #region Actions
            Save();
            wfmsTxtDayTypeID.Enabled = false;
            #endregion
        }

        public void UpdateDayType()
        {
            #region Actions
            try
            {
                DbConnect.OpenConnection();
                OracleCommand oraCmd = new OracleCommand();
                oraCmd.BindByName = true;
                oraCmd.Connection = DbConnect.connection;
                oraCmd.CommandText = @"BEGIN
                                        UPDATE DAY_TYPE_TAB
                                        SET DESCRIPTION = :description,
                                            MODIFIED_DATE = SYSDATE                                              
                                            WHERE DAY_TYPE_ID = :dayTypeId;
                                        COMMIT;
                                 EXCEPTION
                                        WHEN OTHERS THEN
                                            ROLLBACK;
                                            RAISE;
                                 END;";
                oraCmd.Parameters.Add(new OracleParameter("description", wfmsTxtDayTypeDesc.Text));
                oraCmd.Parameters.Add(new OracleParameter("dayTypeId", wfmsTxtDayTypeID.Text));

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

        private void btnDelete_Click(object sender, EventArgs e)
        {
            #region Actions
            if (DBevent == "D")
            {
                DeleteDayType();
            }
            wfmsComboRecordPopulate.Items.Clear();
            onClickedPopulate();
            #endregion
        }
    }
}
