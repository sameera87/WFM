using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MetroFramework.Controls;

namespace WFMS.common
{
    class WFMS_rdo : MetroRadioButton
    {
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // BOLTradio
            // 
            this.Enabled = false;
            this.ResumeLayout(false);

        }
    }
}
