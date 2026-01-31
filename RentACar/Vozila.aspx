<%@ Page Title="Pregled Vozila" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vozila.aspx.cs" Inherits="RentACar.Vozila" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Vozila</h2>
        <p>Pogledajte dostupna vozila ili filtrirajte po željama.</p>
        
        </section>
  <section class="features">
    <div class="feature-card">
        <h3>Pretraga vozila</h3>

        Unesi marku ili model:
        <asp:TextBox ID="txtSearchVozilo" runat="server" MaxLength="25" />
        <asp:Button ID="btnSearchVozilo" runat="server" Text="Pretraži" OnClick="btnSearchVozilo_Click" CausesValidation="False" />

        <asp:Button ID="btnResetVozilo" runat="server" Text="Reset" OnClick="btnResetVozilo_Click" CausesValidation="False" />

        <br /><br />

    <asp:GridView ID="gvVozila" runat="server" AutoGenerateColumns="true" CssClass="table" /></div>
           <div class="feature-card">

      <h2>Novo Vozilo</h2>

        <asp:Label ID="lblError" runat="server" ForeColor="Red" />

        <br />

        Marka:
        <asp:TextBox ID="txtMarka" runat="server" MaxLength="15" />
        <asp:RequiredFieldValidator ID="rfvMarka" runat="server"
            ControlToValidate="txtMarka" ErrorMessage="Marka je obavezna!" ForeColor="Red" />
        <br /><br />

        Model:
        <asp:TextBox ID="txtModel" runat="server" MaxLength="25" />
        <asp:RequiredFieldValidator ID="rfvModel" runat="server"
            ControlToValidate="txtModel" ErrorMessage="Model je obavezan!" ForeColor="Red" />
        <br /><br />

        Godina:
        <asp:TextBox ID="txtGodina" runat="server" MaxLength="4" />
        <asp:RequiredFieldValidator ID="rfvGodina" runat="server"
            ControlToValidate="txtGodina" ErrorMessage="Godina je obavezna!" ForeColor="Red" />
        <asp:RangeValidator ID="rvGodina" runat="server"
            ControlToValidate="txtGodina" MinimumValue="1900" MaximumValue="9999"
            Type="Integer" ErrorMessage="Godina mora biti između 1900 i tekuće godine!" ForeColor="Red" />
        <br /><br />

        Cijena po danu:
        <asp:TextBox ID="txtCijena" runat="server" MaxLength="10" />
        <asp:RequiredFieldValidator ID="rfvCijena" runat="server"
            ControlToValidate="txtCijena" ErrorMessage="Cijena je obavezna!" ForeColor="Red" />
        <asp:RangeValidator ID="rvCijena" runat="server"
            ControlToValidate="txtCijena" MinimumValue="0.01" MaximumValue="1000000"
            Type="Double" ErrorMessage="Cijena mora biti veća od 0!" ForeColor="Red" />
        <br /><br />

        Status:
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="Dostupno" Value="1" />
            <asp:ListItem Text="Zauzeto" Value="0" />
        </asp:DropDownList>
        <br /><br />

        <asp:Button ID="btnAddVozilo" runat="server" Text="Dodaj Vozilo" OnClick="btnAddVozilo_Click" />

        <br /><br />
               </div>
    </section>
    
</asp:Content>
