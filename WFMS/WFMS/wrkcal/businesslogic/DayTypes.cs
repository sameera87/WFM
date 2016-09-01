using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OracleClient;
using WFMS.dataaccess;

namespace WFMS.wrkcal.businesslogic
{
    class DayType
    {
        private string dayTypeID;
        private string dayTypeDescription;
        private double workTimePerDay;

        public string DayTypeID 
        {
            set { this.dayTypeID = value; }
            get { return this.dayTypeID; }
        }

        public string DayTypeDescription
        {
            set { this.dayTypeDescription = value; }
            get { return this.dayTypeDescription; }
        }

        public double WorkTimePerDay
        {
            set { this.workTimePerDay = value; }
            get { return this.workTimePerDay; }
        }

        public DayType() { }
        public DayType(string did) 
        {
            this.dayTypeID = did;
        }
        public DayType(string did, string ddsec) 
        {
            this.dayTypeID = did;
            this.dayTypeDescription = ddsec;
        }
        public DayType(string did, string ddsec, double wtpd) 
        {
            this.dayTypeID = did;
            this.dayTypeDescription = ddsec;
            this.workTimePerDay = wtpd;
        }

        public bool insertDayType()
        {
            string query = "DAY_TYPES.addDayType(d_type => '"+this.dayTypeID+"', d_type_desc => '"+this.dayTypeDescription+"')";
            return new DataAccessModule().executeNonQuery(query);
        }
    }
}
