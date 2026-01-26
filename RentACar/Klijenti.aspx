<%@ Page Title="Pregled Klijenata" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Klijenti.aspx.cs" Inherits="RentACar.Klijenti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Klijenti</h2>
        <p>Pogledajte postojeće klijente ili dodajte nove.</p>
    </section>

    <!-- Client List / Add Section -->
    <section class="features">
        <div class="feature-card">
            <h3>Postojeći klijenti</h3>
            <ul>
                <li>Ime Prezime Horvat – 0911234567 – 123456</li>
                <li>Ime Prezime – 0987654321 – 654321</li>
            </ul>
        </div>

        <div class="feature-card">
            <h3>Dodaj novog klijenta</h3>
            <p>Forma za unos novog klijenta.</p>
            <label>Ime</label>
            <input type="text" class="input" />

            <label>Prezime</label>
            <input type="text" class="input" />

            <label>Telefon</label>
            <input type="text" class="input" />

            <label>Broj dokumenta</label>
            <input type="text" class="input" />

            <br /><br />
            <button class="btn">Sačuvaj klijenta</button>
        </div>
    </section>

</asp:Content>
