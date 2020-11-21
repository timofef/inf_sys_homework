-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.86-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema curs
--

CREATE DATABASE IF NOT EXISTS curs;
USE curs;

--
-- Temporary table structure for view `avg_10_2017`
--
DROP TABLE IF EXISTS `avg_10_2017`;
DROP VIEW IF EXISTS `avg_10_2017`;
CREATE TABLE `avg_10_2017` (
  `mon` int(2),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_11_2017`
--
DROP TABLE IF EXISTS `avg_11_2017`;
DROP VIEW IF EXISTS `avg_11_2017`;
CREATE TABLE `avg_11_2017` (
  `mon` int(2),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_12_2017`
--
DROP TABLE IF EXISTS `avg_12_2017`;
DROP VIEW IF EXISTS `avg_12_2017`;
CREATE TABLE `avg_12_2017` (
  `mon` int(2),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_1_2017`
--
DROP TABLE IF EXISTS `avg_1_2017`;
DROP VIEW IF EXISTS `avg_1_2017`;
CREATE TABLE `avg_1_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_2_2017`
--
DROP TABLE IF EXISTS `avg_2_2017`;
DROP VIEW IF EXISTS `avg_2_2017`;
CREATE TABLE `avg_2_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_3_2017`
--
DROP TABLE IF EXISTS `avg_3_2017`;
DROP VIEW IF EXISTS `avg_3_2017`;
CREATE TABLE `avg_3_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_4_2017`
--
DROP TABLE IF EXISTS `avg_4_2017`;
DROP VIEW IF EXISTS `avg_4_2017`;
CREATE TABLE `avg_4_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_5_2017`
--
DROP TABLE IF EXISTS `avg_5_2017`;
DROP VIEW IF EXISTS `avg_5_2017`;
CREATE TABLE `avg_5_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_6_2017`
--
DROP TABLE IF EXISTS `avg_6_2017`;
DROP VIEW IF EXISTS `avg_6_2017`;
CREATE TABLE `avg_6_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_7_2017`
--
DROP TABLE IF EXISTS `avg_7_2017`;
DROP VIEW IF EXISTS `avg_7_2017`;
CREATE TABLE `avg_7_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_8_2017`
--
DROP TABLE IF EXISTS `avg_8_2017`;
DROP VIEW IF EXISTS `avg_8_2017`;
CREATE TABLE `avg_8_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Temporary table structure for view `avg_9_2017`
--
DROP TABLE IF EXISTS `avg_9_2017`;
DROP VIEW IF EXISTS `avg_9_2017`;
CREATE TABLE `avg_9_2017` (
  `mon` int(1),
  `avg_cost` decimal(14,4)
);

--
-- Definition of table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `client_id` int(11) NOT NULL auto_increment,
  `client_name` varchar(60) default NULL,
  `address` varchar(100) default NULL,
  `district` tinyint(1) default NULL,
  `contact` varchar(30) default NULL,
  `phone` varchar(12) default NULL,
  PRIMARY KEY  (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` (`client_id`,`client_name`,`address`,`district`,`contact`,`phone`) VALUES 
 (1,'Makarov Corp.','Moscow',0,'Makarov','89031234567'),
 (2,'Ivanov Inc.','Zelenograd',1,'Ivanov','89034567890'),
 (3,'Petrov Industries','Moscow, Arbat',0,'Petrov','+79161234567'),
 (4,'Moiseenko Express','Moscow, Lubertsy',0,'Moiseenko','89054201488'),
 (5,'Sibirko Tech Company','Voronej',1,'Sibirko','+79162457634'),
 (6,'Some company','Moscow, Solncevo',0,'Truschelev','89034567632');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;


--
-- Definition of table `delivery_note`
--

DROP TABLE IF EXISTS `delivery_note`;
CREATE TABLE `delivery_note` (
  `delivery_id` int(11) NOT NULL auto_increment,
  `amount` int(11) default NULL,
  `weight` int(11) default NULL,
  `delivery_date` date default NULL,
  `delivery_cost` int(11) default NULL,
  `personal_id` int(11) default NULL,
  `client_id` int(11) default NULL,
  `transport_id` int(11) default NULL,
  PRIMARY KEY  (`delivery_id`),
  KEY `fk1` (`personal_id`),
  KEY `fk2` (`client_id`),
  KEY `fk3` (`transport_id`),
  CONSTRAINT `delivery_note_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`personal_id`) ON DELETE SET NULL,
  CONSTRAINT `delivery_note_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE,
  CONSTRAINT `delivery_note_ibfk_3` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`transport_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `delivery_note`
--

/*!40000 ALTER TABLE `delivery_note` DISABLE KEYS */;
INSERT INTO `delivery_note` (`delivery_id`,`amount`,`weight`,`delivery_date`,`delivery_cost`,`personal_id`,`client_id`,`transport_id`) VALUES 
 (1,500,600,'2016-03-05',12000,1,1,1),
 (3,100,300,'2016-04-05',6000,3,3,2),
 (4,20,100,'2016-04-05',2000,3,5,3),
 (5,80,300,'2016-06-10',6000,3,6,6),
 (6,30,100,'2017-03-10',2000,4,1,2),
 (7,30,200,'2017-03-10',4000,1,3,1),
 (8,200,600,'2017-04-10',10800,4,3,3),
 (9,200,500,'2017-03-10',10000,3,4,5),
 (10,100,200,'2017-03-13',3600,3,4,5),
 (11,150,300,'2017-03-13',4500,1,4,5),
 (12,250,200,'2017-03-13',4000,4,5,2),
 (13,250,200,'2016-03-13',4000,4,2,5),
 (14,250,200,'2020-03-13',4000,4,1,2),
 (15,250,600,'2017-03-13',12000,4,2,2);
/*!40000 ALTER TABLE `delivery_note` ENABLE KEYS */;


--
-- Definition of table `personal`
--

DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal` (
  `personal_id` int(11) NOT NULL auto_increment,
  `surname` varchar(30) default NULL,
  `addr` varchar(100) default NULL,
  `birthday` date default NULL,
  `job` varchar(30) default NULL,
  `emp_date` date default NULL,
  PRIMARY KEY  (`personal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personal`
--

/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` (`personal_id`,`surname`,`addr`,`birthday`,`job`,`emp_date`) VALUES 
 (1,'Kolesov','Moscow','1980-01-01','Driver','2010-03-03'),
 (2,'Barankin','Moscow','1970-01-01','Driver','2012-03-03'),
 (3,'Perevozkin','Voronej','1990-01-01','Driver','2014-03-03'),
 (4,'Voditel','Zelenograd','1985-01-01','Driver','2013-03-03');
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;


--
-- Definition of table `reestr`
--

DROP TABLE IF EXISTS `reestr`;
CREATE TABLE `reestr` (
  `reestr_id` int(11) NOT NULL auto_increment,
  `weight_sum` int(11) default NULL,
  `reestr_year` int(11) default NULL,
  `client_id` int(11) default NULL,
  PRIMARY KEY  (`reestr_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `reestr_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reestr`
--

/*!40000 ALTER TABLE `reestr` DISABLE KEYS */;
INSERT INTO `reestr` (`reestr_id`,`weight_sum`,`reestr_year`,`client_id`) VALUES 
 (1,600,2016,1),
 (2,100,2017,1),
 (3,600,2017,2),
 (4,200,2016,2),
 (8,800,2017,3),
 (9,300,2016,3),
 (10,1000,2017,4),
 (11,0,2016,4),
 (12,200,2017,5),
 (13,100,2016,5),
 (14,0,2017,6),
 (15,300,2016,6),
 (16,200,2020,1);
/*!40000 ALTER TABLE `reestr` ENABLE KEYS */;


--
-- Definition of table `scale`
--

DROP TABLE IF EXISTS `scale`;
CREATE TABLE `scale` (
  `scale_id` int(11) NOT NULL auto_increment,
  `min` int(11) default NULL,
  `max` int(11) default NULL,
  `cost` int(11) default NULL,
  PRIMARY KEY  (`scale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scale`
--

/*!40000 ALTER TABLE `scale` DISABLE KEYS */;
INSERT INTO `scale` (`scale_id`,`min`,`max`,`cost`) VALUES 
 (1,0,100,20),
 (2,101,500,18),
 (3,501,1000,15),
 (4,1001,2000,12),
 (5,2001,3000,10);
/*!40000 ALTER TABLE `scale` ENABLE KEYS */;


--
-- Definition of table `transport`
--

DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport` (
  `transport_id` int(11) NOT NULL auto_increment,
  `brand` varchar(30) default NULL,
  `weight_limit` int(11) default NULL,
  `year` int(11) default NULL,
  `reg_num` varchar(6) default NULL,
  PRIMARY KEY  (`transport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transport`
--

/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
INSERT INTO `transport` (`transport_id`,`brand`,`weight_limit`,`year`,`reg_num`) VALUES 
 (1,'Nissan',1000,2010,'A123BC'),
 (2,'Mercedes',1500,2015,'A456BC'),
 (3,'Renault',2000,2008,'A789BC'),
 (5,'Volksvagen',1800,2005,'A321BC'),
 (6,'Feat',1200,2020,'A654BC');
/*!40000 ALTER TABLE `transport` ENABLE KEYS */;


--
-- Definition of table `year_report`
--

DROP TABLE IF EXISTS `year_report`;
CREATE TABLE `year_report` (
  `report_id` int(11) NOT NULL auto_increment,
  `client_id` int(11) default NULL,
  `deliveries_sum` int(11) default NULL,
  `avg_weight` int(11) default NULL,
  `avg_cost` int(11) default NULL,
  `report_year` int(11) default NULL,
  PRIMARY KEY  (`report_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `year_report_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `year_report`
--

/*!40000 ALTER TABLE `year_report` DISABLE KEYS */;
INSERT INTO `year_report` (`report_id`,`client_id`,`deliveries_sum`,`avg_weight`,`avg_cost`,`report_year`) VALUES 
 (7,1,1,100,2000,2017),
 (8,2,1,600,12000,2017),
 (9,3,2,400,7400,2017),
 (10,4,3,333,6033,2017),
 (11,5,1,200,4000,2017),
 (12,6,0,NULL,NULL,2017);
/*!40000 ALTER TABLE `year_report` ENABLE KEYS */;


--
-- Definition of procedure `create_report`
--

DROP PROCEDURE IF EXISTS `create_report`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_report`(ryear integer)
BEGIN
    DECLARE Done integer default 0;
    DECLARE Customer integer;
    DECLARE Deliveries integer;
    DECLARE AvgDeliveryWeight integer;
    DECLARE AvgDeliveryCost integer;

    DECLARE ClientRows CURSOR FOR SELECT client_id, COUNT(delivery_id), AVG(weight), AVG(delivery_cost) FROM client LEFT JOIN (SELECT * from delivery_note where YEAR(delivery_date)=ryear) t USING(client_id) GROUP BY client_id;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET Done=1;

    DELETE FROM year_report WHERE report_year = ryear;

    OPEN ClientRows;
    REPEAT
        FETCH ClientRows INTO  Customer, Deliveries, AvgDeliveryWeight, AvgDeliveryCost;
        IF !Done THEN
                INSERT INTO year_report (client_id, deliveries_sum, avg_weight, avg_cost, report_year) VALUES (Customer, Deliveries, AvgDeliveryWeight, AvgDeliveryCost, ryear);
        END IF;
    UNTIL Done = 1 END REPEAT;
    CLOSE ClientRows;



END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `avg_10_2017`
--

DROP TABLE IF EXISTS `avg_10_2017`;
DROP VIEW IF EXISTS `avg_10_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_10_2017` AS select 10 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 10));

--
-- Definition of view `avg_11_2017`
--

DROP TABLE IF EXISTS `avg_11_2017`;
DROP VIEW IF EXISTS `avg_11_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_11_2017` AS select 11 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 11));

--
-- Definition of view `avg_12_2017`
--

DROP TABLE IF EXISTS `avg_12_2017`;
DROP VIEW IF EXISTS `avg_12_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_12_2017` AS select 12 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 12));

--
-- Definition of view `avg_1_2017`
--

DROP TABLE IF EXISTS `avg_1_2017`;
DROP VIEW IF EXISTS `avg_1_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_1_2017` AS select 1 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 1));

--
-- Definition of view `avg_2_2017`
--

DROP TABLE IF EXISTS `avg_2_2017`;
DROP VIEW IF EXISTS `avg_2_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_2_2017` AS select 2 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 2));

--
-- Definition of view `avg_3_2017`
--

DROP TABLE IF EXISTS `avg_3_2017`;
DROP VIEW IF EXISTS `avg_3_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_3_2017` AS select 3 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 3));

--
-- Definition of view `avg_4_2017`
--

DROP TABLE IF EXISTS `avg_4_2017`;
DROP VIEW IF EXISTS `avg_4_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_4_2017` AS select 4 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 4));

--
-- Definition of view `avg_5_2017`
--

DROP TABLE IF EXISTS `avg_5_2017`;
DROP VIEW IF EXISTS `avg_5_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_5_2017` AS select 5 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 5));

--
-- Definition of view `avg_6_2017`
--

DROP TABLE IF EXISTS `avg_6_2017`;
DROP VIEW IF EXISTS `avg_6_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_6_2017` AS select 6 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 6));

--
-- Definition of view `avg_7_2017`
--

DROP TABLE IF EXISTS `avg_7_2017`;
DROP VIEW IF EXISTS `avg_7_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_7_2017` AS select 7 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 7));

--
-- Definition of view `avg_8_2017`
--

DROP TABLE IF EXISTS `avg_8_2017`;
DROP VIEW IF EXISTS `avg_8_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_8_2017` AS select 8 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 8));

--
-- Definition of view `avg_9_2017`
--

DROP TABLE IF EXISTS `avg_9_2017`;
DROP VIEW IF EXISTS `avg_9_2017`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_9_2017` AS select 9 AS `mon`,avg(`delivery_note`.`delivery_cost`) AS `avg_cost` from `delivery_note` where ((year(`delivery_note`.`delivery_date`) = 2017) and (month(`delivery_note`.`delivery_date`) = 9));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
