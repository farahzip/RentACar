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
    public partial class Vozila : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rvGodina.MaximumValue = DateTime.Now.Year.ToString();
                LoadVozila();
            }
        }

        private void LoadVozila()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM vozilo", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvVozila.DataSource = dt;
                gvVozila.DataBind();
            }
        }

        protected void btnAddVozilo_Click(object sender, EventArgs e)
        {
            lblError.Text = ""; // reset

            string marka = txtMarka.Text.Trim();
            string model = txtModel.Text.Trim();

            if (string.IsNullOrWhiteSpace(marka) || marka.Length > 15)
            {
                lblError.Text = "Marka je obavezna i max 15 znakova!";
                return;
            }

            if (string.IsNullOrWhiteSpace(model) || model.Length > 25)
            {
                lblError.Text = "Model je obavezan i max 25 znakova!";
                return;
            }

            if (!int.TryParse(txtGodina.Text.Trim(), out int godina) || godina < 1900 || godina > DateTime.Now.Year)
            {
                lblError.Text = "Godina mora biti između 1900 i tekuće godine!";
                return;
            }

            if (!decimal.TryParse(txtCijena.Text.Trim(), out decimal cijena) || cijena <= 0)
            {
                lblError.Text = "Cijena mora biti veća od 0!";
                return;
            }

            int status = int.Parse(ddlStatus.SelectedValue);

            using (SqlConnection con = Db.GetConnection())
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO vozilo (marka, model, godina, cijena_dan, status) VALUES (@m,@mo,@g,@c,@s)", con);

                cmd.Parameters.AddWithValue("@m", marka);
                cmd.Parameters.AddWithValue("@mo", model);
                cmd.Parameters.AddWithValue("@g", godina);
                cmd.Parameters.AddWithValue("@c", cijena);
                cmd.Parameters.AddWithValue("@s", status);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadVozila();

            txtMarka.Text = txtModel.Text = txtGodina.Text = txtCijena.Text = "";
            ddlStatus.SelectedIndex = 0;

            lblError.ForeColor = System.Drawing.Color.Green;
            lblError.Text = "Vozilo uspješno dodano!";
        }

        protected void btnSearchVozilo_Click(object sender, EventArgs e)
        {
            string query = txtSearchVozilo.Text.Trim();

            using (SqlConnection con = Db.GetConnection())
            {
                SqlCommand cmd;

                if (string.IsNullOrEmpty(query))
                {
                    // ako je prazno, prikaži sva vozila
                    cmd = new SqlCommand("SELECT * FROM vozilo", con);
                }
                else
                {
                    // pretraga po marki ili modelu
                    cmd = new SqlCommand(
                        "SELECT * FROM vozilo WHERE marka LIKE @q OR model LIKE @q", con);
                    cmd.Parameters.AddWithValue("@q", "%" + query + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvVozila.DataSource = dt;
                gvVozila.DataBind();
            }
        }

        protected void btnResetVozilo_Click(object sender, EventArgs e)
        {
            txtSearchVozilo.Text = "";
            LoadVozila(); // ponovo učitaj sva vozila
        }

    }
}