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
using WFMS.Common.Controls;

namespace WFMS.Common.Clients
{
    public partial class dlgSearch : MetroForm
    {

        #region Properties

        private char[] fieldDEL = { ',', ':' };
        //private const char fieldDEL = ',';
        private string[] fieldsWithType = new string[10];
        private string[] fieldWithType = new string[10];
        public frmMasterDetail parent;
        public static EventHandler<string> SearchThis;

        #endregion
        
        public dlgSearch()
        {
            InitializeComponent();
        }

        public dlgSearch(string searchWindowName, string attr)
        {
            InitializeComponent();
            Label[] lables = new Label[10];
            WfmsFormText[] textboxes = new WfmsFormText[10];
            DateTimePicker[] dtp = new DateTimePicker[10];
            WfmsDate[] dates = new WfmsDate[10];
            int i = 0;
            int x = 50, y = 70;
            Text = "Search " + searchWindowName;
            fieldsWithType = attr.Split(fieldDEL[0]);
            foreach (String s in fieldsWithType)
            {
                fieldWithType = s.Split(fieldDEL[1]);
                lables[i] = new Label();
                fieldWithType[0] = fieldWithType[0].Replace("_", " ");
                lables[i].Text = fieldWithType[0];

                if (fieldWithType[1] == "DATE")
                {
                    dates[i] = new WfmsDate();
                    dates[i].Format = DateTimePickerFormat.Custom;
                    dates[i].CustomFormat = "dd-MM-yyyy";
                    dates[i].Name = fieldWithType[0];
                    lables[i].Location = new Point(x, y);
                    dates[i].Location = new Point(x + 100, y);
                    Controls.Add(lables[i]);
                    Controls.Add(dates[i]);

                }
                else
                {
                    textboxes[i] = new WfmsFormText();
                    textboxes[i].Name = fieldWithType[0];
                    lables[i].Location = new Point(x, y);
                    textboxes[i].Location = new Point(x + 100, y);
                    Controls.Add(lables[i]);
                    Controls.Add(textboxes[i]);

                }
                i++;
                y = y + 40;

            }
        }

        private void btnSearch_Click_1(object sender, EventArgs e)
        {
            
            string a = "";
            int i = 1;
            foreach (Control x in Controls)
            {
                if (x is WfmsFormText)
                {
                    //((NORMALtxt)x).Text = String.Empty;
                    if (!String.IsNullOrEmpty(((WfmsFormText)x).Text))
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
                else if(x is WfmsDate)
                {
                    if (!String.IsNullOrEmpty(((WfmsDate)x).Text))
                    {
                        if (i == 1)
                        {
                            a += " Where " + x.Name + "= To_Date('" + x.Text + "', 'dd-MM-yyyy')";
                            i++;
                        }
                        else
                        {
                            a += " AND " + x.Name + "= To_Date('" + x.Text + "', 'dd-MM-yyyy')";
                        }
                    }
                }
            }
            parent.SearchQ += a;
            Close();
        }
    }

    public class SeQLColumnEventArgs : EventArgs
    {
        public string SeqlColumn { get; set; }
    }
}
