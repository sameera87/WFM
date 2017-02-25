namespace WFMS.Employee.Clients
{
    partial class frmEmployee
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmEmployee));
            this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtEmpID = new WFMS.Common.Controls.WfmsText();
            this.metroLabel2 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtEmpName = new WFMS.Common.Controls.WfmsText();
            this.metroLabel3 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtAddLine1 = new WFMS.Common.Controls.WfmsText();
            this.metroLabel4 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtAddLine2 = new WFMS.Common.Controls.WfmsText();
            this.metroLabel5 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCity = new WFMS.Common.Controls.WfmsText();
            this.metroLabel6 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtZipCode = new WFMS.Common.Controls.WfmsText();
            ((System.ComponentModel.ISupportInitialize)(this.dt)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLov)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).BeginInit();
            this.SuspendLayout();
            // 
            // btnSave
            // 
            this.btnSave.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.Image")));
            // 
            // wfmsDate
            // 
            this.wfmsDate.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // metroLabel1
            // 
            this.metroLabel1.AutoSize = true;
            this.metroLabel1.Location = new System.Drawing.Point(34, 144);
            this.metroLabel1.Name = "metroLabel1";
            this.metroLabel1.Size = new System.Drawing.Size(83, 19);
            this.metroLabel1.TabIndex = 14;
            this.metroLabel1.Text = "Employee ID";
            // 
            // wfmsTxtEmpID
            // 
            this.wfmsTxtEmpID.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtEmpID.CustomButton.Image = null;
            this.wfmsTxtEmpID.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtEmpID.CustomButton.Name = "";
            this.wfmsTxtEmpID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtEmpID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtEmpID.CustomButton.TabIndex = 1;
            this.wfmsTxtEmpID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtEmpID.CustomButton.UseSelectable = true;
            this.wfmsTxtEmpID.CustomButton.Visible = false;
            this.wfmsTxtEmpID.Datatype = "";
            this.wfmsTxtEmpID.Edited = true;
            this.wfmsTxtEmpID.Enabled = false;
            this.wfmsTxtEmpID.Lines = new string[0];
            this.wfmsTxtEmpID.Location = new System.Drawing.Point(143, 144);
            this.wfmsTxtEmpID.LOV = false;
            this.wfmsTxtEmpID.Mand = false;
            this.wfmsTxtEmpID.MaxLength = 32767;
            this.wfmsTxtEmpID.Name = "wfmsTxtEmpID";
            this.wfmsTxtEmpID.PasswordChar = '\0';
            this.wfmsTxtEmpID.PrimaryKey = true;
            this.wfmsTxtEmpID.ReadOnly = true;
            this.wfmsTxtEmpID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtEmpID.SelectedText = "";
            this.wfmsTxtEmpID.SelectionLength = 0;
            this.wfmsTxtEmpID.SelectionStart = 0;
            this.wfmsTxtEmpID.ShortcutsEnabled = true;
            this.wfmsTxtEmpID.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtEmpID.SQLColumn = "";
            this.wfmsTxtEmpID.TabIndex = 15;
            this.wfmsTxtEmpID.UseCustomBackColor = true;
            this.wfmsTxtEmpID.UseSelectable = true;
            this.wfmsTxtEmpID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtEmpID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel2
            // 
            this.metroLabel2.AutoSize = true;
            this.metroLabel2.Location = new System.Drawing.Point(34, 188);
            this.metroLabel2.Name = "metroLabel2";
            this.metroLabel2.Size = new System.Drawing.Size(45, 19);
            this.metroLabel2.TabIndex = 16;
            this.metroLabel2.Text = "Name";
            // 
            // wfmsTxtEmpName
            // 
            this.wfmsTxtEmpName.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtEmpName.CustomButton.Image = null;
            this.wfmsTxtEmpName.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtEmpName.CustomButton.Name = "";
            this.wfmsTxtEmpName.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtEmpName.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtEmpName.CustomButton.TabIndex = 1;
            this.wfmsTxtEmpName.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtEmpName.CustomButton.UseSelectable = true;
            this.wfmsTxtEmpName.CustomButton.Visible = false;
            this.wfmsTxtEmpName.Datatype = "";
            this.wfmsTxtEmpName.Edited = true;
            this.wfmsTxtEmpName.Enabled = false;
            this.wfmsTxtEmpName.Lines = new string[0];
            this.wfmsTxtEmpName.Location = new System.Drawing.Point(143, 188);
            this.wfmsTxtEmpName.LOV = false;
            this.wfmsTxtEmpName.Mand = true;
            this.wfmsTxtEmpName.MaxLength = 32767;
            this.wfmsTxtEmpName.Name = "wfmsTxtEmpName";
            this.wfmsTxtEmpName.PasswordChar = '\0';
            this.wfmsTxtEmpName.PrimaryKey = false;
            this.wfmsTxtEmpName.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtEmpName.SelectedText = "";
            this.wfmsTxtEmpName.SelectionLength = 0;
            this.wfmsTxtEmpName.SelectionStart = 0;
            this.wfmsTxtEmpName.ShortcutsEnabled = true;
            this.wfmsTxtEmpName.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtEmpName.SQLColumn = "";
            this.wfmsTxtEmpName.TabIndex = 17;
            this.wfmsTxtEmpName.UseCustomBackColor = true;
            this.wfmsTxtEmpName.UseSelectable = true;
            this.wfmsTxtEmpName.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtEmpName.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel3
            // 
            this.metroLabel3.AutoSize = true;
            this.metroLabel3.Location = new System.Drawing.Point(34, 232);
            this.metroLabel3.Name = "metroLabel3";
            this.metroLabel3.Size = new System.Drawing.Size(92, 19);
            this.metroLabel3.TabIndex = 18;
            this.metroLabel3.Text = "Address Line 1";
            // 
            // wfmsTxtAddLine1
            // 
            this.wfmsTxtAddLine1.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtAddLine1.CustomButton.Image = null;
            this.wfmsTxtAddLine1.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtAddLine1.CustomButton.Name = "";
            this.wfmsTxtAddLine1.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtAddLine1.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtAddLine1.CustomButton.TabIndex = 1;
            this.wfmsTxtAddLine1.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtAddLine1.CustomButton.UseSelectable = true;
            this.wfmsTxtAddLine1.CustomButton.Visible = false;
            this.wfmsTxtAddLine1.Datatype = "";
            this.wfmsTxtAddLine1.Edited = true;
            this.wfmsTxtAddLine1.Enabled = false;
            this.wfmsTxtAddLine1.Lines = new string[0];
            this.wfmsTxtAddLine1.Location = new System.Drawing.Point(143, 232);
            this.wfmsTxtAddLine1.LOV = false;
            this.wfmsTxtAddLine1.Mand = true;
            this.wfmsTxtAddLine1.MaxLength = 32767;
            this.wfmsTxtAddLine1.Multiline = true;
            this.wfmsTxtAddLine1.Name = "wfmsTxtAddLine1";
            this.wfmsTxtAddLine1.PasswordChar = '\0';
            this.wfmsTxtAddLine1.PrimaryKey = false;
            this.wfmsTxtAddLine1.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtAddLine1.SelectedText = "";
            this.wfmsTxtAddLine1.SelectionLength = 0;
            this.wfmsTxtAddLine1.SelectionStart = 0;
            this.wfmsTxtAddLine1.ShortcutsEnabled = true;
            this.wfmsTxtAddLine1.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtAddLine1.SQLColumn = "";
            this.wfmsTxtAddLine1.TabIndex = 19;
            this.wfmsTxtAddLine1.UseCustomBackColor = true;
            this.wfmsTxtAddLine1.UseSelectable = true;
            this.wfmsTxtAddLine1.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtAddLine1.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel4
            // 
            this.metroLabel4.AutoSize = true;
            this.metroLabel4.Location = new System.Drawing.Point(34, 276);
            this.metroLabel4.Name = "metroLabel4";
            this.metroLabel4.Size = new System.Drawing.Size(94, 19);
            this.metroLabel4.TabIndex = 20;
            this.metroLabel4.Text = "Address Line 2";
            // 
            // wfmsTxtAddLine2
            // 
            this.wfmsTxtAddLine2.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtAddLine2.CustomButton.Image = null;
            this.wfmsTxtAddLine2.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtAddLine2.CustomButton.Name = "";
            this.wfmsTxtAddLine2.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtAddLine2.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtAddLine2.CustomButton.TabIndex = 1;
            this.wfmsTxtAddLine2.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtAddLine2.CustomButton.UseSelectable = true;
            this.wfmsTxtAddLine2.CustomButton.Visible = false;
            this.wfmsTxtAddLine2.Datatype = "";
            this.wfmsTxtAddLine2.Edited = true;
            this.wfmsTxtAddLine2.Enabled = false;
            this.wfmsTxtAddLine2.Lines = new string[0];
            this.wfmsTxtAddLine2.Location = new System.Drawing.Point(143, 276);
            this.wfmsTxtAddLine2.LOV = false;
            this.wfmsTxtAddLine2.Mand = false;
            this.wfmsTxtAddLine2.MaxLength = 32767;
            this.wfmsTxtAddLine2.Multiline = true;
            this.wfmsTxtAddLine2.Name = "wfmsTxtAddLine2";
            this.wfmsTxtAddLine2.PasswordChar = '\0';
            this.wfmsTxtAddLine2.PrimaryKey = false;
            this.wfmsTxtAddLine2.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtAddLine2.SelectedText = "";
            this.wfmsTxtAddLine2.SelectionLength = 0;
            this.wfmsTxtAddLine2.SelectionStart = 0;
            this.wfmsTxtAddLine2.ShortcutsEnabled = true;
            this.wfmsTxtAddLine2.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtAddLine2.SQLColumn = "";
            this.wfmsTxtAddLine2.TabIndex = 21;
            this.wfmsTxtAddLine2.UseCustomBackColor = true;
            this.wfmsTxtAddLine2.UseSelectable = true;
            this.wfmsTxtAddLine2.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtAddLine2.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel5
            // 
            this.metroLabel5.AutoSize = true;
            this.metroLabel5.Location = new System.Drawing.Point(34, 320);
            this.metroLabel5.Name = "metroLabel5";
            this.metroLabel5.Size = new System.Drawing.Size(31, 19);
            this.metroLabel5.TabIndex = 22;
            this.metroLabel5.Text = "City";
            // 
            // wfmsTxtCity
            // 
            this.wfmsTxtCity.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCity.CustomButton.Image = null;
            this.wfmsTxtCity.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtCity.CustomButton.Name = "";
            this.wfmsTxtCity.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtCity.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCity.CustomButton.TabIndex = 1;
            this.wfmsTxtCity.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCity.CustomButton.UseSelectable = true;
            this.wfmsTxtCity.CustomButton.Visible = false;
            this.wfmsTxtCity.Datatype = "";
            this.wfmsTxtCity.Edited = true;
            this.wfmsTxtCity.Enabled = false;
            this.wfmsTxtCity.Lines = new string[0];
            this.wfmsTxtCity.Location = new System.Drawing.Point(143, 320);
            this.wfmsTxtCity.LOV = false;
            this.wfmsTxtCity.Mand = false;
            this.wfmsTxtCity.MaxLength = 32767;
            this.wfmsTxtCity.Name = "wfmsTxtCity";
            this.wfmsTxtCity.PasswordChar = '\0';
            this.wfmsTxtCity.PrimaryKey = false;
            this.wfmsTxtCity.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCity.SelectedText = "";
            this.wfmsTxtCity.SelectionLength = 0;
            this.wfmsTxtCity.SelectionStart = 0;
            this.wfmsTxtCity.ShortcutsEnabled = true;
            this.wfmsTxtCity.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtCity.SQLColumn = "";
            this.wfmsTxtCity.TabIndex = 23;
            this.wfmsTxtCity.UseCustomBackColor = true;
            this.wfmsTxtCity.UseSelectable = true;
            this.wfmsTxtCity.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCity.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel6
            // 
            this.metroLabel6.AutoSize = true;
            this.metroLabel6.Location = new System.Drawing.Point(34, 364);
            this.metroLabel6.Name = "metroLabel6";
            this.metroLabel6.Size = new System.Drawing.Size(64, 19);
            this.metroLabel6.TabIndex = 24;
            this.metroLabel6.Text = "Zip Code";
            // 
            // wfmsTxtZipCode
            // 
            this.wfmsTxtZipCode.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtZipCode.CustomButton.Image = null;
            this.wfmsTxtZipCode.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtZipCode.CustomButton.Name = "";
            this.wfmsTxtZipCode.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtZipCode.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtZipCode.CustomButton.TabIndex = 1;
            this.wfmsTxtZipCode.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtZipCode.CustomButton.UseSelectable = true;
            this.wfmsTxtZipCode.CustomButton.Visible = false;
            this.wfmsTxtZipCode.Datatype = "";
            this.wfmsTxtZipCode.Edited = true;
            this.wfmsTxtZipCode.Enabled = false;
            this.wfmsTxtZipCode.Lines = new string[0];
            this.wfmsTxtZipCode.Location = new System.Drawing.Point(143, 364);
            this.wfmsTxtZipCode.LOV = false;
            this.wfmsTxtZipCode.Mand = true;
            this.wfmsTxtZipCode.MaxLength = 32767;
            this.wfmsTxtZipCode.Name = "wfmsTxtZipCode";
            this.wfmsTxtZipCode.PasswordChar = '\0';
            this.wfmsTxtZipCode.PrimaryKey = false;
            this.wfmsTxtZipCode.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtZipCode.SelectedText = "";
            this.wfmsTxtZipCode.SelectionLength = 0;
            this.wfmsTxtZipCode.SelectionStart = 0;
            this.wfmsTxtZipCode.ShortcutsEnabled = true;
            this.wfmsTxtZipCode.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtZipCode.SQLColumn = "";
            this.wfmsTxtZipCode.TabIndex = 25;
            this.wfmsTxtZipCode.UseCustomBackColor = true;
            this.wfmsTxtZipCode.UseSelectable = true;
            this.wfmsTxtZipCode.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtZipCode.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // frmEmployee
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.wfmsTxtZipCode);
            this.Controls.Add(this.metroLabel6);
            this.Controls.Add(this.wfmsTxtCity);
            this.Controls.Add(this.metroLabel5);
            this.Controls.Add(this.wfmsTxtAddLine2);
            this.Controls.Add(this.metroLabel4);
            this.Controls.Add(this.wfmsTxtAddLine1);
            this.Controls.Add(this.metroLabel3);
            this.Controls.Add(this.wfmsTxtEmpName);
            this.Controls.Add(this.metroLabel2);
            this.Controls.Add(this.wfmsTxtEmpID);
            this.Controls.Add(this.metroLabel1);
            this.Location = new System.Drawing.Point(0, 0);
            this.Name = "frmEmployee";
            this.Table = "EMPLOYEE_TAB";
            this.Text = "Employee Details";
            this.Controls.SetChildIndex(this.metroLabel1, 0);
            this.Controls.SetChildIndex(this.wfmsTxtEmpID, 0);
            this.Controls.SetChildIndex(this.metroLabel2, 0);
            this.Controls.SetChildIndex(this.wfmsTxtEmpName, 0);
            this.Controls.SetChildIndex(this.wfmsComboRecordPopulate, 0);
            this.Controls.SetChildIndex(this.btnPopulate, 0);
            this.Controls.SetChildIndex(this.btnNew, 0);
            this.Controls.SetChildIndex(this.btnSave, 0);
            this.Controls.SetChildIndex(this.btnLov, 0);
            this.Controls.SetChildIndex(this.btnDelete, 0);
            this.Controls.SetChildIndex(this.btnZoom, 0);
            this.Controls.SetChildIndex(this.btnRefresh, 0);
            this.Controls.SetChildIndex(this.btnSearch, 0);
            this.Controls.SetChildIndex(this.wfmsDate, 0);
            this.Controls.SetChildIndex(this.metroLabel1i, 0);
            this.Controls.SetChildIndex(this.metroLabel2i, 0);
            this.Controls.SetChildIndex(this.wfmsDtpModified, 0);
            this.Controls.SetChildIndex(this.wfmsDtpCreated, 0);
            this.Controls.SetChildIndex(this.metroLabel3, 0);
            this.Controls.SetChildIndex(this.wfmsTxtAddLine1, 0);
            this.Controls.SetChildIndex(this.metroLabel4, 0);
            this.Controls.SetChildIndex(this.wfmsTxtAddLine2, 0);
            this.Controls.SetChildIndex(this.metroLabel5, 0);
            this.Controls.SetChildIndex(this.wfmsTxtCity, 0);
            this.Controls.SetChildIndex(this.metroLabel6, 0);
            this.Controls.SetChildIndex(this.wfmsTxtZipCode, 0);
            ((System.ComponentModel.ISupportInitialize)(this.dt)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLov)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MetroFramework.Controls.MetroLabel metroLabel1;
        private Common.Controls.WfmsText wfmsTxtEmpID;
        private MetroFramework.Controls.MetroLabel metroLabel2;
        private Common.Controls.WfmsText wfmsTxtEmpName;
        private MetroFramework.Controls.MetroLabel metroLabel3;
        private Common.Controls.WfmsText wfmsTxtAddLine1;
        private MetroFramework.Controls.MetroLabel metroLabel4;
        private Common.Controls.WfmsText wfmsTxtAddLine2;
        private MetroFramework.Controls.MetroLabel metroLabel5;
        private Common.Controls.WfmsText wfmsTxtCity;
        private MetroFramework.Controls.MetroLabel metroLabel6;
        private Common.Controls.WfmsText wfmsTxtZipCode;
    }
}
