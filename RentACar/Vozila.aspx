<%@ Page Title="Pregled Vozila" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vozila.aspx.cs" Inherits="RentACar.Vozila" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero">
        <h2>Vozila</h2>
        <p>Pogledajte dostupna vozila ili filtrirajte po željama.</p>
    </section>

    <!-- Filter Section -->
    <section class="filter-section">
        <asp:Label Text="Filter po marki:" AssociatedControlID="ddlMarka" runat="server" />
        <asp:DropDownList ID="ddlMarka" runat="server" CssClass="input" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
            <asp:ListItem Text="Sve marke" Value="" />
            <%-- Dynamic items will be added from the code-behind --%>
        </asp:DropDownList>

        <asp:Label Text="Filter po statusu:" AssociatedControlID="ddlStatus" runat="server" />
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="input" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
            <asp:ListItem Text="Svi" Value="" />
            <asp:ListItem Text="Dostupno" Value="Dostupno" />
            <asp:ListItem Text="Iznajmljeno" Value="Iznajmljeno" />
        </asp:DropDownList>
    </section>

    <!-- Car Listing Section -->
    <section class="car-list">
        <asp:Repeater ID="rptVozila" runat="server">
            <ItemTemplate>
                <div class="car-card">
                    <h3><%# Eval("marka") %> <%# Eval("model") %> (<%# Eval("godina") %>)</h3>
                    <p>Cijena po danu: €<%# Eval("cijena_dan") %></p>
                    <p>Status: <%# Eval("StatusText") %></p>

                    <%-- Show Rent button only if available --%>
                    <asp:Button ID="btnIznajmi" runat="server" Text="Iznajmi" 
                        CommandArgument='<%# Eval("id") %>' 
                        OnClick="RentCar_Click" 
                        Visible='<%# Eval("StatusText").ToString() == "Dostupno" %>' 
                        CssClass="btn" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </section>

</asp:Content>
