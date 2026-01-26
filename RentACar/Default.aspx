<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RentACar._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <section class="hero">
    <h2>Dobrodošli u Rent-a-Car sistem</h2>
    <p>
        Web informacioni sistem za upravljanje vozilima, klijentima
        i procesom iznajmljivanja automobila.
    </p>
</section>

<section class="features">
    <div class="feature-card">
        <h3>🚗 Vozila</h3>
        <p>Pregled, dodavanje i ažuriranje dostupnih vozila.</p>
        <a href="Vozila.aspx" class="btn">Upravljaj vozilima</a>
    </div>

    <div class="feature-card">
        <h3>👤 Klijenti</h3>
        <p>Vođenje evidencije o klijentima i njihovim podacima.</p>
        <a href="Klijenti.aspx" class="btn">Pregled klijenata</a>
    </div>

    <div class="feature-card">
        <h3>📅 Iznajmljivanje</h3>
        <p>Kreiranje rezervacija i automatski obračun cijene.</p>
        <a href="Iznajmljivanje.aspx" class="btn">Novo iznajmljivanje</a>
    </div>
</section>


</asp:Content>
