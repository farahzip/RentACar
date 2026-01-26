<%@ Page Title="Novo Iznajmljivanje" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Iznajmljivanje.aspx.cs" Inherits="RentACar.Iznajmljivanje" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Novo Iznajmljivanje</h2>
        <p>Kreirajte novu rezervaciju automobila.</p>
    </section>

    <!-- Rental Form Section -->
    <section class="feature-card">
        <label>Odaberite klijenta</label>
        <select class="input">
            <option>Ime Prezime</option>
            <option>Ime Prezime</option>
        </select>

        <label>Odaberite vozilo</label>
        <select class="input">
            <option>Audi A3 (2020) - Dostupno</option>
            <option>BMW 320i (2019) - Dostupno</option>
        </select>

        <label>Datum od</label>
        <input type="date" class="input" />

        <label>Datum do</label>
        <input type="date" class="input" />

        <br /><br />
        <button class="btn">Kreiraj rezervaciju</button>
    </section>

</asp:Content>
