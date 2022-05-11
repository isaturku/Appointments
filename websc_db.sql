-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2022 at 09:26 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `websc_db`
--
CREATE DATABASE IF NOT EXISTS `websc_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `websc_db`;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `info` varchar(140) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `creator_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `option1` varchar(32) NOT NULL,
  `option2` varchar(32) NOT NULL,
  `option3` varchar(32) NOT NULL,
  `expires_at` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `title`, `location`, `info`, `duration`, `creator_id`, `created_at`, `option1`, `option2`, `option3`, `expires_at`) VALUES
(75, 'skldfi', 'skldnfi', 'slndf', 'lksdfi', 66, '2022-04-19 20:19:18', '2022-04-20T22:18', '2022-04-21T14:18', '2022-04-22T22:19', '2022-04-30T22:19'),
(79, 'sdfln', 'eklrfj', NULL, 'ermjp', 73, '2022-04-20 07:10:40', '2022-04-29T09:10', '2022-04-29T09:10', '2022-04-30T09:10', '2022-05-07T09:10');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `appointment_id` int(10) NOT NULL,
  `booked_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `option_chosen` varchar(32) NOT NULL,
  `comment` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `appointment_id`, `booked_at`, `option_chosen`, `comment`) VALUES
(67, 67, 75, '2022-04-19 20:19:30', 'option2', 'lkmwefji'),
(68, 70, 75, '2022-04-20 05:46:33', 'Wed Apr 20 2022', 'fwejk'),
(69, 70, 75, '2022-04-20 05:54:34', '', ''),
(70, 71, 75, '2022-04-20 05:54:51', 'Thu Apr 21 2022', ''),
(71, 72, 75, '2022-04-20 05:55:55', '2022-04-20T22:18', 'aef'),
(72, 71, 75, '2022-04-20 06:12:38', '', ''),
(73, 72, 79, '2022-04-20 07:11:02', '2022-04-29T09:10', 'fe');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`) VALUES
(63, 'john'),
(64, 'ed'),
(65, 'sjdfn'),
(66, 'lskndf'),
(67, 'jkfn'),
(68, 'issi_turku'),
(69, 'sadm,f'),
(70, 'sadf'),
(71, ''),
(72, 'asdf'),
(73, 'sdfnj');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`creator_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_bookings` (`user_id`),
  ADD KEY `fk_appointment_id_bookings` (`appointment_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_appointment_id_bookings` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_bookings` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
