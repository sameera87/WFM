using System;
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

namespace WFMS.Common.Clients
{
    public partial class frmMasterDetail : MetroForm
    {

        #region Window Variables
        private string api_;
        private string table_;
        private string mainCombo_col1 = null;
        private string mainCombo_col2 = null;
        private string mainCombo_col3 = null;
        private string mainCombo_col4 = null;
        private string zoomcol = "";

        private string mainCombo_col1_sql = null;
        private string mainCombo_col2_sql = null;
        protected DataTable dt = new DataTable();
        private string searchATTR = "";
        private string searchATTRTypes = "";

        private string LOVFOCUS = "";
        protected string DBevent = "";
        private string searchQ = "";
        #endregion

        #region Window Properties
        public string Table
        {
            get
            {
                return table_;
            }

            set
            {
                table_ = value;
            }
        }

        public string Api_
        {
            get
            {
                return api_;
            }

            set
            {
                api_ = value;
            }
        }

        public string MainCombo_col1
        {
            get
            {
                return mainCombo_col1;
            }

            set
            {
                mainCombo_col1 = value;
            }
        }

        public string MainCombo_col2
        {
            get
            {
                return mainCombo_col2;
            }

            set
            {
                mainCombo_col2 = value;
            }
        }

        public string MainCombo_col3
        {
            get
            {
                return mainCombo_col3;
            }

            set
            {
                mainCombo_col3 = value;
            }
        }

        public string MainCombo_col4
        {
            get
            {
                return mainCombo_col4;
            }

            set
            {
                mainCombo_col4 = value;
            }
        }

        public string MainCombo_col1_sql
        {
            get
            {
                return mainCombo_col1_sql;
            }

            set
            {
                mainCombo_col1_sql = value;
            }
        }

        public string MainCombo_col2_sql
        {
            get
            {
                return mainCombo_col2_sql;
            }

            set
            {
                mainCombo_col2_sql = value;
            }
        }

        public string LOVFOCUS_
        {
            get
            {
                return LOVFOCUS;
            }

            set
            {
                LOVFOCUS = value;
            }
        }

        public string Zoomcol
        {
            get
            {
                return zoomcol;
            }

            set
            {
                zoomcol = value;
            }
        }

        protected string SearchATTR
        {
            get
            {
                return searchATTR;
            }

            set
            {
                searchATTR = value;
            }
        }

        public string SearchATTRTypes
        {
            get
            {
                return searchATTRTypes;
            }

            set
            {
                searchATTRTypes = value;
            }
        }

        public string SearchQ
        {
            get
            {
                return searchQ;
            }

            set
            {
                searchQ = value;
            }
        }
        #endregion
        
        public frmMasterDetail()
        {
            InitializeComponent();
            btnLov_Disable();
            btnZoom_Disable();
            btnRefresh_Disable();
            btnSave_Disable();
            btnDelete_Disable();
            WfmsText.Entered += OnEntered;
            WfmsText.Left += OnLeft;
            //dlgSearch.SearchThis += OnSearch;
        }

        public void OnEntered(object source, SQLColumnEventArgs e)
        {
            btnLov_Enable();
            btnZoom_Enable();
            Zoomcol = e.SqlColumn;
        }

        public void OnLeft(object source, EventArgs e)
        {
            btnLov_Disable();
            btnZoom_Disable();
            Zoomcol = "";
        }

        #region button animations
        private void btnPopulate_MouseDown(object sender, MouseEventArgs e)
        {
            btnPopulate.Image = Properties.Resources.populate_click;
        }

        private void btnPopulate_MouseLeave(object sender, EventArgs e)
        {
            btnPopulate.Image = Properties.Resources.populate_normal;
        }

        private void btnPopulate_MouseUp(object sender, MouseEventArgs e)
        {
            btnPopulate.Image = Properties.Resources.populate_normal;
        }

        private void btnPopulate_MouseEnter(object sender, EventArgs e)
        {
            btnPopulate.Image = Properties.Resources.populate_focus;
        }

        private void btnSave_MouseDown(object sender, MouseEventArgs e)
        {
            btnSave.Image = Properties.Resources.save_click;
        }

        private void btnSave_MouseEnter(object sender, EventArgs e)
        {
            btnSave.Image = Properties.Resources.save_focus;
        }

        private void btnSave_MouseLeave(object sender, EventArgs e)
        {
            btnSave.Image = Properties.Resources.save_normal;
        }

        private void btnSave_MouseUp(object sender, MouseEventArgs e)
        {
            btnSave.Image = Properties.Resources.save_normal;
        }

