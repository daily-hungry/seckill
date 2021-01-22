-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2021-01-22 17:24:03
-- 服务器版本： 5.6.49-log
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seckill`
--

-- --------------------------------------------------------

--
-- 表的结构 `activities`
--

CREATE TABLE IF NOT EXISTS `activities` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `time` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `place` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `sum` int(11) NOT NULL,
  `remain` int(11) NOT NULL,
  `info` varchar(300) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `starttime` int(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `activities`
--

INSERT INTO `activities` (`id`, `name`, `time`, `place`, `sum`, `remain`, `info`, `starttime`) VALUES
(1, '招聘会一场', '2021年1月30日09:00-11:00', '研发楼一楼', 200, 78, '互联网企业招聘专场第一场', 1611295627),
(2, '招聘会二场', '2021年1月30日15:00-17:00', '研发楼一楼', 200, 180, '互联网企业招聘专场第二场', 1711295627),
(3, '招聘会三场', '2021年1月31日09:00-11:00', '研发楼一楼', 100, 86, '互联网企业招聘专场第三场', NULL),
(4, '招聘会四场', '2021年1月31日15:00-17:00', '研发楼一楼', 100, 90, '互联网企业招聘专场第四场', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL,
  `module` varchar(100) NOT NULL,
  `controller` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `ip` bigint(6) NOT NULL,
  `time` int(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `log`
--

INSERT INTO `log` (`id`, `module`, `controller`, `action`, `ip`, `time`) VALUES
(37, 'admin', 'Main', 'index', 1931204375, 1611301219),
(38, 'admin', 'Main', 'images', 1931204375, 1611301219),
(39, 'admin', 'Main', 'images', 1931204375, 1611301219),
(40, 'admin', 'Main', 'images', 1931204375, 1611301219),
(41, 'admin', 'Main', 'images', 1931204375, 1611301219),
(42, 'admin', 'Main', 'images', 1931204375, 1611301219),
(43, 'admin', 'Main', 'images', 1931204375, 1611301219),
(44, 'admin', 'Main', 'images', 1931204375, 1611301219),
(45, 'admin', 'Main', 'images', 1931204375, 1611301219),
(46, 'admin', 'Main', 'images', 1931204375, 1611301219),
(47, 'admin', 'Main', 'images', 1931204375, 1611301219),
(48, 'admin', 'Main', 'images', 1931204375, 1611301219),
(49, 'admin', 'Main', 'index', 1931204375, 1611302663),
(50, 'admin', 'Main', 'images', 1931204375, 1611302663),
(51, 'admin', 'Main', 'images', 1931204375, 1611302663),
(52, 'admin', 'Main', 'images', 1931204375, 1611302663),
(53, 'admin', 'Main', 'images', 1931204375, 1611302663),
(54, 'admin', 'Main', 'images', 1931204375, 1611302663),
(55, 'admin', 'Main', 'images', 1931204375, 1611302663),
(56, 'admin', 'Main', 'images', 1931204375, 1611302663),
(57, 'admin', 'Main', 'images', 1931204375, 1611302663),
(58, 'admin', 'Main', 'images', 1931204375, 1611302663),
(59, 'admin', 'Main', 'images', 1931204375, 1611302663),
(60, 'admin', 'Main', 'images', 1931204375, 1611302663);

-- --------------------------------------------------------

--
-- 表的结构 `nodes`
--

CREATE TABLE IF NOT EXISTS `nodes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `info` varchar(200) CHARACTER SET utf8mb4 NOT NULL,
  `controller` varchar(30) CHARACTER SET utf8mb4 NOT NULL,
  `action` varchar(30) CHARACTER SET utf8mb4 NOT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `nodes`
--

INSERT INTO `nodes` (`id`, `name`, `info`, `controller`, `action`, `url`, `state`) VALUES
(1, '活动信息管理', '', 'activitymanage', 'index', 'activitymanage/index.html', 1),
(2, '报名信息管理', '', 'signmanage', 'index', 'signmanage/index.html', 1),
(3, '后台用户信息管理', '', 'backmanage', 'index', 'backmanage/index.html', 1),
(4, '前台用户信息管理', '', 'frontmanage', 'index', 'frontmanage/index.html', 1),
(5, '角色权限管理', '', 'rolemanage', 'index', 'rolemanage/index.html', 1),
(6, '系统功能管理', '', 'nodemanage', 'index', 'nodemanage/index.html', 1);

-- --------------------------------------------------------

--
-- 表的结构 `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `info` varchar(200) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `roles`
--

INSERT INTO `roles` (`id`, `name`, `info`, `state`) VALUES
(1, '超级管理员', '', 1),
(2, '活动负责人', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `role_node`
--

CREATE TABLE IF NOT EXISTS `role_node` (
  `id` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  `nodeid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `role_node`
--

INSERT INTO `role_node` (`id`, `roleid`, `nodeid`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 2, 1),
(8, 2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `role_node_old`
--

CREATE TABLE IF NOT EXISTS `role_node_old` (
  `id` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  `nodeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `role_node_old`
--

INSERT INTO `role_node_old` (`id`, `roleid`, `nodeid`) VALUES
(0, 1, 1),
(0, 1, 2),
(0, 1, 3),
(0, 1, 4),
(0, 1, 5),
(0, 1, 6),
(0, 2, 1),
(0, 2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `signs`
--

CREATE TABLE IF NOT EXISTS `signs` (
  `id` int(11) NOT NULL,
  `stuid` int(11) NOT NULL,
  `actid` int(11) NOT NULL,
  `gettime` int(30) NOT NULL,
  `info` varchar(300) CHARACTER SET utf8mb4 NOT NULL COMMENT '备注'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `signs`
--

INSERT INTO `signs` (`id`, `stuid`, `actid`, `gettime`, `info`) VALUES
(1, 1, 1, 1611295627, '互联网企业招聘专场第一场'),
(2, 1, 3, 1611301319, '互联网企业招聘专场第三场'),
(3, 1, 3, 1611301506, '互联网企业招聘专场第三场');

-- --------------------------------------------------------

--
-- 表的结构 `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `id` int(11) NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `token` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `logintime` int(30) NOT NULL,
  `state` tinyint(1) NOT NULL COMMENT '是否已报名'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `students`
--

INSERT INTO `students` (`id`, `username`, `password`, `name`, `token`, `logintime`, `state`) VALUES
(1, '2001210671', '92c8c96e4c37100777c7190b76d28233', '小王', '45a9fc789d748f332a10', 1611301506, 0),
(2, '2001210672', 'cfcd208495d565ef66e7dff9f98764da', '小李', 'eb81443e7432ea410668', 1604412949, 0);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `token` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `logintime` int(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `token`, `logintime`) VALUES
(1, 'user1', '92c8c96e4c37100777c7190b76d28233', 'name1', '4e654a28ff0abe10', 1611290948),
(2, 'user2', 'cfcd208495d565ef66e7dff9f98764da', 'name2', '4f91d140d073646c', 1611257585),
(3, 'user3', 'a87ff679a2f3e71d9181a67b7542122c', 'name3', '921b980346936b558d1b', 1604407290);

-- --------------------------------------------------------

--
-- 表的结构 `user_role`
--

CREATE TABLE IF NOT EXISTS `user_role` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_role`
--

INSERT INTO `user_role` (`userid`, `roleid`) VALUES
(1, 1),
(2, 2),
(3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nodes`
--
ALTER TABLE `nodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_node`
--
ALTER TABLE `role_node`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `signs`
--
ALTER TABLE `signs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `role_node`
--
ALTER TABLE `role_node`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `signs`
--
ALTER TABLE `signs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
