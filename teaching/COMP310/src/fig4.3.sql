DROP DATABASE dreamhome43;
CREATE DATABASE  `dreamhome43` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dreamhome43`;

DROP TABLE IF EXISTS `Branch`;
CREATE TABLE `Branch` (
  `branchNo` varchar(4) ,
  `street` varchar(25) ,
  `city` varchar(15) ,
  `postcode` varchar(8) ,
  PRIMARY KEY(`branchNo`)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `Branch` VALUES
('B005','22 Deer Rd','London','SW1 4EH'),
('B007','16 Argyl St','Aberdeen','AB2 3SU'),
('B003','163 Main St','Glasgow','G11 9QX'),
('B004','32 Manse Rd','Bristol','BS99 1NZ'),
('B002','56 Clover Dr','London','NW10 6EU');
COMMIT;

DROP TABLE IF EXISTS `Staff`;
CREATE TABLE `Staff` (
  `staffNo` varchar(4) ,
  `fName` varchar(15) ,
  `lName` varchar(15) ,
  `position` ENUM('Director','Manager','Assistant','Supervisor') ,
  `sex` ENUM('m','f') ,
  `dob` DATE ,
  `salary` INT ,
  `branchNo` varchar(4),
  PRIMARY KEY (`staffNo`),
  FOREIGN KEY (`branchNo`) REFERENCES Branch(branchNo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `Staff` VALUES
  ('SL21','John','White','Manager','m','1945-10-01',30000,'B005'),
  ('SG37','Ann','Beech','Assistant','f','1960-11-10',12000,'B003'),
  ('SG14','David','Ford','Supervisor','m','1958-03-24',18000,'B003'),
  ('SA9','Mary','Howe','Assistant','f','1970-02-19',9000,'B007'),
  ('SG5','Susan','Brand','Manager','f','1940-06-03',24000,'B003'),
  ('SL41','Julie','Lee','Assistant','f','1965-06-13',9000,'B005');
COMMIT;

DROP TABLE IF EXISTS `PrivateOwner`;
CREATE TABLE `PrivateOwner` (
  `ownerNo` varchar(4) ,
  `fName` varchar(15),
  `lName` varchar(15) ,
  `address` varchar(50) ,
  `telNo` varchar(13) ,
  `email` varchar(25) ,
  `password` varchar(32) ,
  PRIMARY KEY(`ownerNo`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `PrivateOwner` VALUES
  ('CO46','Joe','Keogh','2 Fergus Dr., Aberdeen AB2 7SX','01224-861212','jkeogh@lhh.com','*********'),
  ('CO87','Carol','Farrel','6 Achray St., Glasgow G32 9DX','0141-357-7419','cfarrel@gmail.com','*********'),
  ('CO40','Tina','Murphy','63 Well St., Glasgow G42','0141-943-1728','tinam@hotmail.com','*********'),
  ('CO93','Tony','Shaw','12 Park Pl., Gasgow G4 0QR','0141-225-7025','tony.shaw@ark.com','*********');
COMMIT;

DROP TABLE IF EXISTS `PropertyForRent`;
CREATE TABLE `PropertyForRent` (
  `propertyNo` varchar(4) ,
  `street` varchar(25) ,
  `city` varchar(15) ,
  `postcode` varchar(8) ,
  `type` ENUM('House','Flat'),
  `rooms` INT ,
  `rent` INT ,
  `ownerNo` varchar(4) ,
  `staffNo` varchar(4) ,
  `branchNo` varchar(4),
  PRIMARY KEY(`propertyNo`),
  FOREIGN KEY(`staffNo`) REFERENCES Staff(staffNo),
  FOREIGN KEY(`branchNo`) REFERENCES Branch(branchNo),
  FOREIGN KEY(`ownerNo`) REFERENCES PrivateOwner(ownerNo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `PropertyForRent` VALUES
  ('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007'),
  ('PL94','6 Argyll St.','London','NW2','Flat',4,400,'CO87','SL41','B005'),
  ('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40',NULL,'B003'),
  ('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003'),
  ('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003'),
  ('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003');
COMMIT;

DROP TABLE IF EXISTS `Client`;
CREATE TABLE `Client` (
  `clientNo` varchar(4),
  `fName` varchar(15),
  `lName` varchar(15) ,
  `telNo` varchar(13) ,
  `perfType` ENUM('House','Flat'),
  `maxRent` INT ,
  `email` varchar(25) ,
  PRIMARY KEY(`clientNo`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `Client` VALUES
  ('CR76','John','Kay','0207-774-5632','Flat',425,'john.kay@gmail.com'),
  ('CR56','Aline','Stewart','0141-848-1825','Flat',350,'astewart@hotmail.com'),
  ('CR74','Mike','Ritchie','01475-392178','House',750,'mritchie01@yahoo.co.uk'),
  ('CR62','Mary','Tregear','01224-196720','Flat',650,'maryt@hotmail.co.uk');
COMMIT;

DROP TABLE IF EXISTS `Viewing`;
CREATE TABLE `Viewing` (
  `clientNo` varchar(4),
  `propertyNo` varchar(4) ,
  `viewDate` DATE,
  `comment` varchar(128) NULL,
  PRIMARY KEY(`clientNo`,`propertyNo`),
  FOREIGN KEY(`clientNo`) REFERENCES Client(clientNo),
  FOREIGN KEY(`propertyNo`) REFERENCES PropertyForRent(propertyNo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `Viewing` VALUES
 ('CR56','PA14','2013-05-24','too small'),
 ('CR76','PG4','2013-04-20','too remote'),
 ('CR56','PG4','2013-05-26',NULL),
 ('CR62','PA14','2013-05-14','no dining room('),
 ('CR56','PG36','2013-04-28',NULL);
COMMIT;

DROP TABLE IF EXISTS `Registration`;
CREATE TABLE `Registration` (
  `clientNo` varchar(4),
  `branchNo` varchar(4),
  `staffNo` varchar(4),
  `dateJoined` DATE,
  PRIMARY KEY(`clientNo`,`branchNo`),
  FOREIGN KEY(`clientNo`) REFERENCES Client(clientNo),
  FOREIGN KEY(`branchNo`) REFERENCES Branch(branchNo),
  FOREIGN KEY(`staffNo`) REFERENCES Staff(staffNo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `Registration` VALUES
 ('CR76','B005','SL41','2013-01-02'),
 ('CR56','B003','SG37','2012-04-11'),
 ('CR74','B003','SG37','2011-11-16'),
 ('CR62','B007','SA9','2012-03-07');
COMMIT;
