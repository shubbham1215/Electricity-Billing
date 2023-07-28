-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2020 at 07:36 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `billing_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `bill_correction`
--

CREATE TABLE `bill_correction` (
  `Complaint_id` int(11) NOT NULL,
  `C_id` varchar(11) NOT NULL,
  `Bill_no` varchar(11) NOT NULL,
  `Description` varchar(300) NOT NULL,
  `Amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `consumer_details`
--

CREATE TABLE `consumer_details` (
  `Dis_id` int(4) NOT NULL,
  `Category_id` int(4) NOT NULL,
  `Cus_id` varchar(11) NOT NULL,
  `Cus_name` varchar(30) NOT NULL,
  `Cus_address` varchar(50) NOT NULL,
  `Payment_due` double NOT NULL,
  `Email` varchar(20) NOT NULL,
  `Phone` bigint(10) NOT NULL,
  `Reg_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `consumer_details`
--

INSERT INTO `consumer_details` (`Dis_id`, `Category_id`, `Cus_id`, `Cus_name`, `Cus_address`, `Payment_due`, `Email`, `Phone`, `Reg_date`) VALUES
(1000, 0, 'CAN12345222', 'Roland', 'Mapusa', 90.9, 'abc@gmail.com', 3781278130, '2020-08-12'),
(1000, 0, 'CAN12345655', 'Aaqib', 'Margao', 0, 'abc@gmail.com', 3781278130, '2020-08-12'),
(1000, 0, 'CAN12345670', 'Chinmay', 'Bori', 34.56, 'abc@gmail.com', 3781278130, '2020-08-12'),
(1000, 0, 'CAN12345678', 'Shubham', 'Ponda', 0, 'abc@gmail.com', 3781278130, '2020-08-12');

-- --------------------------------------------------------

--
-- Table structure for table `cons_bill_calendar_payment_info`
--

CREATE TABLE `cons_bill_calendar_payment_info` (
  `Bill_no` varchar(11) NOT NULL,
  `Cus_id` varchar(11) NOT NULL,
  `From_date` date NOT NULL,
  `To_date` date NOT NULL,
  `Status_id` int(2) NOT NULL,
  `Trans_id` varchar(10) NOT NULL,
  `Amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cons_bill_calendar_payment_info`
--

INSERT INTO `cons_bill_calendar_payment_info` (`Bill_no`, `Cus_id`, `From_date`, `To_date`, `Status_id`, `Trans_id`, `Amount`) VALUES
('4560', 'CAN12345678', '2020-06-11', '2020-06-20', 11, '34412', 300),
('4567', 'CAN12345678', '2020-05-18', '2020-05-28', 10, '34', 100),
('4568', 'CAN12345678', '2020-05-28', '2020-06-03', 12, '344', 150),
('4569', 'CAN12345678', '2020-06-03', '2020-06-10', 12, '3441', 200),
('6789', 'CAN12345655', '2020-04-06', '2020-04-30', 10, '8901', 400),
('6812', 'CAN12345655', '2020-05-16', '2020-05-31', 11, '892', 500),
('6813', 'CAN12345655', '2020-06-01', '2020-06-15', 11, '893', 500),
('689', 'CAN12345655', '2020-05-01', '2020-05-15', 10, '891', 450);

-- --------------------------------------------------------

--
-- Table structure for table `cus_meter_reading`
--

CREATE TABLE `cus_meter_reading` (
  `Consumer_id` varchar(11) NOT NULL,
  `Reading` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Peak_load` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cus_meter_reading`
--

INSERT INTO `cus_meter_reading` (`Consumer_id`, `Reading`, `Date`, `Peak_load`) VALUES
('CAN12345670', 150, '2020-08-26', 0.5),
('CAN12345670', 250, '2020-08-29', 0.3),
('CAN12345670', 300, '2020-08-30', 0.3),
('CAN12345678', 340, '2020-05-12', 0.5),
('CAN12345678', 440, '2020-05-17', 0.5),
('CAN12345678', 540, '2020-05-21', 0.5),
('CAN12345222', 170, '2020-05-20', 0.3),
('CAN12345222', 360, '2020-05-31', 0.4),
('CAN12345222', 550, '2020-06-15', 0.2),
('CAN12345655', 400, '2020-05-12', 0.3),
('CAN12345655', 900, '2020-05-27', 0.5),
('CAN12345655', 1590, '2020-06-17', 0.4);

-- --------------------------------------------------------

--
-- Table structure for table `discom`
--

CREATE TABLE `discom` (
  `Distributor_id` tinyint(4) NOT NULL,
  `Dis_id` int(4) NOT NULL,
  `Dis_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `discom`
--

INSERT INTO `discom` (`Distributor_id`, `Dis_id`, `Dis_name`) VALUES
(1, 1000, 'REC Power Distribution Co Ltd');

-- --------------------------------------------------------

--
-- Table structure for table `distributor_details`
--

CREATE TABLE `distributor_details` (
  `Distri_name` varchar(30) NOT NULL,
  `Distri_id` tinyint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `distributor_details`
--

INSERT INTO `distributor_details` (`Distri_name`, `Distri_id`) VALUES
('Goa Electricity Department', 1);

-- --------------------------------------------------------

--
-- Table structure for table `elec_charges`
--

CREATE TABLE `elec_charges` (
  `Dis_id` int(4) NOT NULL,
  `From_date` date NOT NULL,
  `To_date` date NOT NULL,
  `Fppca` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `elec_charges`
--

INSERT INTO `elec_charges` (`Dis_id`, `From_date`, `To_date`, `Fppca`) VALUES
(1000, '2020-08-18', '2020-08-26', 60),
(1000, '2020-08-27', '2020-08-28', 70),
(1000, '2019-10-14', '2020-08-17', 45.5);

-- --------------------------------------------------------

--
-- Table structure for table `meter`
--

CREATE TABLE `meter` (
  `Cus_id` varchar(11) NOT NULL,
  `Meter_Number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meter`
--

INSERT INTO `meter` (`Cus_id`, `Meter_Number`) VALUES
('CAN12345222', 12346),
('CAN12345655', 12348),
('CAN12345670', 12347),
('CAN12345678', 12345);

-- --------------------------------------------------------

--
-- Table structure for table `notice`
--

CREATE TABLE `notice` (
  `Notice_id` int(5) NOT NULL,
  `C_id` varchar(11) NOT NULL,
  `Bill_no` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sanctioned_load_table`
--

CREATE TABLE `sanctioned_load_table` (
  `Dis_id` int(4) NOT NULL,
  `Category_id` int(4) NOT NULL,
  `Sanctioned_load` double NOT NULL,
  `Sanctioned_load_rate` double NOT NULL,
  `Sanctioned_Cross_rate` double NOT NULL DEFAULT 50.5,
  `Subsidy` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sanctioned_load_table`
--

INSERT INTO `sanctioned_load_table` (`Dis_id`, `Category_id`, `Sanctioned_load`, `Sanctioned_load_rate`, `Sanctioned_Cross_rate`, `Subsidy`) VALUES
(1000, 0, 0.6, 0.9, 1, 65),
(1000, 1, 1.6, 2.5, 3, 75),
(1000, 2, 2.6, 3.5, 4, 100);

-- --------------------------------------------------------

--
-- Table structure for table `slabs1`
--

CREATE TABLE `slabs1` (
  `Dis_id` int(4) NOT NULL,
  `Category_id` int(4) NOT NULL,
  `Category_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `slabs1`
--

INSERT INTO `slabs1` (`Dis_id`, `Category_id`, `Category_name`) VALUES
(1000, 0, 'Domestic'),
(1000, 1, 'Commercial'),
(1000, 2, 'Industrial');

-- --------------------------------------------------------

--
-- Table structure for table `slabs_charges`
--

CREATE TABLE `slabs_charges` (
  `Dis_id` int(4) NOT NULL,
  `Category_id` int(4) NOT NULL,
  `Low` int(11) NOT NULL,
  `High` int(11) NOT NULL,
  `Charges` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `slabs_charges`
--

INSERT INTO `slabs_charges` (`Dis_id`, `Category_id`, `Low`, `High`, `Charges`) VALUES
(1000, 0, 0, 100, 1.25),
(1000, 0, 101, 200, 1.5),
(1000, 0, 201, 300, 1.75),
(1000, 0, 301, 400, 2.5),
(1000, 0, 401, 2147483646, 3),
(1000, 1, 0, 200, 2.5),
(1000, 1, 201, 400, 4),
(1000, 1, 401, 2147483646, 5),
(1000, 2, 0, 500, 7),
(1000, 2, 501, 2147483647, 10);

-- --------------------------------------------------------

--
-- Table structure for table `status_table`
--

CREATE TABLE `status_table` (
  `Status_id` int(2) NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status_table`
--

INSERT INTO `status_table` (`Status_id`, `Status`) VALUES
(10, 'Paid'),
(11, 'UnPaid'),
(12, 'Paid with warning');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill_correction`
--
ALTER TABLE `bill_correction`
  ADD PRIMARY KEY (`Complaint_id`),
  ADD KEY `cons_details_bill_correction` (`C_id`),
  ADD KEY `bill_corr_bill_calen` (`Bill_no`);

--
-- Indexes for table `consumer_details`
--
ALTER TABLE `consumer_details`
  ADD PRIMARY KEY (`Cus_id`),
  ADD KEY `cons_details_slabs` (`Dis_id`,`Category_id`);

--
-- Indexes for table `cons_bill_calendar_payment_info`
--
ALTER TABLE `cons_bill_calendar_payment_info`
  ADD PRIMARY KEY (`Bill_no`),
  ADD UNIQUE KEY `Trans_id` (`Trans_id`),
  ADD KEY `consumer_details_bill_calendar` (`Cus_id`),
  ADD KEY `cons_bill_status` (`Status_id`);

--
-- Indexes for table `cus_meter_reading`
--
ALTER TABLE `cus_meter_reading`
  ADD KEY `Foreign_1` (`Consumer_id`);

--
-- Indexes for table `discom`
--
ALTER TABLE `discom`
  ADD PRIMARY KEY (`Dis_id`),
  ADD KEY `Distributor_Discom` (`Distributor_id`);

--
-- Indexes for table `distributor_details`
--
ALTER TABLE `distributor_details`
  ADD PRIMARY KEY (`Distri_id`);

--
-- Indexes for table `elec_charges`
--
ALTER TABLE `elec_charges`
  ADD KEY `rates_discom` (`Dis_id`);

--
-- Indexes for table `meter`
--
ALTER TABLE `meter`
  ADD PRIMARY KEY (`Meter_Number`),
  ADD KEY `Meter_consumer` (`Cus_id`);

--
-- Indexes for table `notice`
--
ALTER TABLE `notice`
  ADD PRIMARY KEY (`Notice_id`),
  ADD KEY `Notice_cons_details` (`C_id`),
  ADD KEY `Notice_bill_calendar` (`Bill_no`);

--
-- Indexes for table `sanctioned_load_table`
--
ALTER TABLE `sanctioned_load_table`
  ADD KEY `Load_slabs1` (`Dis_id`,`Category_id`);

--
-- Indexes for table `slabs1`
--
ALTER TABLE `slabs1`
  ADD PRIMARY KEY (`Dis_id`,`Category_id`);

--
-- Indexes for table `slabs_charges`
--
ALTER TABLE `slabs_charges`
  ADD KEY `slabs_charges_slabs` (`Dis_id`,`Category_id`);

--
-- Indexes for table `status_table`
--
ALTER TABLE `status_table`
  ADD PRIMARY KEY (`Status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill_correction`
--
ALTER TABLE `bill_correction`
  MODIFY `Complaint_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `distributor_details`
--
ALTER TABLE `distributor_details`
  MODIFY `Distri_id` tinyint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `meter`
--
ALTER TABLE `meter`
  MODIFY `Meter_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12349;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill_correction`
--
ALTER TABLE `bill_correction`
  ADD CONSTRAINT `bill_corr_bill_calen` FOREIGN KEY (`Bill_no`) REFERENCES `cons_bill_calendar_payment_info` (`Bill_no`),
  ADD CONSTRAINT `cons_details_bill_correction` FOREIGN KEY (`C_id`) REFERENCES `consumer_details` (`Cus_id`);

--
-- Constraints for table `consumer_details`
--
ALTER TABLE `consumer_details`
  ADD CONSTRAINT `cons_details_slabs` FOREIGN KEY (`Dis_id`,`Category_id`) REFERENCES `slabs1` (`Dis_id`, `Category_id`);

--
-- Constraints for table `cons_bill_calendar_payment_info`
--
ALTER TABLE `cons_bill_calendar_payment_info`
  ADD CONSTRAINT `cons_bill_status` FOREIGN KEY (`Status_id`) REFERENCES `status_table` (`Status_id`),
  ADD CONSTRAINT `consumer_details_bill_calendar` FOREIGN KEY (`Cus_id`) REFERENCES `consumer_details` (`Cus_id`);

--
-- Constraints for table `cus_meter_reading`
--
ALTER TABLE `cus_meter_reading`
  ADD CONSTRAINT `Foreign_1` FOREIGN KEY (`Consumer_id`) REFERENCES `consumer_details` (`Cus_id`);

--
-- Constraints for table `discom`
--
ALTER TABLE `discom`
  ADD CONSTRAINT `Distributor_Discom` FOREIGN KEY (`Distributor_id`) REFERENCES `distributor_details` (`Distri_id`);

--
-- Constraints for table `elec_charges`
--
ALTER TABLE `elec_charges`
  ADD CONSTRAINT `rates_discom` FOREIGN KEY (`Dis_id`) REFERENCES `discom` (`Dis_id`);

--
-- Constraints for table `meter`
--
ALTER TABLE `meter`
  ADD CONSTRAINT `Meter_consumer` FOREIGN KEY (`Cus_id`) REFERENCES `consumer_details` (`Cus_id`);

--
-- Constraints for table `notice`
--
ALTER TABLE `notice`
  ADD CONSTRAINT `Notice_bill_calendar` FOREIGN KEY (`Bill_no`) REFERENCES `cons_bill_calendar_payment_info` (`Bill_no`),
  ADD CONSTRAINT `Notice_cons_details` FOREIGN KEY (`C_id`) REFERENCES `consumer_details` (`Cus_id`);

--
-- Constraints for table `sanctioned_load_table`
--
ALTER TABLE `sanctioned_load_table`
  ADD CONSTRAINT `Load_slabs1` FOREIGN KEY (`Dis_id`,`Category_id`) REFERENCES `slabs1` (`Dis_id`, `Category_id`);

--
-- Constraints for table `slabs1`
--
ALTER TABLE `slabs1`
  ADD CONSTRAINT `SSlabs_discom4` FOREIGN KEY (`Dis_id`) REFERENCES `discom` (`Dis_id`);

--
-- Constraints for table `slabs_charges`
--
ALTER TABLE `slabs_charges`
  ADD CONSTRAINT `slabs_charges_slabs` FOREIGN KEY (`Dis_id`,`Category_id`) REFERENCES `slabs1` (`Dis_id`, `Category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
