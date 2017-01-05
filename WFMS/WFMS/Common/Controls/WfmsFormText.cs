using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace WFMS.Common.Controls
{
    public class WfmsFormText : TextBox
    {
        #region properties

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
        #endregion property

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            //
            // 
            this.TextChanged += new System.EventHandler(this.WfmsFormText_TextChanged);
            this.ResumeLayout(false);

        }

        private void WfmsFormText_TextChanged(object sender, EventArgs e)
        {
            Edited = true;
        }
    }
}
