using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WFMS.Common.Clients;
using WFMS.Common.Classes;
using Oracle.ManagedDataAccess.Client;
using WFMS.Enterprise.Business_Logic;

namespace WFMS.Enterprise.Client
{
    public partial class frmDayType : frmMasterDetail
    {
        public frmDayType()
        {
            InitializeComponent();
        }
    }
}
