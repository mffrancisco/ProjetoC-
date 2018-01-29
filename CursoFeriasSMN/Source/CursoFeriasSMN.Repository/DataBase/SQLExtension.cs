using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CursoFeriasSMN.Repository.DataBase
{
    public class SQLExtension
    {
        public static string ReadAsString(this SqlDataReader r, string campo)
        {
            return r.GetString(r.GetOrdinal(campo));
        }

        public SQLExtension()
        {

        }
    }
}
