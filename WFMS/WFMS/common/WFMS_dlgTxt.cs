using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WFMS.common
{
    class WFMS_dlgTxt : TextBox
    {

        #region Local Variables and Properties
        private Boolean edited = false;

        public bool Edited
        {
            get
            {
                return edited;
            }

            set
            {
                edited = value;
            }
        }
        #endregion

        #region Methods
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // NORMALtxt
            // 
            this.TextChanged += new System.EventHandler(this.WFMS_dlgTxt_TextChanged);
            this.ResumeLayout(false);
        }

        private void WFMS_dlgTxt_TextChanged(object sender, EventArgs e)
        {
            Edited = true;
        }
        #endregion

    }
}
