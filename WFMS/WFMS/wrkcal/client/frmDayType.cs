using System;
using MetroFramework.Forms;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.dataaccess;
using Oracle.ManagedDataAccess.Client;
using WFMS.wrkcal.businesslogic;
using WFMS.common;

namespace WFMS.wrkcal.client
{
    public partial class frmDayType : frmMasterDetailForm
    {
        public frmDayType()
        {
            InitializeComponent();
        }

        //public void populateOneRecord(DayType dayTypeObj) 
        //{
        //    cmbDayTypeID.Text = dayTypeObj.DayTypeID;
        //    txtDayTypeDesc.Text = dayTypeObj.DayTypeDescription;
        //    txtWorkTimeCalendar.Text = dayTypeObj.WorkTimePerDay.ToString();
        //}

        //private void btnSave_Click(object sender, EventArgs e)
        //{
        //    if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled==true)
        //    {
        //        try
        //        {
        //            DayType dayTypeObj = new DayType(cmbDayTypeID.Text, txtDayTypeDesc.Text);
        //            dayTypeObj.addDayType(dayTypeObj);

        //            cmbDayTypeID.Enabled = false;
        //        }

        //        catch (Exception ex)
        //        {
        //            MessageBox.Show(ex.Message);
        //        }
        //    }

        //    else if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled==false) //To Update any changes done for the Day Type
        //    {
        //        try
        //        {
        //            DayType dayTypeObj = new DayType(cmbDayTypeID.Text, txtDayTypeDesc.Text);
        //            dayTypeObj.updateDayType(dayTypeObj);

        //            cmbDayTypeID.Enabled = false;
        //        }

        //        catch (Exception ex)
        //        {
        //            MessageBox.Show(ex.Message);
        //        }
        //    }
        //    else
        //    {
        //        MessageBox.Show("Error in Transaction");
        //    }
        //}

        //private void btnNew_Click(object sender, EventArgs e)
        //{
        //    cmbDayTypeID.Items.Clear();
        //    txtDayTypeDesc.Clear();
        //    txtWorkTimeCalendar.Clear();

        //    cmbDayTypeID.Enabled = true;
        //    txtDayTypeDesc.Enabled = true;
        //    cmbDayTypeID.Focus();

        //    btnSave.Enabled = true;
        //}

        //private void btnDelete_Click(object sender, EventArgs e)
        //{
        //    if (cmbDayTypeID.Text != null && cmbDayTypeID.Enabled == false)
        //    {
        //        try
        //        {
        //            DayType dayTypeObj = new DayType(cmbDayTypeID.Text, txtDayTypeDesc.Text);
        //            dayTypeObj.deleteDayType(dayTypeObj);

        //            cmbDayTypeID.Enabled = false;
        //            txtDayTypeDesc.Enabled = false;

        //            cmbDayTypeID.Items.Clear();
        //            txtDayTypeDesc.Clear();
        //            txtWorkTimeCalendar.Clear();
        //        }

        //        catch (Exception ex)
        //        {
        //            MessageBox.Show(ex.Message);
        //        }
        //    }
        //}

        //private void btnQuery_Click(object sender, EventArgs e)
        //{
        //    dlgSearchDialog sd = new dlgSearchDialog();
        //    sd.Show();
        //}
    }
}
