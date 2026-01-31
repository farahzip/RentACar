using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RentACar
{
    public partial class Izvjestaji : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummary();
            }
        }

        private void LoadSummary()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                con.Open();

                // broj klijenata
                SqlCommand cmdKlijenti = new SqlCommand("SELECT COUNT(*) FROM klijent", con);
                lblBrojKlijenata.Text = cmdKlijenti.ExecuteScalar().ToString();

                // broj vozila ukupno
                SqlCommand cmdVozila = new SqlCommand("SELECT COUNT(*) FROM vozilo", con);
                lblBrojVozila.Text = cmdVozila.ExecuteScalar().ToString();

                // dostupna vozila
                SqlCommand cmdDostupna = new SqlCommand("SELECT COUNT(*) FROM vozilo WHERE status = 1", con);
                lblDostupna.Text = cmdDostupna.ExecuteScalar().ToString();

                // zauzeta vozila
                SqlCommand cmdZauzeta = new SqlCommand("SELECT COUNT(*) FROM vozilo WHERE status = 0", con);
                lblZauzeta.Text = cmdZauzeta.ExecuteScalar().ToString();

                // ukupna zarada
                SqlCommand cmdZarada = new SqlCommand("SELECT ISNULL(SUM(ukupna_cijena),0) FROM rezervacija", con);
                lblZarada.Text = cmdZarada.ExecuteScalar().ToString() + " KM";

                con.Close();
            }
        }
    }
}