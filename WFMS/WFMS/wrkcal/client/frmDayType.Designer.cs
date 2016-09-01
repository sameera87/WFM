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
            this.txtDayTypeID = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtDayTypeDesc = new System.Windows.Forms.TextBox();
            this.btnNew = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.txtWorkTimeCalendar = new System.Windows.Forms.TextBox();
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
            // txtDayTypeID
            // 
            this.txtDayTypeID.Enabled = false;
            this.txtDayTypeID.Location = new System.Drawing.Point(37, 49);
            this.txtDayTypeID.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.txtDayTypeID.Name = "txtDayTypeID";
            this.txtDayTypeID.Size = new System.Drawing.Size(76, 20);
            this.txtDayTypeID.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(162, 24);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(109, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Day Type Description";
            // 
            // txtDayTypeDesc
            // 
            this.txtDayTypeDesc.Enabled = false;
            this.txtDayTypeDesc.Location = new System.Drawing.Point(164, 49);
            this.txtDayTypeDesc.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.txtDayTypeDesc.Multiline = true;
            this.txtDayTypeDesc.Name = "txtDayTypeDesc";
            this.txtDayTypeDesc.Size = new System.Drawing.Size(166, 22);
            this.txtDayTypeDesc.TabIndex = 3;
            // 
            // btnNew
            // 
            this.btnNew.Location = new System.Drawing.Point(624, 404);
            this.btnNew.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
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
            this.btnSave.Location = new System.Drawing.Point(698, 404);
            this.btnSave.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
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
            this.label3.Location = new System.Drawing.Point(388, 24);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(100, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Work Time Per Day";
            // 
            // txtWorkTimeCalendar
            // 
            this.txtWorkTimeCalendar.Location = new System.Drawing.Point(391, 49);
            this.txtWorkTimeCalendar.Name = "txtWorkTimeCalendar";
            this.txtWorkTimeCalendar.ReadOnly = true;
            this.txtWorkTimeCalendar.Size = new System.Drawing.Size(100, 20);
            this.txtWorkTimeCalendar.TabIndex = 7;
            // 
            // frmDayType
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(831, 467);
            this.Controls.Add(this.txtWorkTimeCalendar);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnNew);
            this.Controls.Add(this.txtDayTypeDesc);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtDayTypeID);
            this.Controls.Add(this.label1);
            this.Name = "frmDayType";
            this.Text = "frmDayType";
            this.Load += new System.EventHandler(this.frmDayType_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtDayTypeID;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtDayTypeDesc;
        private System.Windows.Forms.Button btnNew;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtWorkTimeCalendar;
    }
}