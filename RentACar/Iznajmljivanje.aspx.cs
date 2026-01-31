using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace RentACar
{
    public partial class Iznajmljivanje : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKlijenti();
                LoadVozila();
                LoadRezervacije();
            }
        }

        private void LoadKlijenti()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT id, ime + ' ' + prezime AS ImePrezime FROM klijent", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlKlijent.DataSource = dt;
                ddlKlijent.DataTextField = "ImePrezime";
                ddlKlijent.DataValueField = "id";
                ddlKlijent.DataBind();

                ddlKlijent.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Odaberite--", ""));
            }
        }

        private void LoadVozila()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT id, marka + ' ' + model AS Vozilo FROM vozilo", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlVozilo.DataSource = dt;
                ddlVozilo.DataTextField = "Vozilo";
                ddlVozilo.DataValueField = "id";
                ddlVozilo.DataBind();

                ddlVozilo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Odaberite--", ""));
            }
        }

        private void LoadRezervacije()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                SELECT r.id,
                       k.ime + ' ' + k.prezime AS Klijent,
                       v.marka + ' ' + v.model AS Vozilo,
                       r.datum_od,
                       r.datum_do,
                       r.ukupna_cijena
                FROM rezervacija r
                JOIN klijent k ON r.klijent_id = k.id
                JOIN vozilo v ON r.vozilo_id = v.id", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRezervacija.DataSource = dt;
                gvRezervacija.DataBind();
            }
        }

        protected void btnRezervisi_Click(object sender, EventArgs e)
        {
            lblError.Text = ""; // reset

            // 1. Validacija dropdown-a
            if (string.IsNullOrEmpty(ddlKlijent.SelectedValue))
            {
                lblError.Text = "Odaberite klijenta!";
                return;
            }
            if (string.IsNullOrEmpty(ddlVozilo.SelectedValue))
            {
                lblError.Text = "Odaberite vozilo!";
                return;
            }

            // 2. Validacija datuma
            if (!DateTime.TryParse(txtOd.Text, out DateTime od))
            {
                lblError.Text = "Datum početka nije validan!";
                return;
            }
            if (!DateTime.TryParse(txtDo.Text, out DateTime doDat))
            {
                lblError.Text = "Datum završetka nije validan!";
                return;
            }
            if (doDat < od)
            {
                lblError.Text = "Datum završetka mora biti isti ili veći od datuma početka!";
                return;
            }

            // 3. Provjera da li je vozilo već rezervisano
            using (SqlConnection con = Db.GetConnection())
            {
                SqlCommand check = new SqlCommand(
                    @"SELECT COUNT(*) 
                  FROM rezervacija 
                  WHERE vozilo_id=@v AND datum_do >= @od AND datum_od <= @do", con);

                check.Parameters.AddWithValue("@v", ddlVozilo.SelectedValue);
                check.Parameters.AddWithValue("@od", od);
                check.Parameters.AddWithValue("@do", doDat);

                con.Open();
                int conflict = (int)check.ExecuteScalar();

                if (conflict > 0)
                {
                    lblError.Text = "Ovo vozilo je već rezervisano u odabranom periodu!";
                    return;
                }

                // 4. Uzmi cijenu vozila
                SqlCommand getPrice = new SqlCommand(
                    "SELECT cijena_dan FROM vozilo WHERE id=@id", con);
                getPrice.Parameters.AddWithValue("@id", ddlVozilo.SelectedValue);
                object scalar = getPrice.ExecuteScalar();
                if (scalar == null || scalar == DBNull.Value)
                {
                    lblError.Text = "Cijena vozila nije pronađena.";
                    return;
                }
                decimal cijenaPoDanu;
                try
                {
                    cijenaPoDanu = Convert.ToDecimal(scalar); // handles FLOAT/double, DECIMAL, int, etc.
                }
                catch (Exception)
                {
                    lblError.Text = "Error parsiranja.";
                    return;
                }

                int brojDana = (doDat - od).Days + 1;
                decimal ukupno = brojDana * cijenaPoDanu;

                // 5. Insert u rezervaciju
                SqlCommand insert = new SqlCommand(@"
                INSERT INTO rezervacija
                (vozilo_id, klijent_id, datum_kreiranja, datum_od, datum_do, ukupna_cijena)
                VALUES (@v, @k, GETDATE(), @od, @do, @u)", con);

                insert.Parameters.AddWithValue("@v", ddlVozilo.SelectedValue);
                insert.Parameters.AddWithValue("@k", ddlKlijent.SelectedValue);
                insert.Parameters.AddWithValue("@od", od);
                insert.Parameters.AddWithValue("@do", doDat);
                insert.Parameters.AddWithValue("@u", ukupno);

                insert.ExecuteNonQuery();

                // 6. Promjena statusa vozila na zauzeto
                SqlCommand updateStatus = new SqlCommand(
                    "UPDATE vozilo SET status=0 WHERE id=@id", con);
                updateStatus.Parameters.AddWithValue("@id", ddlVozilo.SelectedValue);
                updateStatus.ExecuteNonQuery();

                con.Close();
            }

            // 7. Osvježi stranice i dropdown-e
            LoadRezervacije();
            LoadVozila();

            // 8. Clear inpute
            ddlKlijent.SelectedIndex = 0;
            ddlVozilo.SelectedIndex = 0;
            txtOd.Text = txtDo.Text = "";

            lblError.ForeColor = System.Drawing.Color.Green;
            lblError.Text = "Rezervacija uspješno dodana!";
        }
        protected void btnSearchRez_Click(object sender, EventArgs e)
        {
            string klijentQuery = txtSearchKlijent.Text.Trim();
            string voziloQuery = txtSearchVozilo.Text.Trim();

            DateTime? od = null;
            DateTime? doDat = null;

            if (DateTime.TryParse(txtSearchOd.Text, out DateTime odTemp))
                od = odTemp;
            if (DateTime.TryParse(txtSearchDo.Text, out DateTime doTemp))
                doDat = doTemp;

            using (SqlConnection con = Db.GetConnection())
            {
                string sql = @"
                    SELECT r.id,
                           k.ime + ' ' + k.prezime AS Klijent,
                           v.marka + ' ' + v.model AS Vozilo,
                           r.datum_od,
                           r.datum_do,
                           r.ukupna_cijena
                    FROM rezervacija r
                    JOIN klijent k ON r.klijent_id = k.id
                    JOIN vozilo v ON r.vozilo_id = v.id
                    WHERE 1=1";

                if (!string.IsNullOrEmpty(klijentQuery))
                    sql += " AND (k.ime LIKE @kl OR k.prezime LIKE @kl)";
                if (!string.IsNullOrEmpty(voziloQuery))
                    sql += " AND (v.marka LIKE @voz OR v.model LIKE @voz)";
                if (od.HasValue)
                    sql += " AND r.datum_od >= @od";
                if (doDat.HasValue)
                    sql += " AND r.datum_do <= @do";

                SqlCommand cmd = new SqlCommand(sql, con);

                if (!string.IsNullOrEmpty(klijentQuery))
                    cmd.Parameters.AddWithValue("@kl", "%" + klijentQuery + "%");
                if (!string.IsNullOrEmpty(voziloQuery))
                    cmd.Parameters.AddWithValue("@voz", "%" + voziloQuery + "%");
                if (od.HasValue)
                    cmd.Parameters.AddWithValue("@od", od.Value);
                if (doDat.HasValue)
                    cmd.Parameters.AddWithValue("@do", doDat.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRezervacija.DataSource = dt;
                gvRezervacija.DataBind();
            }
        }

        protected void btnResetRez_Click(object sender, EventArgs e)
        {
            txtSearchKlijent.Text = "";
            txtSearchVozilo.Text = "";
            txtSearchOd.Text = "";
            txtSearchDo.Text = "";
            LoadRezervacije(); // Prikaz svih rezervacija
        }
    }
}