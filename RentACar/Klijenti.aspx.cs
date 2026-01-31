using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RentACar
{
    public partial class Klijenti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKlijente();
            }
        }

        private void LoadKlijente()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM klijent", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvKlijent.DataSource = dt;
                gvKlijent.DataBind();
            }
        }

        protected void btnAddKlijent_Click(object sender, EventArgs e)
        {
            lblError.Text = ""; // reset

            // dodatna server-side validacija
            if (string.IsNullOrWhiteSpace(txtIme.Text) || txtIme.Text.Length > 45)
            {
                lblError.Text = "Ime je obavezno i max 45 znakova!";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPrezime.Text) || txtPrezime.Text.Length > 45)
            {
                lblError.Text = "Prezime je obavezno i max 45 znakova!";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtTelefon.Text))
            {
                lblError.Text = "Telefon je obavezan!";
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(txtTelefon.Text, @"^\+?[0-9]{7,15}$"))
            {
                lblError.Text = "Telefon mora biti validan (samo brojevi ili +)";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtDokument.Text) || txtDokument.Text.Length > 20)
            {
                lblError.Text = "Broj dokumenta je obavezan i max 20 znakova!";
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(txtDokument.Text, @"^[A-Za-z0-9]+$"))
            {
                lblError.Text = "Broj dokumenta može sadržavati samo slova i brojeve";
                return;
            }

            // opcionalno: provjera da li br_dokumenta već postoji
            using (SqlConnection con = Db.GetConnection())
            {
                SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM klijent WHERE br_dokumenta=@d", con);
                check.Parameters.AddWithValue("@d", txtDokument.Text.Trim());

                con.Open();
                int exists = (int)check.ExecuteScalar();
                if (exists > 0)
                {
                    lblError.Text = "Klijent sa ovim brojem dokumenta već postoji!";
                    return;
                }

                // insert
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO klijent (ime, prezime, telefon, br_dokumenta) VALUES (@i,@p,@t,@d)", con);

                cmd.Parameters.AddWithValue("@i", txtIme.Text.Trim());
                cmd.Parameters.AddWithValue("@p", txtPrezime.Text.Trim());
                cmd.Parameters.AddWithValue("@t", txtTelefon.Text.Trim());
                cmd.Parameters.AddWithValue("@d", txtDokument.Text.Trim());

                cmd.ExecuteNonQuery();
                con.Close();
            }

            // refresh liste
            LoadKlijente();

            // clear input
            txtIme.Text = txtPrezime.Text = txtTelefon.Text = txtDokument.Text = "";

            lblError.ForeColor = System.Drawing.Color.Green;
            lblError.Text = "Klijent uspješno dodan!";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string query = txtSearch.Text.Trim();

            using (SqlConnection con = Db.GetConnection())
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT * FROM klijent 
              WHERE ime LIKE @q OR prezime LIKE @q", con);

                cmd.Parameters.AddWithValue("@q", "%" + query + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvKlijent.DataSource = dt;
                gvKlijent.DataBind();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadKlijente();
        }
    }

}