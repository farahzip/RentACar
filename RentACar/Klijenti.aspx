<%@ Page Title="Pregled Klijenata" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Klijenti.aspx.cs" Inherits="RentACar.Klijenti" %>

<asp:Content ID="contentsection" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Klijenti</h2>
        <p>Pogledajte postojeće klijente ili dodajte nove.</p>
    </section>

    <!-- Client List / Add Section -->
    <section class="features">
        <div class="feature-card">
            <h3>Pretraga klijenata</h3>

            Unesi ime ili prezime:
            <asp:TextBox ID="txtSearch" runat="server" MaxLength="45" />
            <asp:Button ID="btnSearch" runat="server" Text="Pretraži" OnClick="btnSearch_Click" CausesValidation="False"/>

            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CausesValidation="False"/>

            <br /><br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" />
            <h3>Postojeći klijenti</h3>
             <asp:GridView ID="gvKlijent" runat="server" AutoGenerateColumns="true" CssClass="table" />
        </div>

        <div class="feature-card">
            <h2>Novi Klijent</h2>

            <asp:Label ID="lblError" runat="server" ForeColor="Red" />

            <br />

            Ime:
            <asp:TextBox ID="txtIme" runat="server" MaxLength="45" />
            <asp:RequiredFieldValidator ID="rfvIme" runat="server"
                ControlToValidate="txtIme" ErrorMessage="Ime je obavezno!" ForeColor="Red" />
            <br /><br />

            Prezime:
            <asp:TextBox ID="txtPrezime" runat="server" MaxLength="45" />
            <asp:RequiredFieldValidator ID="rfvPrezime" runat="server"
                ControlToValidate="txtPrezime" ErrorMessage="Prezime je obavezno!" ForeColor="Red" />
            <br /><br />

            Telefon:
            <asp:TextBox ID="txtTelefon" runat="server" MaxLength="15" />
            <asp:RequiredFieldValidator ID="rfvTelefon" runat="server"
                ControlToValidate="txtTelefon" ErrorMessage="Telefon je obavezan!" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revTelefon" runat="server"
                ControlToValidate="txtTelefon"
                ErrorMessage="Telefon mora biti validan (samo brojevi ili +)"
                ValidationExpression="^\+?[0-9]{7,15}$"
                ForeColor="Red" />
            <br /><br />

            Broj dokumenta:
            <asp:TextBox ID="txtDokument" runat="server" MaxLength="20" />
            <asp:RequiredFieldValidator ID="rfvDokument" runat="server"
                ControlToValidate="txtDokument" ErrorMessage="Broj dokumenta je obavezan!" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revDokument" runat="server"
                ControlToValidate="txtDokument"
                ErrorMessage="Broj dokumenta može sadržavati samo slova i brojeve"
                ValidationExpression="^[A-Za-z0-9]+$"
                ForeColor="Red" />
            <br /><br />

            <asp:Button ID="btnAddKlijent" runat="server" Text="Dodaj Klijenta" OnClick="btnAddKlijent_Click" />

            <br /><br />
        </div>
    </section>
      
</asp:Content>
    