<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RentACar._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


<section class="about-hero">
    <h1>Dobrodošli u Rent-a-Car sistem</h1>
    <p class="lead">
        RentACar je moderna platforma za iznajmljivanje vozila, razvijena s ciljem
        pojednostavljenja upravljanja flotom i pružanja brzog, jasnog i pouzdanog
        iskustva korisnicima.
    </p>
</section>

<section class="about-grid">
    <div class="about-card">
        <h2>Čime se bavimo</h2>
        <p>
            Omogućavamo jednostavno upravljanje vozilima, rezervacijama i korisnicima
            kroz centralizovan sistem. Naša platforma pomaže rent-a-car kompanijama
            da rade efikasnije, uz potpunu kontrolu nad dostupnošću i cijenama.
        </p>
    </div>

    <div class="about-card">
        <h2>Naš pristup</h2>
        <p>
            Fokusirani smo na jednostavnost, pouzdanost i preglednost. Svaka funkcionalnost
            je osmišljena tako da smanji administraciju i ubrza svakodnevne procese,
            bez nepotrebne složenosti.
        </p>
    </div>

    <div class="about-card">
        <h2>Ključne funkcionalnosti</h2>
        <ul>
            <li>Pregled dostupnosti vozila u realnom vremenu</li>
            <li>Upravljanje rezervacijama i korisnicima</li>
            <li>Fleksibilne cijene i periodi najma</li>
            <li>Izvještaji i operativni pregled poslovanja</li>
        </ul>
    </div>

    <div class="about-card">
        <h2>Rješenje koje raste s vama</h2>
        <p>
            RentACar je prilagodljiv sistem koji raste zajedno s vašim poslovanjem —
            od manjih lokalnih flota do većih rent-a-car kompanija sa više lokacija.
            Stabilnost, sigurnost i skalabilnost su u osnovi našeg rješenja.
        </p>
    </div>
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
