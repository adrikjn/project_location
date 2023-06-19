-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 18 juin 2023 à 16:39
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet2`
--

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `membre_id` int(11) NOT NULL,
  `vehicule_id` int(11) NOT NULL,
  `date_heure_depart` datetime NOT NULL,
  `date_heure_fin` datetime NOT NULL,
  `prix_total` int(11) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `membre_id`, `vehicule_id`, `date_heure_depart`, `date_heure_fin`, `prix_total`, `date_enregistrement`) VALUES
(1, 1, 1, '2023-06-20 19:33:00', '2023-06-30 21:33:00', 2750, '2023-06-18 15:33:21'),
(2, 1, 1, '2023-06-21 19:33:00', '2023-06-30 21:33:00', 2500, '2023-06-18 15:34:39');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230618114642', '2023-06-18 13:46:48', 216),
('DoctrineMigrations\\Version20230618130450', '2023-06-18 15:04:55', 33);

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `civilite` varchar(255) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `membre`
--

INSERT INTO `membre` (`id`, `email`, `roles`, `password`, `username`, `nom`, `prenom`, `civilite`, `date_enregistrement`) VALUES
(1, 'admin@admin.com', '[\"ROLE_ADMIN\"]', '$2y$13$W3lzcDrgDeZ4Xis/hE0FPu1MaM0WewR4jT/PPiIF9zT2/gL//WrG6', 'admin', 'admin', 'admin', 'Femme', '2023-06-18 15:05:58');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

CREATE TABLE `vehicule` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `marque` varchar(255) NOT NULL,
  `modele` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `photo` varchar(255) NOT NULL,
  `prix_journalier` int(11) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vehicule`
--

INSERT INTO `vehicule` (`id`, `titre`, `marque`, `modele`, `description`, `photo`, `prix_journalier`, `date_enregistrement`) VALUES
(1, 'Mercedes EQE', 'Mercédès', 'EQE', 'Calandre Black Panel avec étoile centrale Mercedes-Benz\r\nJupe avant dans le ton carrosserie avec inserts décoratifs dans les parties supérieure et inférieure chromés\r\nBas de caisse peint en noir avec baguettes de seuil chromées\r\nJupe arrière dans le ton carrosserie avec partie inférieure en finition noire grenée et inserts décoratifs chromés\r\nJantes alliage 48,3 cm (19\") à 5 doubles branches, finition noir brillant/naturel brillant\r\nCâble de charge pour boîtier mural et borne de recharge publique, 5 m, non spiralé\r\nFeux arrière à LED design hélice en 3D avec bandeau lumineux à l’arrière\r\nPhares LED hautes performances', 'https://www.mercedes-benz.fr/content/france/fr/passengercars/models/saloon/eqe/overview/_jcr_content/root/responsivegrid/simple_stage.component.damq6.3365013431300.jpg/EQE_STAGE.jpg', 250, '2023-06-18 14:24:51'),
(3, 'Mercedes Tout-terrains EQS SUV', 'Mercedes', 'EQS SUV', 'ièges confort avec éclairage des contours en cuir nappa gris neva / bleu biscayenne avec des sièges au design spécifique\r\nPlanche de bord supérieure et lignes de ceinture en finition Nappa bleu Biscaya avec surpiqûre dans le ton or rose\r\nAccoudoir de la console centrale en cuir Nappa gris neva\r\nInserts décoratifs en noyer aspect pont de bateau à pores ouverts\r\nBoucles de ceinture design à l\'avant et à l\'arrière, éclairées\r\nCiel de pavillon en tissu gris neva\r\nTapis de sol avec passepoil en bleu Biscaya et surpiqûre gris neva', 'https://www.mercedes-benz.fr/content/france/fr/passengercars/models/suv/eqs/overview/_jcr_content/root/responsivegrid/simple_stage.component.damq6.3369502566001.jpg/EQS-SUV_stage.jpg', 350, '2023-06-18 14:31:17'),
(4, 'Mercedes CLA Coupé', 'Mercedes', 'CLA Coupé', 'Kit carrosserie AMG composé d’une jupe avant AMG avec splitter avant chromé, d’un habillage des bas de caisse AMG et d’une jupe arrière AMG avec enjoliveurs de sortie d’échappement apparents et d’un insert décoratif chromé\r\nCalandre avec motif Mercedes-Benz chromé avec étoile centrale Mercedes-Benz et lamelle individuelle avec insert de marchepied chromé\r\nBaguettes de haut de glace et de bas de glace en aluminium brillant\r\nJantes alliage AMG 45,7 cm (18\") à 5 doubles branches, optimisées en termes d\'aérodynamisme, finition gris trémolite et naturel brillant', 'https://www.mercedes-benz.fr/content/france/fr/passengercars/models/coupe/c118-fl-23-1/overview/_jcr_content/root/responsivegrid/simple_stage.component.damq6.3360360698662.jpg/stage-cla-coupe-hybride-overview2.jpg', 260, '2023-06-18 14:33:04');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6EEAA67D6A99F74A` (`membre_id`),
  ADD KEY `IDX_6EEAA67D4A4A3511` (`vehicule_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_F6B4FB29E7927C74` (`email`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `membre`
--
ALTER TABLE `membre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicule`
--
ALTER TABLE `vehicule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67D4A4A3511` FOREIGN KEY (`vehicule_id`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `FK_6EEAA67D6A99F74A` FOREIGN KEY (`membre_id`) REFERENCES `membre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
