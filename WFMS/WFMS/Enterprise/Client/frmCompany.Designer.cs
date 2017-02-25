namespace WFMS.Enterprise.Client
{
    partial class frmCompany
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmCompany));
            this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCompanyID = new WFMS.Common.Controls.WfmsText();
            this.metroLabel2 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCompanyDesc = new WFMS.Common.Controls.WfmsText();
            this.metroLabel3 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCompanyAddress = new WFMS.Common.Controls.WfmsText();
            this.metroLabel4 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtPhoneNo = new WFMS.Common.Controls.WfmsText();
            this.metroLabel5 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtAutoSchInterval = new WFMS.Common.Controls.WfmsText();
            this.wfmsCmbAutoSchUnit = new WFMS.Common.Controls.WfmsCombo();
            this.metroLabel6 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCalendarID = new WFMS.Common.Controls.WfmsText();
            this.metroLabel7 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtCurrencyCode = new WFMS.Common.Controls.WfmsText();
            this.btnAddLocation = new MetroFramework.Controls.MetroButton();
            this.btnAddress = new MetroFramework.Controls.MetroButton();
            this.wfmsTxtAddressID = new WFMS.Common.Controls.WfmsText();
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
            // btnNew
            // 
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            // 
            // btnSave
            // 
            this.btnSave.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.Image")));
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // wfmsDate
            // 
            this.wfmsDate.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // wfmsDtpCreated
            // 
            this.wfmsDtpCreated.Location = new System.Drawing.Point(143, 365);
            this.wfmsDtpCreated.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // metroLabel1i
            // 
            this.metroLabel1i.Location = new System.Drawing.Point(34, 365);
            // 
            // metroLabel2i
            // 
            this.metroLabel2i.Location = new System.Drawing.Point(34, 415);
            // 
            // wfmsDtpModified
            // 
            this.wfmsDtpModified.Location = new System.Drawing.Point(143, 415);
            this.wfmsDtpModified.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // metroLabel1
            // 
            this.metroLabel1.AutoSize = true;
            this.metroLabel1.Location = new System.Drawing.Point(34, 144);
            this.metroLabel1.Name = "metroLabel1";
            this.metroLabel1.Size = new System.Drawing.Size(82, 19);
            this.metroLabel1.TabIndex = 10;
            this.metroLabel1.Text = "Company ID";
            // 
            // wfmsTxtCompanyID
            // 
            this.wfmsTxtCompanyID.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCompanyID.CustomButton.Image = null;
            this.wfmsTxtCompanyID.CustomButton.Location = new System.Drawing.Point(190, 1);
            this.wfmsTxtCompanyID.CustomButton.Name = "";
            this.wfmsTxtCompanyID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtCompanyID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCompanyID.CustomButton.TabIndex = 1;
            this.wfmsTxtCompanyID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCompanyID.CustomButton.UseSelectable = true;
            this.wfmsTxtCompanyID.CustomButton.Visible = false;
            this.wfmsTxtCompanyID.Datatype = "";
            this.wfmsTxtCompanyID.Edited = false;
            this.wfmsTxtCompanyID.Enabled = false;
            this.wfmsTxtCompanyID.Lines = new string[0];
            this.wfmsTxtCompanyID.Location = new System.Drawing.Point(143, 144);
            this.wfmsTxtCompanyID.LOV = false;
            this.wfmsTxtCompanyID.Mand = true;
            this.wfmsTxtCompanyID.MaxLength = 32767;
            this.wfmsTxtCompanyID.Name = "wfmsTxtCompanyID";
            this.wfmsTxtCompanyID.PasswordChar = '\0';
            this.wfmsTxtCompanyID.PrimaryKey = true;
            this.wfmsTxtCompanyID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCompanyID.SelectedText = "";
            this.wfmsTxtCompanyID.SelectionLength = 0;
            this.wfmsTxtCompanyID.SelectionStart = 0;
            this.wfmsTxtCompanyID.ShortcutsEnabled = true;
            this.wfmsTxtCompanyID.Size = new System.Drawing.Size(212, 23);
            this.wfmsTxtCompanyID.SQLColumn = "COMPANY_ID";
            this.wfmsTxtCompanyID.TabIndex = 11;
            this.wfmsTxtCompanyID.UseCustomBackColor = true;
            this.wfmsTxtCompanyID.UseSelectable = true;
            this.wfmsTxtCompanyID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCompanyID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel2
            // 
            this.metroLabel2.AutoSize = true;
            this.metroLabel2.Location = new System.Drawing.Point(34, 188);
            this.metroLabel2.Name = "metroLabel2";
            this.metroLabel2.Size = new System.Drawing.Size(74, 19);
            this.metroLabel2.TabIndex = 12;
            this.metroLabel2.Text = "Description";
            // 
            // wfmsTxtCompanyDesc
            // 
            this.wfmsTxtCompanyDesc.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCompanyDesc.CustomButton.Image = null;
            this.wfmsTxtCompanyDesc.CustomButton.Location = new System.Drawing.Point(190, 1);
            this.wfmsTxtCompanyDesc.CustomButton.Name = "";
            this.wfmsTxtCompanyDesc.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtCompanyDesc.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCompanyDesc.CustomButton.TabIndex = 1;
            this.wfmsTxtCompanyDesc.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCompanyDesc.CustomButton.UseSelectable = true;
            this.wfmsTxtCompanyDesc.CustomButton.Visible = false;
            this.wfmsTxtCompanyDesc.Datatype = "";
            this.wfmsTxtCompanyDesc.Edited = false;
            this.wfmsTxtCompanyDesc.Enabled = false;
            this.wfmsTxtCompanyDesc.Lines = new string[0];
            this.wfmsTxtCompanyDesc.Location = new System.Drawing.Point(143, 188);
            this.wfmsTxtCompanyDesc.LOV = false;
            this.wfmsTxtCompanyDesc.Mand = true;
            this.wfmsTxtCompanyDesc.MaxLength = 32767;
            this.wfmsTxtCompanyDesc.Name = "wfmsTxtCompanyDesc";
            this.wfmsTxtCompanyDesc.PasswordChar = '\0';
            this.wfmsTxtCompanyDesc.PrimaryKey = false;
            this.wfmsTxtCompanyDesc.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCompanyDesc.SelectedText = "";
            this.wfmsTxtCompanyDesc.SelectionLength = 0;
            this.wfmsTxtCompanyDesc.SelectionStart = 0;
            this.wfmsTxtCompanyDesc.ShortcutsEnabled = true;
            this.wfmsTxtCompanyDesc.Size = new System.Drawing.Size(212, 23);
            this.wfmsTxtCompanyDesc.SQLColumn = "DESCRIPTION";
            this.wfmsTxtCompanyDesc.TabIndex = 13;
            this.wfmsTxtCompanyDesc.UseCustomBackColor = true;
            this.wfmsTxtCompanyDesc.UseSelectable = true;
            this.wfmsTxtCompanyDesc.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCompanyDesc.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel3
            // 
            this.metroLabel3.AutoSize = true;
            this.metroLabel3.Location = new System.Drawing.Point(419, 144);
            this.metroLabel3.Name = "metroLabel3";
            this.metroLabel3.Size = new System.Drawing.Size(56, 19);
            this.metroLabel3.TabIndex = 14;
            this.metroLabel3.Text = "Address";
            // 
            // wfmsTxtCompanyAddress
            // 
            this.wfmsTxtCompanyAddress.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCompanyAddress.CustomButton.Image = null;
            this.wfmsTxtCompanyAddress.CustomButton.Location = new System.Drawing.Point(146, 1);
            this.wfmsTxtCompanyAddress.CustomButton.Name = "";
            this.wfmsTxtCompanyAddress.CustomButton.Size = new System.Drawing.Size(65, 65);
            this.wfmsTxtCompanyAddress.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCompanyAddress.CustomButton.TabIndex = 1;
            this.wfmsTxtCompanyAddress.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCompanyAddress.CustomButton.UseSelectable = true;
            this.wfmsTxtCompanyAddress.CustomButton.Visible = false;
            this.wfmsTxtCompanyAddress.Datatype = "";
            this.wfmsTxtCompanyAddress.Edited = false;
            this.wfmsTxtCompanyAddress.Enabled = false;
            this.wfmsTxtCompanyAddress.Lines = new string[0];
            this.wfmsTxtCompanyAddress.Location = new System.Drawing.Point(528, 144);
            this.wfmsTxtCompanyAddress.LOV = false;
            this.wfmsTxtCompanyAddress.Mand = true;
            this.wfmsTxtCompanyAddress.MaxLength = 32767;
            this.wfmsTxtCompanyAddress.Multiline = true;
            this.wfmsTxtCompanyAddress.Name = "wfmsTxtCompanyAddress";
            this.wfmsTxtCompanyAddress.PasswordChar = '\0';
            this.wfmsTxtCompanyAddress.PrimaryKey = false;
            this.wfmsTxtCompanyAddress.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCompanyAddress.SelectedText = "";
            this.wfmsTxtCompanyAddress.SelectionLength = 0;
            this.wfmsTxtCompanyAddress.SelectionStart = 0;
            this.wfmsTxtCompanyAddress.ShortcutsEnabled = true;
            this.wfmsTxtCompanyAddress.Size = new System.Drawing.Size(212, 67);
            this.wfmsTxtCompanyAddress.SQLColumn = "ADDRESS";
            this.wfmsTxtCompanyAddress.TabIndex = 15;
            this.wfmsTxtCompanyAddress.UseCustomBackColor = true;
            this.wfmsTxtCompanyAddress.UseSelectable = true;
            this.wfmsTxtCompanyAddress.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCompanyAddress.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel4
            // 
            this.metroLabel4.AutoSize = true;
            this.metroLabel4.Location = new System.Drawing.Point(419, 233);
            this.metroLabel4.Name = "metroLabel4";
            this.metroLabel4.Size = new System.Drawing.Size(68, 19);
            this.metroLabel4.TabIndex = 16;
            this.metroLabel4.Text = "Phone No";
            // 
            // wfmsTxtPhoneNo
            // 
            this.wfmsTxtPhoneNo.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtPhoneNo.CustomButton.Image = null;
            this.wfmsTxtPhoneNo.CustomButton.Location = new System.Drawing.Point(190, 1);
            this.wfmsTxtPhoneNo.CustomButton.Name = "";
            this.wfmsTxtPhoneNo.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtPhoneNo.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtPhoneNo.CustomButton.TabIndex = 1;
            this.wfmsTxtPhoneNo.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtPhoneNo.CustomButton.UseSelectable = true;
            this.wfmsTxtPhoneNo.CustomButton.Visible = false;
            this.wfmsTxtPhoneNo.Datatype = "";
            this.wfmsTxtPhoneNo.Edited = false;
            this.wfmsTxtPhoneNo.Enabled = false;
            this.wfmsTxtPhoneNo.Lines = new string[0];
            this.wfmsTxtPhoneNo.Location = new System.Drawing.Point(528, 233);
            this.wfmsTxtPhoneNo.LOV = false;
            this.wfmsTxtPhoneNo.Mand = false;
            this.wfmsTxtPhoneNo.MaxLength = 32767;
            this.wfmsTxtPhoneNo.Name = "wfmsTxtPhoneNo";
            this.wfmsTxtPhoneNo.PasswordChar = '\0';
            this.wfmsTxtPhoneNo.PrimaryKey = false;
            this.wfmsTxtPhoneNo.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtPhoneNo.SelectedText = "";
            this.wfmsTxtPhoneNo.SelectionLength = 0;
            this.wfmsTxtPhoneNo.SelectionStart = 0;
            this.wfmsTxtPhoneNo.ShortcutsEnabled = true;
            this.wfmsTxtPhoneNo.Size = new System.Drawing.Size(212, 23);
            this.wfmsTxtPhoneNo.SQLColumn = "PHONE_NO";
            this.wfmsTxtPhoneNo.TabIndex = 17;
            this.wfmsTxtPhoneNo.UseCustomBackColor = true;
            this.wfmsTxtPhoneNo.UseSelectable = true;
            this.wfmsTxtPhoneNo.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtPhoneNo.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel5
            // 
            this.metroLabel5.AutoSize = true;
            this.metroLabel5.Location = new System.Drawing.Point(34, 233);
            this.metroLabel5.Name = "metroLabel5";
            this.metroLabel5.Size = new System.Drawing.Size(140, 19);
            this.metroLabel5.TabIndex = 18;
            this.metroLabel5.Text = "Auto Schedule Interval";
            // 
            // wfmsTxtAutoSchInterval
            // 
            this.wfmsTxtAutoSchInterval.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtAutoSchInterval.CustomButton.Image = null;
            this.wfmsTxtAutoSchInterval.CustomButton.Location = new System.Drawing.Point(52, 1);
            this.wfmsTxtAutoSchInterval.CustomButton.Name = "";
            this.wfmsTxtAutoSchInterval.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtAutoSchInterval.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtAutoSchInterval.CustomButton.TabIndex = 1;
            this.wfmsTxtAutoSchInterval.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtAutoSchInterval.CustomButton.UseSelectable = true;
            this.wfmsTxtAutoSchInterval.CustomButton.Visible = false;
            this.wfmsTxtAutoSchInterval.Datatype = "";
            this.wfmsTxtAutoSchInterval.Edited = false;
            this.wfmsTxtAutoSchInterval.Enabled = false;
            this.wfmsTxtAutoSchInterval.Lines = new string[0];
            this.wfmsTxtAutoSchInterval.Location = new System.Drawing.Point(188, 233);
            this.wfmsTxtAutoSchInterval.LOV = false;
            this.wfmsTxtAutoSchInterval.Mand = true;
            this.wfmsTxtAutoSchInterval.MaxLength = 32767;
            this.wfmsTxtAutoSchInterval.Name = "wfmsTxtAutoSchInterval";
            this.wfmsTxtAutoSchInterval.PasswordChar = '\0';
            this.wfmsTxtAutoSchInterval.PrimaryKey = false;
            this.wfmsTxtAutoSchInterval.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtAutoSchInterval.SelectedText = "";
            this.wfmsTxtAutoSchInterval.SelectionLength = 0;
            this.wfmsTxtAutoSchInterval.SelectionStart = 0;
            this.wfmsTxtAutoSchInterval.ShortcutsEnabled = true;
            this.wfmsTxtAutoSchInterval.Size = new System.Drawing.Size(74, 23);
            this.wfmsTxtAutoSchInterval.SQLColumn = "AUTO_SCH_INTERVAL";
            this.wfmsTxtAutoSchInterval.TabIndex = 19;
            this.wfmsTxtAutoSchInterval.UseCustomBackColor = true;
            this.wfmsTxtAutoSchInterval.UseSelectable = true;
            this.wfmsTxtAutoSchInterval.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtAutoSchInterval.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // wfmsCmbAutoSchUnit
            // 
            this.wfmsCmbAutoSchUnit.BackColor = System.Drawing.Color.LightGray;
            this.wfmsCmbAutoSchUnit.Edited = false;
            this.wfmsCmbAutoSchUnit.Enabled = false;
            this.wfmsCmbAutoSchUnit.ForeverDisable = false;
            this.wfmsCmbAutoSchUnit.FormattingEnabled = true;
            this.wfmsCmbAutoSchUnit.ItemHeight = 23;
            this.wfmsCmbAutoSchUnit.Items.AddRange(new object[] {
            "seconds",
            "minutes",
            "hours",
            "days"});
            this.wfmsCmbAutoSchUnit.Location = new System.Drawing.Point(278, 231);
            this.wfmsCmbAutoSchUnit.MainCMB = false;
            this.wfmsCmbAutoSchUnit.Mand = false;
            this.wfmsCmbAutoSchUnit.Name = "wfmsCmbAutoSchUnit";
            this.wfmsCmbAutoSchUnit.Size = new System.Drawing.Size(77, 29);
            this.wfmsCmbAutoSchUnit.SQLColumn = "AUTO_SCH_INT_UNIT";
            this.wfmsCmbAutoSchUnit.TabIndex = 20;
            this.wfmsCmbAutoSchUnit.UseSelectable = true;
            // 
            // metroLabel6
            // 
            this.metroLabel6.AutoSize = true;
            this.metroLabel6.Location = new System.Drawing.Point(34, 279);
            this.metroLabel6.Name = "metroLabel6";
            this.metroLabel6.Size = new System.Drawing.Size(130, 19);
            this.metroLabel6.TabIndex = 21;
            this.metroLabel6.Text = "Work Time Calendar";
            // 
            // wfmsTxtCalendarID
            // 
            this.wfmsTxtCalendarID.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCalendarID.CustomButton.Image = null;
            this.wfmsTxtCalendarID.CustomButton.Location = new System.Drawing.Point(145, 1);
            this.wfmsTxtCalendarID.CustomButton.Name = "";
            this.wfmsTxtCalendarID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtCalendarID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCalendarID.CustomButton.TabIndex = 1;
            this.wfmsTxtCalendarID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCalendarID.CustomButton.UseSelectable = true;
            this.wfmsTxtCalendarID.CustomButton.Visible = false;
            this.wfmsTxtCalendarID.Datatype = "";
            this.wfmsTxtCalendarID.Edited = false;
            this.wfmsTxtCalendarID.Enabled = false;
            this.wfmsTxtCalendarID.Lines = new string[0];
            this.wfmsTxtCalendarID.Location = new System.Drawing.Point(188, 279);
            this.wfmsTxtCalendarID.LOV = true;
            this.wfmsTxtCalendarID.Mand = true;
            this.wfmsTxtCalendarID.MaxLength = 32767;
            this.wfmsTxtCalendarID.Name = "wfmsTxtCalendarID";
            this.wfmsTxtCalendarID.PasswordChar = '\0';
            this.wfmsTxtCalendarID.PrimaryKey = false;
            this.wfmsTxtCalendarID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCalendarID.SelectedText = "";
            this.wfmsTxtCalendarID.SelectionLength = 0;
            this.wfmsTxtCalendarID.SelectionStart = 0;
            this.wfmsTxtCalendarID.ShortcutsEnabled = true;
            this.wfmsTxtCalendarID.Size = new System.Drawing.Size(167, 23);
            this.wfmsTxtCalendarID.SQLColumn = "CALENDAR_ID";
            this.wfmsTxtCalendarID.TabIndex = 22;
            this.wfmsTxtCalendarID.UseCustomBackColor = true;
            this.wfmsTxtCalendarID.UseSelectable = true;
            this.wfmsTxtCalendarID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCalendarID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel7
            // 
            this.metroLabel7.AutoSize = true;
            this.metroLabel7.Location = new System.Drawing.Point(34, 321);
            this.metroLabel7.Name = "metroLabel7";
            this.metroLabel7.Size = new System.Drawing.Size(97, 19);
            this.metroLabel7.TabIndex = 23;
            this.metroLabel7.Text = "Currency Code";
            // 
            // wfmsTxtCurrencyCode
            // 
            this.wfmsTxtCurrencyCode.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtCurrencyCode.CustomButton.Image = null;
            this.wfmsTxtCurrencyCode.CustomButton.Location = new System.Drawing.Point(145, 1);
            this.wfmsTxtCurrencyCode.CustomButton.Name = "";
            this.wfmsTxtCurrencyCode.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtCurrencyCode.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtCurrencyCode.CustomButton.TabIndex = 1;
            this.wfmsTxtCurrencyCode.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtCurrencyCode.CustomButton.UseSelectable = true;
            this.wfmsTxtCurrencyCode.CustomButton.Visible = false;
            this.wfmsTxtCurrencyCode.Datatype = "";
            this.wfmsTxtCurrencyCode.Edited = false;
            this.wfmsTxtCurrencyCode.Enabled = false;
            this.wfmsTxtCurrencyCode.Lines = new string[0];
            this.wfmsTxtCurrencyCode.Location = new System.Drawing.Point(188, 321);
            this.wfmsTxtCurrencyCode.LOV = true;
            this.wfmsTxtCurrencyCode.Mand = true;
            this.wfmsTxtCurrencyCode.MaxLength = 32767;
            this.wfmsTxtCurrencyCode.Name = "wfmsTxtCurrencyCode";
            this.wfmsTxtCurrencyCode.PasswordChar = '\0';
            this.wfmsTxtCurrencyCode.PrimaryKey = false;
            this.wfmsTxtCurrencyCode.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtCurrencyCode.SelectedText = "";
            this.wfmsTxtCurrencyCode.SelectionLength = 0;
            this.wfmsTxtCurrencyCode.SelectionStart = 0;
            this.wfmsTxtCurrencyCode.ShortcutsEnabled = true;
            this.wfmsTxtCurrencyCode.Size = new System.Drawing.Size(167, 23);
            this.wfmsTxtCurrencyCode.SQLColumn = "CURRENCY_CODE";
            this.wfmsTxtCurrencyCode.TabIndex = 24;
            this.wfmsTxtCurrencyCode.UseCustomBackColor = true;
            this.wfmsTxtCurrencyCode.UseSelectable = true;
            this.wfmsTxtCurrencyCode.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtCurrencyCode.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // btnAddLocation
            // 
            this.btnAddLocation.Location = new System.Drawing.Point(805, 144);
            this.btnAddLocation.Name = "btnAddLocation";
            this.btnAddLocation.Size = new System.Drawing.Size(119, 23);
            this.btnAddLocation.TabIndex = 25;
            this.btnAddLocation.Text = "Add Location";
            this.btnAddLocation.UseSelectable = true;
            // 
            // btnAddress
            // 
            this.btnAddress.Location = new System.Drawing.Point(805, 188);
            this.btnAddress.Name = "btnAddress";
            this.btnAddress.Size = new System.Drawing.Size(119, 23);
            this.btnAddress.TabIndex = 26;
            this.btnAddress.Text = "Add/Edit Address";
            this.btnAddress.UseSelectable = true;
            this.btnAddress.Click += new System.EventHandler(this.btnAddress_Click);
            // 
            // wfmsTxtAddressID
            // 
            this.wfmsTxtAddressID.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtAddressID.CustomButton.Image = null;
            this.wfmsTxtAddressID.CustomButton.Location = new System.Drawing.Point(53, 1);
            this.wfmsTxtAddressID.CustomButton.Name = "";
            this.wfmsTxtAddressID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtAddressID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtAddressID.CustomButton.TabIndex = 1;
            this.wfmsTxtAddressID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtAddressID.CustomButton.UseSelectable = true;
            this.wfmsTxtAddressID.CustomButton.Visible = false;
            this.wfmsTxtAddressID.Datatype = "";
            this.wfmsTxtAddressID.Edited = true;
            this.wfmsTxtAddressID.Enabled = false;
            this.wfmsTxtAddressID.Lines = new string[0];
            this.wfmsTxtAddressID.Location = new System.Drawing.Point(805, 236);
            this.wfmsTxtAddressID.LOV = false;
            this.wfmsTxtAddressID.Mand = false;
            this.wfmsTxtAddressID.MaxLength = 32767;
            this.wfmsTxtAddressID.Name = "wfmsTxtAddressID";
            this.wfmsTxtAddressID.PasswordChar = '\0';
            this.wfmsTxtAddressID.PrimaryKey = false;
            this.wfmsTxtAddressID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtAddressID.SelectedText = "";
            this.wfmsTxtAddressID.SelectionLength = 0;
            this.wfmsTxtAddressID.SelectionStart = 0;
            this.wfmsTxtAddressID.ShortcutsEnabled = true;
            this.wfmsTxtAddressID.Size = new System.Drawing.Size(75, 23);
            this.wfmsTxtAddressID.SQLColumn = "ADDRESS_ID";
            this.wfmsTxtAddressID.TabIndex = 27;
            this.wfmsTxtAddressID.UseCustomBackColor = true;
            this.wfmsTxtAddressID.UseSelectable = true;
            this.wfmsTxtAddressID.Visible = false;
            this.wfmsTxtAddressID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtAddressID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // frmCompany
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.wfmsTxtAddressID);
            this.Controls.Add(this.btnAddress);
            this.Controls.Add(this.btnAddLocation);
            this.Controls.Add(this.wfmsTxtCurrencyCode);
            this.Controls.Add(this.metroLabel7);
            this.Controls.Add(this.wfmsTxtCalendarID);
            this.Controls.Add(this.metroLabel6);
            this.Controls.Add(this.wfmsCmbAutoSchUnit);
            this.Controls.Add(this.wfmsTxtAutoSchInterval);
            this.Controls.Add(this.metroLabel5);
            this.Controls.Add(this.wfmsTxtPhoneNo);
            this.Controls.Add(this.metroLabel4);
            this.Controls.Add(this.wfmsTxtCompanyAddress);
            this.Controls.Add(this.metroLabel3);
            this.Controls.Add(this.wfmsTxtCompanyDesc);
            this.Controls.Add(this.metroLabel2);
            this.Controls.Add(this.wfmsTxtCompanyID);
            this.Controls.Add(this.metroLabel1);
            this.Location = new System.Drawing.Point(0, 0);
            this.MainCombo_col1 = "COMPANY_ID";
            this.MainCombo_col1_sql = "COMPANY_ID";
            this.MainCombo_col2 = "DESCRIPTION";
            this.MainCombo_col2_sql = "DESCRIPTION";
            this.Name = "frmCompany";
            this.Table = "COMPANY_TAB";
            this.Text = "Company";
            this.Controls.SetChildIndex(this.metroLabel1i, 0);
            this.Controls.SetChildIndex(this.metroLabel2i, 0);
            this.Controls.SetChildIndex(this.wfmsDtpModified, 0);
            this.Controls.SetChildIndex(this.wfmsDtpCreated, 0);
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
            this.Controls.SetChildIndex(this.wfmsTxtCompanyID, 0);
            this.Controls.SetChildIndex(this.metroLabel2, 0);
            this.Controls.SetChildIndex(this.wfmsTxtCompanyDesc, 0);
            this.Controls.SetChildIndex(this.metroLabel3, 0);
            this.Controls.SetChildIndex(this.wfmsTxtCompanyAddress, 0);
            this.Controls.SetChildIndex(this.metroLabel4, 0);
            this.Controls.SetChildIndex(this.wfmsTxtPhoneNo, 0);
            this.Controls.SetChildIndex(this.metroLabel5, 0);
            this.Controls.SetChildIndex(this.wfmsTxtAutoSchInterval, 0);
            this.Controls.SetChildIndex(this.wfmsCmbAutoSchUnit, 0);
            this.Controls.SetChildIndex(this.metroLabel6, 0);
            this.Controls.SetChildIndex(this.wfmsTxtCalendarID, 0);
            this.Controls.SetChildIndex(this.metroLabel7, 0);
            this.Controls.SetChildIndex(this.wfmsTxtCurrencyCode, 0);
            this.Controls.SetChildIndex(this.btnAddLocation, 0);
            this.Controls.SetChildIndex(this.btnAddress, 0);
            this.Controls.SetChildIndex(this.wfmsTxtAddressID, 0);
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
        private Common.Controls.WfmsText wfmsTxtCompanyID;
        private MetroFramework.Controls.MetroLabel metroLabel2;
        private Common.Controls.WfmsText wfmsTxtCompanyDesc;
        private MetroFramework.Controls.MetroLabel metroLabel3;
        private Common.Controls.WfmsText wfmsTxtCompanyAddress;
        private MetroFramework.Controls.MetroLabel metroLabel4;
        private Common.Controls.WfmsText wfmsTxtPhoneNo;
        private MetroFramework.Controls.MetroLabel metroLabel5;
        private Common.Controls.WfmsText wfmsTxtAutoSchInterval;
        private Common.Controls.WfmsCombo wfmsCmbAutoSchUnit;
        private MetroFramework.Controls.MetroLabel metroLabel6;
        private Common.Controls.WfmsText wfmsTxtCalendarID;
        private MetroFramework.Controls.MetroLabel metroLabel7;
        private Common.Controls.WfmsText wfmsTxtCurrencyCode;
        private MetroFramework.Controls.MetroButton btnAddLocation;
        private MetroFramework.Controls.MetroButton btnAddress;
        private Common.Controls.WfmsText wfmsTxtAddressID;
    }
}