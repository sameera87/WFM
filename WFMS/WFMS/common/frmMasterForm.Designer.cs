namespace WFMS.common
{
    partial class frmMasterDetailForm
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
            this.btnLOV = new System.Windows.Forms.PictureBox();
            this.btnDelete = new System.Windows.Forms.PictureBox();
            this.btnZoom = new System.Windows.Forms.PictureBox();
            this.btnRefresh = new System.Windows.Forms.PictureBox();
            this.btnSearch = new System.Windows.Forms.PictureBox();
            this.cmbPopulatedList = new WFMS.common.WFMS_cmb();
            this.wfmS_date1 = new WFMS.common.WFMS_date();
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLOV)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).BeginInit();
            this.SuspendLayout();
            // 
            // btnPopulate
            // 
            this.btnPopulate.Image = global::WFMS.Properties.Resources.populate_normal;
            this.btnPopulate.Location = new System.Drawing.Point(23, 87);
            this.btnPopulate.Name = "btnPopulate";
            this.btnPopulate.Size = new System.Drawing.Size(32, 32);
            this.btnPopulate.TabIndex = 1;
            this.btnPopulate.TabStop = false;
            // 
            // btnNew
            // 
            this.btnNew.Image = global::WFMS.Properties.Resources.new_normal;
            this.btnNew.Location = new System.Drawing.Point(78, 87);
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(32, 32);
            this.btnNew.TabIndex = 2;
            this.btnNew.TabStop = false;
            // 
            // btnSave
            // 
            this.btnSave.Image = global::WFMS.Properties.Resources.save_normal;
            this.btnSave.Location = new System.Drawing.Point(132, 87);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(32, 32);
            this.btnSave.TabIndex = 3;
            this.btnSave.TabStop = false;
            // 
            // btnLOV
            // 
            this.btnLOV.Image = global::WFMS.Properties.Resources.LOV_normal;
            this.btnLOV.Location = new System.Drawing.Point(193, 87);
            this.btnLOV.Name = "btnLOV";
            this.btnLOV.Size = new System.Drawing.Size(32, 32);
            this.btnLOV.TabIndex = 4;
            this.btnLOV.TabStop = false;
            // 
            // btnDelete
            // 
            this.btnDelete.Image = global::WFMS.Properties.Resources.Delete_normal;
            this.btnDelete.Location = new System.Drawing.Point(255, 87);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(32, 32);
            this.btnDelete.TabIndex = 5;
            this.btnDelete.TabStop = false;
            // 
            // btnZoom
            // 
            this.btnZoom.Image = global::WFMS.Properties.Resources.navigate_normal;
            this.btnZoom.Location = new System.Drawing.Point(319, 87);
            this.btnZoom.Name = "btnZoom";
            this.btnZoom.Size = new System.Drawing.Size(32, 32);
            this.btnZoom.TabIndex = 6;
            this.btnZoom.TabStop = false;
            // 
            // btnRefresh
            // 
            this.btnRefresh.Image = global::WFMS.Properties.Resources.refresh_normal;
            this.btnRefresh.Location = new System.Drawing.Point(378, 87);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(32, 32);
            this.btnRefresh.TabIndex = 7;
            this.btnRefresh.TabStop = false;
            // 
            // btnSearch
            // 
            this.btnSearch.Image = global::WFMS.Properties.Resources.search_normal;
            this.btnSearch.Location = new System.Drawing.Point(440, 87);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(32, 32);
            this.btnSearch.TabIndex = 8;
            this.btnSearch.TabStop = false;
            // 
            // cmbPopulatedList
            // 
            this.cmbPopulatedList.Edited = false;
            this.cmbPopulatedList.ForeverDisable = false;
            this.cmbPopulatedList.FormattingEnabled = true;
            this.cmbPopulatedList.ItemHeight = 23;
            this.cmbPopulatedList.Location = new System.Drawing.Point(378, 29);
            this.cmbPopulatedList.MainCMB = false;
            this.cmbPopulatedList.Mand = false;
            this.cmbPopulatedList.Name = "cmbPopulatedList";
            this.cmbPopulatedList.Size = new System.Drawing.Size(594, 29);
            this.cmbPopulatedList.SQLColumn = "";
            this.cmbPopulatedList.TabIndex = 9;
            this.cmbPopulatedList.UseSelectable = true;
            // 
            // wfmS_date1
            // 
            this.wfmS_date1.Location = new System.Drawing.Point(748, 90);
            this.wfmS_date1.MinimumSize = new System.Drawing.Size(0, 29);
            this.wfmS_date1.Name = "wfmS_date1";
            this.wfmS_date1.Size = new System.Drawing.Size(224, 29);
            this.wfmS_date1.SQLColumn = "";
            this.wfmS_date1.TabIndex = 10;
            // 
            // frmMasterDetailForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 768);
            this.Controls.Add(this.wfmS_date1);
            this.Controls.Add(this.cmbPopulatedList);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.btnZoom);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnLOV);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnNew);
            this.Controls.Add(this.btnPopulate);
            this.Name = "frmMasterDetailForm";
            this.Text = "frmMasterDetailForm";
            ((System.ComponentModel.ISupportInitialize)(this.btnPopulate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNew)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnLOV)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnDelete)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnZoom)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnRefresh)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSearch)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.PictureBox btnPopulate;
        private System.Windows.Forms.PictureBox btnNew;
        private System.Windows.Forms.PictureBox btnSave;
        private System.Windows.Forms.PictureBox btnLOV;
        private System.Windows.Forms.PictureBox btnDelete;
        private System.Windows.Forms.PictureBox btnZoom;
        private System.Windows.Forms.PictureBox btnRefresh;
        private System.Windows.Forms.PictureBox btnSearch;
        private WFMS_cmb cmbPopulatedList;
        private WFMS_date wfmS_date1;
    }
}