using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Threading.Tasks;
using System.Data;
using MetroFramework.Controls;
using WFMS.Common.Clients;

namespace WFMS.Common.Controls
{
    public class WfmsText : MetroTextBox
    {
        public WfmsText()
        {
            InitializeComponent();
            frmMasterDetail.ClickedNew += onClickedNew;
            frmMasterDetail.ClickedPopulated += onClickedpop;
        }

        private void onClickedpop(object sender, EventArgs e)
        {
            if (!PrimaryKey)
                Enabled = true;
            UseCustomBackColor = true;
            BackColor = Color.White;
        }

        public static EventHandler<SQLColumnEventArgs> Entered;
        public static EventHandler Left;

        #region Properties

        private bool Editedd = false;
        private bool Mandatory = false;
        private string SQL_COL = "";
        private bool LoV = false;
        private string datatype = "";
        private bool primaryKey = false;

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

        public bool LOV
        {
            get
            {
                return LoV;
            }
            set
            {
                LoV = value;
            }
        }

        public string Datatype
        {
            get
            {
                return datatype;
            }

            set
            {
                datatype = value;
            }
        }

        public bool PrimaryKey
        {
            get
            {
                return primaryKey;
            }

            set
            {
                primaryKey = value;
            }
        }
        #endregion

        public void onClickedNew(object source, EventArgs e)
        {
            Enabled = true;
            UseCustomBackColor = true;
            BackColor = Color.White;
            if (this.Mand == true)
                BackColor = Color.LightSkyBlue;
        }

        private void metroTextBox1_TextChanged(object sender, EventArgs e)
        {
            UseCustomBackColor = true;
            if (Mand == true)
            {
                BackColor = default(Color);
            }
        }      

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            //
            // 
            this.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.CustomButton.Image = null;
            this.CustomButton.Location = new System.Drawing.Point(-20, 2);
            this.CustomButton.Name = "";
            this.CustomButton.Size = new System.Drawing.Size(17, 17);
            this.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.CustomButton.TabIndex = 1;
            this.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.CustomButton.UseSelectable = true;
            this.CustomButton.Visible = false;
            this.Enabled = false;
            this.Lines = new string[0];
            this.TextChanged += new System.EventHandler(this.WfmsText_TextChanged);
            this.Enter += new System.EventHandler(this.WfmsText_Enter);
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.WfmsText_KeyPress);
            this.Leave += new System.EventHandler(this.WfmsText_Leave);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        private void WfmsText_TextChanged(object sender, EventArgs e)
        {
            UseCustomBackColor = true;
            if (Mand == true)
            {
                BackColor = default(Color);
            }
            Edited = true;    
        }

        private void WfmsText_Enter(object sender, EventArgs e)
        {
            OnEntered();               
        }

        protected virtual void OnEntered()
        {
            if (LOV == true)
            {                
                if (Entered != null)
                    Entered(this, new SQLColumnEventArgs() { SqlColumn = SQLColumn});
            }
        }

        private void WfmsText_Leave(object sender, EventArgs e)
        {
            OnLeft();
        }

        protected virtual void OnLeft()
        {            
            if (Left != null)
                Left(this, EventArgs.Empty);            
        }

        private void WfmsText_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            if (Datatype == "NUMBER")
            {
                if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
                {
                    e.Handled = true;
                }

                // only allow one decimal point
                if (e.KeyChar == '.' && Text.IndexOf('.') > -1)
                {
                    e.Handled = true;
                }

                //base.OnKeyPress(e);
            }
        }
    }

    public class SQLColumnEventArgs : EventArgs
    {
        public string SqlColumn { get; set; }
    }
}