        private void btnLov_MouseDown(object sender, MouseEventArgs e)
        {
            btnLov.Image = Properties.Resources.LOV_click;
        }

        private void btnLov_MouseEnter(object sender, EventArgs e)
        {
            btnLov.Image = Properties.Resources.LOV_focus;
        }

        private void btnLov_MouseLeave(object sender, EventArgs e)
        {
            btnLov.Image = Properties.Resources.LOV_normal;
        }

        private void btnLov_MouseUp(object sender, MouseEventArgs e)
        {
            btnLov.Image = Properties.Resources.LOV_focus;
        }

        private void btnDelete_MouseDown(object sender, MouseEventArgs e)
        {
            btnDelete.Image = Properties.Resources.Delete_click;
        }

        private void btnDelete_MouseEnter(object sender, EventArgs e)
        {
            btnDelete.Image = Properties.Resources.Delete_focus;
        }

        private void btnDelete_MouseLeave(object sender, EventArgs e)
        {
            btnDelete.Image = Properties.Resources.Delete_normal;
        }

        private void btnDelete_MouseUp(object sender, MouseEventArgs e)
        {
            btnDelete.Image = Properties.Resources.Delete_focus;
        }

        private void btnZoom_MouseDown(object sender, MouseEventArgs e)
        {
            btnZoom.Image = Properties.Resources.navigate_click;
        }

        private void btnZoom_MouseEnter(object sender, EventArgs e)
        {
            btnZoom.Image = Properties.Resources.navigate_focus;
        }

        private void btnZoom_MouseLeave(object sender, EventArgs e)
        {
            btnZoom.Image = Properties.Resources.navigate_normal;
        }

        private void btnZoom_MouseUp(object sender, MouseEventArgs e)
        {
            btnZoom.Image = Properties.Resources.navigate_focus;
        }

        private void btnRefresh_MouseDown(object sender, MouseEventArgs e)
        {
            btnRefresh.Image = Properties.Resources.refresh_click;
        }

        private void btnRefresh_MouseEnter(object sender, EventArgs e)
        {
            btnRefresh.Image = Properties.Resources.refresh_focus;
        }

        private void btnRefresh_MouseLeave(object sender, EventArgs e)
        {
            btnRefresh.Image = Properties.Resources.refresh_normal;
        }

        private void btnRefresh_MouseUp(object sender, MouseEventArgs e)
        {
            btnRefresh.Image = Properties.Resources.refresh_focus;
        }

        private void btnSearch_MouseDown(object sender, MouseEventArgs e)
        {
            btnSearch.Image = Properties.Resources.search_click;
        }

        private void btnSearch_MouseEnter(object sender, EventArgs e)
        {
            btnSearch.Image = Properties.Resources.search_focus;
        }

        private void btnSearch_MouseLeave(object sender, EventArgs e)
        {
            btnSearch.Image = Properties.Resources.search_normal;
        }

        private void btnSearch_MouseUp(object sender, MouseEventArgs e)
        {
            btnSearch.Image = Properties.Resources.search_focus;
        }

        private void btnNew_MouseDown(object sender, MouseEventArgs e)
        {
            btnNew.Image = Properties.Resources.new_click;
        }

        private void btnNew_MouseEnter(object sender, EventArgs e)
        {
            btnNew.Image = Properties.Resources.new_focus;
        }

        private void btnNew_MouseLeave(object sender, EventArgs e)
        {
            btnNew.Image = Properties.Resources.new_normal;
        }

        private void btnNew_MouseUp(object sender, MouseEventArgs e)
        {
            btnNew.Image = Properties.Resources.new_focus;
        }
        #endregion

