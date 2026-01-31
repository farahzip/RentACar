<%@ Page Title="Novo Iznajmljivanje" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Iznajmljivanje.aspx.cs" Inherits="RentACar.Iznajmljivanje" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Novo Iznajmljivanje</h2>
        <p>Kreirajte novu rezervaciju automobila.</p>
    </section>

    <!-- Rental Form Section -->
    <section class="features">
    <div class="feature-card">
        <h3>Pretraga rezervacija</h3>

        Klijent (ime/prezime):
        <asp:TextBox ID="txtSearchKlijent" runat="server" MaxLength="45" />

        Vozilo (marka/model):
        <asp:TextBox ID="txtSearchVozilo" runat="server" MaxLength="25" />

        Datum od:
        <asp:TextBox ID="txtSearchOd" runat="server" TextMode="Date" />

        Datum do:
        <asp:TextBox ID="txtSearchDo" runat="server" TextMode="Date" />

        <br /><br />

        <asp:Button ID="btnSearchRez" runat="server" Text="Pretraži" OnClick="btnSearchRez_Click" CausesValidation="False" />
        <asp:Button ID="btnResetRez" runat="server" Text="Reset" OnClick="btnResetRez_Click" CausesValidation="False" />

        <br /><br />
        <asp:GridView ID="gvRezervacija" runat="server" AutoGenerateColumns="true" CssClass="table"/>
        </div>

    <div class="feature-card">
        <h3>Nova rezervacija</h3>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" /> 
        <br />
        Klijent:
        <asp:DropDownList ID="ddlKlijent" runat="server" />
        <asp:RequiredFieldValidator ControlToValidate="ddlKlijent"
            InitialValue="" Text="Odaberite klijenta!" ForeColor="Red" runat="server" />
        <br /><br />

        Vozilo:
        <asp:DropDownList ID="ddlVozilo" runat="server" />
        <asp:RequiredFieldValidator ControlToValidate="ddlVozilo"
            InitialValue="" Text="Odaberite vozilo!" ForeColor="Red" runat="server" />
        <br /><br />

        Datum od:
        <asp:TextBox ID="txtOd" runat="server" TextMode="Date" />
        <asp:RequiredFieldValidator ControlToValidate="txtOd"
            Text="Datum početka je obavezan!" ForeColor="Red" runat="server" />
        <br /><br />

        Datum do:
        <asp:TextBox ID="txtDo" runat="server" TextMode="Date" />
        <asp:RequiredFieldValidator ControlToValidate="txtDo"
            Text="Datum završetka je obavezan!" ForeColor="Red" runat="server" />
        <br /><br />

        <asp:Button ID="btnRezervisi"
            runat="server"
            Text="Rezerviši"
            OnClick="btnRezervisi_Click" />

        <br /><br />
        </div>
    </section>

</asp:Content>
