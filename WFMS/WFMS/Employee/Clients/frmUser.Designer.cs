namespace WFMS.Employee.Clients
{
    partial class frmUser
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
            this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtUserID = new WFMS.Common.Controls.WfmsText();
            this.metroLabel2 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtFirstName = new WFMS.Common.Controls.WfmsText();
            this.metroLabel3 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtLastName = new WFMS.Common.Controls.WfmsText();
            this.metroLabel4 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtPassword = new WFMS.Common.Controls.WfmsText();
            this.metroLabel5 = new MetroFramework.Controls.MetroLabel();
            this.wfmsCmbUserType = new WFMS.Common.Controls.WfmsCombo();
            this.metroLabel6 = new MetroFramework.Controls.MetroLabel();
            this.wfmsDtpCreated = new WFMS.Common.Controls.WfmsDate();
            this.metroLabel7 = new MetroFramework.Controls.MetroLabel();
            this.wfmsDtpModified = new WFMS.Common.Controls.WfmsDate();
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
            // wfmsComboRecordPopulate
            // 
            this.wfmsComboRecordPopulate.SelectedIndexChanged += new System.EventHandler(this.wfmsComboRecordPopulate_SelectedIndexChanged);
            // 
            // btnSave
            // 
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
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
            this.metroLabel1.Size = new System.Drawing.Size(51, 19);
            this.metroLabel1.TabIndex = 10;
            this.metroLabel1.Text = "User ID";
            // 
            // wfmsTxtUserID
            // 
            this.wfmsTxtUserID.BackColor = System.Drawing.Color.LightGray;
            this.wfmsTxtUserID.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            // 
            // 
            // 
            this.wfmsTxtUserID.CustomButton.Image = null;
            this.wfmsTxtUserID.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtUserID.CustomButton.Name = "";
            this.wfmsTxtUserID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtUserID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtUserID.CustomButton.TabIndex = 1;
            this.wfmsTxtUserID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtUserID.CustomButton.UseSelectable = true;
            this.wfmsTxtUserID.CustomButton.Visible = false;
            this.wfmsTxtUserID.Datatype = "";
            this.wfmsTxtUserID.Edited = false;
            this.wfmsTxtUserID.Enabled = false;
            this.wfmsTxtUserID.Lines = new string[0];
            this.wfmsTxtUserID.Location = new System.Drawing.Point(143, 144);
            this.wfmsTxtUserID.LOV = false;
            this.wfmsTxtUserID.Mand = true;
            this.wfmsTxtUserID.MaxLength = 32767;
            this.wfmsTxtUserID.Name = "wfmsTxtUserID";
            this.wfmsTxtUserID.PasswordChar = '\0';
            this.wfmsTxtUserID.PrimaryKey = true;
            this.wfmsTxtUserID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtUserID.SelectedText = "";
            this.wfmsTxtUserID.SelectionLength = 0;
            this.wfmsTxtUserID.SelectionStart = 0;
            this.wfmsTxtUserID.ShortcutsEnabled = true;
            this.wfmsTxtUserID.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtUserID.SQLColumn = "USER_ID";
            this.wfmsTxtUserID.TabIndex = 11;
            this.wfmsTxtUserID.UseCustomBackColor = true;
            this.wfmsTxtUserID.UseSelectable = true;
            this.wfmsTxtUserID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtUserID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            this.wfmsTxtUserID.Enter += new System.EventHandler(this.wfmsTxtUserID_Enter);
            // 
            // metroLabel2
            // 
            this.metroLabel2.AutoSize = true;
            this.metroLabel2.Location = new System.Drawing.Point(34, 188);
            this.metroLabel2.Name = "metroLabel2";
            this.metroLabel2.Size = new System.Drawing.Size(73, 19);
            this.metroLabel2.TabIndex = 12;
            this.metroLabel2.Text = "First Name";
            // 
            // wfmsTxtFirstName
            // 
            this.wfmsTxtFirstName.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtFirstName.CustomButton.Image = null;
            this.wfmsTxtFirstName.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtFirstName.CustomButton.Name = "";
            this.wfmsTxtFirstName.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtFirstName.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtFirstName.CustomButton.TabIndex = 1;
            this.wfmsTxtFirstName.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtFirstName.CustomButton.UseSelectable = true;
            this.wfmsTxtFirstName.CustomButton.Visible = false;
            this.wfmsTxtFirstName.Datatype = "";
            this.wfmsTxtFirstName.Edited = false;
            this.wfmsTxtFirstName.Enabled = false;
            this.wfmsTxtFirstName.Lines = new string[0];
            this.wfmsTxtFirstName.Location = new System.Drawing.Point(143, 188);
            this.wfmsTxtFirstName.LOV = false;
            this.wfmsTxtFirstName.Mand = true;
            this.wfmsTxtFirstName.MaxLength = 32767;
            this.wfmsTxtFirstName.Name = "wfmsTxtFirstName";
            this.wfmsTxtFirstName.PasswordChar = '\0';
            this.wfmsTxtFirstName.PrimaryKey = false;
            this.wfmsTxtFirstName.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtFirstName.SelectedText = "";
            this.wfmsTxtFirstName.SelectionLength = 0;
            this.wfmsTxtFirstName.SelectionStart = 0;
            this.wfmsTxtFirstName.ShortcutsEnabled = true;
            this.wfmsTxtFirstName.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtFirstName.SQLColumn = "FIRST_NAME";
            this.wfmsTxtFirstName.TabIndex = 13;
            this.wfmsTxtFirstName.UseCustomBackColor = true;
            this.wfmsTxtFirstName.UseSelectable = true;
            this.wfmsTxtFirstName.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtFirstName.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel3
            // 
            this.metroLabel3.AutoSize = true;
            this.metroLabel3.Location = new System.Drawing.Point(34, 232);
            this.metroLabel3.Name = "metroLabel3";
            this.metroLabel3.Size = new System.Drawing.Size(71, 19);
            this.metroLabel3.TabIndex = 14;
            this.metroLabel3.Text = "Last Name";
            // 
            // wfmsTxtLastName
            // 
            this.wfmsTxtLastName.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtLastName.CustomButton.Image = null;
            this.wfmsTxtLastName.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtLastName.CustomButton.Name = "";
            this.wfmsTxtLastName.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtLastName.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtLastName.CustomButton.TabIndex = 1;
            this.wfmsTxtLastName.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtLastName.CustomButton.UseSelectable = true;
            this.wfmsTxtLastName.CustomButton.Visible = false;
            this.wfmsTxtLastName.Datatype = "";
            this.wfmsTxtLastName.Edited = true;
            this.wfmsTxtLastName.Enabled = false;
            this.wfmsTxtLastName.Lines = new string[0];
            this.wfmsTxtLastName.Location = new System.Drawing.Point(143, 232);
            this.wfmsTxtLastName.LOV = false;
            this.wfmsTxtLastName.Mand = false;
            this.wfmsTxtLastName.MaxLength = 32767;
            this.wfmsTxtLastName.Name = "wfmsTxtLastName";
            this.wfmsTxtLastName.PasswordChar = '\0';
            this.wfmsTxtLastName.PrimaryKey = false;
            this.wfmsTxtLastName.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtLastName.SelectedText = "";
            this.wfmsTxtLastName.SelectionLength = 0;
            this.wfmsTxtLastName.SelectionStart = 0;
            this.wfmsTxtLastName.ShortcutsEnabled = true;
            this.wfmsTxtLastName.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtLastName.SQLColumn = "LAST_NAME";
            this.wfmsTxtLastName.TabIndex = 15;
            this.wfmsTxtLastName.UseCustomBackColor = true;
            this.wfmsTxtLastName.UseSelectable = true;
            this.wfmsTxtLastName.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtLastName.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel4
            // 
            this.metroLabel4.AutoSize = true;
            this.metroLabel4.Location = new System.Drawing.Point(34, 276);
            this.metroLabel4.Name = "metroLabel4";
            this.metroLabel4.Size = new System.Drawing.Size(63, 19);
            this.metroLabel4.TabIndex = 16;
            this.metroLabel4.Text = "Password";
            // 
            // wfmsTxtPassword
            // 
            this.wfmsTxtPassword.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtPassword.CustomButton.Image = null;
            this.wfmsTxtPassword.CustomButton.Location = new System.Drawing.Point(217, 1);
            this.wfmsTxtPassword.CustomButton.Name = "";
            this.wfmsTxtPassword.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtPassword.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtPassword.CustomButton.TabIndex = 1;
            this.wfmsTxtPassword.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtPassword.CustomButton.UseSelectable = true;
            this.wfmsTxtPassword.CustomButton.Visible = false;
            this.wfmsTxtPassword.Datatype = "";
            this.wfmsTxtPassword.Edited = false;
            this.wfmsTxtPassword.Enabled = false;
            this.wfmsTxtPassword.Lines = new string[0];
            this.wfmsTxtPassword.Location = new System.Drawing.Point(143, 276);
            this.wfmsTxtPassword.LOV = false;
            this.wfmsTxtPassword.Mand = true;
            this.wfmsTxtPassword.MaxLength = 32767;
            this.wfmsTxtPassword.Name = "wfmsTxtPassword";
            this.wfmsTxtPassword.PasswordChar = '\0';
            this.wfmsTxtPassword.PrimaryKey = false;
            this.wfmsTxtPassword.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtPassword.SelectedText = "";
            this.wfmsTxtPassword.SelectionLength = 0;
            this.wfmsTxtPassword.SelectionStart = 0;
            this.wfmsTxtPassword.ShortcutsEnabled = true;
            this.wfmsTxtPassword.Size = new System.Drawing.Size(239, 23);
            this.wfmsTxtPassword.SQLColumn = "PASSWORD";
            this.wfmsTxtPassword.TabIndex = 17;
            this.wfmsTxtPassword.UseCustomBackColor = true;
            this.wfmsTxtPassword.UseSelectable = true;
            this.wfmsTxtPassword.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtPassword.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel5
            // 
            this.metroLabel5.AutoSize = true;
            this.metroLabel5.Location = new System.Drawing.Point(34, 320);
            this.metroLabel5.Name = "metroLabel5";
            this.metroLabel5.Size = new System.Drawing.Size(66, 19);
            this.metroLabel5.TabIndex = 18;
            this.metroLabel5.Text = "User Type";
            // 
            // wfmsCmbUserType
            // 
            this.wfmsCmbUserType.BackColor = System.Drawing.Color.LightGray;
            this.wfmsCmbUserType.Edited = false;
            this.wfmsCmbUserType.Enabled = false;
            this.wfmsCmbUserType.ForeverDisable = false;
            this.wfmsCmbUserType.FormattingEnabled = true;
            this.wfmsCmbUserType.ItemHeight = 23;
            this.wfmsCmbUserType.Items.AddRange(new object[] {
            "Accountant",
            "Customer",
            "Executive",
            "Field Service Engineer",
            "Manager",
            "Senior Manager",
            "System Administrator"});
            this.wfmsCmbUserType.Location = new System.Drawing.Point(143, 320);
            this.wfmsCmbUserType.MainCMB = false;
            this.wfmsCmbUserType.Mand = false;
            this.wfmsCmbUserType.Name = "wfmsCmbUserType";
            this.wfmsCmbUserType.Size = new System.Drawing.Size(239, 29);
            this.wfmsCmbUserType.SQLColumn = "UESR_TYPE";
            this.wfmsCmbUserType.TabIndex = 19;
            this.wfmsCmbUserType.UseSelectable = true;
            // 
            // metroLabel6
            // 
            this.metroLabel6.AutoSize = true;
            this.metroLabel6.Location = new System.Drawing.Point(34, 370);
            this.metroLabel6.Name = "metroLabel6";
            this.metroLabel6.Size = new System.Drawing.Size(56, 19);
            this.metroLabel6.TabIndex = 20;
            this.metroLabel6.Text = "Created";
            // 
            // wfmsDtpCreated
            // 
            this.wfmsDtpCreated.Enabled = false;
            this.wfmsDtpCreated.Location = new System.Drawing.Point(143, 370);
            this.wfmsDtpCreated.MinimumSize = new System.Drawing.Size(0, 29);
            this.wfmsDtpCreated.Name = "wfmsDtpCreated";
            this.wfmsDtpCreated.Size = new System.Drawing.Size(239, 29);
            this.wfmsDtpCreated.SQLColumn = "CREATED_DATE";
            this.wfmsDtpCreated.TabIndex = 21;
            // 
            // metroLabel7
            // 
            this.metroLabel7.AutoSize = true;
            this.metroLabel7.Location = new System.Drawing.Point(34, 420);
            this.metroLabel7.Name = "metroLabel7";
            this.metroLabel7.Size = new System.Drawing.Size(62, 19);
            this.metroLabel7.TabIndex = 22;
            this.metroLabel7.Text = "Modified";
            // 
            // wfmsDtpModified
            // 
            this.wfmsDtpModified.Enabled = false;
            this.wfmsDtpModified.Location = new System.Drawing.Point(143, 420);
            this.wfmsDtpModified.MinimumSize = new System.Drawing.Size(0, 29);
            this.wfmsDtpModified.Name = "wfmsDtpModified";
            this.wfmsDtpModified.Size = new System.Drawing.Size(239, 29);
            this.wfmsDtpModified.SQLColumn = "MODIFIED_DATE";
            this.wfmsDtpModified.TabIndex = 23;
            // 
            // frmUser
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.wfmsDtpModified);
            this.Controls.Add(this.metroLabel7);
            this.Controls.Add(this.wfmsDtpCreated);
            this.Controls.Add(this.metroLabel6);
            this.Controls.Add(this.wfmsCmbUserType);
            this.Controls.Add(this.metroLabel5);
            this.Controls.Add(this.wfmsTxtPassword);
            this.Controls.Add(this.metroLabel4);
            this.Controls.Add(this.wfmsTxtLastName);
            this.Controls.Add(this.metroLabel3);
            this.Controls.Add(this.wfmsTxtFirstName);
            this.Controls.Add(this.metroLabel2);
            this.Controls.Add(this.wfmsTxtUserID);
            this.Controls.Add(this.metroLabel1);
            this.Name = "frmUser";
            this.Text = "Manage Users";
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
            this.Controls.SetChildIndex(this.metroLabel1, 0);
            this.Controls.SetChildIndex(this.wfmsTxtUserID, 0);
            this.Controls.SetChildIndex(this.metroLabel2, 0);
            this.Controls.SetChildIndex(this.wfmsTxtFirstName, 0);
            this.Controls.SetChildIndex(this.metroLabel3, 0);
            this.Controls.SetChildIndex(this.wfmsTxtLastName, 0);
            this.Controls.SetChildIndex(this.metroLabel4, 0);
            this.Controls.SetChildIndex(this.wfmsTxtPassword, 0);
            this.Controls.SetChildIndex(this.metroLabel5, 0);
            this.Controls.SetChildIndex(this.wfmsCmbUserType, 0);
            this.Controls.SetChildIndex(this.metroLabel6, 0);
            this.Controls.SetChildIndex(this.wfmsDtpCreated, 0);
            this.Controls.SetChildIndex(this.metroLabel7, 0);
            this.Controls.SetChildIndex(this.wfmsDtpModified, 0);
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
        private Common.Controls.WfmsText wfmsTxtUserID;
        private MetroFramework.Controls.MetroLabel metroLabel2;
        private Common.Controls.WfmsText wfmsTxtFirstName;
        private MetroFramework.Controls.MetroLabel metroLabel3;
        private Common.Controls.WfmsText wfmsTxtLastName;
        private MetroFramework.Controls.MetroLabel metroLabel4;
        private Common.Controls.WfmsText wfmsTxtPassword;
        private MetroFramework.Controls.MetroLabel metroLabel5;
        private Common.Controls.WfmsCombo wfmsCmbUserType;
        private MetroFramework.Controls.MetroLabel metroLabel6;
        private Common.Controls.WfmsDate wfmsDtpCreated;
        private MetroFramework.Controls.MetroLabel metroLabel7;
        private Common.Controls.WfmsDate wfmsDtpModified;
    }
}