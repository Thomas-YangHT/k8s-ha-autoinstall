-- --------------------------------------------------------
-- 主机:                           172.16.254.110
-- 服务器版本:                        10.2.13-MariaDB-10.2.13+maria~jessie-log - mariadb.org binary distribution
-- 服务器操作系统:                      debian-linux-gnu
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 students 的数据库结构
CREATE DATABASE IF NOT EXISTS `students` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `students`;


-- 导出  表 students.base 结构
CREATE TABLE IF NOT EXISTS `base` (
  `stud_no` varchar(10) NOT NULL COMMENT '学号',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `sex` varchar(2) NOT NULL COMMENT '性别',
  `native` varchar(10) NOT NULL COMMENT '籍贯',
  `nation` varchar(20) NOT NULL COMMENT '民族',
  `birth` varchar(10) NOT NULL COMMENT '出生年月',
  `high` varchar(5) NOT NULL COMMENT '身高',
  `weigh` varchar(5) NOT NULL COMMENT '体重（公斤）',
  `education` varchar(10) NOT NULL COMMENT '学历',
  `school` varchar(30) NOT NULL COMMENT '毕业院校',
  `tele` varchar(30) NOT NULL COMMENT '电话',
  `QQ` varchar(30) NOT NULL COMMENT 'QQ',
  `linkman` varchar(50) NOT NULL COMMENT '紧急联系人及电话',
  `comedate` varchar(50) NOT NULL COMMENT '入班日期',
  PRIMARY KEY (`stud_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 students.chengji 结构
CREATE TABLE IF NOT EXISTS `chengji` (
  `stud_no` varchar(10) NOT NULL,
  `hardware` char(10) DEFAULT NULL,
  `software` char(10) DEFAULT NULL,
  `network` char(10) DEFAULT NULL,
  `english` char(10) DEFAULT NULL,
  `type` char(10) DEFAULT NULL COMMENT ' 打字成绩',
  `RAID` char(10) DEFAULT NULL COMMENT 'RAID实践',
  `wire` char(10) DEFAULT NULL COMMENT '网线制作',
  `BIOS` char(10) DEFAULT NULL COMMENT 'BIOS设定',
  `sysinstall` char(10) DEFAULT NULL COMMENT '系统安装',
  `sysmanager` char(10) DEFAULT NULL COMMENT 'windows系统管理',
  `netmanager` char(10) DEFAULT NULL COMMENT '网络故障排查',
  `VISIO` char(10) DEFAULT NULL COMMENT 'VISIO画架构图',
  PRIMARY KEY (`stud_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='\r\n';

-- 数据导出被取消选择。


-- 导出  表 students.score 结构
CREATE TABLE IF NOT EXISTS `score` (
  `stud_no` varchar(10) DEFAULT NULL COMMENT '学号',
  `coursename` varchar(20) DEFAULT NULL COMMENT '课程名或实践考核名称',
  `ctype` varchar(1) DEFAULT NULL COMMENT '理论（t）or 实践（p）',
  `clevel` varchar(1) DEFAULT NULL COMMENT '1-计算机基础 2-linux基础',
  `score` varchar(10) DEFAULT NULL COMMENT '分数或优良级'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
