using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading.Tasks;
using MetroFramework.Controls;

namespace WFMS.Common.Controls
{
    class WfmsDate : MetroDateTime
    {
        #region Properties
        private string SQL_COL = "";

        public string SQLColumn
        {
            get
            {
                return SQL_COL;
            }

            set
            {
                SQL_COL = value;
            }
        }
        #endregion

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            //
            // 
            this.Enabled = false;
            this.FontSize = MetroFramework.MetroDateTimeSize.Small;
            this.ResumeLayout(false);

        }
    }
}
