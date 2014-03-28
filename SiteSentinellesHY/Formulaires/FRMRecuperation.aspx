<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMRecuperation.aspx.vb" Inherits="SiteSentinellesHY.FRMRecuperation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Obtenir un nouveau mot de passe</h1>
    <p>Vous avez oublié votre mot de passe? En entrant le courriel que vous avez utilisé pour vous inscrire ci-dessous, nous vous enverrons des instructions pour réinitialiser votre mot de passe.</p>
    <div>
        <div class="row">
            <div class="span6 offset1">
                <asp:TextBox ID="tbCourriel" runat="server" placeholder="courriel@courriel.com" MaxLength="150" /><br />
                <asp:LinkButton ID="lbtnEnvoyer" runat="server" CssClass="btn btn-primary" OnClick="lbtnEnvoyer_Click"><i class="icon-chevron-right icon-white"></i> Obtenir un nouveau mot de passe</asp:LinkButton><br />
                <asp:Label ID="lblErreur" CssClass="text-error" runat="server"></asp:Label>
                <asp:Label ID="lblSucces" CssClass="text-success" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
