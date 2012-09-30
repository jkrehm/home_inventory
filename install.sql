CREATE DATABASE home_inventory;

use home_inventory;


CREATE TABLE `Location` (
  `LOC_ID` int(11) NOT NULL auto_increment,
  `LOC_Description1` varchar(80) default NULL,
  `LOC_Description2` varchar(200) NOT NULL default '',
  `LOC_Picture` varchar(50) default NULL,
  PRIMARY KEY  (`LOC_ID`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Location for objects';



CREATE TABLE `Person` (
  `PPL_ID` int(11) NOT NULL auto_increment,
  `PPL_Name` varchar(40) default NULL,
  `PPL_Telefone` varchar(20) NOT NULL default '',
  `PPL_EMail` varchar(40) default NULL,
  PRIMARY KEY  (`PPL_ID`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Peoples who I can lend an object to';



CREATE TABLE `Item` (
  `ITM_ID` int(11) NOT NULL auto_increment,
  `ITM_ShortName` varchar(50) default NULL,
  `ITM_Description` varchar(250) default NULL,
  `ITM_Picture` varchar(50) default NULL,
  `ITM_LocationId` int(11) default NULL,
  `ITM_LendToId` int(11) default NULL,
  `ITM_LendDate` date default NULL,
  `ITM_InsertDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `ITM_Quantity` smallint(6) default NULL,
  `ITM_Brand` varchar(40) default NULL,
  `ITM_Model` varchar(40) default NULL,
  `ITM_SerialNum` varchar(20) default NULL,
  `ITM_State` tinyint(4) default NULL,
  `ITM_Condition` tinyint(4) default NULL,
  `ITM_ConditionDescr` varchar(80) default NULL,
  `ITM_PurchaseDate` date default NULL,
  `ITM_PurchaseLocation` varchar(40) default NULL,
  `ITM_PurchasePrice` varchar(15) default NULL,
  `ITM_CurrentValue` varchar(15) default NULL,
  `ITM_ReplacementCost` varchar(15) default NULL,
  `ITM_WarrantyInfo` varchar(100) default NULL,
  `ITM_History` text,
  PRIMARY KEY  (`ITM_ID`),
  KEY `ITM_LocationId` (`ITM_LocationId`),
  KEY `ITM_LendToId` (`ITM_LendToId`),
  CONSTRAINT `Item_ibfk_1` FOREIGN KEY (`ITM_LocationId`) REFERENCES `Location` (`LOC_ID`),
  CONSTRAINT `Item_ibfk_2` FOREIGN KEY (`ITM_LendToId`) REFERENCES `Person` (`PPL_ID`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Inventary''s objects';



CREATE TABLE `Picture` (
  `PCT_ID` int(11) NOT NULL auto_increment,
  `PCT_ItemId` int(11) NOT NULL default '0',
  `PCT_FileName` varchar(50) default NULL,
  PRIMARY KEY  (`PCT_ID`),
  KEY `PCT_ItemId` (`PCT_ItemId`),
  CONSTRAINT `PCT_Item_fk` FOREIGN KEY (`PCT_ItemId`) REFERENCES `Item` (`ITM_ID`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Item''s Picture';