        #region ButtonEnableDisable
        public void btnPopulate_Enable()
        {
            btnPopulate.Enabled = true;
            btnPopulate.Image = Properties.Resources.populate_normal;
        }
        public void btnPopulate_Disable()
        {
            btnPopulate.Enabled = false;
            btnPopulate.Image = Properties.Resources.populate_disable;
        }
        public void btnNew_Enable()
        {
            btnNew.Enabled = true;
            btnNew.Image = Properties.Resources.new_normal;
        }
        public void btnNew_Disable()
        {
            btnNew.Enabled = false;
            btnNew.Image = Properties.Resources.new_disable;
        }
        public void btnSave_Enable()
        {
            btnSave.Enabled = true;
            btnSave.Image = Properties.Resources.save_normal;
        }
        public void btnSave_Disable()
        {
            btnSave.Enabled = false;
            btnSave.Image = Properties.Resources.save_disable;
        }
        public void btnLov_Enable()
        {
            btnLov.Enabled = true;
            btnLov.Image = Properties.Resources.LOV_normal;
        }
        public void btnLov_Disable()
        {
            btnLov.Enabled = false;
            btnLov.Image = Properties.Resources.LOV_disable;
        }
        public void btnDelete_Enable()
        {
            btnDelete.Enabled = true;
            btnDelete.Image = Properties.Resources.Delete_normal;
        }
        public void btnDelete_Disable()
        {
            btnDelete.Enabled = false;
            btnDelete.Image = Properties.Resources.Delete_Disable;
        }
        public void btnZoom_Enable()
        {
            btnZoom.Enabled = true;
            btnZoom.Image = Properties.Resources.navigate_normal;
        }
        public void btnZoom_Disable()
        {
            btnZoom.Enabled = false;
            btnZoom.Image = Properties.Resources.navigate_disable;
        }
        public void btnRefresh_Enable()
        {
            btnRefresh.Enabled = true;
            btnRefresh.Image = Properties.Resources.refresh_normal;
        }
        public void btnRefresh_Disable()
        {
            btnRefresh.Enabled = false;
            btnRefresh.Image = Properties.Resources.refresh_disable;
        }
        public void btnSearch_Enable()
        {
            btnSearch.Enabled = true;
            btnSearch.Image = Properties.Resources.search_normal;
        }
        public void btnSearch_Disable()
        {
            btnSearch.Enabled = false;
        }
        #endregion

        public delegate void ClckedNewEventHandler(object source, EventArgs args);
        public static event ClckedNewEventHandler ClickedNew;
        public static EventHandler<DataTable> ClickedPopulate;
        public static EventHandler ClickedPopulated;

        protected virtual void onClickedNew()
        {
            btnSave_Enable();
            if (ClickedNew != null)
                ClickedNew(this, EventArgs.Empty);
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            DBevent = "N";
            onClickedNew();
        }

        protected virtual void onClickedPopulate()
        {
            dt.Reset();
            if (MainCombo_col1 != null)
                dt.Columns.Add(MainCombo_col1, typeof(String));
            if (MainCombo_col2 != null)
                dt.Columns.Add(MainCombo_col2, typeof(String));
            if (MainCombo_col3 != null)
                dt.Columns.Add(MainCombo_col3, typeof(String));
            if (MainCombo_col4 != null)
                dt.Columns.Add(MainCombo_col4, typeof(String));
            /////
            try
            {
                DbConnect.OpenConnection();

                OracleCommand newCmd = DbConnect.connection.CreateCommand();
                newCmd.Connection = DbConnect.connection;
                newCmd.CommandType = CommandType.Text;
                if (SearchQ == "")
                    newCmd.CommandText = "select * from " + table_;
                else
                {
                    newCmd.CommandText = SearchQ;
                    SearchQ = "";
                }
                OracleDataReader dr = newCmd.ExecuteReader();

                while (dr.Read())
                {
                    dt.Rows.Add(dr[MainCombo_col1], dr[MainCombo_col2]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error :" + ex.Message);
            }
            finally
            {
                if (DbConnect.connection.State == ConnectionState.Open)
                {
                    DbConnect.connection.Close();
                }
            }
            /////
            if (ClickedPopulate != null)
                ClickedPopulate(this, dt);
            btnSave_Enable();
        }

        private void btnPopulate_Click(object sender, EventArgs e)
        {
            wfmsComboRecordPopulate.Items.Clear();
            if (!String.IsNullOrEmpty(table_))
            {
                onClickedPopulate();
            }
            DBevent = "U";
            ClickedPopulated(this, EventArgs.Empty);
        }

        public void OnEntered(object source, String sqlcol)
        {
            btnLov.Enabled = true;
            LOVFOCUS_ = sqlcol;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DBevent = "U";
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            DBevent = "D";
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            dlgSearch searchDialogue = new dlgSearch(Text, SearchATTR);
            SearchQ = "Select * from " + Table;
            searchDialogue.parent = this;
            searchDialogue.ShowDialog();
            //SearchQ = "Select * from " + Table + " Where ";

            if (!String.IsNullOrEmpty(table_))
            {
                onClickedPopulate();
            }

            //btnLov_Enable();
            //btnZoom_Enable();
            btnRefresh_Enable();
            btnSave_Enable();
            ClickedPopulated(this, EventArgs.Empty);
            //btnDelete_Enable();
        }

    }
}
