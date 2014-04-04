<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMdevenirsentinelle.aspx.vb" Inherits="SiteSentinellesHY.FRMdevenirsentinelle" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="ModeleSentinellesHY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p><b><%= outils.obtenirLangue("Vous souhaitez devenir Sentinelle?|")%></b></p>
    <p><%= outils.obtenirLangue("Remplissez le formulaire suivant et un de nos responsables vous contactera afin de compléter votre inscription et de vous donnez tous les informations requises.|")%></p>
    <div class="listeAccueil">
        <h3><%= outils.obtenirLangue("DEVENIR SENTINELLE|BECOME SENTINEL")%></h3>
        <div id="divFormulaire" runat="server" class="cadrageItems">
            <div class="row">
                <asp:Label ID="lblNom" runat="server" CssClass="lblFormulaire"><%= outils.obtenirLangue("Nom :|Name :")%></asp:Label>
                <asp:TextBox ID="tbnom" runat="server" onkeydown="return (event.keyCode!=13);" Width="300" CssClass="tbFormulaire"></asp:TextBox>
                <span style="color: red; float: right; font-size: large;">*</span>
            </div>
            <div class="row">
                <asp:Label ID="lblNoTelephone" runat="server" CssClass="lblFormulaire"><%= outils.obtenirLangue("Numéro de téléphone :|Phone number :")%></asp:Label>
                <asp:TextBox ID="tbnoTelephone" runat="server" onkeydown="return (event.keyCode!=13);" Width="300" CssClass="tbFormulaire" placeHolder="450-555-5555"></asp:TextBox>
                <span style="color: red; float: right; font-size: large;">*</span>
            </div>
            <div class="row">
                <asp:Label ID="lblCourriel" runat="server" CssClass="lblFormulaire"><%= outils.obtenirLangue(" Courriel :| Email :")%></asp:Label>
                <asp:TextBox ID="tbcourriel" runat="server" onkeydown="return (event.keyCode!=13);" Width="300" CssClass="tbFormulaire" placeHolder="utilisateur@fournisseur.com"></asp:TextBox>
            </div>
            <div class="row">
                <asp:Label ID="lblAPropos" runat="server" CssClass="lblFormulaire" ClientIDMode="Static"><%= outils.obtenirLangue("À propos de vous :|More about you :")%></asp:Label>
                <asp:TextBox ID="tbaPropos" runat="server" Width="300" Rows="5" MaxLength="500" TextMode="MultiLine" CssClass="tbFormulaire"
                    ClientIDMode="Static" onpaste="return false;"></asp:TextBox>
                <span style="color: red; float: right; font-size: large;">*</span>
            </div>
            <div class="row">
                <div class="tbFormulaire" style="width: 310px;">
                    <asp:Label runat="server" ID="lblCharRestant" Text="500" CssClass="caracteresRestants"></asp:Label>
                    <asp:Label runat="server" ID="texteCharRestant" CssClass="caracteresRestants"><%= outils.obtenirLangue(" caractères restants| remaining characters ")%></asp:Label>
                </div>
            </div>
            <div class="row">
                <asp:LinkButton runat="server" ID="btnEnvoi" CssClass="btn btn-primary tbFormulaire disabled-button" OnClick="btnEnvoi_Click"><%= outils.obtenirLangue("Envoyer|Submit")%></asp:LinkButton>
                                <span style="color: red;margin-right:147px;float:right;"><%= outils.obtenirLangue("* Champs requis|* Required fields") %></span>
            </div>
            <div class="row">
                <asp:Label runat="server" ID="lblErreurSentinelle" CssClass="lblFormulaire text-error"></asp:Label>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function countDown(textbox, label, maxcount) {
            var count = parseInt(document.getElementById(textbox).value.length);
            document.getElementById(label).innerHTML = maxcount - count;
        }
        function checkTextAreaMaxLength(textBox, e, length) {

            var mLen = textBox["MaxLength"];
            if (null == mLen)
                mLen = length;

            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                    {
                        e.returnValue = false;
                        return false;
                    }
                    else//Firefox
                        e.preventDefault();
                }
            }
        }

        function checkSpecialKeys(e) {
            if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 35 && e.keyCode != 36 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
                return false;
            else
                return true;
        }
    </script>

</asp:Content>
