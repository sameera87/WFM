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
    class WFMS_date : MetroDateTime
    {
        #region Local Variables and Properties
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

        #region Methods
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
        #endregion
    }
}
