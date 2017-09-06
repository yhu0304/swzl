/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.50 : Database - swzl
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`swzl` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `swzl`;

/*Table structure for table `t_category` */

DROP TABLE IF EXISTS `t_category`;

CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `t_category` */

insert  into `t_category`(`id`,`cname`) values (1,'卡类证件'),(2,'随身物品'),(3,'电子数码'),(4,'书籍资料'),(5,'衣物饰品'),(6,'其他物品');

/*Table structure for table `t_claimuser` */

DROP TABLE IF EXISTS `t_claimuser`;

CREATE TABLE `t_claimuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_claimuser` */

insert  into `t_claimuser`(`id`,`email`,`tel`,`username`) values (4,'','','李四');

/*Table structure for table `t_goods` */

DROP TABLE IF EXISTS `t_goods`;

CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `crearetime` datetime DEFAULT NULL,
  `happentime` datetime DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `typename` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `claimuid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9E8BE3AB10FBE6D9` (`claimuid`),
  KEY `FK9E8BE3AB6E2F87DE` (`cid`),
  KEY `FK9E8BE3ABB4525B3D` (`uid`),
  CONSTRAINT `FK9E8BE3AB10FBE6D9` FOREIGN KEY (`claimuid`) REFERENCES `t_claimuser` (`id`),
  CONSTRAINT `FK9E8BE3AB6E2F87DE` FOREIGN KEY (`cid`) REFERENCES `t_category` (`id`),
  CONSTRAINT `FK9E8BE3ABB4525B3D` FOREIGN KEY (`uid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods` */

insert  into `t_goods`(`id`,`address`,`crearetime`,`happentime`,`info`,`mobile`,`name`,`qq`,`remark`,`result`,`state`,`title`,`typename`,`cid`,`claimuid`,`uid`) values (8,'浦区','2017-02-19 18:55:07','2017-02-10 00:00:00','11111111111111111111111111111111111','13333333333','iphone6','','',NULL,0,'丢失iphone6一部','lost',3,NULL,7),(9,'二食堂','2017-02-19 19:24:34','2017-02-11 00:00:00','22222222222222222222222222','13444444444','校园卡','','小小',NULL,1,'捡到校园卡一张','find',1,4,7),(10,'操场','2017-02-19 19:51:52','2017-02-19 19:51:52','11111111111111','13333333333','三生三世十里桃花','','',NULL,0,'捡到一本书','find',4,NULL,7),(11,'一食堂','2017-02-19 19:57:33','2017-02-19 19:57:33','3333333333333333','15651700000','卡西欧','','',NULL,0,'捡到一个手表','find',3,NULL,5);

/*Table structure for table `t_reply` */

DROP TABLE IF EXISTS `t_reply`;

CREATE TABLE `t_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `gid` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9F225F3FB4525B3D` (`uid`),
  CONSTRAINT `FK9F225F3FB4525B3D` FOREIGN KEY (`uid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_reply` */

insert  into `t_reply`(`id`,`content`,`createtime`,`gid`,`uid`) values (4,'我帮你问问','2017-02-19 19:09:28',8,4);

/*Table structure for table `t_thanksletter` */

DROP TABLE IF EXISTS `t_thanksletter`;

CREATE TABLE `t_thanksletter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crearetime` datetime DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD98DA65AB4525B3D` (`uid`),
  CONSTRAINT `FKD98DA65AB4525B3D` FOREIGN KEY (`uid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_thanksletter` */

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createtime` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `userlock` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`createtime`,`email`,`password`,`role`,`userlock`,`username`) values (1,NULL,'admin','admin',1,0,'admin'),(4,'2016-12-17 15:02:12','12345@qq.com','123456',0,0,'张三'),(5,'2016-12-17 15:02:12','24689@qq.com','123456',0,0,'李四'),(6,'2016-12-17 15:02:12','22888@qq.com','123456',0,0,'王五'),(7,'2017-02-19 19:22:57','lili@163.com','123456',0,0,'lili'),(8,'2017-02-21 09:44:52','qq@qq.com','123456',0,0,'nini');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
