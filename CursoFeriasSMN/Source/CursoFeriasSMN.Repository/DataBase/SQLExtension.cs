using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CursoFeriasSMN.Repository.DataBase
{
    public static class SqlExtension
    {
        public static string ReadAsString(this SqlDataReader r, string campo)
        {
            return r.GetString(r.GetOrdinal(campo));
        }

        public static int ReadAsInt(this SqlDataReader r, string campo)
        {
            return r.GetInt32(r.GetOrdinal(campo));
        }

        public static int ReadAsShort(this SqlDataReader r, string campo)
        {
            return r.GetInt16(r.GetOrdinal(campo));
        }

        public static decimal ReadAsDecimal(this SqlDataReader r, string campo)
        {
            return r.GetDecimal(r.GetOrdinal(campo));
        }

        /* A interrogação nesse caso indica que o valor aqui pode vir nulo e permite 
           que isso aconteça sem problemas */
        public static decimal? ReadAsDecimalNull(this SqlDataReader r, string campo)
        {
            var ordinal = r.GetOrdinal(campo);
            return r.IsDBNull(ordinal) ? (decimal?)null : r.GetDecimal(r.GetOrdinal(campo));
        }

        public static DateTime ReadAsDateTime(this SqlDataReader r, string campo)
        {
            return r.GetDateTime(r.GetOrdinal(campo));
        }
    }
}
