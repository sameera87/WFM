namespace WFMS.wrkcal.client
{
    partial class dlgSearchDialog
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
            this.txtDayTypeID_SD = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.btnSearchDayType = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(18, 52);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(96, 20);
            this.label1.TabIndex = 0;
            this.label1.Text = "Day Type ID";
            // 
            // txtDayTypeID_SD
            // 
            this.txtDayTypeID_SD.Location = new System.Drawing.Point(148, 48);
            this.txtDayTypeID_SD.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.txtDayTypeID_SD.Name = "txtDayTypeID_SD";
            this.txtDayTypeID_SD.Size = new System.Drawing.Size(258, 26);
            this.txtDayTypeID_SD.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(18, 118);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(116, 20);
            this.label2.TabIndex = 2;
            this.label2.Text = "Day Type Desc";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(148, 114);
            this.textBox1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(258, 26);
            this.textBox1.TabIndex = 3;
            // 
            // btnSearchDayType
            // 
            this.btnSearchDayType.Location = new System.Drawing.Point(58, 312);
            this.btnSearchDayType.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnSearchDayType.Name = "btnSearchDayType";
            this.btnSearchDayType.Size = new System.Drawing.Size(112, 35);
            this.btnSearchDayType.TabIndex = 4;
            this.btnSearchDayType.Text = "Search";
            this.btnSearchDayType.UseVisualStyleBackColor = true;
            this.btnSearchDayType.Click += new System.EventHandler(this.btnSearchDayType_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(212, 312);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(112, 35);
            this.btnCancel.TabIndex = 5;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // dlgSearchDialog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(426, 402);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSearchDayType);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtDayTypeID_SD);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "dlgSearchDialog";
            this.Text = "SearchDialog";
            this.Load += new System.EventHandler(this.dlgSearchDialog_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtDayTypeID_SD;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button btnSearchDayType;
        private System.Windows.Forms.Button btnCancel;
    }
}