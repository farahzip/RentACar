<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Izvjestaji.aspx.cs" Inherits="RentACar.Izvjestaji" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Izvještaji Rent-a-Car</h2>

    <!-- Sumirani podaci -->
    <div>
        <asp:Label ID="lblBrojKlijenataLabel" runat="server" Text="Ukupno klijenata: " />
        <asp:Label ID="lblBrojKlijenata" runat="server" /><br />

        <asp:Label ID="lblBrojVozilaLabel" runat="server" Text="Ukupno vozila: " />
        <asp:Label ID="lblBrojVozila" runat="server" /><br />

        <asp:Label ID="lblDostupnaLabel" runat="server" Text="Dostupna vozila: " />
        <asp:Label ID="lblDostupna" runat="server" /><br />

        <asp:Label ID="lblZauzetaLabel" runat="server" Text="Zauzeta vozila: " />
        <asp:Label ID="lblZauzeta" runat="server" /><br />

        <asp:Label ID="lblZaradaLabel" runat="server" Text="Ukupna zarada: " />
        <asp:Label ID="lblZarada" runat="server" />
    </div>

    <hr />
    </asp:Content>