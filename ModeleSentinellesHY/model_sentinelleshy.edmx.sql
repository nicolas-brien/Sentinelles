
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 10/02/2013 13:42:46
-- Generated from EDMX file: C:\Users\Proprio\Desktop\SentinellesHY\SentinellesHY\ModeleSentinellesHY\model_sentinelleshy.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [AreslambA2013];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CategoriePublication]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PublicationJeu] DROP CONSTRAINT [FK_CategoriePublication];
GO
IF OBJECT_ID(N'[dbo].[FK_PublicationPublication]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PublicationJeu] DROP CONSTRAINT [FK_PublicationPublication];
GO
IF OBJECT_ID(N'[dbo].[FK_StatutUtilisateur]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UtilisateurJeu] DROP CONSTRAINT [FK_StatutUtilisateur];
GO
IF OBJECT_ID(N'[dbo].[FK_UtilisateurÉvénement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ÉvénementJeu] DROP CONSTRAINT [FK_UtilisateurÉvénement];
GO
IF OBJECT_ID(N'[dbo].[FK_UtilisateurNouvelle]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[NouvelleJeu] DROP CONSTRAINT [FK_UtilisateurNouvelle];
GO
IF OBJECT_ID(N'[dbo].[FK_UtilisateurPublication]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PublicationJeu] DROP CONSTRAINT [FK_UtilisateurPublication];
GO
IF OBJECT_ID(N'[dbo].[FK_UtilisateurRevueDePresse]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RevueDePresseJeu] DROP CONSTRAINT [FK_UtilisateurRevueDePresse];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[CategorieJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CategorieJeu];
GO
IF OBJECT_ID(N'[dbo].[ÉvénementJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ÉvénementJeu];
GO
IF OBJECT_ID(N'[dbo].[NouvelleJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[NouvelleJeu];
GO
IF OBJECT_ID(N'[dbo].[PublicationJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PublicationJeu];
GO
IF OBJECT_ID(N'[dbo].[RevueDePresseJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RevueDePresseJeu];
GO
IF OBJECT_ID(N'[dbo].[StatutJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StatutJeu];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[UtilisateurJeu]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UtilisateurJeu];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'CategorieJeu'
CREATE TABLE [dbo].[CategorieJeu] (
    [idCategorie] int IDENTITY(1,1) NOT NULL,
    [nomCaegorieFR] nvarchar(50)  NOT NULL,
    [nomCategorieEN] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'ÉvénementJeu'
CREATE TABLE [dbo].[ÉvénementJeu] (
    [idEvenement] int IDENTITY(1,1) NOT NULL,
    [titreFR] nvarchar(75)  NOT NULL,
    [contenuEN] nvarchar(max)  NOT NULL,
    [titreEN] nvarchar(75)  NOT NULL,
    [contenuFR] nvarchar(max)  NOT NULL,
    [dateRedaction] datetime  NOT NULL,
    [dateEvenement] datetime  NOT NULL,
    [idUtilisateur] int  NULL
);
GO

-- Creating table 'NouvelleJeu'
CREATE TABLE [dbo].[NouvelleJeu] (
    [idNouvelle] int IDENTITY(1,1) NOT NULL,
    [titreFR] nvarchar(75)  NOT NULL,
    [contenuFR] nvarchar(max)  NOT NULL,
    [titreEN] nvarchar(75)  NOT NULL,
    [contenuEN] nvarchar(max)  NOT NULL,
    [dateRedaction] datetime  NOT NULL,
    [idUtilisateur] int  NULL
);
GO

-- Creating table 'PublicationJeu'
CREATE TABLE [dbo].[PublicationJeu] (
    [idPublication] int IDENTITY(1,1) NOT NULL,
    [titre] nvarchar(75)  NOT NULL,
    [datePublication] datetime  NOT NULL,
    [epinglee] bit  NOT NULL,
    [consulteParIntervenant] bit  NOT NULL,
    [idCategorie] int  NULL,
    [idUtilisateur] int  NULL,
    [idParent] int  NOT NULL
);
GO

-- Creating table 'RevueDePresseJeu'
CREATE TABLE [dbo].[RevueDePresseJeu] (
    [idRDP] int IDENTITY(1,1) NOT NULL,
    [titreFR] nvarchar(75)  NOT NULL,
    [contenuEN] nvarchar(max)  NOT NULL,
    [titreEN] nvarchar(75)  NOT NULL,
    [contenuFR] nvarchar(max)  NOT NULL,
    [dateRedaction] datetime  NOT NULL,
    [urlDocument] nvarchar(100)  NOT NULL,
    [idUtilisateur] int  NULL
);
GO

-- Creating table 'StatutJeu'
CREATE TABLE [dbo].[StatutJeu] (
    [nomStatutFR] nvarchar(20)  NOT NULL,
    [nomStatutEN] nvarchar(20)  NOT NULL,
    [idStatut] int  NOT NULL
);
GO

-- Creating table 'sysdiagrams'
CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

-- Creating table 'UtilisateurJeu'
CREATE TABLE [dbo].[UtilisateurJeu] (
    [nomUtilisateur] nvarchar(50)  NOT NULL,
    [motDePasse] nvarchar(50)  NOT NULL,
    [SelDeMer] nvarchar(50)  NOT NULL,
    [UrlAvatar] nvarchar(120)  NOT NULL,
    [dateInscription] datetime  NOT NULL,
    [courriel] nvarchar(100)  NOT NULL,
    [milieu] nvarchar(75)  NOT NULL,
    [nom] nvarchar(25)  NOT NULL,
    [prenom] nvarchar(25)  NOT NULL,
    [sexe] nvarchar(10)  NOT NULL,
    [noTelephone] nvarchar(25)  NOT NULL,
    [idUtilisateur] int IDENTITY(1,1) NOT NULL,
    [idStatut] int  NULL
);
GO

-- Creating table 'InfoGeneraleJeu'
CREATE TABLE [dbo].[InfoGeneraleJeu] (
    [idInfo] int IDENTITY(1,1) NOT NULL,
    [accueilPensee] nvarchar(max)  NOT NULL,
    [accueilImgCarrousel1] nvarchar(max)  NOT NULL,
    [accueilImgCarrousel2] nvarchar(max)  NOT NULL,
    [accueilImgCarrousel3] nvarchar(max)  NOT NULL,
    [temoignage] nvarchar(max)  NOT NULL,
    [courrielFormulaire] nvarchar(max)  NOT NULL,
    [idUtilisateur] int  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [idCategorie] in table 'CategorieJeu'
ALTER TABLE [dbo].[CategorieJeu]
ADD CONSTRAINT [PK_CategorieJeu]
    PRIMARY KEY CLUSTERED ([idCategorie] ASC);
GO

-- Creating primary key on [idEvenement] in table 'ÉvénementJeu'
ALTER TABLE [dbo].[ÉvénementJeu]
ADD CONSTRAINT [PK_ÉvénementJeu]
    PRIMARY KEY CLUSTERED ([idEvenement] ASC);
GO

-- Creating primary key on [idNouvelle] in table 'NouvelleJeu'
ALTER TABLE [dbo].[NouvelleJeu]
ADD CONSTRAINT [PK_NouvelleJeu]
    PRIMARY KEY CLUSTERED ([idNouvelle] ASC);
GO

-- Creating primary key on [idPublication] in table 'PublicationJeu'
ALTER TABLE [dbo].[PublicationJeu]
ADD CONSTRAINT [PK_PublicationJeu]
    PRIMARY KEY CLUSTERED ([idPublication] ASC);
GO

-- Creating primary key on [idRDP] in table 'RevueDePresseJeu'
ALTER TABLE [dbo].[RevueDePresseJeu]
ADD CONSTRAINT [PK_RevueDePresseJeu]
    PRIMARY KEY CLUSTERED ([idRDP] ASC);
GO

-- Creating primary key on [idStatut] in table 'StatutJeu'
ALTER TABLE [dbo].[StatutJeu]
ADD CONSTRAINT [PK_StatutJeu]
    PRIMARY KEY CLUSTERED ([idStatut] ASC);
GO

-- Creating primary key on [diagram_id] in table 'sysdiagrams'
ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

-- Creating primary key on [idUtilisateur] in table 'UtilisateurJeu'
ALTER TABLE [dbo].[UtilisateurJeu]
ADD CONSTRAINT [PK_UtilisateurJeu]
    PRIMARY KEY CLUSTERED ([idUtilisateur] ASC);
GO

-- Creating primary key on [idInfo] in table 'InfoGeneraleJeu'
ALTER TABLE [dbo].[InfoGeneraleJeu]
ADD CONSTRAINT [PK_InfoGeneraleJeu]
    PRIMARY KEY CLUSTERED ([idInfo] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [idCategorie] in table 'PublicationJeu'
ALTER TABLE [dbo].[PublicationJeu]
ADD CONSTRAINT [FK_CategoriePublication]
    FOREIGN KEY ([idCategorie])
    REFERENCES [dbo].[CategorieJeu]
        ([idCategorie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CategoriePublication'
CREATE INDEX [IX_FK_CategoriePublication]
ON [dbo].[PublicationJeu]
    ([idCategorie]);
GO

-- Creating foreign key on [idUtilisateur] in table 'PublicationJeu'
ALTER TABLE [dbo].[PublicationJeu]
ADD CONSTRAINT [FK_UtilisateurPublication]
    FOREIGN KEY ([idUtilisateur])
    REFERENCES [dbo].[UtilisateurJeu]
        ([idUtilisateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UtilisateurPublication'
CREATE INDEX [IX_FK_UtilisateurPublication]
ON [dbo].[PublicationJeu]
    ([idUtilisateur]);
GO

-- Creating foreign key on [idUtilisateur] in table 'NouvelleJeu'
ALTER TABLE [dbo].[NouvelleJeu]
ADD CONSTRAINT [FK_UtilisateurNouvelle]
    FOREIGN KEY ([idUtilisateur])
    REFERENCES [dbo].[UtilisateurJeu]
        ([idUtilisateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UtilisateurNouvelle'
CREATE INDEX [IX_FK_UtilisateurNouvelle]
ON [dbo].[NouvelleJeu]
    ([idUtilisateur]);
GO

-- Creating foreign key on [idUtilisateur] in table 'ÉvénementJeu'
ALTER TABLE [dbo].[ÉvénementJeu]
ADD CONSTRAINT [FK_UtilisateurÉvénement]
    FOREIGN KEY ([idUtilisateur])
    REFERENCES [dbo].[UtilisateurJeu]
        ([idUtilisateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UtilisateurÉvénement'
CREATE INDEX [IX_FK_UtilisateurÉvénement]
ON [dbo].[ÉvénementJeu]
    ([idUtilisateur]);
GO

-- Creating foreign key on [idUtilisateur] in table 'RevueDePresseJeu'
ALTER TABLE [dbo].[RevueDePresseJeu]
ADD CONSTRAINT [FK_UtilisateurRevueDePresse]
    FOREIGN KEY ([idUtilisateur])
    REFERENCES [dbo].[UtilisateurJeu]
        ([idUtilisateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UtilisateurRevueDePresse'
CREATE INDEX [IX_FK_UtilisateurRevueDePresse]
ON [dbo].[RevueDePresseJeu]
    ([idUtilisateur]);
GO

-- Creating foreign key on [idStatut] in table 'UtilisateurJeu'
ALTER TABLE [dbo].[UtilisateurJeu]
ADD CONSTRAINT [FK_StatutUtilisateur]
    FOREIGN KEY ([idStatut])
    REFERENCES [dbo].[StatutJeu]
        ([idStatut])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_StatutUtilisateur'
CREATE INDEX [IX_FK_StatutUtilisateur]
ON [dbo].[UtilisateurJeu]
    ([idStatut]);
GO

-- Creating foreign key on [idParent] in table 'PublicationJeu'
ALTER TABLE [dbo].[PublicationJeu]
ADD CONSTRAINT [FK_PublicationPublication]
    FOREIGN KEY ([idParent])
    REFERENCES [dbo].[PublicationJeu]
        ([idPublication])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PublicationPublication'
CREATE INDEX [IX_FK_PublicationPublication]
ON [dbo].[PublicationJeu]
    ([idParent]);
GO

-- Creating foreign key on [idUtilisateur] in table 'InfoGeneraleJeu'
ALTER TABLE [dbo].[InfoGeneraleJeu]
ADD CONSTRAINT [FK_UtilisateurInfoGenerale]
    FOREIGN KEY ([idUtilisateur])
    REFERENCES [dbo].[UtilisateurJeu]
        ([idUtilisateur])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UtilisateurInfoGenerale'
CREATE INDEX [IX_FK_UtilisateurInfoGenerale]
ON [dbo].[InfoGeneraleJeu]
    ([idUtilisateur]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------