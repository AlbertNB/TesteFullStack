-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 04-Abr-2019 às 23:04
-- Versão do servidor: 10.1.38-MariaDB
-- versão do PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `appstore_db`
--
CREATE DATABASE IF NOT EXISTS `appstore_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `appstore_db`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `titulo` varchar(15) CHARACTER SET latin1 NOT NULL,
  `cor` char(7) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `titulo`, `cor`) VALUES
(1, 'Performance', '#d8d8ee'),
(2, 'Engajamento', '#bbbbbb'),
(3, 'Cultura', '#eCfCe7'),
(4, 'Relações', '#C8AEEB');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`id`, `nome`) VALUES
(1, 'Alberto'),
(2, 'Ze');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente_modulo`
--

CREATE TABLE `cliente_modulo` (
  `Cliente_id` int(11) NOT NULL,
  `Modulo_id` int(11) NOT NULL,
  `ativo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cliente_modulo`
--

INSERT INTO `cliente_modulo` (`Cliente_id`, `Modulo_id`, `ativo`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `modulo`
--

CREATE TABLE `modulo` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) CHARACTER SET latin1 NOT NULL,
  `icone` varchar(30) CHARACTER SET latin1 NOT NULL,
  `Categoria_id` int(11) NOT NULL,
  `preco` double(6,2) DEFAULT NULL,
  `cor_bg` char(7) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `modulo`
--

INSERT INTO `modulo` (`id`, `nome`, `icone`, `Categoria_id`, `preco`, `cor_bg`) VALUES
(1, 'Checkin & Checkout', 'fa-book', 1, 50.00, '#F1501c'),
(2, 'Badges & Cards de Reconhecimento Gratuito', 'fa-air-freshener', 2, 50.00, '#5a0fad'),
(3, 'Planos de Ação', 'fa-calculator', 2, 50.00, '#8a5caa'),
(4, 'Recomendações de Conteúdo sob medida', 'fa-coffee', 2, 50.00, '#2a2ead'),
(5, 'Posts de Comunicados e Avisos', 'fa-chalkboard-teacher', 2, 50.00, '#F35c36'),
(6, 'Suggestion Box', 'fa-comments', 2, 50.00, '#5a546d'),
(7, 'Análise de Comentários', 'fa-comment-dollar', 2, 50.00, '#Fa50a5'),
(8, 'Fitting Cultural', 'fa-crown', 3, 50.00, '#F25c2d'),
(9, 'Assessments e Recomendações Gratuito', 'fa-shoe-prints', 4, 0.00, '#aaeca3'),
(10, 'Quick Deck', 'fa-check', 1, 50.00, '#5ab3ad'),
(11, 'Evidências & Feedback', 'fa-motorcycle', 1, 50.00, '#Fa5ca2'),
(12, 'Pulsos de Performance', 'fa-running', 1, 50.00, '#ca6c6d'),
(13, 'Team Fitting', 'fa-heart', 3, 50.00, '#ead0a7'),
(14, 'PDI 70:20:10', 'fa-money-check-alt', 1, 50.00, '#0a5cad');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cliente_modulo`
--
ALTER TABLE `cliente_modulo`
  ADD PRIMARY KEY (`Cliente_id`,`Modulo_id`),
  ADD KEY `Cliente_Modulo_Modulo` (`Modulo_id`);

--
-- Indexes for table `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Modulo_Categoria` (`Categoria_id`);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `cliente_modulo`
--
ALTER TABLE `cliente_modulo`
  ADD CONSTRAINT `Cliente_Modulo_Cliente` FOREIGN KEY (`Cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `Cliente_Modulo_Modulo` FOREIGN KEY (`Modulo_id`) REFERENCES `modulo` (`id`);

--
-- Limitadores para a tabela `modulo`
--
ALTER TABLE `modulo`
  ADD CONSTRAINT `Modulo_Categoria` FOREIGN KEY (`Categoria_id`) REFERENCES `categoria` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
