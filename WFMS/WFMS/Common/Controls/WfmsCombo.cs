using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading.Tasks;
using MetroFramework.Controls;
using WFMS.Common.Clients;

namespace WFMS.Common.Controls
{
    public class WfmsCombo : MetroComboBox
    {
        public WfmsCombo()
        {
            //InitializeComponent();    
            frmMasterDetail.ClickedPopulate += onClickedPopulate;
            frmMasterDetail.ClickedNew += onClickedNew;
        }

        #region Properties

        private bool Editedd = false;
        private bool Mandatory = false;
        private string SQL_COL = "";
        private bool mainCMB = false;
        private bool foreverDisable = false;

        public bool Edited
        {
            get
            {
                return Editedd;
            }
            set
            {
                Editedd = value;
            }
        }

        public bool Mand
        {
            get
            {
                return Mandatory;
            }
            set
            {
                Mandatory = value;
            }
        }

        public string SQLColumn
        {
            get
            {
                return SQL_COL;
            }
            set
            {
                SQL_COL = value;
            }
        }

        public bool MainCMB
        {
            get
            {
                return mainCMB;
            }

            set
            {
                mainCMB = value;
            }
        }

        public bool ForeverDisable
        {
            get
            {
                return foreverDisable;
            }

            set
            {
                foreverDisable = value;
            }
        }
        #endregion

        #region Methods

        public void onClickedPopulate(object source, DataTable dt)
        {
            if (MainCMB == true)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Items.Add(dt.Rows[i][0] + "     | " + dt.Rows[i][1]);
                }
                if (dt.Rows.Count > 1)
                {
                    Visible = true;
                    SelectedIndex = 0;
                }
                else if (dt.Rows.Count > 0)
                {
                    SelectedIndex = 0;
                }
                //DataSource = dt;
            }
        }

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            //
            // 
            this.BackColor = System.Drawing.Color.LightGray;
            this.Enabled = false;
            this.ResumeLayout(false);

        }

        public void onClickedNew(object source, EventArgs e)
        {
            if (ForeverDisable != true)
                Enabled = true;
        }

        #endregion

    }
}