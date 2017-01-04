using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MetroFramework.Controls;

namespace WFMS.Common.Controls
{
    class WfmsRadio : MetroRadioButton
    {
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            //
            // 
            this.Enabled = false;
            this.ResumeLayout(false);
        }
    }
}
