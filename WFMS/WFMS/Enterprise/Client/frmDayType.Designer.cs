namespace WFMS.Enterprise.Client
{
    partial class frmDayType
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmDayType));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtDayTypeID = new WFMS.Common.Controls.WfmsText();
            this.metroLabel2 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtDayTypeDesc = new WFMS.Common.Controls.WfmsText();
            this.metroLabel3 = new MetroFramework.Controls.MetroLabel();
            this.metroLabel4 = new MetroFramework.Controls.MetroLabel();
            this.wfmsTxtWorkTimePerDay = new WFMS.Common.Controls.WfmsText();
            this.metroGrid1 = new MetroFramework.Controls.MetroGrid();
            ((System.ComponentModel.ISupportInitialize)(this.dt)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLov)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.metroGrid1)).BeginInit();
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
            this.wfmsDtpCreated.Location = new System.Drawing.Point(527, 138);
            this.wfmsDtpCreated.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // metroLabel1i
            // 
            this.metroLabel1i.Location = new System.Drawing.Point(418, 144);
            // 
            // metroLabel2i
            // 
            this.metroLabel2i.Location = new System.Drawing.Point(418, 188);
            // 
            // wfmsDtpModified
            // 
            this.wfmsDtpModified.Location = new System.Drawing.Point(527, 182);
            this.wfmsDtpModified.MinimumSize = new System.Drawing.Size(0, 29);
            // 
            // metroLabel1
            // 
            this.metroLabel1.AutoSize = true;
            this.metroLabel1.Location = new System.Drawing.Point(34, 144);
            this.metroLabel1.Name = "metroLabel1";
            this.metroLabel1.Size = new System.Drawing.Size(78, 19);
            this.metroLabel1.TabIndex = 14;
            this.metroLabel1.Text = "Day Type ID";
            // 
            // wfmsTxtDayTypeID
            // 
            this.wfmsTxtDayTypeID.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtDayTypeID.CustomButton.Image = null;
            this.wfmsTxtDayTypeID.CustomButton.Location = new System.Drawing.Point(190, 1);
            this.wfmsTxtDayTypeID.CustomButton.Name = "";
            this.wfmsTxtDayTypeID.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtDayTypeID.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtDayTypeID.CustomButton.TabIndex = 1;
            this.wfmsTxtDayTypeID.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtDayTypeID.CustomButton.UseSelectable = true;
            this.wfmsTxtDayTypeID.CustomButton.Visible = false;
            this.wfmsTxtDayTypeID.Datatype = "";
            this.wfmsTxtDayTypeID.Edited = false;
            this.wfmsTxtDayTypeID.Enabled = false;
            this.wfmsTxtDayTypeID.Lines = new string[0];
            this.wfmsTxtDayTypeID.Location = new System.Drawing.Point(143, 144);
            this.wfmsTxtDayTypeID.LOV = false;
            this.wfmsTxtDayTypeID.Mand = true;
            this.wfmsTxtDayTypeID.MaxLength = 32767;
            this.wfmsTxtDayTypeID.Name = "wfmsTxtDayTypeID";
            this.wfmsTxtDayTypeID.PasswordChar = '\0';
            this.wfmsTxtDayTypeID.PrimaryKey = true;
            this.wfmsTxtDayTypeID.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtDayTypeID.SelectedText = "";
            this.wfmsTxtDayTypeID.SelectionLength = 0;
            this.wfmsTxtDayTypeID.SelectionStart = 0;
            this.wfmsTxtDayTypeID.ShortcutsEnabled = true;
            this.wfmsTxtDayTypeID.Size = new System.Drawing.Size(212, 23);
            this.wfmsTxtDayTypeID.SQLColumn = "DAY_TYPE_ID";
            this.wfmsTxtDayTypeID.TabIndex = 15;
            this.wfmsTxtDayTypeID.UseCustomBackColor = true;
            this.wfmsTxtDayTypeID.UseSelectable = true;
            this.wfmsTxtDayTypeID.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtDayTypeID.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel2
            // 
            this.metroLabel2.AutoSize = true;
            this.metroLabel2.Location = new System.Drawing.Point(34, 188);
            this.metroLabel2.Name = "metroLabel2";
            this.metroLabel2.Size = new System.Drawing.Size(74, 19);
            this.metroLabel2.TabIndex = 16;
            this.metroLabel2.Text = "Description";
            // 
            // wfmsTxtDayTypeDesc
            // 
            this.wfmsTxtDayTypeDesc.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtDayTypeDesc.CustomButton.Image = null;
            this.wfmsTxtDayTypeDesc.CustomButton.Location = new System.Drawing.Point(190, 1);
            this.wfmsTxtDayTypeDesc.CustomButton.Name = "";
            this.wfmsTxtDayTypeDesc.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtDayTypeDesc.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtDayTypeDesc.CustomButton.TabIndex = 1;
            this.wfmsTxtDayTypeDesc.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtDayTypeDesc.CustomButton.UseSelectable = true;
            this.wfmsTxtDayTypeDesc.CustomButton.Visible = false;
            this.wfmsTxtDayTypeDesc.Datatype = "";
            this.wfmsTxtDayTypeDesc.Edited = false;
            this.wfmsTxtDayTypeDesc.Enabled = false;
            this.wfmsTxtDayTypeDesc.Lines = new string[0];
            this.wfmsTxtDayTypeDesc.Location = new System.Drawing.Point(143, 188);
            this.wfmsTxtDayTypeDesc.LOV = false;
            this.wfmsTxtDayTypeDesc.Mand = true;
            this.wfmsTxtDayTypeDesc.MaxLength = 32767;
            this.wfmsTxtDayTypeDesc.Name = "wfmsTxtDayTypeDesc";
            this.wfmsTxtDayTypeDesc.PasswordChar = '\0';
            this.wfmsTxtDayTypeDesc.PrimaryKey = false;
            this.wfmsTxtDayTypeDesc.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtDayTypeDesc.SelectedText = "";
            this.wfmsTxtDayTypeDesc.SelectionLength = 0;
            this.wfmsTxtDayTypeDesc.SelectionStart = 0;
            this.wfmsTxtDayTypeDesc.ShortcutsEnabled = true;
            this.wfmsTxtDayTypeDesc.Size = new System.Drawing.Size(212, 23);
            this.wfmsTxtDayTypeDesc.SQLColumn = "DESCRIPTION";
            this.wfmsTxtDayTypeDesc.TabIndex = 17;
            this.wfmsTxtDayTypeDesc.UseCustomBackColor = true;
            this.wfmsTxtDayTypeDesc.UseSelectable = true;
            this.wfmsTxtDayTypeDesc.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtDayTypeDesc.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroLabel3
            // 
            this.metroLabel3.AutoSize = true;
            this.metroLabel3.Location = new System.Drawing.Point(34, 232);
            this.metroLabel3.Name = "metroLabel3";
            this.metroLabel3.Size = new System.Drawing.Size(122, 19);
            this.metroLabel3.TabIndex = 18;
            this.metroLabel3.Text = "Work Time Per Day";
            // 
            // metroLabel4
            // 
            this.metroLabel4.AutoSize = true;
            this.metroLabel4.Location = new System.Drawing.Point(319, 232);
            this.metroLabel4.Name = "metroLabel4";
            this.metroLabel4.Size = new System.Drawing.Size(36, 19);
            this.metroLabel4.TabIndex = 19;
            this.metroLabel4.Text = "Mins";
            // 
            // wfmsTxtWorkTimePerDay
            // 
            this.wfmsTxtWorkTimePerDay.BackColor = System.Drawing.Color.LightGray;
            // 
            // 
            // 
            this.wfmsTxtWorkTimePerDay.CustomButton.Image = null;
            this.wfmsTxtWorkTimePerDay.CustomButton.Location = new System.Drawing.Point(115, 1);
            this.wfmsTxtWorkTimePerDay.CustomButton.Name = "";
            this.wfmsTxtWorkTimePerDay.CustomButton.Size = new System.Drawing.Size(21, 21);
            this.wfmsTxtWorkTimePerDay.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.wfmsTxtWorkTimePerDay.CustomButton.TabIndex = 1;
            this.wfmsTxtWorkTimePerDay.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.wfmsTxtWorkTimePerDay.CustomButton.UseSelectable = true;
            this.wfmsTxtWorkTimePerDay.CustomButton.Visible = false;
            this.wfmsTxtWorkTimePerDay.Datatype = "";
            this.wfmsTxtWorkTimePerDay.Edited = true;
            this.wfmsTxtWorkTimePerDay.Enabled = false;
            this.wfmsTxtWorkTimePerDay.Lines = new string[0];
            this.wfmsTxtWorkTimePerDay.Location = new System.Drawing.Point(176, 232);
            this.wfmsTxtWorkTimePerDay.LOV = false;
            this.wfmsTxtWorkTimePerDay.Mand = false;
            this.wfmsTxtWorkTimePerDay.MaxLength = 32767;
            this.wfmsTxtWorkTimePerDay.Name = "wfmsTxtWorkTimePerDay";
            this.wfmsTxtWorkTimePerDay.PasswordChar = '\0';
            this.wfmsTxtWorkTimePerDay.PrimaryKey = false;
            this.wfmsTxtWorkTimePerDay.ReadOnly = true;
            this.wfmsTxtWorkTimePerDay.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.wfmsTxtWorkTimePerDay.SelectedText = "";
            this.wfmsTxtWorkTimePerDay.SelectionLength = 0;
            this.wfmsTxtWorkTimePerDay.SelectionStart = 0;
            this.wfmsTxtWorkTimePerDay.ShortcutsEnabled = true;
            this.wfmsTxtWorkTimePerDay.Size = new System.Drawing.Size(137, 23);
            this.wfmsTxtWorkTimePerDay.SQLColumn = "WORK_TIME_PER_DAY";
            this.wfmsTxtWorkTimePerDay.TabIndex = 20;
            this.wfmsTxtWorkTimePerDay.UseCustomBackColor = true;
            this.wfmsTxtWorkTimePerDay.UseSelectable = true;
            this.wfmsTxtWorkTimePerDay.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.wfmsTxtWorkTimePerDay.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // metroGrid1
            // 
            this.metroGrid1.AllowUserToResizeRows = false;
            this.metroGrid1.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.metroGrid1.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.metroGrid1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.metroGrid1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(174)))), ((int)(((byte)(219)))));
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(198)))), ((int)(((byte)(247)))));
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(17)))), ((int)(((byte)(17)))), ((int)(((byte)(17)))));
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.metroGrid1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.metroGrid1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(136)))), ((int)(((byte)(136)))), ((int)(((byte)(136)))));
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(198)))), ((int)(((byte)(247)))));
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(17)))), ((int)(((byte)(17)))), ((int)(((byte)(17)))));
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.metroGrid1.DefaultCellStyle = dataGridViewCellStyle2;
            this.metroGrid1.EnableHeadersVisualStyles = false;
            this.metroGrid1.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            this.metroGrid1.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.metroGrid1.Location = new System.Drawing.Point(34, 281);
            this.metroGrid1.Name = "metroGrid1";
            this.metroGrid1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(174)))), ((int)(((byte)(219)))));
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            dataGridViewCellStyle3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(198)))), ((int)(((byte)(247)))));
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(17)))), ((int)(((byte)(17)))), ((int)(((byte)(17)))));
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.metroGrid1.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.metroGrid1.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.metroGrid1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.metroGrid1.Size = new System.Drawing.Size(904, 431);
            this.metroGrid1.TabIndex = 21;
            // 
            // frmDayType
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.metroGrid1);
            this.Controls.Add(this.wfmsTxtWorkTimePerDay);
            this.Controls.Add(this.metroLabel4);
            this.Controls.Add(this.metroLabel3);
            this.Controls.Add(this.wfmsTxtDayTypeDesc);
            this.Controls.Add(this.metroLabel2);
            this.Controls.Add(this.wfmsTxtDayTypeID);
            this.Controls.Add(this.metroLabel1);
            this.Location = new System.Drawing.Point(0, 0);
            this.MainCombo_col1 = "DAY_TYPE_ID";
            this.MainCombo_col1_sql = "DAY_TYPE_ID";
            this.MainCombo_col2 = "DESCRIPTION";
            this.MainCombo_col2_sql = "DESCRIPTION";
            this.Name = "frmDayType";
            this.Table = "DAY_TYPE_TAB";
            this.Text = "Day Type";
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
            this.Controls.SetChildIndex(this.metroLabel1, 0);
            this.Controls.SetChildIndex(this.wfmsTxtDayTypeID, 0);
            this.Controls.SetChildIndex(this.metroLabel2, 0);
            this.Controls.SetChildIndex(this.wfmsTxtDayTypeDesc, 0);
            this.Controls.SetChildIndex(this.metroLabel3, 0);
            this.Controls.SetChildIndex(this.metroLabel4, 0);
            this.Controls.SetChildIndex(this.wfmsTxtWorkTimePerDay, 0);
            this.Controls.SetChildIndex(this.metroGrid1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.dt)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLov)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.metroGrid1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MetroFramework.Controls.MetroLabel metroLabel1;
        private Common.Controls.WfmsText wfmsTxtDayTypeID;
        private MetroFramework.Controls.MetroLabel metroLabel2;
        private Common.Controls.WfmsText wfmsTxtDayTypeDesc;
        private MetroFramework.Controls.MetroLabel metroLabel3;
        private MetroFramework.Controls.MetroLabel metroLabel4;
        private Common.Controls.WfmsText wfmsTxtWorkTimePerDay;
        private MetroFramework.Controls.MetroGrid metroGrid1;
    }
}