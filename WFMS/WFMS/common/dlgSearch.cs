using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MetroFramework.Forms;

namespace WFMS.common
{
    public partial class dlgSearch : MetroForm
    {
        #region Local Variables and Properties

        private char[] fieldDEL = { ',', ':' };
        //private const char fieldDEL = ',';
        private string[] fieldsWithType = new string[10];
        private string[] fieldWithType = new string[10];
        public frmMasterDetailForm parent;
        public static EventHandler<string> SearchThis;

        #endregion

        public dlgSearch()
        {
            InitializeComponent();
        }

        public class SeQLColumnEventArgs : EventArgs
        {
            public string SeqlColumn { get; set; }
        }

        #region Methods

        public dlgSearch(string searchWindowName, string attr)
        {
            InitializeComponent();
            Label[] lables = new Label[10];
            WFMS_dlgTxt[] textboxes = new WFMS_dlgTxt[10];
            DateTimePicker[] dtp = new DateTimePicker[10];
            int i = 0;
            int x = 50, y = 70;
            Text = "Search " + searchWindowName;
            fieldsWithType = attr.Split(fieldDEL[0]);
            foreach (String s in fieldsWithType)
            {
                fieldWithType = s.Split(fieldDEL[1]);
                lables[i] = new Label();
                lables[i].Text = fieldWithType[0];
                textboxes[i] = new WFMS_dlgTxt();
                textboxes[i].Name = fieldWithType[0];
                lables[i].Location = new Point(x, y);
                textboxes[i].Location = new Point(x + 100, y);
                Controls.Add(lables[i]);
                Controls.Add(textboxes[i]);
                i++;
                y = y + 30;
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            string a = "";
            int i = 1;
            foreach (Control x in Controls)
            {
                if (x is WFMS_dlgTxt)
                {
                    //((NORMALtxt)x).Text = String.Empty;
                    if (!String.IsNullOrEmpty(((WFMS_dlgTxt)x).Text))
                    {
                        if (i == 1)
                        {
                            a += " Where " + x.Name + "='" + x.Text + "'";
                            i++;
                        }
                        else
                        {
                            a += " AND " + x.Name + "= '" + x.Text + "'";
                        }
                    }

                }
            }
            //parent.SearchQ += a;
            Close();
        }
        #endregion

    }
}
