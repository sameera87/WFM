using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.wrkcal.businesslogic;

namespace WFMS.wrkcal.client
{
    public partial class frmDayType : Form
    {
        public frmDayType()
        {
            InitializeComponent();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (new DayType(txtDayTypeID.Text, txtDayTypeDesc.Text).insertDayType())
            {
                MessageBox.Show("New Day Type Added.");
            }
            else
            {
                MessageBox.Show("Error in Transaction");
            }
        }
    }
}
