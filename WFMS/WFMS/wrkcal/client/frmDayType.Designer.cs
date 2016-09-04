namespace WFMS.wrkcal.client
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtDayTypeDesc = new System.Windows.Forms.TextBox();
            this.btnNew = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.txtWorkTimeCalendar = new System.Windows.Forms.TextBox();
            this.dgvWorkTimeLines = new System.Windows.Forms.DataGridView();
            this.btnPopulate = new System.Windows.Forms.Button();
            this.btnQuery = new System.Windows.Forms.Button();
            this.btnDelete = new System.Windows.Forms.Button();
            this.cmbDayTypeID = new System.Windows.Forms.ComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgvWorkTimeLines)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(34, 24);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(67, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Day Type ID";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(195, 24);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(109, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Day Type Description";
            // 
            // txtDayTypeDesc
            // 
            this.txtDayTypeDesc.Enabled = false;
            this.txtDayTypeDesc.Location = new System.Drawing.Point(196, 50);
            this.txtDayTypeDesc.Margin = new System.Windows.Forms.Padding(2);
            this.txtDayTypeDesc.Multiline = true;
            this.txtDayTypeDesc.Name = "txtDayTypeDesc";
            this.txtDayTypeDesc.Size = new System.Drawing.Size(252, 22);
            this.txtDayTypeDesc.TabIndex = 3;
            // 
            // btnNew
            // 
            this.btnNew.Location = new System.Drawing.Point(37, 404);
            this.btnNew.Margin = new System.Windows.Forms.Padding(2);
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(56, 19);
            this.btnNew.TabIndex = 4;
            this.btnNew.Text = "New";
            this.btnNew.UseVisualStyleBackColor = true;
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            // 
            // btnSave
            // 
            this.btnSave.Enabled = false;
            this.btnSave.Location = new System.Drawing.Point(112, 404);
            this.btnSave.Margin = new System.Windows.Forms.Padding(2);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(56, 19);
            this.btnSave.TabIndex = 5;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(485, 24);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(100, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Work Time Per Day";
            // 
            // txtWorkTimeCalendar
            // 
            this.txtWorkTimeCalendar.Location = new System.Drawing.Point(485, 50);
            this.txtWorkTimeCalendar.Name = "txtWorkTimeCalendar";
            this.txtWorkTimeCalendar.ReadOnly = true;
            this.txtWorkTimeCalendar.Size = new System.Drawing.Size(115, 20);
            this.txtWorkTimeCalendar.TabIndex = 7;
            // 
            // dgvWorkTimeLines
            // 
            this.dgvWorkTimeLines.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvWorkTimeLines.Location = new System.Drawing.Point(37, 95);
            this.dgvWorkTimeLines.Name = "dgvWorkTimeLines";
            this.dgvWorkTimeLines.Size = new System.Drawing.Size(749, 285);
            this.dgvWorkTimeLines.TabIndex = 8;
            // 
            // btnPopulate
            // 
            this.btnPopulate.Location = new System.Drawing.Point(196, 402);
            this.btnPopulate.Name = "btnPopulate";
            this.btnPopulate.Size = new System.Drawing.Size(75, 23);
            this.btnPopulate.TabIndex = 9;
            this.btnPopulate.Text = "Populate";
            this.btnPopulate.UseVisualStyleBackColor = true;
            // 
            // btnQuery
            // 
            this.btnQuery.Location = new System.Drawing.Point(292, 402);
            this.btnQuery.Name = "btnQuery";
            this.btnQuery.Size = new System.Drawing.Size(75, 23);
            this.btnQuery.TabIndex = 10;
            this.btnQuery.Text = "Search";
            this.btnQuery.UseVisualStyleBackColor = true;
            // 
            // btnDelete
            // 
            this.btnDelete.Location = new System.Drawing.Point(391, 402);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(75, 23);
            this.btnDelete.TabIndex = 11;
            this.btnDelete.Text = "Delete";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // cmbDayTypeID
            // 
            this.cmbDayTypeID.Enabled = false;
            this.cmbDayTypeID.FormattingEnabled = true;
            this.cmbDayTypeID.Location = new System.Drawing.Point(37, 50);
            this.cmbDayTypeID.Name = "cmbDayTypeID";
            this.cmbDayTypeID.Size = new System.Drawing.Size(121, 21);
            this.cmbDayTypeID.TabIndex = 12;
            // 
            // frmDayType
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(831, 467);
            this.Controls.Add(this.cmbDayTypeID);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnQuery);
            this.Controls.Add(this.btnPopulate);
            this.Controls.Add(this.dgvWorkTimeLines);
            this.Controls.Add(this.txtWorkTimeCalendar);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnNew);
            this.Controls.Add(this.txtDayTypeDesc);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmDayType";
            this.Text = "frmDayType";
            ((System.ComponentModel.ISupportInitialize)(this.dgvWorkTimeLines)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtDayTypeDesc;
        private System.Windows.Forms.Button btnNew;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtWorkTimeCalendar;
        private System.Windows.Forms.DataGridView dgvWorkTimeLines;
        private System.Windows.Forms.Button btnPopulate;
        private System.Windows.Forms.Button btnQuery;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.ComboBox cmbDayTypeID;
    }
}