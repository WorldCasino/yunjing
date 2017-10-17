/*
Navicat MySQL Data Transfer

Source Server         : agdress
Source Server Version : 50637
Source Host           : 192.168.1.43:3306
Source Database       : kk

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-10-17 11:08:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `m_activitys`
-- ----------------------------
DROP TABLE IF EXISTS `m_activitys`;
CREATE TABLE `m_activitys` (
  `activity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `summary` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告摘要 描述',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `image_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告图片地址',
  `link_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链接url',
  `link_title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链接标题',
  `link_remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_seq` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m_activitys
-- ----------------------------
INSERT INTO `m_activitys` VALUES ('1', '新用户免费领2000元', '2017-08-22 18:29:03', '2018-08-22 00:00:00', 'banners/activity_01.jpg', 'http://cdn.sztchx.com/help/index.html?locale=zh_CN', '新用户免费领2000元', '新用户免费领2000元', '3', '1', '1', '2017-08-29 14:56:26', '1', '2017-08-29 14:56:26', '0');
INSERT INTO `m_activitys` VALUES ('2', '享受娱乐，不用到澳门', '2017-08-22 18:30:22', '2018-08-22 00:00:00', 'banners/activity_02.jpg', 'http://cdn.sztchx.com/help/index.html?locale=zh_CN', '享受娱乐，不用到澳门', '一分钟了解星河娱乐', '2', '1', '1', '2017-08-29 14:55:52', '1', '2017-08-29 14:55:52', '0');
INSERT INTO `m_activitys` VALUES ('3', '超多游戏，一次玩个够', '2017-08-22 18:30:22', '2017-08-30 00:00:00', 'banners/activity_03.jpg', 'http://cdn.sztchx.com/help/index.html?locale=zh_CN', '超多游戏，一次玩个够', '超多游戏，一次玩个够', '1', '1', '1', '2017-09-08 16:01:12', '1', '2017-09-08 16:01:12', '1');

-- ----------------------------
-- Table structure for `m_agents`
-- ----------------------------
DROP TABLE IF EXISTS `m_agents`;
CREATE TABLE `m_agents` (
  `agent_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '代理商ID',
  `agent_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代理商名称',
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `remarks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `defection_proportion` decimal(20,2) DEFAULT NULL COMMENT '反水比例/1000(千分之几)',
  `bg_login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG代理登录ID',
  `bg_pwd` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG代理登录密码',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bg_agent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代理商';

-- ----------------------------
-- Records of m_agents
-- ----------------------------
INSERT INTO `m_agents` VALUES ('1', '星河娱乐', '971083603@wqq.com', '131', '1.11', 'agdress', '123456', '1', '1', '2017-09-30 13:58:17', '1', '2017-09-30 13:58:17', '0', '20361889');
INSERT INTO `m_agents` VALUES ('2', '我自己a', '971083603@qq.com', '测试代理商', '1.11', 'agdress1', '123456', '1', '1', '2017-09-28 20:38:20', '1', '2017-09-28 20:38:20', '0', '2036190');
INSERT INTO `m_agents` VALUES ('5', '代理商测试1', '971083603@qq.com', '\n                             ', '11.11', 'agdresstest1', '123456', '1', '1', '2017-09-28 20:38:35', null, '2017-09-28 20:38:35', '0', '23687335');
INSERT INTO `m_agents` VALUES ('6', '代理商测试', '971083603@qq.com', '\n                             ', '1.11', 'agdresstest22', '123456', '1', '1', '2017-09-30 13:58:10', null, '2017-09-30 13:58:10', '0', '23708587');

-- ----------------------------
-- Table structure for `m_bank_types`
-- ----------------------------
DROP TABLE IF EXISTS `m_bank_types`;
CREATE TABLE `m_bank_types` (
  `bank_type` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '银行类型ID',
  `bank_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银行名称',
  `bank_icon` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银行图标',
  `pay_icon` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付时候显示的icon',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bank_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_pay` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`bank_type`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='银行类型';

-- ----------------------------
-- Records of m_bank_types
-- ----------------------------
INSERT INTO `m_bank_types` VALUES ('1', '农业银行', 'bank/info/nongye.png', 'bank/pay/nongye.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'ABC', '中国农业银行', '0');
INSERT INTO `m_bank_types` VALUES ('2', '工商银行', 'bank/info/gongshang.png', 'bank/pay/gongshang.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'ICBC', '中国工商银行', '0');
INSERT INTO `m_bank_types` VALUES ('3', '建设银行', 'bank/info/jianshe.png', 'bank/pay/jianshe.png', '1', '1', '2017-08-28 19:00:35', null, '2017-08-28 19:00:35', '0', 'CCB', '中国建设银行', '1');
INSERT INTO `m_bank_types` VALUES ('14', '中国银行', 'bank/info/zhongguo.png', 'bank/pay/zhongguo.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'BOC', '中国银行', '0');
INSERT INTO `m_bank_types` VALUES ('15', '浦发银行', 'bank/info/pufa.png', 'bank/pay/pufa.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'SPDB', '浦发银行', '0');
INSERT INTO `m_bank_types` VALUES ('16', '光大银行', 'bank/info/guangda.png', 'bank/pay/guangda.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'CEB', '光大银行', '0');
INSERT INTO `m_bank_types` VALUES ('17', '平安银行', 'bank/info/pingan.png', 'bank/pay/pingan.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'PINGAN', '中国平安银行', '0');
INSERT INTO `m_bank_types` VALUES ('18', '兴业银行', 'bank/info/xingye.png', 'bank/pay/xingye.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'CIB', '兴业银行', '0');
INSERT INTO `m_bank_types` VALUES ('19', '邮政储蓄', 'bank/info/youzheng.png', 'bank/pay/youzheng.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'POST', '中国邮政储蓄', '0');
INSERT INTO `m_bank_types` VALUES ('20', '华夏银行', 'bank/info/huaxia.png', 'bank/pay/huaxia.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'HXB', '华夏银行', '0');
INSERT INTO `m_bank_types` VALUES ('21', '招商银行', 'bank/info/zhaoshang.png', 'bank/pay/zhaoshang.png', '1', '1', '2017-08-28 19:00:35', null, '2017-08-28 19:00:35', '0', 'CMB', '中国招商银行', '1');
INSERT INTO `m_bank_types` VALUES ('22', '民生银行', 'bank/info/minsheng.png', 'bank/pay/minsheng.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'CMBC', '中国民生银行', '0');
INSERT INTO `m_bank_types` VALUES ('23', '北京银行', 'bank/info/beijing.png', 'bank/pay/beijing.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'BCCB', '北京银行', '0');
INSERT INTO `m_bank_types` VALUES ('24', '中信银行', 'bank/info/zhongxin.png', 'bank/pay/zhongxin.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'CITIC', '中信银行', '0');
INSERT INTO `m_bank_types` VALUES ('25', '交通银行', 'bank/info/jiaotong.png', 'bank/pay/jiaotong.png', '1', '1', '2017-08-30 10:27:09', null, '2017-08-30 10:27:09', '0', 'BOCOM', '中国交通银行', '0');

-- ----------------------------
-- Table structure for `m_items`
-- ----------------------------
DROP TABLE IF EXISTS `m_items`;
CREATE TABLE `m_items` (
  `item_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `item_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品编号',
  `item_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `item_type` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型（0：充值商品 1：普通商品）',
  `price` decimal(18,2) DEFAULT NULL COMMENT '单价',
  `period_start` timestamp NULL DEFAULT NULL COMMENT '生效时间',
  `period_end` timestamp NULL DEFAULT NULL COMMENT '有效期',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片地址',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m_items
-- ----------------------------
INSERT INTO `m_items` VALUES ('1', 'R10', '充10元', '0', '10.00', '2017-10-13 14:32:50', '2017-10-12 14:38:35', null, '1', '1', '2017-10-13 14:55:50', '1', '2017-10-13 14:55:50', '0');
INSERT INTO `m_items` VALUES ('2', 'R50', '充50元', '0', '50.00', null, null, null, '1', '1', '2017-10-13 15:01:33', '1', '2017-10-13 15:01:33', '0');
INSERT INTO `m_items` VALUES ('3', 'R100', '充100元', '0', '100.00', null, null, null, '1', '1', '2017-10-13 14:39:09', '1', '2017-10-13 14:39:09', '0');
INSERT INTO `m_items` VALUES ('4', 'R500', '充500元', '0', '500.00', null, null, null, '1', '1', '2017-10-13 14:39:11', '1', '2017-10-13 14:39:11', '0');
INSERT INTO `m_items` VALUES ('5', 'xinhe_Product30', '星河娱乐30金币', '2', '30.00', null, null, null, '1', '1', '2017-10-13 14:39:16', null, '2017-10-13 14:39:16', '0');
INSERT INTO `m_items` VALUES ('6', 'xinhe_Product68', '星河娱乐68金币', '2', '68.00', '2017-10-12 14:34:42', '2017-10-15 14:35:01', null, '1', '1', '2017-10-13 14:35:31', null, '2017-10-13 14:35:31', '0');
INSERT INTO `m_items` VALUES ('7', 'xinhe_Product118', '星河娱乐118金币', '2', '118.00', null, null, null, '1', '1', '2017-10-13 14:39:03', null, '2017-10-13 14:39:03', '0');
INSERT INTO `m_items` VALUES ('8', 'xinhe_Product518', '星河娱乐518金币', '2', '518.00', null, null, null, '1', '1', '2017-10-13 14:39:17', null, '2017-10-13 14:39:17', '0');
INSERT INTO `m_items` VALUES ('9', 'xinhe_Product998', '星河娱乐998金币', '2', '998.00', '2017-10-14 14:34:53', '2017-10-15 14:35:01', null, '1', '1', '2017-10-13 14:35:33', null, '2017-10-13 14:35:33', '0');
INSERT INTO `m_items` VALUES ('10', 'xinhe_Product4998', '星河娱乐4998金币', '2', '4998.00', '2017-10-14 14:34:57', '2017-10-15 14:35:01', null, '1', '1', '2017-10-13 14:35:33', null, '2017-10-13 14:35:33', '0');

-- ----------------------------
-- Table structure for `m_modules`
-- ----------------------------
DROP TABLE IF EXISTS `m_modules`;
CREATE TABLE `m_modules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块名称',
  `open_mode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '打开方式 空或者ajax',
  `url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '访问URL',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级节点ID',
  `module_type` int(11) NOT NULL DEFAULT '1' COMMENT '枚举（1：菜单 2：按钮）',
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标CSS',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `opened` int(11) NOT NULL DEFAULT '0' COMMENT '是否打开新窗口（1：打开 0：不打开）',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '资源状态（1：有效 0：无效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='资源模块';

-- ----------------------------
-- Records of m_modules
-- ----------------------------
INSERT INTO `m_modules` VALUES ('1', '用户管理', '0', null, '0', '1', 'look', 'fa fa-user', '0', '0', '1');
INSERT INTO `m_modules` VALUES ('2', '用户查询', '1', null, '20', '2', 'search', null, '0', '0', '1');
INSERT INTO `m_modules` VALUES ('3', '用户详情', '1', null, '20', '2', 'detail', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('4', '用户修改', '1', null, '20', '2', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('5', '账户出入金明细', '0', 'ss_ac_detail/manager', '21', '1', 'look', 'fa fa-calendar-check-o', '1', '1', '1');
INSERT INTO `m_modules` VALUES ('6', '账户出入金明细查询', '1', null, '5', '2', 'search', null, '0', '0', '1');
INSERT INTO `m_modules` VALUES ('7', '账户出入金明细审核', '1', null, '5', '2', 'examine', null, '0', '1', '0');
INSERT INTO `m_modules` VALUES ('8', '账户出金打款表', '0', 'ss_ac_detail/upmanager', '21', '1', 'look', 'fa fa-calendar-check-o', '3', '0', '1');
INSERT INTO `m_modules` VALUES ('9', '账户出金打款表查询', '1', null, '8', '2', 'search', null, '0', '0', '1');
INSERT INTO `m_modules` VALUES ('10', '账户出金打款表打款', '1', null, '8', '2', 'mademoney', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('12', '客服查询', '1', null, '23', '2', 'search', null, '0', '0', '1');
INSERT INTO `m_modules` VALUES ('13', '账号列表', '0', 'ss_user/xtmanager', '24', '1', 'look', 'fa fa-map', '0', '0', '1');
INSERT INTO `m_modules` VALUES ('14', '账号新增', '1', null, '13', '2', 'add', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('15', '账号查询', '1', null, '13', '2', 'search', null, '0', '0', '1');
INSERT INTO `m_modules` VALUES ('16', '账号修改', '1', null, '13', '2', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('17', '角色列表', '0', 'ss_role/manager', '25', '1', 'look', 'fa fa-map', '0', '0', '1');
INSERT INTO `m_modules` VALUES ('18', '角色新增', '1', null, '17', '2', 'add', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('19', '角色权限设置', '1', null, '17', '2', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('20', '用户列表', '0', 'ss_user/manager', '1', '1', 'look', 'fa fa-user', '0', '1', '1');
INSERT INTO `m_modules` VALUES ('21', '出入金管理', '0', null, '0', '1', 'look', 'fa fa-calendar-check-o', '3', '0', '1');
INSERT INTO `m_modules` VALUES ('22', '客服管理', '0', null, '0', '1', 'look', 'fa fa-user', '6', '0', '1');
INSERT INTO `m_modules` VALUES ('23', '客服列表', '0', 'ss_user/ywmanager', '22', '1', 'look', 'fa fa-user', '0', '1', '1');
INSERT INTO `m_modules` VALUES ('24', '账号管理', '0', null, '0', '1', 'look', 'fa fa-map', '7', '0', '1');
INSERT INTO `m_modules` VALUES ('25', '角色管理', '0', null, '0', '1', 'look', 'fa fa-map', '8', '1', '1');
INSERT INTO `m_modules` VALUES ('26', '角色查询', '1', null, '17', '2', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('27', '代理商管理', '0', null, '0', '1', 'look', 'fa fa-user', '4', '0', '1');
INSERT INTO `m_modules` VALUES ('28', '代理商列表', '0', 'ss_agent/dataGrid', '27', '1', 'look', 'fa fa-user', '0', '1', '1');
INSERT INTO `m_modules` VALUES ('29', '游戏管理', '0', null, '0', '1', 'look', 'fa fa-user', '2', '0', '1');
INSERT INTO `m_modules` VALUES ('30', '游戏记录查询', '0', 'ss_games/dataGrid', '29', '1', 'look', 'fa fa-user', '0', '1', '1');
INSERT INTO `m_modules` VALUES ('31', '客服新增', '1', null, '23', '1', 'add', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('32', '客服修改', '1', null, '23', '1', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('33', '代理商新增', '1', null, '28', '1', 'add', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('34', '代理商修改', '1', null, '28', '1', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('35', '代理商查询', '1', null, '28', '1', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('36', '游戏查询', '1', null, '30', '1', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('37', '审核管理', '0', null, '0', '1', 'look', 'fa fa-calendar-check-o', '5', '0', '0');
INSERT INTO `m_modules` VALUES ('38', '出金审核列表', '9', 'audit/withdrawal', '21', '1', 'look', 'fa fa-map', '2', '1', '1');
INSERT INTO `m_modules` VALUES ('39', '出金审核查询', '1', null, '38', '1', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('40', '出金审核', '1', null, '38', '1', 'examine', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('41', '消息管理', '0', '', '0', '1', 'look', 'fa fa-calendar-check-o', '9', '0', '1');
INSERT INTO `m_modules` VALUES ('42', '消息列表', '0', 'message/dataGrid', '41', '1', 'look', 'fa fa-calendar-check-o', '0', '0', '1');
INSERT INTO `m_modules` VALUES ('43', '消息查询', '1', null, '42', '1', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('44', '消息更新', '1', null, '42', '1', 'update', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('45', '用户充值', '1', null, '20', '1', 'recharge', null, '0', '1', '1');

-- ----------------------------
-- Table structure for `m_role_modules`
-- ----------------------------
DROP TABLE IF EXISTS `m_role_modules`;
CREATE TABLE `m_role_modules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `module_id` bigint(20) NOT NULL COMMENT '模块ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限';

-- ----------------------------
-- Records of m_role_modules
-- ----------------------------
INSERT INTO `m_role_modules` VALUES ('1', '1', '1');
INSERT INTO `m_role_modules` VALUES ('2', '1', '2');
INSERT INTO `m_role_modules` VALUES ('3', '1', '3');
INSERT INTO `m_role_modules` VALUES ('4', '1', '4');
INSERT INTO `m_role_modules` VALUES ('5', '1', '5');
INSERT INTO `m_role_modules` VALUES ('6', '1', '6');
INSERT INTO `m_role_modules` VALUES ('7', '1', '7');
INSERT INTO `m_role_modules` VALUES ('8', '1', '8');
INSERT INTO `m_role_modules` VALUES ('9', '1', '9');
INSERT INTO `m_role_modules` VALUES ('10', '1', '10');
INSERT INTO `m_role_modules` VALUES ('11', '1', '11');
INSERT INTO `m_role_modules` VALUES ('12', '1', '12');
INSERT INTO `m_role_modules` VALUES ('13', '1', '13');
INSERT INTO `m_role_modules` VALUES ('14', '1', '14');
INSERT INTO `m_role_modules` VALUES ('15', '1', '15');
INSERT INTO `m_role_modules` VALUES ('16', '1', '16');
INSERT INTO `m_role_modules` VALUES ('17', '1', '17');
INSERT INTO `m_role_modules` VALUES ('18', '1', '18');
INSERT INTO `m_role_modules` VALUES ('19', '1', '19');
INSERT INTO `m_role_modules` VALUES ('20', '1', '20');
INSERT INTO `m_role_modules` VALUES ('21', '1', '21');
INSERT INTO `m_role_modules` VALUES ('23', '1', '23');
INSERT INTO `m_role_modules` VALUES ('24', '1', '24');
INSERT INTO `m_role_modules` VALUES ('25', '1', '25');
INSERT INTO `m_role_modules` VALUES ('30', '1', '26');
INSERT INTO `m_role_modules` VALUES ('31', '1', '22');
INSERT INTO `m_role_modules` VALUES ('33', '7', '1');
INSERT INTO `m_role_modules` VALUES ('34', '7', '20');
INSERT INTO `m_role_modules` VALUES ('35', '7', '2');
INSERT INTO `m_role_modules` VALUES ('36', '7', '11');
INSERT INTO `m_role_modules` VALUES ('37', '7', '23');
INSERT INTO `m_role_modules` VALUES ('38', '7', '12');
INSERT INTO `m_role_modules` VALUES ('39', '7', '21');
INSERT INTO `m_role_modules` VALUES ('40', '7', '5');
INSERT INTO `m_role_modules` VALUES ('41', '7', '6');
INSERT INTO `m_role_modules` VALUES ('42', '7', '8');
INSERT INTO `m_role_modules` VALUES ('43', '7', '9');
INSERT INTO `m_role_modules` VALUES ('44', '7', '24');
INSERT INTO `m_role_modules` VALUES ('45', '7', '13');
INSERT INTO `m_role_modules` VALUES ('46', '7', '15');
INSERT INTO `m_role_modules` VALUES ('47', '7', '25');
INSERT INTO `m_role_modules` VALUES ('48', '7', '17');
INSERT INTO `m_role_modules` VALUES ('79', '1', '27');
INSERT INTO `m_role_modules` VALUES ('80', '1', '28');
INSERT INTO `m_role_modules` VALUES ('81', '1', '29');
INSERT INTO `m_role_modules` VALUES ('82', '1', '30');
INSERT INTO `m_role_modules` VALUES ('83', '1', '31');
INSERT INTO `m_role_modules` VALUES ('84', '1', '32');
INSERT INTO `m_role_modules` VALUES ('85', '1', '33');
INSERT INTO `m_role_modules` VALUES ('86', '1', '34');
INSERT INTO `m_role_modules` VALUES ('128', '1', '35');
INSERT INTO `m_role_modules` VALUES ('129', '1', '36');
INSERT INTO `m_role_modules` VALUES ('130', '5', '1');
INSERT INTO `m_role_modules` VALUES ('131', '5', '20');
INSERT INTO `m_role_modules` VALUES ('132', '5', '2');
INSERT INTO `m_role_modules` VALUES ('133', '5', '11');
INSERT INTO `m_role_modules` VALUES ('134', '5', '23');
INSERT INTO `m_role_modules` VALUES ('135', '5', '12');
INSERT INTO `m_role_modules` VALUES ('136', '5', '27');
INSERT INTO `m_role_modules` VALUES ('137', '5', '28');
INSERT INTO `m_role_modules` VALUES ('138', '5', '35');
INSERT INTO `m_role_modules` VALUES ('139', '5', '29');
INSERT INTO `m_role_modules` VALUES ('140', '5', '30');
INSERT INTO `m_role_modules` VALUES ('141', '5', '36');
INSERT INTO `m_role_modules` VALUES ('142', '5', '21');
INSERT INTO `m_role_modules` VALUES ('143', '5', '5');
INSERT INTO `m_role_modules` VALUES ('144', '5', '6');
INSERT INTO `m_role_modules` VALUES ('145', '5', '8');
INSERT INTO `m_role_modules` VALUES ('146', '5', '9');
INSERT INTO `m_role_modules` VALUES ('147', '5', '24');
INSERT INTO `m_role_modules` VALUES ('148', '5', '13');
INSERT INTO `m_role_modules` VALUES ('149', '5', '15');
INSERT INTO `m_role_modules` VALUES ('150', '5', '25');
INSERT INTO `m_role_modules` VALUES ('151', '5', '17');
INSERT INTO `m_role_modules` VALUES ('152', '5', '18');
INSERT INTO `m_role_modules` VALUES ('153', '1', '37');
INSERT INTO `m_role_modules` VALUES ('154', '1', '38');
INSERT INTO `m_role_modules` VALUES ('159', '1', '39');
INSERT INTO `m_role_modules` VALUES ('160', '1', '40');
INSERT INTO `m_role_modules` VALUES ('189', '1', '41');
INSERT INTO `m_role_modules` VALUES ('190', '1', '42');
INSERT INTO `m_role_modules` VALUES ('191', '1', '43');
INSERT INTO `m_role_modules` VALUES ('212', '4', '21');
INSERT INTO `m_role_modules` VALUES ('213', '4', '5');
INSERT INTO `m_role_modules` VALUES ('214', '4', '6');
INSERT INTO `m_role_modules` VALUES ('215', '4', '8');
INSERT INTO `m_role_modules` VALUES ('216', '4', '9');
INSERT INTO `m_role_modules` VALUES ('217', '4', '10');
INSERT INTO `m_role_modules` VALUES ('218', '4', '37');
INSERT INTO `m_role_modules` VALUES ('219', '4', '38');
INSERT INTO `m_role_modules` VALUES ('220', '4', '39');
INSERT INTO `m_role_modules` VALUES ('221', '4', '40');
INSERT INTO `m_role_modules` VALUES ('222', '4', '41');
INSERT INTO `m_role_modules` VALUES ('223', '4', '42');
INSERT INTO `m_role_modules` VALUES ('224', '4', '43');
INSERT INTO `m_role_modules` VALUES ('225', '1', '44');
INSERT INTO `m_role_modules` VALUES ('227', '4', '44');
INSERT INTO `m_role_modules` VALUES ('249', '1', '45');
INSERT INTO `m_role_modules` VALUES ('274', '3', '1');
INSERT INTO `m_role_modules` VALUES ('275', '3', '20');
INSERT INTO `m_role_modules` VALUES ('276', '3', '2');
INSERT INTO `m_role_modules` VALUES ('277', '3', '3');
INSERT INTO `m_role_modules` VALUES ('278', '3', '4');
INSERT INTO `m_role_modules` VALUES ('279', '3', '45');
INSERT INTO `m_role_modules` VALUES ('280', '3', '21');
INSERT INTO `m_role_modules` VALUES ('281', '3', '5');
INSERT INTO `m_role_modules` VALUES ('282', '3', '6');
INSERT INTO `m_role_modules` VALUES ('283', '3', '8');
INSERT INTO `m_role_modules` VALUES ('284', '3', '9');
INSERT INTO `m_role_modules` VALUES ('285', '3', '38');
INSERT INTO `m_role_modules` VALUES ('286', '3', '39');
INSERT INTO `m_role_modules` VALUES ('287', '3', '40');
INSERT INTO `m_role_modules` VALUES ('288', '3', '22');
INSERT INTO `m_role_modules` VALUES ('289', '3', '23');
INSERT INTO `m_role_modules` VALUES ('290', '3', '12');
INSERT INTO `m_role_modules` VALUES ('291', '3', '24');
INSERT INTO `m_role_modules` VALUES ('292', '3', '13');
INSERT INTO `m_role_modules` VALUES ('293', '3', '25');
INSERT INTO `m_role_modules` VALUES ('294', '3', '17');
INSERT INTO `m_role_modules` VALUES ('295', '3', '41');
INSERT INTO `m_role_modules` VALUES ('296', '3', '42');
INSERT INTO `m_role_modules` VALUES ('297', '3', '43');
INSERT INTO `m_role_modules` VALUES ('298', '3', '44');

-- ----------------------------
-- Table structure for `m_roles`
-- ----------------------------
DROP TABLE IF EXISTS `m_roles`;
CREATE TABLE `m_roles` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名',
  `version_no` bigint(20) DEFAULT '0',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';

-- ----------------------------
-- Records of m_roles
-- ----------------------------
INSERT INTO `m_roles` VALUES ('1', '超级管理员', null, '1', '2017-08-11 18:28:02', '1', '2017-08-11 18:28:09', '0');
INSERT INTO `m_roles` VALUES ('2', '系统运营账户', null, '1', '2017-09-30 17:13:40', '1', '2017-09-30 17:13:40', '1');
INSERT INTO `m_roles` VALUES ('3', '客服员', null, '1', '2017-09-20 16:48:22', '1', '2017-09-20 16:48:22', '0');
INSERT INTO `m_roles` VALUES ('4', '财务', null, '1', '2017-08-28 14:12:49', '1', '2017-08-28 14:12:49', '0');
INSERT INTO `m_roles` VALUES ('5', '代理商', null, '1', '2017-09-20 16:48:40', '1', '2017-09-20 16:48:40', '0');
INSERT INTO `m_roles` VALUES ('7', '查阅者', '0', '1', '2017-09-30 17:13:41', '1', '2017-09-30 17:13:41', '1');

-- ----------------------------
-- Table structure for `t_audit_logs`
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_logs`;
CREATE TABLE `t_audit_logs` (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '审核记录ID',
  `trade_id` bigint(20) NOT NULL COMMENT '交易记录ID',
  `temp_id` bigint(20) NOT NULL COMMENT '审核模板关联ID',
  `flow_id` bigint(11) NOT NULL COMMENT '审核步骤关联ID',
  `remarks` varchar(500) DEFAULT NULL COMMENT '审核备注',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_logs
-- ----------------------------
INSERT INTO `t_audit_logs` VALUES ('8', '11', '1', '1', '出金审核不通过', '1', '17000011', '2017-09-04 21:53:22', '17000011', '2017-09-04 21:53:22', '0');
INSERT INTO `t_audit_logs` VALUES ('9', '10', '1', '1', '出金审核通过', '1', '17000011', '2017-09-04 21:53:35', '17000011', '2017-09-04 21:53:35', '0');
INSERT INTO `t_audit_logs` VALUES ('10', '10', '1', '2', '出金审核不通过', '1', '1', '2017-09-04 21:56:00', '1', '2017-09-04 21:56:00', '0');
INSERT INTO `t_audit_logs` VALUES ('11', '28', '1', '1', '出金审核通过', '1', '17000011', '2017-09-04 21:56:26', '17000011', '2017-09-04 21:56:26', '0');
INSERT INTO `t_audit_logs` VALUES ('12', '28', '1', '2', '出金审核通过', '1', '1', '2017-09-04 21:56:57', '1', '2017-09-04 21:56:57', '0');
INSERT INTO `t_audit_logs` VALUES ('13', '28', '1', '1', '出金审核通过', '1', '4', '2017-09-25 11:30:18', '4', '2017-09-25 11:30:18', '0');
INSERT INTO `t_audit_logs` VALUES ('14', '28', '1', '1', 'sssss', '1', '4', '2017-09-25 15:45:16', '4', '2017-09-25 15:45:16', '0');
INSERT INTO `t_audit_logs` VALUES ('15', '28', '1', '1', '出金审核通过', '1', '4', '2017-09-25 15:47:17', '4', '2017-09-25 15:47:17', '0');
INSERT INTO `t_audit_logs` VALUES ('16', '28', '1', '2', '出金审核通过', '1', '17000022', '2017-09-25 15:48:10', '17000022', '2017-09-25 15:48:10', '0');
INSERT INTO `t_audit_logs` VALUES ('17', '28', '1', '1', '出金审核通过', '1', '4', '2017-09-25 16:04:51', '4', '2017-09-25 16:04:51', '0');
INSERT INTO `t_audit_logs` VALUES ('18', '28', '1', '2', '出金审核通过', '1', '17000022', '2017-09-25 16:05:14', '17000022', '2017-09-25 16:05:14', '0');
INSERT INTO `t_audit_logs` VALUES ('19', '28', '1', '2', '出金审核通过', '1', '17000022', '2017-09-25 16:07:52', '17000022', '2017-09-25 16:07:52', '0');
INSERT INTO `t_audit_logs` VALUES ('20', '15', '1', '1', '出金审核通过', '1', '4', '2017-09-25 17:58:28', '4', '2017-09-25 17:58:28', '0');
INSERT INTO `t_audit_logs` VALUES ('21', '15', '1', '2', '出金审核通过', '1', '17000022', '2017-09-25 17:58:51', '17000022', '2017-09-25 17:58:51', '0');
INSERT INTO `t_audit_logs` VALUES ('22', '15', '1', '1', '出金审核通过', '1', '4', '2017-09-28 12:07:19', '4', '2017-09-28 12:07:19', '0');
INSERT INTO `t_audit_logs` VALUES ('23', '15', '1', '1', '出金审核通过', '1', '4', '2017-09-28 12:57:15', '4', '2017-09-28 12:57:15', '0');
INSERT INTO `t_audit_logs` VALUES ('24', '14', '1', '1', '出金审核通过', '1', '4', '2017-09-28 13:18:32', '4', '2017-09-28 13:18:32', '0');
INSERT INTO `t_audit_logs` VALUES ('25', '10', '1', '1', '出金审核通过', '1', '4', '2017-09-28 13:20:35', '4', '2017-09-28 13:20:35', '0');
INSERT INTO `t_audit_logs` VALUES ('26', '10', '1', '1', '测试审核通过', '1', '4', '2017-09-28 13:21:38', '4', '2017-09-28 13:21:38', '0');
INSERT INTO `t_audit_logs` VALUES ('27', '15', '1', '1', '测试审核不通过', '1', '4', '2017-09-28 13:22:07', '4', '2017-09-28 13:22:07', '0');
INSERT INTO `t_audit_logs` VALUES ('28', '14', '1', '1', '测试审核通过', '1', '4', '2017-09-28 13:22:46', '4', '2017-09-28 13:22:46', '0');
INSERT INTO `t_audit_logs` VALUES ('29', '14', '1', '2', '财务审核通过', '1', '17000022', '2017-09-28 13:41:20', '17000022', '2017-09-28 13:41:20', '0');
INSERT INTO `t_audit_logs` VALUES ('30', '10', '1', '2', '财务审核不通过', '1', '17000022', '2017-09-28 13:41:52', '17000022', '2017-09-28 13:41:52', '0');
INSERT INTO `t_audit_logs` VALUES ('31', '14', '1', '2', '财务审核不通过', '1', '17000022', '2017-09-28 13:45:45', '17000022', '2017-09-28 13:45:45', '0');
INSERT INTO `t_audit_logs` VALUES ('32', '10', '1', '2', '财务审核不通过', '1', '17000022', '2017-09-28 13:47:02', '17000022', '2017-09-28 13:47:02', '0');
INSERT INTO `t_audit_logs` VALUES ('33', '28', '1', '1', '客服审核通过', '1', '4', '2017-09-28 13:49:58', '4', '2017-09-28 13:49:58', '0');
INSERT INTO `t_audit_logs` VALUES ('34', '28', '1', '2', '财务审核通过', '1', '17000022', '2017-09-28 13:50:38', '17000022', '2017-09-28 13:50:38', '0');
INSERT INTO `t_audit_logs` VALUES ('35', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 13:54:05', '4', '2017-09-28 13:54:05', '0');
INSERT INTO `t_audit_logs` VALUES ('36', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 13:56:03', '4', '2017-09-28 13:56:03', '0');
INSERT INTO `t_audit_logs` VALUES ('37', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 13:59:57', '4', '2017-09-28 13:59:57', '0');
INSERT INTO `t_audit_logs` VALUES ('38', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 14:01:08', '4', '2017-09-28 14:01:08', '0');
INSERT INTO `t_audit_logs` VALUES ('39', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 14:10:14', '4', '2017-09-28 14:10:14', '0');
INSERT INTO `t_audit_logs` VALUES ('40', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-28 14:35:36', '4', '2017-09-28 14:35:36', '0');
INSERT INTO `t_audit_logs` VALUES ('41', '11', '1', '1', '测试客服审核通过', '1', '4', '2017-09-28 17:32:36', '4', '2017-09-28 17:32:36', '0');
INSERT INTO `t_audit_logs` VALUES ('42', '11', '1', '1', '出金审核通过', '1', '4', '2017-09-29 12:13:35', '4', '2017-09-29 12:13:35', '0');
INSERT INTO `t_audit_logs` VALUES ('43', '11', '1', '2', '出金审核通过', '1', '17000022', '2017-09-29 13:35:00', '17000022', '2017-09-29 13:35:00', '0');
INSERT INTO `t_audit_logs` VALUES ('44', '10', '1', '1', '出金审核通过', '1', '4', '2017-09-29 14:41:02', '4', '2017-09-29 14:41:02', '0');
INSERT INTO `t_audit_logs` VALUES ('45', '14', '1', '1', '出金审核通过', '1', '4', '2017-09-29 14:50:45', '4', '2017-09-29 14:50:45', '0');
INSERT INTO `t_audit_logs` VALUES ('46', '28', '1', '1', '出金审核通过', '1', '4', '2017-09-30 17:18:50', '4', '2017-09-30 17:18:50', '0');
INSERT INTO `t_audit_logs` VALUES ('47', '13', '1', '1', '测试不通过', '1', '4', '2017-09-30 17:19:30', '4', '2017-09-30 17:19:30', '0');
INSERT INTO `t_audit_logs` VALUES ('48', '12', '1', '1', '测试数据 ', '1', '4', '2017-09-30 17:20:46', '4', '2017-09-30 17:20:46', '0');
INSERT INTO `t_audit_logs` VALUES ('49', '14', '1', '1', '测试数据', '1', '4', '2017-09-30 17:22:19', '4', '2017-09-30 17:22:19', '0');
INSERT INTO `t_audit_logs` VALUES ('50', '10', '1', '1', '测试数据', '1', '4', '2017-09-30 17:25:49', '4', '2017-09-30 17:25:49', '0');
INSERT INTO `t_audit_logs` VALUES ('51', '11', '1', '1', '测试数据', '1', '4', '2017-09-30 17:26:48', '4', '2017-09-30 17:26:48', '0');
INSERT INTO `t_audit_logs` VALUES ('52', '15', '1', '1', '出金审核通过', '1', '4', '2017-09-30 17:27:26', '4', '2017-09-30 17:27:26', '0');
INSERT INTO `t_audit_logs` VALUES ('53', '15', '1', '2', '出金审核通过', '1', '17000022', '2017-09-30 17:28:20', '17000022', '2017-09-30 17:28:20', '0');
INSERT INTO `t_audit_logs` VALUES ('54', '10', '1', '2', '出金审核通过', '1', '17000022', '2017-09-30 17:28:31', '17000022', '2017-09-30 17:28:31', '0');
INSERT INTO `t_audit_logs` VALUES ('55', '28', '1', '2', '财务审核不通过', '1', '17000022', '2017-09-30 17:28:46', '17000022', '2017-09-30 17:28:46', '0');

-- ----------------------------
-- Table structure for `t_audit_template`
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_template`;
CREATE TABLE `t_audit_template` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `temp_name` varchar(100) NOT NULL COMMENT '审核模板名称',
  `remarks` varchar(100) DEFAULT NULL COMMENT '模板备注',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`temp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_template
-- ----------------------------
INSERT INTO `t_audit_template` VALUES ('1', '出金记录审核', '出金记录审核', '1', '1', '2017-09-04 22:01:11', '1', '2017-09-04 22:01:11', '0');

-- ----------------------------
-- Table structure for `t_audit_template_step`
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_template_step`;
CREATE TABLE `t_audit_template_step` (
  `flow_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '审核步骤ID',
  `temp_id` bigint(20) NOT NULL COMMENT '审核模板关联ID',
  `step` int(11) NOT NULL DEFAULT '1' COMMENT '审核步骤',
  `role_id` bigint(20) NOT NULL COMMENT '审核角色ID',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_template_step
-- ----------------------------
INSERT INTO `t_audit_template_step` VALUES ('1', '1', '1', '1', '1', '1', '2017-10-16 16:25:23', '1', '2017-10-16 16:25:23', '0');

-- ----------------------------
-- Table structure for `t_games`
-- ----------------------------
DROP TABLE IF EXISTS `t_games`;
CREATE TABLE `t_games` (
  `only_id` int(11) NOT NULL AUTO_INCREMENT,
  `games_id` varchar(200) DEFAULT NULL,
  `accounts` varchar(200) DEFAULT NULL,
  `server_id` varchar(255) DEFAULT NULL,
  `kind_id` varchar(255) DEFAULT NULL,
  `table_id` varchar(255) DEFAULT NULL,
  `chair_id` varchar(255) DEFAULT NULL,
  `user_count` varchar(255) DEFAULT NULL,
  `card_value` varchar(255) DEFAULT NULL,
  `cell_score` varchar(255) DEFAULT NULL,
  `all_bet` varchar(255) DEFAULT NULL,
  `profit` varchar(255) DEFAULT NULL,
  `revenue` varchar(255) DEFAULT NULL,
  `game_start_time` datetime DEFAULT NULL,
  `game_end_time` datetime DEFAULT NULL,
  `channel_id` varchar(255) DEFAULT NULL,
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`only_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_games
-- ----------------------------

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_type` int(11) DEFAULT NULL COMMENT '通知类型',
  `icon` varchar(255) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL COMMENT '订单ID-关联t_user_account_detail',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('12', '50', 'fa fa-user text-red', '199', '1', '17000030', '2017-10-13 15:28:42', '17000030', '2017-10-13 15:28:42', '0');
INSERT INTO `t_message` VALUES ('13', '50', 'fa fa-user text-red', '200', '1', '17000030', '2017-10-13 15:29:51', '17000030', '2017-10-13 15:29:51', '0');

-- ----------------------------
-- Table structure for `t_message_content`
-- ----------------------------
DROP TABLE IF EXISTS `t_message_content`;
CREATE TABLE `t_message_content` (
  `message_content_id` int(11) NOT NULL AUTO_INCREMENT,
  `trade_id` int(11) DEFAULT NULL COMMENT ' 订单ID',
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(20) DEFAULT NULL COMMENT '用户ID-关联t_users',
  `content` varchar(200) DEFAULT NULL COMMENT '提醒内容',
  `status` int(11) DEFAULT '0' COMMENT '处理状态：0-（默认）未处理，1-已处理',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`message_content_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_content
-- ----------------------------
INSERT INTO `t_message_content` VALUES ('38', '199', '3', '4', '你有一笔新的提现审核，编号：W150787972181822026。', '0', '1', '17000030', '2017-10-13 15:28:42', '17000030', '2017-10-13 15:28:42', '0');
INSERT INTO `t_message_content` VALUES ('39', '200', '3', '4', '你有一笔新的提现审核，编号：W150787979137194000。', '0', '1', '17000030', '2017-10-13 15:29:51', '17000030', '2017-10-13 15:29:51', '0');

-- ----------------------------
-- Table structure for `t_payment_records`
-- ----------------------------
DROP TABLE IF EXISTS `t_payment_records`;
CREATE TABLE `t_payment_records` (
  `pay_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '支付记录ID',
  `user_id` bigint(20) NOT NULL COMMENT '支付用户ID',
  `pay_target` int(255) NOT NULL DEFAULT '0' COMMENT '支付来源（0：充值支付 1：订单支付）',
  `order_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易订单号（支付来源是充值时存充值单号，需要传给微信，支付宝的商家订单号）',
  `pay_amount` decimal(18,2) NOT NULL COMMENT '需支付金额',
  `pay_status` int(11) NOT NULL DEFAULT '0' COMMENT '支付状态（0：未支付 1：支付中 2：支付成功 3：支付失败 4：已取消）',
  `trade_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付单号（微信或支付返回）',
  `pay_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '实际支付完成时间',
  `pay_message` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '新宝支付返回的支付消息',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payment_records
-- ----------------------------
INSERT INTO `t_payment_records` VALUES ('364', '17000030', '0', 'R150813999231459350', '50.00', '1', null, null, null, '1', '17000030', '2017-10-16 15:46:32', '17000030', '2017-10-16 15:46:32', '0');
INSERT INTO `t_payment_records` VALUES ('365', '17000030', '0', 'R150814050398224232', '50.00', '1', null, null, null, '1', '17000030', '2017-10-16 15:55:04', '17000030', '2017-10-16 15:55:04', '0');
INSERT INTO `t_payment_records` VALUES ('366', '17000030', '0', 'R150814050803166452', '50.00', '1', null, null, null, '1', '17000030', '2017-10-16 15:55:08', '17000030', '2017-10-16 15:55:08', '0');
INSERT INTO `t_payment_records` VALUES ('367', '17000030', '0', 'R150814051523992217', '50.00', '1', null, null, null, '1', '17000030', '2017-10-16 15:55:15', '17000030', '2017-10-16 15:55:15', '0');
INSERT INTO `t_payment_records` VALUES ('368', '17000033', '0', 'R150820457149752345', '50.00', '1', null, null, null, '1', '17000033', '2017-10-17 09:42:52', '17000033', '2017-10-17 09:42:52', '0');
INSERT INTO `t_payment_records` VALUES ('369', '17000030', '0', 'R150820855628011979', '50.00', '1', null, null, null, '1', '17000030', '2017-10-17 10:49:16', '17000030', '2017-10-17 10:49:16', '0');
INSERT INTO `t_payment_records` VALUES ('370', '17000030', '0', 'R150820922965517611', '50.00', '1', null, null, null, '1', '17000030', '2017-10-17 11:00:30', '17000030', '2017-10-17 11:00:30', '0');
INSERT INTO `t_payment_records` VALUES ('371', '17000030', '0', 'R150820926557460182', '50.00', '1', null, null, null, '1', '17000030', '2017-10-17 11:01:06', '17000030', '2017-10-17 11:01:06', '0');
INSERT INTO `t_payment_records` VALUES ('372', '17000030', '0', 'R150820946165152905', '50.00', '1', null, null, null, '1', '17000030', '2017-10-17 11:04:22', '17000030', '2017-10-17 11:04:22', '0');
INSERT INTO `t_payment_records` VALUES ('373', '17000033', '0', 'R150820966904245663', '100.00', '1', null, null, null, '1', '17000033', '2017-10-17 11:07:49', '17000033', '2017-10-17 11:07:49', '0');
INSERT INTO `t_payment_records` VALUES ('374', '17000033', '0', 'R150820968699362517', '50.00', '1', null, null, null, '1', '17000033', '2017-10-17 11:08:07', '17000033', '2017-10-17 11:08:07', '0');

-- ----------------------------
-- Table structure for `t_payments`
-- ----------------------------
DROP TABLE IF EXISTS `t_payments`;
CREATE TABLE `t_payments` (
  `payment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `payment_mode` int(11) NOT NULL DEFAULT '0' COMMENT '支付方式（1：网银支付 2：微信扫码 3：支付宝扫码 5：支付宝WAP 6：QQ扫码 7:QQ WAP）',
  `card_id` bigint(20) DEFAULT NULL COMMENT '银行卡ID',
  `amount_paid` decimal(18,2) DEFAULT NULL COMMENT '实际支付金额',
  `payment_status` int(11) NOT NULL DEFAULT '0' COMMENT '支付状态（0：未支付 1：支付中 2：支付成功 3：支付失败 4：已取消）',
  `payment_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付单号（微信或支付返回）',
  `pay_id` bigint(20) NOT NULL DEFAULT '0',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payments
-- ----------------------------
INSERT INTO `t_payments` VALUES ('305', '7', '0', '50.00', '1', null, '364', '1', '17000030', '2017-10-16 15:46:32', '17000030', '2017-10-16 15:46:32', '0');
INSERT INTO `t_payments` VALUES ('306', '7', '0', '50.00', '1', null, '365', '1', '17000030', '2017-10-16 15:55:04', '17000030', '2017-10-16 15:55:04', '0');
INSERT INTO `t_payments` VALUES ('307', '5', '0', '50.00', '1', null, '366', '1', '17000030', '2017-10-16 15:55:08', '17000030', '2017-10-16 15:55:08', '0');
INSERT INTO `t_payments` VALUES ('308', '2', '0', '50.00', '1', null, '367', '1', '17000030', '2017-10-16 15:55:15', '17000030', '2017-10-16 15:55:15', '0');
INSERT INTO `t_payments` VALUES ('309', '7', '0', '50.00', '1', null, '368', '1', '17000033', '2017-10-17 09:42:52', '17000033', '2017-10-17 09:42:52', '0');
INSERT INTO `t_payments` VALUES ('310', '7', '0', '50.00', '1', null, '369', '1', '17000030', '2017-10-17 10:49:16', '17000030', '2017-10-17 10:49:16', '0');
INSERT INTO `t_payments` VALUES ('311', '3', '0', '50.00', '1', null, '370', '1', '17000030', '2017-10-17 11:00:30', '17000030', '2017-10-17 11:00:30', '0');
INSERT INTO `t_payments` VALUES ('312', '7', '0', '50.00', '1', null, '371', '1', '17000030', '2017-10-17 11:01:06', '17000030', '2017-10-17 11:01:06', '0');
INSERT INTO `t_payments` VALUES ('313', '7', '0', '50.00', '1', null, '372', '1', '17000030', '2017-10-17 11:04:22', '17000030', '2017-10-17 11:04:22', '0');
INSERT INTO `t_payments` VALUES ('314', '3', '0', '100.00', '1', null, '373', '1', '17000033', '2017-10-17 11:07:49', '17000033', '2017-10-17 11:07:49', '0');
INSERT INTO `t_payments` VALUES ('315', '3', '0', '50.00', '1', null, '374', '1', '17000033', '2017-10-17 11:08:07', '17000033', '2017-10-17 11:08:07', '0');

-- ----------------------------
-- Table structure for `t_recharges`
-- ----------------------------
DROP TABLE IF EXISTS `t_recharges`;
CREATE TABLE `t_recharges` (
  `recharge_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `recharge_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '充值唯一单号（生成规则 R+yyyyMMddHHmmss+4位随机数）',
  `recharge_status` int(11) NOT NULL DEFAULT '0' COMMENT '充值状态\r\n（0：未支付 1：充值成功 2：充值失败）',
  `recharge_amount` decimal(18,2) NOT NULL COMMENT '充值金额',
  `summery` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '充值商品描述',
  `item_id` bigint(255) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `iap_receipt` text CHARACTER SET utf8 COMMENT '苹果支付凭证',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';

-- ----------------------------
-- Records of t_recharges
-- ----------------------------
INSERT INTO `t_recharges` VALUES ('312', '17000030', 'R150813999231459350', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-16 15:46:32', '17000030', '2017-10-16 15:46:32', '0');
INSERT INTO `t_recharges` VALUES ('313', '17000030', 'R150814050398224232', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-16 15:55:04', '17000030', '2017-10-16 15:55:04', '0');
INSERT INTO `t_recharges` VALUES ('314', '17000030', 'R150814050803166452', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-16 15:55:08', '17000030', '2017-10-16 15:55:08', '0');
INSERT INTO `t_recharges` VALUES ('315', '17000030', 'R150814051523992217', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-16 15:55:15', '17000030', '2017-10-16 15:55:15', '0');
INSERT INTO `t_recharges` VALUES ('316', '17000030', 'R150814164217351023', '1', '100.00', '测试', '0', null, '1', '1', '2017-10-16 16:14:02', '1', '2017-10-16 16:14:02', '0');
INSERT INTO `t_recharges` VALUES ('317', '17000033', 'R150820457149752345', '0', '50.00', null, '0', null, '1', '17000033', '2017-10-17 09:42:51', '17000033', '2017-10-17 09:42:51', '0');
INSERT INTO `t_recharges` VALUES ('318', '17000030', 'R150820855628011979', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-17 10:49:16', '17000030', '2017-10-17 10:49:16', '0');
INSERT INTO `t_recharges` VALUES ('319', '17000030', 'R150820922965517611', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-17 11:00:30', '17000030', '2017-10-17 11:00:30', '0');
INSERT INTO `t_recharges` VALUES ('320', '17000030', 'R150820926557460182', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-17 11:01:06', '17000030', '2017-10-17 11:01:06', '0');
INSERT INTO `t_recharges` VALUES ('321', '17000030', 'R150820946165152905', '0', '50.00', null, '0', null, '1', '17000030', '2017-10-17 11:04:22', '17000030', '2017-10-17 11:04:22', '0');
INSERT INTO `t_recharges` VALUES ('322', '17000033', 'R150820966904245663', '0', '100.00', null, '0', null, '1', '17000033', '2017-10-17 11:07:49', '17000033', '2017-10-17 11:07:49', '0');
INSERT INTO `t_recharges` VALUES ('323', '17000033', 'R150820968699362517', '0', '50.00', null, '0', null, '1', '17000033', '2017-10-17 11:08:07', '17000033', '2017-10-17 11:08:07', '0');

-- ----------------------------
-- Table structure for `t_user_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account`;
CREATE TABLE `t_user_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `actype` int(11) NOT NULL DEFAULT '1' COMMENT '账户类型 0：试玩账号 1：真钱账号',
  `currency` int(11) NOT NULL DEFAULT '0' COMMENT '币种类型 \r\n0：CNY 人民币\r\n1：KRW 韩元\r\n2：MYR 马来西亚币 \r\n3：USD 美元\r\n4：JPY 日元\r\n5：THB 泰铢\r\n6：BTC 比特币\r\n7：IDR 印尼盾\r\n8：VND 越南盾\r\n9：EUR 欧元\r\n10：INR 印度卢比',
  `balance` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '账户余额',
  `total_recharge` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '充值总额',
  `total_withdraw` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '提现总额',
  `total_lottery` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '转码总量(玩家下注总金额)',
  `total_income` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '收入总额（赢',
  `total_expend` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '支出总额（亏）',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('1', '17000001', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '145', '17000001', '2017-10-13 15:09:46', '17000001', '2017-10-13 15:09:46', '0');
INSERT INTO `t_user_account` VALUES ('22', '17000030', '1', '0', '400.00', '100.00', '10.00', '0.00', '0.00', '0.00', '20', '17000030', '2017-10-13 15:29:45', '17000030', '2017-10-17 11:04:22', '0');
INSERT INTO `t_user_account` VALUES ('23', '17000033', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '70', '17000033', '2017-10-16 14:09:20', '17000033', '2017-10-17 11:08:07', '0');

-- ----------------------------
-- Table structure for `t_user_account_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account_detail`;
CREATE TABLE `t_user_account_detail` (
  `trade_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '交易明细ID',
  `account_id` bigint(20) NOT NULL COMMENT '所属账户ID',
  `user_id` bigint(20) NOT NULL COMMENT '所属用户ID',
  `order_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联开元的订单ID',
  `trade_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一交易单号  yyMMddHHmm+userid+4位随机数',
  `trade_kind` int(11) NOT NULL DEFAULT '1' COMMENT '事件区分 1：入金 -2：出金区分',
  `amount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易收支金额',
  `trade_currency` int(11) DEFAULT '4' COMMENT '出入金方式：1-支付宝，2-微信，3-银行卡，4-后台操作',
  `new_balance` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '账户余额（收支计算后）',
  `trade_type` int(11) NOT NULL DEFAULT '10' COMMENT '交易类型\r\n10：充值\r\n20：游戏转码（下注）\r\n30：游戏赢利\r\n40：游戏赔付\r\n50：提现',
  `trade_status` int(11) NOT NULL DEFAULT '10' COMMENT '交易状态\r\n 10：已提交\r\n 20：审核中\r\n 30：已完成\r\n 40：审核不通过\r\n 50：已关闭？？？',
  `remarks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `flow_id` bigint(11) DEFAULT NULL COMMENT '审核记录ID',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户交易明细';

-- ----------------------------
-- Records of t_user_account_detail
-- ----------------------------
INSERT INTO `t_user_account_detail` VALUES ('197', '21', '17000033', '2100320171013032042', 'W150787924300245667', '-1', '30.00', '4', '330.00', '50', '0', null, '1', '1', '17000029', '2017-10-17 09:54:58', '17000029', '2017-10-17 09:54:58', '0');
INSERT INTO `t_user_account_detail` VALUES ('198', '21', '17000033', '2100320171013032053', 'W150787925334917436', '-1', '10.00', '4', '320.00', '50', '0', null, '1', '1', '17000029', '2017-10-17 09:54:59', '17000029', '2017-10-17 09:54:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('199', '22', '17000033', '2100320171013032841', 'W150787972181822026', '1', '10.00', '4', '310.00', '11', '2', null, '1', '1', '17000030', '2017-10-17 09:55:00', '17000030', '2017-10-17 09:55:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('200', '22', '17000033', '2100320171013032951', 'W150787979137194000', '1', '10.00', '4', '300.00', '10', '5', null, '1', '1', '17000030', '2017-10-17 09:55:00', '17000030', '2017-10-17 09:55:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('201', '22', '17000033', '2100320171016034632', 'R150813999231459350', '1', '50.00', '4', '300.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 09:55:01', '17000030', '2017-10-17 09:55:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('202', '22', '17000033', '2100320171016035503', 'R150814050398224232', '1', '50.00', '4', '300.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 09:55:01', '17000030', '2017-10-17 09:55:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('203', '22', '17000033', '2100320171016035508', 'R150814050803166452', '1', '50.00', '4', '300.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 09:55:02', '17000030', '2017-10-17 09:55:02', '0');
INSERT INTO `t_user_account_detail` VALUES ('204', '22', '17000033', '2100320171016035515', 'R150814051523992217', '1', '50.00', '4', '300.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 09:55:06', '17000030', '2017-10-17 09:55:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('205', '22', '17000033', '2100320171016041402', 'R150814164217351023', '1', '100.00', '4', '400.00', '11', '2', '测试', null, '1', '17000030', '2017-10-17 09:55:03', '17000030', '2017-10-17 09:55:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('206', '23', '17000033', '2100320171017094251', 'R150820457149752345', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000033', '2017-10-17 09:42:52', '17000033', '2017-10-17 09:42:52', '0');
INSERT INTO `t_user_account_detail` VALUES ('207', '22', '17000030', '2100320171017104916', 'R150820855628011979', '1', '50.00', '4', '400.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 10:49:16', '17000030', '2017-10-17 10:49:16', '0');
INSERT INTO `t_user_account_detail` VALUES ('208', '22', '17000030', '2100320171017110029', 'R150820922965517611', '1', '50.00', '4', '400.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 11:00:30', '17000030', '2017-10-17 11:00:30', '0');
INSERT INTO `t_user_account_detail` VALUES ('209', '22', '17000030', '2100320171017110105', 'R150820926557460182', '1', '50.00', '4', '400.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 11:01:06', '17000030', '2017-10-17 11:01:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('210', '22', '17000030', '2100320171017110421', 'R150820946165152905', '1', '50.00', '4', '400.00', '10', '5', '玩家充值', null, '1', '17000030', '2017-10-17 11:04:22', '17000030', '2017-10-17 11:04:22', '0');
INSERT INTO `t_user_account_detail` VALUES ('211', '23', '17000033', '2100320171017110749', 'R150820966904245663', '1', '100.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000033', '2017-10-17 11:07:49', '17000033', '2017-10-17 11:07:49', '0');
INSERT INTO `t_user_account_detail` VALUES ('212', '23', '17000033', '2100320171017110807', 'R150820968699362517', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000033', '2017-10-17 11:08:07', '17000033', '2017-10-17 11:08:07', '0');

-- ----------------------------
-- Table structure for `t_user_cards`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_cards`;
CREATE TABLE `t_user_cards` (
  `card_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '卡片ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `card_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '卡片编号',
  `card_bank` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '银行卡开户行',
  `bank_type` bigint(20) DEFAULT NULL COMMENT '所属银行',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `card_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户绑定卡片';

-- ----------------------------
-- Records of t_user_cards
-- ----------------------------
INSERT INTO `t_user_cards` VALUES ('9', '17000030', '6217001840000832875', '建设银行', '3', '1', '1', '0000-00-00 00:00:00', null, null, '0', '魏汉文');
INSERT INTO `t_user_cards` VALUES ('10', '17000033', '1234567890000000', '农业银行', '1', '1', '1', '0000-00-00 00:00:00', null, null, '0', '1');

-- ----------------------------
-- Table structure for `t_users`
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `login_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录用户名 一般为手机号',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录密码',
  `nickname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `gender` int(11) NOT NULL DEFAULT '2' COMMENT '1：男 0：女 2：未知',
  `user_type` int(11) NOT NULL DEFAULT '0' COMMENT '用户类型（0：系统用户 1：普通玩家）',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色（系统用户才有角色）',
  `be_user_id` bigint(20) DEFAULT NULL COMMENT '被关联的userid(业务员)',
  `head_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像URL',
  `last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后登录时间',
  `user_status` int(11) DEFAULT '0' COMMENT '用户状态（0：正常 1：锁定 2：拉黑 ）',
  `agent_id` bigint(20) DEFAULT NULL COMMENT '代理商ID',
  `ky_account` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开云棋盘账号',
  `ky_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开元棋盘url',
  `qq` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bg_user_id` bigint(20) DEFAULT NULL COMMENT 'BG会员ID',
  `bg_reg_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG用户注册类型',
  `bg_login_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17000035 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '15260282340', '2', '0', '1', '1', 'http://img.jsqq.net/uploads/allimg/150111/1_150111080328_19.jpg', '2017-09-28 12:09:34', '0', null, null, null, '2', '3', '1', '2017-09-28 12:09:34', '1', '2017-09-28 12:09:34', '0', null, null, null);
INSERT INTO `t_users` VALUES ('4', 'KF001', 'e10adc3949ba59abbe56e057f20f883e', '客服', '15260282340', '2', '0', '3', '1', null, '2017-10-16 16:25:48', '0', null, null, null, null, '1', '1', '2017-10-16 16:25:48', null, '2017-10-16 16:25:48', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000001', '15901794296', '423350', '阳光大佬2', '15901794296', '-1', '1', '0', '4', '2017090809061430402302.jpeg', '2017-10-16 16:28:59', '0', '1', null, null, '9', '6', '0', '2017-10-16 16:28:59', '1', '2017-10-16 16:28:59', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000030', '15260282340', '123456', '我是测试', '15260282340', '-1', '1', null, '4', null, '2017-10-17 11:06:31', '0', null, '我是测试', 'http://exp.ky508.com:89/game/index.html?account=21003_我是测试&token=eyJkYXRhIjoiMjEwMDNf5oiR5piv5rWL6K+VIiwiY3JlYXRlZCI6MTUwODIwNjQ4MSwiZXhwIjozMH0=.9Z0hOJPPxVthvSQ8dcehT0gFkXVMwkKLvZ0SW9R4aE4=&lang=undefined&gameId=0', null, '6', '1', '2017-10-17 11:06:31', '17000030', '2017-10-17 11:06:31', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000031', '游客_test123456', null, '游客_test123456', null, '-1', '2', null, '4', null, '2017-10-16 16:28:39', '0', null, '游客_test123456', null, null, '1', '1', '2017-10-16 16:28:39', null, '2017-10-16 16:28:39', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000033', '13295353220', 'mtf123456', 'mtf', '13295353220', '-1', '1', null, '4', null, '2017-10-17 11:07:37', '0', null, 'mtf', 'http://exp.ky508.com:89/game/index.html?account=21003_mtf&token=eyJkYXRhIjoiMjEwMDNfbXRmIiwiY3JlYXRlZCI6MTUwODIwOTYzMCwiZXhwIjozMH0=.n0pAFf521x5l6lFMiQaM0JTOK0oPu6SCbu2t6akGk4Q=&lang=undefined&gameId=0', null, '73', '1', '2017-10-16 16:28:40', '17000033', '2017-10-17 11:07:37', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000034', '游客_15260282340', null, '游客_15260282340', null, '-1', '2', null, null, null, '2017-10-17 09:47:35', '0', null, '游客_15260282340', null, null, '1', '1', '2017-10-17 09:47:35', null, null, '0', null, null, null);
