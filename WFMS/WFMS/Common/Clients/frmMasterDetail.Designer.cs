namespace WFMS.Common.Clients
{
    partial class frmMasterDetail
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
            this.btnPopulate = new System.Windows.Forms.PictureBox();
            this.btnNew = new System.Windows.Forms.PictureBox();
            this.btnSave = new System.Windows.Forms.PictureBox();
            this.btnLov = new System.Windows.Forms.PictureBox();
            this.btnDelete = new System.Windows.Forms.PictureBox();
            this.btnZoom = new System.Windows.Forms.PictureBox();
            this.btnRefresh = new System.Windows.Forms.PictureBox();
            this.btnSearch = new System.Windows.Forms.PictureBox();
            this.wfmsDate = new WFMS.Common.Controls.WfmsDate();
            this.wfmsComboRecordPopulate = new WFMS.Common.Controls.WfmsCombo();
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
            // btnPopulate
            // 
            this.btnPopulate.Image = global::WFMS.Properties.Resources.populate_normal;
            this.btnPopulate.Location = new System.Drawing.Point(23, 73);
            this.btnPopulate.Name = "btnPopulate";
            this.btnPopulate.Size = new System.Drawing.Size(32, 32);
            this.btnPopulate.TabIndex = 1;
            this.btnPopulate.TabStop = false;
            this.btnPopulate.Click += new System.EventHandler(this.btnPopulate_Click);
            this.btnPopulate.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnPopulate_MouseDown);
            this.btnPopulate.MouseEnter += new System.EventHandler(this.btnPopulate_MouseEnter);
            this.btnPopulate.MouseLeave += new System.EventHandler(this.btnPopulate_MouseLeave);
            this.btnPopulate.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnPopulate_MouseUp);
            // 
            // btnNew
            // 
            this.btnNew.Image = global::WFMS.Properties.Resources.new_normal;
            this.btnNew.Location = new System.Drawing.Point(83, 73);
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(32, 32);
            this.btnNew.TabIndex = 2;
            this.btnNew.TabStop = false;
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            this.btnNew.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnNew_MouseDown);
            this.btnNew.MouseEnter += new System.EventHandler(this.btnNew_MouseEnter);
            this.btnNew.MouseLeave += new System.EventHandler(this.btnNew_MouseLeave);
            this.btnNew.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnNew_MouseUp);
            // 
            // btnSave
            // 
            this.btnSave.BackgroundImage = global::WFMS.Properties.Resources.save_normal;
            this.btnSave.Location = new System.Drawing.Point(143, 73);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(32, 32);
            this.btnSave.TabIndex = 3;
            this.btnSave.TabStop = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            this.btnSave.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnSave_MouseDown);
            this.btnSave.MouseEnter += new System.EventHandler(this.btnSave_MouseEnter);
            this.btnSave.MouseLeave += new System.EventHandler(this.btnSave_MouseLeave);
            this.btnSave.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnSave_MouseUp);
            // 
            // btnLov
            // 
            this.btnLov.Image = global::WFMS.Properties.Resources.LOV_normal;
            this.btnLov.Location = new System.Drawing.Point(203, 73);
            this.btnLov.Name = "btnLov";
            this.btnLov.Size = new System.Drawing.Size(32, 32);
            this.btnLov.TabIndex = 4;
            this.btnLov.TabStop = false;
            this.btnLov.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnLov_MouseDown);
            this.btnLov.MouseEnter += new System.EventHandler(this.btnLov_MouseEnter);
            this.btnLov.MouseLeave += new System.EventHandler(this.btnLov_MouseLeave);
            this.btnLov.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnLov_MouseUp);
            // 
            // btnDelete
            // 
            this.btnDelete.Image = global::WFMS.Properties.Resources.Delete_normal;
            this.btnDelete.Location = new System.Drawing.Point(263, 73);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(32, 32);
            this.btnDelete.TabIndex = 5;
            this.btnDelete.TabStop = false;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            this.btnDelete.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnDelete_MouseDown);
            this.btnDelete.MouseEnter += new System.EventHandler(this.btnDelete_MouseEnter);
            this.btnDelete.MouseLeave += new System.EventHandler(this.btnDelete_MouseLeave);
            this.btnDelete.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnDelete_MouseUp);
            // 
            // btnZoom
            // 
            this.btnZoom.Image = global::WFMS.Properties.Resources.navigate_normal;
            this.btnZoom.Location = new System.Drawing.Point(323, 73);
            this.btnZoom.Name = "btnZoom";
            this.btnZoom.Size = new System.Drawing.Size(32, 32);
            this.btnZoom.TabIndex = 6;
            this.btnZoom.TabStop = false;
            this.btnZoom.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnZoom_MouseDown);
            this.btnZoom.MouseEnter += new System.EventHandler(this.btnZoom_MouseEnter);
            this.btnZoom.MouseLeave += new System.EventHandler(this.btnZoom_MouseLeave);
            this.btnZoom.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnZoom_MouseUp);
            // 
            // btnRefresh
            // 
            this.btnRefresh.Image = global::WFMS.Properties.Resources.refresh_normal;
            this.btnRefresh.Location = new System.Drawing.Point(383, 73);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(32, 32);
            this.btnRefresh.TabIndex = 7;
            this.btnRefresh.TabStop = false;
            this.btnRefresh.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnRefresh_MouseDown);
            this.btnRefresh.MouseEnter += new System.EventHandler(this.btnRefresh_MouseEnter);
            this.btnRefresh.MouseLeave += new System.EventHandler(this.btnRefresh_MouseLeave);
            this.btnRefresh.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnRefresh_MouseUp);
            // 
            // btnSearch
            // 
            this.btnSearch.Image = global::WFMS.Properties.Resources.search_normal;
            this.btnSearch.Location = new System.Drawing.Point(443, 73);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(32, 32);
            this.btnSearch.TabIndex = 8;
            this.btnSearch.TabStop = false;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            this.btnSearch.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnSearch_MouseDown);
            this.btnSearch.MouseEnter += new System.EventHandler(this.btnSearch_MouseEnter);
            this.btnSearch.MouseLeave += new System.EventHandler(this.btnSearch_MouseLeave);
            this.btnSearch.MouseUp += new System.Windows.Forms.MouseEventHandler(this.btnSearch_MouseUp);
            // 
            // wfmsDate
            // 
            this.wfmsDate.Location = new System.Drawing.Point(792, 76);
            this.wfmsDate.MinimumSize = new System.Drawing.Size(0, 29);
            this.wfmsDate.Name = "wfmsDate";
            this.wfmsDate.Size = new System.Drawing.Size(200, 29);
            this.wfmsDate.SQLColumn = "";
            this.wfmsDate.TabIndex = 9;
            // 
            // wfmsComboRecordPopulate
            // 
            this.wfmsComboRecordPopulate.BackColor = System.Drawing.Color.LightGray;
            this.wfmsComboRecordPopulate.Edited = false;
            this.wfmsComboRecordPopulate.Enabled = false;
            this.wfmsComboRecordPopulate.ForeverDisable = false;
            this.wfmsComboRecordPopulate.FormattingEnabled = true;
            this.wfmsComboRecordPopulate.ItemHeight = 23;
            this.wfmsComboRecordPopulate.Location = new System.Drawing.Point(393, 27);
            this.wfmsComboRecordPopulate.MainCMB = false;
            this.wfmsComboRecordPopulate.Mand = false;
            this.wfmsComboRecordPopulate.Name = "wfmsComboRecordPopulate";
            this.wfmsComboRecordPopulate.Size = new System.Drawing.Size(599, 29);
            this.wfmsComboRecordPopulate.SQLColumn = "";
            this.wfmsComboRecordPopulate.TabIndex = 0;
            this.wfmsComboRecordPopulate.UseSelectable = true;
            // 
            // frmMasterDetail
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.wfmsDate);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.btnZoom);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnLov);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnNew);
            this.Controls.Add(this.btnPopulate);
            this.Controls.Add(this.wfmsComboRecordPopulate);
            this.Name = "frmMasterDetail";
            this.Text = "frmMasterDetail";
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLov)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Controls.WfmsCombo wfmsComboRecordPopulate;
        private System.Windows.Forms.PictureBox btnPopulate;
        private System.Windows.Forms.PictureBox btnNew;
        private System.Windows.Forms.PictureBox btnSave;
        private System.Windows.Forms.PictureBox btnLov;
        private System.Windows.Forms.PictureBox btnDelete;
        private System.Windows.Forms.PictureBox btnZoom;
        private System.Windows.Forms.PictureBox btnRefresh;
        private System.Windows.Forms.PictureBox btnSearch;
        private Controls.WfmsDate wfmsDate;
    }
}