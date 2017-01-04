using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WFMS.Common.Classes
{
    class Client_SYS
    {
        private const String field_separator = ""; //this variable is not empty (unicode)
        private const String record_separator = ""; //this variable is not empty (unicode)
        public static void Add_To_Attr(ref String attr, String name, String value)
        {
            attr += name.ToUpper() + field_separator + value + record_separator;
        }

        public static void Add_To_Attr(ref String attr, String name, DateTime value)
        {
            Add_To_Attr(ref attr, name, value.ToString());
        }

        public static void Add_To_Attr(ref String attr, String name, Double value)
        {
            Add_To_Attr(ref attr, name, value.ToString());
        }

        public static void Add_To_Attr(ref String attr, String name, Int32 value)
        {
            Add_To_Attr(ref attr, name, value.ToString());
        }

        public static void Add_To_Attr(ref String attr, String name, Boolean value)
        {
            if (value)
                Add_To_Attr(ref attr, name, "TRUE");
            else
                Add_To_Attr(ref attr, name, "FALSE");
        }


        public static void Get_From_Attr(String attr, String name, ref String value)
        {
            string[] fields = attr.Split(record_separator.ToCharArray());
            String[] record;
            for (int i = 0; i < fields.Length; i++)
            {
                record = fields[i].Split(field_separator.ToCharArray());
                if (record[0].Equals(name))
                {
                    value = record[1];
                    i = fields.Length;
                }
            }
        }

        public static Int32 Get_Attr_Field_Count(String attr)
        {
            string[] fields = attr.Split(record_separator.ToCharArray());
            int count = fields.Length;
            return count;
        }

        public static void Get_From_Attr(String attr, String name, ref Double value)
        {
            String tmp = "";
            Get_From_Attr(attr, name, ref tmp);
            value = Double.Parse(tmp);
        }

        public static void Get_From_Attr(String attr, String name, ref DateTime value)
        {
            String tmp = "";
            Get_From_Attr(attr, name, ref tmp);
            value = DateTime.Parse(tmp);
        }

        public static void Get_From_Attr(String attr, String name, ref int value)
        {
            String tmp = "";
            Get_From_Attr(attr, name, ref tmp);
            value = Int32.Parse(tmp);
        }
        public static void Get_From_Attr(String attr, String name, ref Boolean value)
        {
            String tmp = "";
            Get_From_Attr(attr, name, ref tmp);
            if (tmp == "TRUE")
                value = true;
            else
                value = false;
        }
    }
}
