using System.Configuration;
using System.Data.SqlClient;

namespace RentACar
{
    public static class Db
    {
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(
                ConfigurationManager.ConnectionStrings["RentACarCS"].ConnectionString
            );
        }
    }
}