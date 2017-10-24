/*
Navicat MySQL Data Transfer

Source Server         : api——product
Source Server Version : 50637
Source Host           : 58.64.197.100:3306
Source Database       : bgdress

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-10-24 11:24:42
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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
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
INSERT INTO `m_activitys` VALUES ('3', '超多游戏，一次玩个够', '2017-08-22 18:30:22', '2017-08-30 00:00:00', 'banners/activity_03.jpg', 'http://cdn.sztchx.com/help/index.html?locale=zh_CN', '超多游戏，一次玩个够', '超多游戏，一次玩个够', '1', '1', '1', '2017-09-08 16:00:33', '1', '2017-09-08 16:00:33', '1');

-- ----------------------------
-- Table structure for `m_agents`
-- ----------------------------
DROP TABLE IF EXISTS `m_agents`;
CREATE TABLE `m_agents` (
  `agent_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '代理商ID',
  `agent_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代理商名称',
  `bg_login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG代理登录ID',
  `bg_pwd` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG代理登录密码',
  `remarks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defection_proportion` decimal(20,2) DEFAULT NULL COMMENT '反水比例/1000(千分之几)',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bg_agent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代理商';

-- ----------------------------
-- Records of m_agents
-- ----------------------------
INSERT INTO `m_agents` VALUES ('1', '星河娱乐测试SN', 'agdress', '123456', null, null, null, '1', '1', '2017-09-13 10:19:10', '1', '2017-09-13 10:19:10', '1', '20361889');
INSERT INTO `m_agents` VALUES ('2', '我自己', 'agdress1', '123456', null, null, null, '1', '1', '2017-09-08 22:49:48', '1', '2017-09-08 22:49:48', '1', '2036190');
INSERT INTO `m_agents` VALUES ('4', '星河娱乐', 'ix00_601134', 'BG_dress2017', '', '971083603@qq.com', '0.08', '1', '1', '2017-09-13 10:19:12', '1', '2017-09-30 15:33:22', '0', '21283177');
INSERT INTO `m_agents` VALUES ('5', 'houlai', 'fh', '123456', '周返                             ', '123qqww@qq.com', '10.00', '1', '1', '2017-09-30 15:37:12', null, '2017-09-30 17:42:21', '0', '23843603');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
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
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m_items
-- ----------------------------
INSERT INTO `m_items` VALUES ('1', 'R10', '充10元', '0', '10.00', null, null, '1', '1', '2017-08-22 18:35:19', '1', '2017-08-22 18:35:19', '0');
INSERT INTO `m_items` VALUES ('2', 'R50', '充50元', '0', '50.00', null, null, '1', '1', '2017-08-22 18:37:17', '1', '2017-08-22 18:37:17', '0');
INSERT INTO `m_items` VALUES ('3', 'R100', '充100元', '0', '100.00', null, null, '1', '1', '2017-08-22 18:39:00', '1', '2017-08-22 18:39:00', '0');
INSERT INTO `m_items` VALUES ('4', 'R500', '充500元', '0', '500.00', null, null, '1', '1', '2017-08-22 18:39:02', '1', '2017-08-22 18:39:02', '0');
INSERT INTO `m_items` VALUES ('5', 'xinhe_Product30', '星河娱乐30金币', '2', '30.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');
INSERT INTO `m_items` VALUES ('6', 'xinhe_Product68', '星河娱乐68金币', '2', '68.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');
INSERT INTO `m_items` VALUES ('7', 'xinhe_Product118', '星河娱乐118金币', '2', '118.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');
INSERT INTO `m_items` VALUES ('8', 'xinhe_Product518', '星河娱乐518金币', '2', '518.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');
INSERT INTO `m_items` VALUES ('9', 'xinhe_Product998', '星河娱乐998金币', '2', '998.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');
INSERT INTO `m_items` VALUES ('10', 'xinhe_Product4998', '星河娱乐4998金币', '2', '4998.00', null, null, '1', '1', '2017-09-06 21:31:34', null, '2017-09-06 21:31:34', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='资源模块';

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
INSERT INTO `m_modules` VALUES ('43', '消息查询', '1', '', '42', '1', 'search', '', '0', '1', '1');
INSERT INTO `m_modules` VALUES ('44', '消息更新', '1', '', '42', '1', 'update', '', '0', '1', '0');
INSERT INTO `m_modules` VALUES ('45', '用户充值', '1', null, '20', '1', 'recharge', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('46', '账号启用/停用', '1', null, '13', '1', 'status', null, '0', '1', '1');

-- ----------------------------
-- Table structure for `m_role_modules`
-- ----------------------------
DROP TABLE IF EXISTS `m_role_modules`;
CREATE TABLE `m_role_modules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `module_id` bigint(20) NOT NULL COMMENT '模块ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限';

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
INSERT INTO `m_role_modules` VALUES ('49', '4', '21');
INSERT INTO `m_role_modules` VALUES ('50', '4', '5');
INSERT INTO `m_role_modules` VALUES ('51', '4', '6');
INSERT INTO `m_role_modules` VALUES ('52', '4', '7');
INSERT INTO `m_role_modules` VALUES ('53', '4', '8');
INSERT INTO `m_role_modules` VALUES ('54', '4', '9');
INSERT INTO `m_role_modules` VALUES ('55', '4', '10');
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
INSERT INTO `m_role_modules` VALUES ('153', '1', '37');
INSERT INTO `m_role_modules` VALUES ('154', '1', '38');
INSERT INTO `m_role_modules` VALUES ('157', '4', '37');
INSERT INTO `m_role_modules` VALUES ('158', '4', '38');
INSERT INTO `m_role_modules` VALUES ('159', '1', '39');
INSERT INTO `m_role_modules` VALUES ('160', '1', '40');
INSERT INTO `m_role_modules` VALUES ('163', '4', '39');
INSERT INTO `m_role_modules` VALUES ('164', '4', '40');
INSERT INTO `m_role_modules` VALUES ('199', '1', '41');
INSERT INTO `m_role_modules` VALUES ('200', '1', '42');
INSERT INTO `m_role_modules` VALUES ('201', '1', '43');
INSERT INTO `m_role_modules` VALUES ('205', '4', '41');
INSERT INTO `m_role_modules` VALUES ('206', '4', '42');
INSERT INTO `m_role_modules` VALUES ('207', '4', '43');
INSERT INTO `m_role_modules` VALUES ('208', '1', '44');
INSERT INTO `m_role_modules` VALUES ('210', '4', '44');
INSERT INTO `m_role_modules` VALUES ('211', '1', '45');
INSERT INTO `m_role_modules` VALUES ('213', '3', '1');
INSERT INTO `m_role_modules` VALUES ('214', '3', '20');
INSERT INTO `m_role_modules` VALUES ('215', '3', '2');
INSERT INTO `m_role_modules` VALUES ('216', '3', '3');
INSERT INTO `m_role_modules` VALUES ('217', '3', '4');
INSERT INTO `m_role_modules` VALUES ('218', '3', '45');
INSERT INTO `m_role_modules` VALUES ('219', '3', '21');
INSERT INTO `m_role_modules` VALUES ('220', '3', '5');
INSERT INTO `m_role_modules` VALUES ('221', '3', '8');
INSERT INTO `m_role_modules` VALUES ('222', '3', '38');
INSERT INTO `m_role_modules` VALUES ('223', '3', '39');
INSERT INTO `m_role_modules` VALUES ('224', '3', '40');
INSERT INTO `m_role_modules` VALUES ('225', '3', '22');
INSERT INTO `m_role_modules` VALUES ('226', '3', '23');
INSERT INTO `m_role_modules` VALUES ('227', '3', '12');
INSERT INTO `m_role_modules` VALUES ('228', '3', '41');
INSERT INTO `m_role_modules` VALUES ('229', '3', '42');
INSERT INTO `m_role_modules` VALUES ('230', '3', '43');
INSERT INTO `m_role_modules` VALUES ('245', '1', '46');
INSERT INTO `m_role_modules` VALUES ('246', '5', '1');
INSERT INTO `m_role_modules` VALUES ('247', '5', '20');
INSERT INTO `m_role_modules` VALUES ('248', '5', '2');
INSERT INTO `m_role_modules` VALUES ('249', '5', '29');
INSERT INTO `m_role_modules` VALUES ('250', '5', '30');
INSERT INTO `m_role_modules` VALUES ('251', '5', '36');

-- ----------------------------
-- Table structure for `m_roles`
-- ----------------------------
DROP TABLE IF EXISTS `m_roles`;
CREATE TABLE `m_roles` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名',
  `version_no` bigint(20) DEFAULT '0',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';

-- ----------------------------
-- Records of m_roles
-- ----------------------------
INSERT INTO `m_roles` VALUES ('1', '超级管理员', null, '1', '2017-08-11 18:28:02', '1', '2017-08-11 18:28:09', '0');
INSERT INTO `m_roles` VALUES ('2', '系统运营账户', null, '1', '2017-08-11 18:29:01', '1', '2017-09-30 17:12:39', '1');
INSERT INTO `m_roles` VALUES ('3', '客服专员', null, '1', '2017-09-22 16:22:32', '1', '2017-09-22 16:22:32', '0');
INSERT INTO `m_roles` VALUES ('4', '财务', null, '1', '2017-08-28 14:12:49', '1', '2017-08-28 14:12:49', '0');
INSERT INTO `m_roles` VALUES ('5', '代理商', null, '1', '2017-09-20 16:48:40', '1', '2017-09-20 16:48:40', '0');
INSERT INTO `m_roles` VALUES ('7', '查阅者', '0', '1', '2017-09-20 16:48:41', '1', '2017-09-26 14:32:59', '1');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_logs
-- ----------------------------
INSERT INTO `t_audit_logs` VALUES ('1', '70', '1', '1', '测试', '1', '4', '2017-09-23 18:34:43', '4', '2017-09-23 18:34:43', '0');
INSERT INTO `t_audit_logs` VALUES ('2', '70', '1', '2', '什么鬼，测试你也想要钱', '1', '17000071', '2017-09-23 18:36:12', '17000071', '2017-09-23 18:36:12', '0');
INSERT INTO `t_audit_logs` VALUES ('3', '83', '1', '1', '出金审核通过', '1', '4', '2017-09-23 18:46:34', '4', '2017-09-23 18:46:34', '0');
INSERT INTO `t_audit_logs` VALUES ('4', '83', '1', '2', '出金审核通过', '1', '17000071', '2017-09-23 18:49:22', '17000071', '2017-09-23 18:49:22', '0');
INSERT INTO `t_audit_logs` VALUES ('5', '100', '1', '1', '傻妞 测试', '1', '3', '2017-09-26 15:27:53', '3', '2017-09-26 15:27:53', '0');
INSERT INTO `t_audit_logs` VALUES ('6', '100', '1', '2', '傻妞测试测试', '1', '17000071', '2017-09-26 15:28:34', '17000071', '2017-09-26 15:28:34', '0');
INSERT INTO `t_audit_logs` VALUES ('7', '101', '1', '1', '测试审核，客服002审核通过', '1', '3', '2017-09-27 22:23:31', '3', '2017-09-27 22:23:31', '0');
INSERT INTO `t_audit_logs` VALUES ('8', '74', '1', '1', '测试通过 ', '1', '3', '2017-09-27 22:23:54', '3', '2017-09-27 22:23:54', '0');
INSERT INTO `t_audit_logs` VALUES ('9', '101', '1', '2', '出金审核通过', '1', '17000071', '2017-09-28 09:28:34', '17000071', '2017-09-28 09:28:34', '0');
INSERT INTO `t_audit_logs` VALUES ('10', '111', '1', '1', '出金审核通过', '1', '4', '2017-09-28 18:13:25', '4', '2017-09-28 18:13:25', '0');
INSERT INTO `t_audit_logs` VALUES ('11', '111', '1', '2', '出金审核通过', '1', '17000071', '2017-09-30 17:16:29', '17000071', '2017-09-30 17:16:29', '0');
INSERT INTO `t_audit_logs` VALUES ('12', '119', '1', '1', '出金审核通过', '1', '4', '2017-09-30 17:23:49', '4', '2017-09-30 17:23:49', '0');
INSERT INTO `t_audit_logs` VALUES ('13', '119', '1', '2', '出金审核通过', '1', '17000071', '2017-09-30 17:25:29', '17000071', '2017-09-30 17:25:29', '0');
INSERT INTO `t_audit_logs` VALUES ('14', '112', '1', '1', '出金审核通过', '1', '3', '2017-09-30 17:33:00', '3', '2017-09-30 17:33:00', '0');
INSERT INTO `t_audit_logs` VALUES ('15', '112', '1', '2', '出金审核通过', '1', '17000071', '2017-09-30 17:33:42', '17000071', '2017-09-30 17:33:42', '0');
INSERT INTO `t_audit_logs` VALUES ('16', '124', '1', '1', '出金审核通过', '1', '3', '2017-09-30 19:30:18', '3', '2017-09-30 19:30:18', '0');
INSERT INTO `t_audit_logs` VALUES ('17', '124', '1', '2', '出金审核通过', '1', '17000071', '2017-09-30 19:30:41', '17000071', '2017-09-30 19:30:41', '0');
INSERT INTO `t_audit_logs` VALUES ('18', '145', '1', '1', '出金审核通过', '1', '3', '2017-09-30 21:23:27', '3', '2017-09-30 21:23:27', '0');
INSERT INTO `t_audit_logs` VALUES ('19', '156', '1', '1', '出金审核通过', '1', '3', '2017-10-10 12:42:52', '3', '2017-10-10 12:42:52', '0');
INSERT INTO `t_audit_logs` VALUES ('20', '156', '1', '2', '出金审核通过', '1', '17000071', '2017-10-10 12:46:21', '17000071', '2017-10-10 12:46:21', '0');
INSERT INTO `t_audit_logs` VALUES ('21', '145', '1', '2', '出金审核通过', '1', '17000071', '2017-10-10 12:47:59', '17000071', '2017-10-10 12:47:59', '0');
INSERT INTO `t_audit_logs` VALUES ('22', '175', '1', '1', '出金审核通过', '1', '3', '2017-10-10 17:18:21', '3', '2017-10-10 17:18:21', '0');
INSERT INTO `t_audit_logs` VALUES ('23', '175', '1', '2', 'ceshi', '1', '17000071', '2017-10-10 17:18:52', '17000071', '2017-10-10 17:18:52', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`temp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_template
-- ----------------------------
INSERT INTO `t_audit_template` VALUES ('1', '提现记录审核', '提现记录审核', '1', '1', '2017-09-04 17:52:16', '1', '2017-09-04 17:52:16', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_audit_template_step
-- ----------------------------
INSERT INTO `t_audit_template_step` VALUES ('1', '1', '1', '3', '1', '1', '2017-09-22 11:00:22', '1', '2017-09-22 11:00:22', '0');
INSERT INTO `t_audit_template_step` VALUES ('2', '1', '2', '4', '1', '1', '2017-09-22 11:00:24', '1', '2017-09-22 11:00:24', '0');

-- ----------------------------
-- Table structure for `t_game_data`
-- ----------------------------
DROP TABLE IF EXISTS `t_game_data`;
CREATE TABLE `t_game_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `bg_order_id` bigint(20) NOT NULL,
  `bg_tran_id` bigint(20) DEFAULT NULL,
  `bg_uid` bigint(20) NOT NULL,
  `bg_login_id` varchar(255) DEFAULT NULL,
  `bg_module_id` bigint(20) NOT NULL,
  `bg_module_name` varchar(255) DEFAULT NULL,
  `bg_game_id` bigint(20) DEFAULT NULL,
  `bg_game_name` varchar(255) DEFAULT NULL,
  `bg_order_status` int(11) NOT NULL,
  `bg_b_amount` bigint(20) NOT NULL,
  `bg_a_amount` bigint(20) NOT NULL,
  `bg_order_time` datetime NOT NULL,
  `bg_last_update_time` datetime DEFAULT NULL,
  `bg_from_ip` varchar(255) DEFAULT NULL,
  `bg_frop_ip_addr` varchar(255) DEFAULT NULL,
  `bg_issue_id` varchar(255) CHARACTER SET ascii DEFAULT NULL,
  `bg_play_id` varchar(255) DEFAULT NULL,
  `version_no` bigint(20) NOT NULL,
  `create_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `is_delete` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_game_data
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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('6', '50', 'fa fa-user text-red', '112', '1', '17000046', '2017-09-30 11:05:17', '17000046', '2017-09-30 11:05:17', '0');
INSERT INTO `t_message` VALUES ('7', '10', 'fa fa-users text-aqua', '113', '1', '17000135', '2017-09-30 15:45:35', null, '2017-09-30 15:45:35', '0');
INSERT INTO `t_message` VALUES ('8', '10', 'fa fa-users text-aqua', '114', '1', '17000135', '2017-09-30 15:47:01', null, '2017-09-30 15:47:01', '0');
INSERT INTO `t_message` VALUES ('9', '10', 'fa fa-users text-aqua', '115', '1', '17000133', '2017-09-30 15:47:18', null, '2017-09-30 15:47:18', '0');
INSERT INTO `t_message` VALUES ('10', '10', 'fa fa-users text-aqua', '116', '1', '17000135', '2017-09-30 15:54:27', null, '2017-09-30 15:54:27', '0');
INSERT INTO `t_message` VALUES ('11', '10', 'fa fa-users text-aqua', '117', '1', '17000135', '2017-09-30 15:56:24', null, '2017-09-30 15:56:24', '0');
INSERT INTO `t_message` VALUES ('12', '10', 'fa fa-users text-aqua', '118', '1', '17000046', '2017-09-30 15:56:51', null, '2017-09-30 15:56:51', '0');
INSERT INTO `t_message` VALUES ('13', '10', 'fa fa-users text-aqua', '117', '1', '17000135', '2017-09-30 15:57:42', null, '2017-09-30 15:57:42', '0');
INSERT INTO `t_message` VALUES ('14', '50', 'fa fa-user text-red', '119', '1', '17000135', '2017-09-30 16:03:39', '17000135', '2017-09-30 16:03:39', '0');
INSERT INTO `t_message` VALUES ('15', '10', 'fa fa-users text-aqua', '120', '1', '17000135', '2017-09-30 16:29:30', null, '2017-09-30 16:29:30', '0');
INSERT INTO `t_message` VALUES ('16', '10', 'fa fa-users text-aqua', '120', '1', '17000135', '2017-09-30 17:32:19', null, '2017-09-30 17:32:19', '0');
INSERT INTO `t_message` VALUES ('17', '10', 'fa fa-users text-aqua', '121', '1', '1', '2017-09-30 18:56:29', null, '2017-09-30 18:56:29', '0');
INSERT INTO `t_message` VALUES ('18', '10', 'fa fa-users text-aqua', '122', '1', '17000050', '2017-09-30 18:22:22', null, '2017-09-30 18:22:22', '0');
INSERT INTO `t_message` VALUES ('19', '10', 'fa fa-users text-aqua', '123', '1', '17000056', '2017-09-30 18:22:30', null, '2017-09-30 18:22:30', '0');
INSERT INTO `t_message` VALUES ('20', '50', 'fa fa-user text-red', '124', '1', '17000060', '2017-09-30 18:24:12', '17000060', '2017-09-30 18:24:12', '0');
INSERT INTO `t_message` VALUES ('21', '10', 'fa fa-users text-aqua', '125', '1', '17000060', '2017-09-30 18:26:29', null, '2017-09-30 18:26:29', '0');
INSERT INTO `t_message` VALUES ('22', '10', 'fa fa-users text-aqua', '126', '1', '17000056', '2017-09-30 18:26:36', null, '2017-09-30 18:26:36', '0');
INSERT INTO `t_message` VALUES ('23', '10', 'fa fa-users text-aqua', '127', '1', '17000060', '2017-09-30 18:27:20', null, '2017-09-30 18:27:20', '0');
INSERT INTO `t_message` VALUES ('24', '10', 'fa fa-users text-aqua', '128', '1', '17000060', '2017-09-30 18:27:20', null, '2017-09-30 18:27:20', '0');
INSERT INTO `t_message` VALUES ('25', '10', 'fa fa-users text-aqua', '129', '1', '17000060', '2017-09-30 18:27:44', null, '2017-09-30 18:27:44', '0');
INSERT INTO `t_message` VALUES ('26', '10', 'fa fa-users text-aqua', '130', '1', '17000060', '2017-09-30 18:30:18', null, '2017-09-30 18:30:18', '0');
INSERT INTO `t_message` VALUES ('27', '10', 'fa fa-users text-aqua', '131', '1', '17000060', '2017-09-30 18:30:19', null, '2017-09-30 18:30:19', '0');
INSERT INTO `t_message` VALUES ('28', '10', 'fa fa-users text-aqua', '132', '1', '17000050', '2017-09-30 18:32:10', null, '2017-09-30 18:32:10', '0');
INSERT INTO `t_message` VALUES ('29', '10', 'fa fa-users text-aqua', '133', '1', '17000050', '2017-09-30 18:32:50', null, '2017-09-30 18:32:50', '0');
INSERT INTO `t_message` VALUES ('30', '10', 'fa fa-users text-aqua', '134', '1', '17000060', '2017-09-30 18:32:54', null, '2017-09-30 18:32:54', '0');
INSERT INTO `t_message` VALUES ('31', '10', 'fa fa-users text-aqua', '135', '1', '17000060', '2017-09-30 18:33:14', null, '2017-09-30 18:33:14', '0');
INSERT INTO `t_message` VALUES ('32', '10', 'fa fa-users text-aqua', '136', '1', '17000050', '2017-09-30 18:33:17', null, '2017-09-30 18:33:17', '0');
INSERT INTO `t_message` VALUES ('33', '50', 'fa fa-user text-red', '137', '1', '17000060', '2017-09-30 18:44:32', '17000060', '2017-09-30 18:44:32', '0');
INSERT INTO `t_message` VALUES ('34', '10', 'fa fa-users text-aqua', '138', '1', '17000060', '2017-09-30 18:47:30', null, '2017-09-30 18:47:30', '0');
INSERT INTO `t_message` VALUES ('35', '10', 'fa fa-users text-aqua', '139', '1', '17000050', '2017-09-30 18:48:58', null, '2017-09-30 18:48:58', '0');
INSERT INTO `t_message` VALUES ('36', '10', 'fa fa-users text-aqua', '140', '1', '17000050', '2017-09-30 18:49:12', null, '2017-09-30 18:49:12', '0');
INSERT INTO `t_message` VALUES ('37', '10', 'fa fa-users text-aqua', '141', '1', '17000050', '2017-09-30 18:50:54', null, '2017-09-30 18:50:54', '0');
INSERT INTO `t_message` VALUES ('38', '10', 'fa fa-users text-aqua', '142', '1', '17000060', '2017-09-30 18:51:16', null, '2017-09-30 18:51:16', '0');
INSERT INTO `t_message` VALUES ('39', '10', 'fa fa-users text-aqua', '143', '1', '17000060', '2017-09-30 18:51:57', null, '2017-09-30 18:51:57', '0');
INSERT INTO `t_message` VALUES ('40', '10', 'fa fa-users text-aqua', '144', '1', '17000050', '2017-09-30 18:54:12', null, '2017-09-30 18:54:12', '0');
INSERT INTO `t_message` VALUES ('41', '50', 'fa fa-user text-red', '145', '1', '17000046', '2017-09-30 20:17:54', '17000046', '2017-09-30 20:17:54', '0');
INSERT INTO `t_message` VALUES ('42', '10', 'fa fa-users text-aqua', '146', '1', '17000137', '2017-10-01 07:37:51', null, '2017-10-01 07:37:51', '0');
INSERT INTO `t_message` VALUES ('43', '10', 'fa fa-users text-aqua', '147', '1', '17000137', '2017-10-01 09:49:17', null, '2017-10-01 09:49:17', '0');
INSERT INTO `t_message` VALUES ('44', '10', 'fa fa-users text-aqua', '147', '1', '17000137', '2017-10-01 10:52:59', null, '2017-10-01 10:52:59', '0');
INSERT INTO `t_message` VALUES ('45', '10', 'fa fa-users text-aqua', '148', '1', '17000137', '2017-10-02 14:49:23', null, '2017-10-02 14:49:23', '0');
INSERT INTO `t_message` VALUES ('46', '10', 'fa fa-users text-aqua', '149', '1', '17000137', '2017-10-02 14:49:42', null, '2017-10-02 14:49:42', '0');
INSERT INTO `t_message` VALUES ('47', '10', 'fa fa-users text-aqua', '153', '1', '17000141', '2017-10-08 03:14:30', null, '2017-10-08 03:14:30', '0');
INSERT INTO `t_message` VALUES ('48', '10', 'fa fa-users text-aqua', '154', '1', '17000137', '2017-10-08 13:02:29', null, '2017-10-08 13:02:29', '0');
INSERT INTO `t_message` VALUES ('49', '10', 'fa fa-users text-aqua', '155', '1', '17000142', '2017-10-09 11:46:39', null, '2017-10-09 11:46:39', '0');
INSERT INTO `t_message` VALUES ('50', '50', 'fa fa-user text-red', '156', '1', '17000046', '2017-10-09 20:50:37', '17000046', '2017-10-09 20:50:37', '0');
INSERT INTO `t_message` VALUES ('51', '10', 'fa fa-users text-aqua', '163', '1', '17000046', '2017-10-10 11:29:31', null, '2017-10-10 11:29:31', '0');
INSERT INTO `t_message` VALUES ('52', '50', 'fa fa-user text-red', '175', '1', '17000046', '2017-10-10 11:49:55', '17000046', '2017-10-10 11:49:55', '0');
INSERT INTO `t_message` VALUES ('53', '10', 'fa fa-users text-aqua', '185', '1', '1', '2017-10-10 17:08:10', null, '2017-10-10 17:08:10', '0');
INSERT INTO `t_message` VALUES ('54', '10', 'fa fa-users text-aqua', '276', '1', '17000055', '2017-10-12 16:48:13', null, '2017-10-12 16:48:13', '0');
INSERT INTO `t_message` VALUES ('55', '10', 'fa fa-users text-aqua', '308', '1', '17000046', '2017-10-12 19:54:48', null, '2017-10-12 19:54:48', '0');
INSERT INTO `t_message` VALUES ('56', '10', 'fa fa-users text-aqua', '364', '1', '17000044', '2017-10-13 15:12:51', null, '2017-10-13 15:12:51', '0');
INSERT INTO `t_message` VALUES ('57', '10', 'fa fa-users text-aqua', '395', '1', '1', '2017-10-13 16:11:01', null, '2017-10-13 16:11:01', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_content
-- ----------------------------
INSERT INTO `t_message_content` VALUES ('22', '112', '3', '3', '你有一笔新的提现审核，编号：W150674071690177810。', '1', '1', '17000046', '2017-10-09 20:54:05', '17000046', '2017-10-09 20:54:05', '0');
INSERT INTO `t_message_content` VALUES ('23', '113', '1', '1', '15883532221]发起了一笔充值，金额：100.0，订单编号：R150675753494081870。', '1', '1', '17000135', '2017-09-30 19:10:49', null, '2017-09-30 19:10:49', '0');
INSERT INTO `t_message_content` VALUES ('24', '114', '1', '1', '15883532221]发起了一笔充值，金额：100.0，订单编号：R150675762057277508。', '1', '1', '17000135', '2017-10-10 10:53:19', null, '2017-10-10 10:53:19', '0');
INSERT INTO `t_message_content` VALUES ('25', '115', '1', '1', '13018912571]发起了一笔充值，金额：1.0，订单编号：R150675763847963019。', '1', '1', '17000133', '2017-10-10 16:10:32', null, '2017-10-10 16:10:32', '0');
INSERT INTO `t_message_content` VALUES ('26', '116', '1', '1', '15883532221]发起了一笔充值，金额：100.0，订单编号：R150675806723138655。', '1', '1', '17000135', '2017-10-10 16:10:32', null, '2017-10-10 16:10:32', '0');
INSERT INTO `t_message_content` VALUES ('27', '117', '1', '1', '15883532221]发起了一笔充值，金额：100.0，订单编号：R150675818420137525。', '1', '1', '17000135', '2017-10-09 10:16:08', null, '2017-10-09 10:16:08', '0');
INSERT INTO `t_message_content` VALUES ('28', '118', '1', '1', '17767077763]发起了一笔充值，金额：1.0，订单编号：R150675821117213453。', '1', '1', '17000046', '2017-10-10 10:54:31', null, '2017-10-10 10:54:31', '0');
INSERT INTO `t_message_content` VALUES ('29', '117', '1', '1', '15883532221]发起了一笔充值，金额：100.0，订单编号：R150675818420137525。', '1', '1', '17000135', '2017-10-10 10:53:33', null, '2017-10-10 10:53:33', '0');
INSERT INTO `t_message_content` VALUES ('30', '119', '3', '4', '你有一笔新的提现审核，编号：W150675861874723663。', '1', '1', '17000135', '2017-09-30 16:27:29', '17000135', '2017-09-30 16:27:29', '0');
INSERT INTO `t_message_content` VALUES ('31', '119', '4', null, '你有一笔新的提现审核，编号：W150675861874723663。', '1', '1', '4', '2017-09-30 16:24:41', '4', '2017-09-30 16:24:41', '0');
INSERT INTO `t_message_content` VALUES ('32', '120', '1', '1', '15883532221]发起了一笔充值，金额：50.0，订单编号：R150676016975014062。', '1', '1', '17000135', '2017-10-09 23:00:58', null, '2017-10-09 23:00:58', '0');
INSERT INTO `t_message_content` VALUES ('33', '120', '1', '1', '15883532221]发起了一笔充值，金额：50.0，订单编号：R150676016975014062。', '1', '1', '17000135', '2017-09-30 16:44:39', null, '2017-09-30 16:44:39', '0');
INSERT INTO `t_message_content` VALUES ('34', '112', '4', null, '你有一笔新的提现审核，编号：W150674071690177810。', '1', '1', '3', '2017-09-30 16:31:10', '3', '2017-09-30 16:31:10', '0');
INSERT INTO `t_message_content` VALUES ('35', '121', '1', '1', '小小测试员]充值了100.0元，订单编号：R150676898874249903。', '1', '1', '1', '2017-09-30 18:24:55', null, '2017-09-30 18:24:55', '0');
INSERT INTO `t_message_content` VALUES ('36', '122', '1', '1', '将军]发起了一笔充值，金额：50.0，订单编号：R150676694219335852。', '1', '1', '17000050', '2017-10-10 10:52:32', null, '2017-10-10 10:52:32', '0');
INSERT INTO `t_message_content` VALUES ('37', '123', '1', '1', '15558296177]发起了一笔充值，金额：100.0，订单编号：R150676694995794362。', '1', '1', '17000056', '2017-10-09 21:00:52', null, '2017-10-09 21:00:52', '0');
INSERT INTO `t_message_content` VALUES ('38', '124', '3', '3', '你有一笔新的提现审核，编号：W150676705236320887。', '1', '1', '17000060', '2017-10-09 20:54:01', '17000060', '2017-10-09 20:54:01', '0');
INSERT INTO `t_message_content` VALUES ('39', '125', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676718881673848。', '1', '1', '17000060', '2017-09-30 19:20:07', null, '2017-09-30 19:20:07', '0');
INSERT INTO `t_message_content` VALUES ('40', '126', '1', '1', '15558296177]发起了一笔充值，金额：100.0，订单编号：R150676719601677258。', '1', '1', '17000056', '2017-09-30 19:20:06', null, '2017-09-30 19:20:06', '0');
INSERT INTO `t_message_content` VALUES ('41', '127', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676724030936471。', '1', '1', '17000060', '2017-10-10 10:52:11', null, '2017-10-10 10:52:11', '0');
INSERT INTO `t_message_content` VALUES ('42', '128', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676724046451240。', '1', '1', '17000060', '2017-09-30 19:20:06', null, '2017-09-30 19:20:06', '0');
INSERT INTO `t_message_content` VALUES ('43', '129', '1', '1', '小小测试员]发起了一笔充值，金额：1.0，订单编号：R150676726410574845。', '1', '1', '17000060', '2017-09-30 19:10:16', null, '2017-09-30 19:10:16', '0');
INSERT INTO `t_message_content` VALUES ('44', '124', '4', null, '你有一笔新的提现审核，编号：W150676705236320887。', '1', '1', '3', '2017-10-10 16:16:17', '3', '2017-10-10 16:16:17', '0');
INSERT INTO `t_message_content` VALUES ('45', '130', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676741802471294。', '1', '1', '17000060', '2017-09-30 19:42:48', null, '2017-09-30 19:42:48', '0');
INSERT INTO `t_message_content` VALUES ('46', '131', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676741939899994。', '1', '1', '17000060', '2017-09-30 19:42:17', null, '2017-09-30 19:42:17', '0');
INSERT INTO `t_message_content` VALUES ('47', '132', '1', '1', '将军]发起了一笔充值，金额：10.0，订单编号：R150676753009879565。', '1', '1', '17000050', '2017-09-30 19:20:04', null, '2017-09-30 19:20:04', '0');
INSERT INTO `t_message_content` VALUES ('48', '133', '1', '1', '将军]发起了一笔充值，金额：10.0，订单编号：R150676757000073413。', '1', '1', '17000050', '2017-09-30 19:20:04', null, '2017-09-30 19:20:04', '0');
INSERT INTO `t_message_content` VALUES ('49', '134', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676757366797192。', '1', '1', '17000060', '2017-09-30 19:20:03', null, '2017-09-30 19:20:03', '0');
INSERT INTO `t_message_content` VALUES ('50', '135', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676759422450577。', '1', '1', '17000060', '2017-09-30 19:10:30', null, '2017-09-30 19:10:30', '0');
INSERT INTO `t_message_content` VALUES ('51', '136', '1', '1', '将军]发起了一笔充值，金额：50.0，订单编号：R150676759700213777。', '1', '1', '17000050', '2017-09-30 19:10:00', null, '2017-09-30 19:10:00', '0');
INSERT INTO `t_message_content` VALUES ('52', '137', '3', '3', '你有一笔新的提现审核，编号：W150676827227912150。', '1', '1', '17000060', '2017-10-09 20:53:55', '17000060', '2017-10-09 20:53:55', '0');
INSERT INTO `t_message_content` VALUES ('53', '138', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676844977238950。', '1', '1', '17000060', '2017-09-30 19:20:00', null, '2017-09-30 19:20:00', '0');
INSERT INTO `t_message_content` VALUES ('54', '139', '1', '1', '将军]发起了一笔充值，金额：50.0，订单编号：R150676853797544560。', '1', '1', '17000050', '2017-09-30 19:09:58', null, '2017-09-30 19:09:58', '0');
INSERT INTO `t_message_content` VALUES ('55', '140', '1', '1', '将军]发起了一笔充值，金额：50.0，订单编号：R150676855167676363。', '1', '1', '17000050', '2017-09-30 19:09:38', null, '2017-09-30 19:09:38', '0');
INSERT INTO `t_message_content` VALUES ('56', '141', '1', '1', '将军]发起了一笔充值，金额：50.0，订单编号：R150676865383722139。', '1', '1', '17000050', '2017-09-30 19:09:17', null, '2017-09-30 19:09:17', '0');
INSERT INTO `t_message_content` VALUES ('57', '142', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676867609995511。', '1', '1', '17000060', '2017-09-30 19:09:16', null, '2017-09-30 19:09:16', '0');
INSERT INTO `t_message_content` VALUES ('58', '143', '1', '1', '小小测试员]发起了一笔充值，金额：10.0，订单编号：R150676871737396518。', '1', '1', '17000060', '2017-09-30 19:09:14', null, '2017-09-30 19:09:14', '0');
INSERT INTO `t_message_content` VALUES ('59', '144', '1', '1', '将军]发起了一笔充值，金额：20.0，订单编号：R150676885239566602。', '1', '1', '17000050', '2017-09-30 19:09:09', null, '2017-09-30 19:09:09', '0');
INSERT INTO `t_message_content` VALUES ('60', '145', '3', '3', '你有一笔新的提现审核，编号：W150677387410442397。', '1', '2', '17000046', '2017-09-30 20:17:54', '3', '2017-09-30 21:23:27', '0');
INSERT INTO `t_message_content` VALUES ('61', '145', '4', null, '你有一笔新的提现审核，编号：W150677387410442397。', '1', '2', '3', '2017-09-30 21:23:27', '17000071', '2017-10-10 12:47:59', '0');
INSERT INTO `t_message_content` VALUES ('62', '146', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150681467058754546。', '1', '1', '17000137', '2017-10-10 10:51:06', null, '2017-10-10 10:51:06', '0');
INSERT INTO `t_message_content` VALUES ('63', '147', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150682255722219146。', '1', '1', '17000137', '2017-10-09 10:15:22', null, '2017-10-09 10:15:22', '0');
INSERT INTO `t_message_content` VALUES ('64', '147', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150682255722219146。', '1', '1', '17000137', '2017-10-01 15:57:38', null, '2017-10-01 15:57:38', '0');
INSERT INTO `t_message_content` VALUES ('65', '148', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150692696286965464。', '1', '1', '17000137', '2017-10-05 16:51:26', null, '2017-10-05 16:51:26', '0');
INSERT INTO `t_message_content` VALUES ('66', '149', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150692698152934437。', '1', '1', '17000137', '2017-10-05 16:50:55', null, '2017-10-05 16:50:55', '0');
INSERT INTO `t_message_content` VALUES ('67', '153', '1', '1', '13420534991]发起了一笔充值，金额：20.0，订单编号：R150740366960019808。', '1', '1', '17000141', '2017-10-09 10:15:29', null, '2017-10-09 10:15:29', '0');
INSERT INTO `t_message_content` VALUES ('68', '154', '1', '1', '15558296377]发起了一笔充值，金额：50.0，订单编号：R150743894857212386。', '1', '1', '17000137', '2017-10-09 21:00:43', null, '2017-10-09 21:00:43', '0');
INSERT INTO `t_message_content` VALUES ('69', '155', '1', '1', '15057184591]发起了一笔充值，金额：100.0，订单编号：R150752079917958456。', '1', '1', '17000142', '2017-10-09 21:00:05', null, '2017-10-09 21:00:05', '0');
INSERT INTO `t_message_content` VALUES ('70', '156', '3', '3', '你有一笔新的提现审核，编号：W150755343659385627。', '1', '2', '17000046', '2017-10-09 20:52:22', '3', '2017-10-10 12:42:52', '0');
INSERT INTO `t_message_content` VALUES ('71', '163', '1', '1', '17767077763 发起了一笔充值，金额：1.0，订单编号：R150760608875774218。', '1', '1', '17000046', '2017-10-10 16:10:32', null, '2017-10-10 16:10:32', '0');
INSERT INTO `t_message_content` VALUES ('72', '156', '4', null, '你有一笔新的提现审核，编号：W150755343659385627。', '1', '2', '3', '2017-10-10 12:42:52', '17000071', '2017-10-10 12:46:21', '0');
INSERT INTO `t_message_content` VALUES ('73', '175', '3', '3', '你有一笔新的提现审核，编号：W150760739509518058。', '1', '2', '17000046', '2017-10-10 11:49:55', '3', '2017-10-10 17:18:21', '0');
INSERT INTO `t_message_content` VALUES ('74', '185', '1', '1', '13588276084 ]充值了20.0元，订单编号：R150762649033159775。', '1', '1', '1', '2017-10-10 16:10:32', null, '2017-10-10 16:10:32', '0');
INSERT INTO `t_message_content` VALUES ('75', '175', '4', null, '你有一笔新的提现审核，编号：W150760739509518058。', '1', '2', '3', '2017-10-10 16:16:20', '17000071', '2017-10-10 17:18:52', '0');
INSERT INTO `t_message_content` VALUES ('76', '276', '1', '1', '地主婆 发起了一笔充值，金额：1.0，订单编号：R150779429817238897。', '1', '1', '17000055', '2017-10-13 17:29:50', null, '2017-10-13 17:29:50', '0');
INSERT INTO `t_message_content` VALUES ('77', '308', '1', '1', '17767077763 发起了一笔充值，金额：1.0，订单编号：R150780924939946567。', '1', '1', '17000046', '2017-10-13 17:29:50', null, '2017-10-13 17:29:50', '0');
INSERT INTO `t_message_content` VALUES ('78', '364', '1', '1', '爱丝寂寞人 发起了一笔充值，金额：1.0，订单编号：R150787499684639261。', '1', '1', '17000044', '2017-10-13 17:29:50', null, '2017-10-13 17:29:50', '0');
INSERT INTO `t_message_content` VALUES ('79', '395', '1', '1', '18668223750 ]充值了100.0元，订单编号：R150788226102889791。', '1', '1', '1', '2017-10-13 17:29:50', null, '2017-10-13 17:29:50', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=660 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payment_records
-- ----------------------------
INSERT INTO `t_payment_records` VALUES ('314', '17000060', '0', 'R150599410565873635', '10.00', '1', null, null, null, '1', '17000060', '2017-09-21 19:41:46', '17000060', '2017-09-21 19:41:46', '0');
INSERT INTO `t_payment_records` VALUES ('315', '17000060', '0', 'R150599412599697931', '10.00', '1', null, null, null, '1', '17000060', '2017-09-21 19:42:06', '17000060', '2017-09-21 19:42:06', '0');
INSERT INTO `t_payment_records` VALUES ('316', '17000050', '0', 'R150599858703597516', '10.00', '1', null, null, null, '1', '17000050', '2017-09-21 20:56:27', '17000050', '2017-09-21 20:56:27', '0');
INSERT INTO `t_payment_records` VALUES ('317', '17000060', '0', 'R150605141473517700', '10.00', '1', null, null, null, '1', '17000060', '2017-09-22 11:36:55', '17000060', '2017-09-22 11:36:55', '0');
INSERT INTO `t_payment_records` VALUES ('318', '17000046', '0', 'R150605443444840157', '1.00', '1', null, null, null, '1', '17000046', '2017-09-22 12:27:14', '17000046', '2017-09-22 12:27:14', '0');
INSERT INTO `t_payment_records` VALUES ('319', '17000066', '0', 'R150605484723117343', '50.00', '1', null, null, null, '1', '17000066', '2017-09-22 12:34:07', '17000066', '2017-09-22 12:34:07', '0');
INSERT INTO `t_payment_records` VALUES ('320', '17000046', '0', 'R150606611961611442', '1.00', '1', null, null, null, '1', '17000046', '2017-09-22 15:42:00', '17000046', '2017-09-22 15:42:00', '0');
INSERT INTO `t_payment_records` VALUES ('321', '17000060', '0', 'R150607281089652126', '50.00', '1', null, null, null, '1', '17000060', '2017-09-22 17:33:31', '17000060', '2017-09-22 17:33:31', '0');
INSERT INTO `t_payment_records` VALUES ('322', '17000060', '0', 'R150607504540188598', '1.00', '1', null, null, null, '1', '17000060', '2017-09-22 18:10:45', '17000060', '2017-09-22 18:10:45', '0');
INSERT INTO `t_payment_records` VALUES ('323', '17000060', '0', 'R150607505769963503', '1.00', '1', null, null, null, '1', '17000060', '2017-09-22 18:10:58', '17000060', '2017-09-22 18:10:58', '0');
INSERT INTO `t_payment_records` VALUES ('324', '17000050', '0', 'R150609420256547049', '10.00', '1', null, null, null, '1', '17000050', '2017-09-22 23:30:03', '17000050', '2017-09-22 23:30:03', '0');
INSERT INTO `t_payment_records` VALUES ('325', '17000050', '0', 'R150609422620751215', '10.00', '1', null, null, null, '1', '17000050', '2017-09-22 23:30:26', '17000050', '2017-09-22 23:30:26', '0');
INSERT INTO `t_payment_records` VALUES ('326', '17000050', '0', 'R150609422651590217', '10.00', '1', null, null, null, '1', '17000050', '2017-09-22 23:30:27', '17000050', '2017-09-22 23:30:27', '0');
INSERT INTO `t_payment_records` VALUES ('327', '17000046', '0', 'R150613575529840748', '1.00', '1', null, null, null, '1', '17000046', '2017-09-23 11:02:35', '17000046', '2017-09-23 11:02:35', '0');
INSERT INTO `t_payment_records` VALUES ('328', '17000050', '0', 'R150614229601336897', '10.00', '1', null, null, null, '1', '17000050', '2017-09-23 12:51:36', '17000050', '2017-09-23 12:51:36', '0');
INSERT INTO `t_payment_records` VALUES ('329', '17000046', '0', 'R150615124351283006', '1.00', '1', null, null, null, '1', '17000046', '2017-09-23 15:20:44', '17000046', '2017-09-23 15:20:44', '0');
INSERT INTO `t_payment_records` VALUES ('330', '17000046', '0', 'R150615405320492119', '1.00', '1', null, null, null, '1', '17000046', '2017-09-23 16:07:33', '17000046', '2017-09-23 16:07:33', '0');
INSERT INTO `t_payment_records` VALUES ('331', '17000046', '0', 'R150615609335962853', '1.00', '1', null, null, null, '1', '17000046', '2017-09-23 16:41:33', '17000046', '2017-09-23 16:41:33', '0');
INSERT INTO `t_payment_records` VALUES ('332', '17000046', '0', 'R150616010421265189', '2.00', '1', null, null, null, '1', '17000046', '2017-09-23 17:48:24', '17000046', '2017-09-23 17:48:24', '0');
INSERT INTO `t_payment_records` VALUES ('333', '17000043', '0', 'R150616172591586974', '500.00', '1', null, null, null, '1', '17000043', '2017-09-23 18:15:26', '17000043', '2017-09-23 18:15:26', '0');
INSERT INTO `t_payment_records` VALUES ('334', '17000046', '0', 'R150616292286980624', '10.00', '1', null, null, null, '1', '17000046', '2017-09-23 18:35:23', '17000046', '2017-09-23 18:35:23', '0');
INSERT INTO `t_payment_records` VALUES ('335', '17000046', '0', 'R150616293569673528', '10.00', '1', null, null, null, '1', '17000046', '2017-09-23 18:35:36', '17000046', '2017-09-23 18:35:36', '0');
INSERT INTO `t_payment_records` VALUES ('336', '17000077', '0', 'R150625528410819303', '1000.00', '1', null, null, null, '1', '17000077', '2017-09-24 20:14:44', '17000077', '2017-09-24 20:14:44', '0');
INSERT INTO `t_payment_records` VALUES ('337', '17000050', '0', 'R150632140505331420', '50.00', '1', null, null, null, '1', '17000050', '2017-09-25 14:36:45', '17000050', '2017-09-25 14:36:45', '0');
INSERT INTO `t_payment_records` VALUES ('338', '17000060', '0', 'R150632140982265872', '10.00', '1', null, null, null, '1', '17000060', '2017-09-25 14:36:50', '17000060', '2017-09-25 14:36:50', '0');
INSERT INTO `t_payment_records` VALUES ('339', '17000050', '0', 'R150632143122719637', '10.00', '1', null, null, null, '1', '17000050', '2017-09-25 14:37:11', '17000050', '2017-09-25 14:37:11', '0');
INSERT INTO `t_payment_records` VALUES ('340', '17000050', '0', 'R150632145605466042', '10.00', '1', null, null, null, '1', '17000050', '2017-09-25 14:37:36', '17000050', '2017-09-25 14:37:36', '0');
INSERT INTO `t_payment_records` VALUES ('341', '17000060', '0', 'R150632145925159571', '50.00', '1', null, null, null, '1', '17000060', '2017-09-25 14:37:39', '17000060', '2017-09-25 14:37:39', '0');
INSERT INTO `t_payment_records` VALUES ('342', '17000060', '0', 'R150632148177025036', '10.00', '1', null, null, null, '1', '17000060', '2017-09-25 14:38:02', '17000060', '2017-09-25 14:38:02', '0');
INSERT INTO `t_payment_records` VALUES ('343', '17000060', '0', 'R150632152243439397', '1.00', '1', null, null, null, '1', '17000060', '2017-09-25 14:38:42', '17000060', '2017-09-25 14:38:42', '0');
INSERT INTO `t_payment_records` VALUES ('344', '17000079', '0', 'R150633679701940706', '480.00', '1', null, null, null, '1', '17000079', '2017-09-25 18:53:17', '17000079', '2017-09-25 18:53:17', '0');
INSERT INTO `t_payment_records` VALUES ('345', '17000079', '0', 'R150633681916329072', '480.00', '1', null, null, null, '1', '17000079', '2017-09-25 18:53:39', '17000079', '2017-09-25 18:53:39', '0');
INSERT INTO `t_payment_records` VALUES ('346', '17000083', '0', 'R150639772062838738', '10.00', '1', null, null, null, '1', '17000083', '2017-09-26 11:48:41', '17000083', '2017-09-26 11:48:41', '0');
INSERT INTO `t_payment_records` VALUES ('347', '17000046', '0', 'R150640656802661460', '1.00', '1', null, null, null, '1', '17000046', '2017-09-26 14:16:08', '17000046', '2017-09-26 14:16:08', '0');
INSERT INTO `t_payment_records` VALUES ('348', '17000084', '0', 'R150644448041585781', '100.00', '1', null, null, null, '1', '17000084', '2017-09-27 00:48:00', '17000084', '2017-09-27 00:48:00', '0');
INSERT INTO `t_payment_records` VALUES ('349', '17000084', '0', 'R150646087109070470', '100.00', '1', null, null, null, '1', '17000084', '2017-09-27 05:21:11', '17000084', '2017-09-27 05:21:11', '0');
INSERT INTO `t_payment_records` VALUES ('350', '17000084', '0', 'R150646090828627762', '100.00', '1', null, null, null, '1', '17000084', '2017-09-27 05:21:48', '17000084', '2017-09-27 05:21:48', '0');
INSERT INTO `t_payment_records` VALUES ('351', '17000050', '0', 'R150649312496391631', '50.00', '1', null, null, null, '1', '17000050', '2017-09-27 14:18:45', '17000050', '2017-09-27 14:18:45', '0');
INSERT INTO `t_payment_records` VALUES ('352', '17000052', '0', 'R150649489265437583', '20.00', '1', null, null, null, '1', '17000052', '2017-09-27 14:48:13', '17000052', '2017-09-27 14:48:13', '0');
INSERT INTO `t_payment_records` VALUES ('353', '17000086', '0', 'R150653469646951727', '10.00', '1', null, null, null, '1', '17000086', '2017-09-28 01:51:36', '17000086', '2017-09-28 01:51:36', '0');
INSERT INTO `t_payment_records` VALUES ('354', '17000086', '0', 'R150653483503027431', '5000.00', '1', null, null, null, '1', '17000086', '2017-09-28 01:53:55', '17000086', '2017-09-28 01:53:55', '0');
INSERT INTO `t_payment_records` VALUES ('355', '17000050', '0', 'R150655846761099424', '10.00', '1', null, null, null, '1', '17000050', '2017-09-28 08:27:48', '17000050', '2017-09-28 08:27:48', '0');
INSERT INTO `t_payment_records` VALUES ('356', '17000050', '0', 'R150655850092516955', '10.00', '1', null, null, null, '1', '17000050', '2017-09-28 08:28:21', '17000050', '2017-09-28 08:28:21', '0');
INSERT INTO `t_payment_records` VALUES ('357', '17000135', '0', 'R150675753494081870', '100.00', '1', null, null, null, '1', '17000135', '2017-09-30 15:45:35', '17000135', '2017-09-30 15:45:35', '0');
INSERT INTO `t_payment_records` VALUES ('358', '17000135', '0', 'R150675762057277508', '100.00', '1', null, null, null, '1', '17000135', '2017-09-30 15:47:01', '17000135', '2017-09-30 15:47:01', '0');
INSERT INTO `t_payment_records` VALUES ('360', '17000133', '0', 'R150675763847963019', '1.00', '1', null, null, null, '1', '17000133', '2017-09-30 15:47:18', '17000133', '2017-09-30 15:47:18', '0');
INSERT INTO `t_payment_records` VALUES ('361', '17000135', '0', 'R150675806723138655', '100.00', '1', null, null, null, '1', '17000135', '2017-09-30 15:54:27', '17000135', '2017-09-30 15:54:27', '0');
INSERT INTO `t_payment_records` VALUES ('362', '17000135', '0', 'R150675818420137525', '100.00', '1', null, null, null, '1', '17000135', '2017-09-30 15:56:24', '17000135', '2017-09-30 15:56:24', '0');
INSERT INTO `t_payment_records` VALUES ('363', '17000046', '0', 'R150675821117213453', '1.00', '1', null, null, null, '1', '17000046', '2017-09-30 15:56:51', '17000046', '2017-09-30 15:56:51', '0');
INSERT INTO `t_payment_records` VALUES ('364', '17000135', '0', 'R150676016975014062', '50.00', '1', null, null, null, '1', '17000135', '2017-09-30 16:29:30', '17000135', '2017-09-30 16:29:30', '0');
INSERT INTO `t_payment_records` VALUES ('365', '17000050', '0', 'R150676694219335852', '50.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:22:22', '17000050', '2017-09-30 18:22:22', '0');
INSERT INTO `t_payment_records` VALUES ('366', '17000056', '0', 'R150676694995794362', '100.00', '1', null, null, null, '1', '17000056', '2017-09-30 18:22:30', '17000056', '2017-09-30 18:22:30', '0');
INSERT INTO `t_payment_records` VALUES ('367', '17000060', '0', 'R150676718881673848', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:26:29', '17000060', '2017-09-30 18:26:29', '0');
INSERT INTO `t_payment_records` VALUES ('368', '17000056', '0', 'R150676719601677258', '100.00', '1', null, null, null, '1', '17000056', '2017-09-30 18:26:36', '17000056', '2017-09-30 18:26:36', '0');
INSERT INTO `t_payment_records` VALUES ('369', '17000060', '0', 'R150676724030936471', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_payment_records` VALUES ('370', '17000060', '0', 'R150676724046451240', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_payment_records` VALUES ('371', '17000060', '0', 'R150676726410574845', '1.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:27:44', '17000060', '2017-09-30 18:27:44', '0');
INSERT INTO `t_payment_records` VALUES ('372', '17000060', '0', 'R150676741802471294', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:30:18', '17000060', '2017-09-30 18:30:18', '0');
INSERT INTO `t_payment_records` VALUES ('373', '17000060', '0', 'R150676741939899994', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:30:19', '17000060', '2017-09-30 18:30:19', '0');
INSERT INTO `t_payment_records` VALUES ('374', '17000050', '0', 'R150676753009879565', '10.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:32:10', '17000050', '2017-09-30 18:32:10', '0');
INSERT INTO `t_payment_records` VALUES ('375', '17000050', '0', 'R150676757000073413', '10.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:32:50', '17000050', '2017-09-30 18:32:50', '0');
INSERT INTO `t_payment_records` VALUES ('376', '17000060', '0', 'R150676757366797192', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:32:54', '17000060', '2017-09-30 18:32:54', '0');
INSERT INTO `t_payment_records` VALUES ('377', '17000060', '0', 'R150676759422450577', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:33:14', '17000060', '2017-09-30 18:33:14', '0');
INSERT INTO `t_payment_records` VALUES ('378', '17000050', '0', 'R150676759700213777', '50.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:33:17', '17000050', '2017-09-30 18:33:17', '0');
INSERT INTO `t_payment_records` VALUES ('379', '17000060', '0', 'R150676844977238950', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:47:30', '17000060', '2017-09-30 18:47:30', '0');
INSERT INTO `t_payment_records` VALUES ('380', '17000050', '0', 'R150676853797544560', '50.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:48:58', '17000050', '2017-09-30 18:48:58', '0');
INSERT INTO `t_payment_records` VALUES ('381', '17000050', '0', 'R150676855167676363', '50.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:49:12', '17000050', '2017-09-30 18:49:12', '0');
INSERT INTO `t_payment_records` VALUES ('382', '17000050', '0', 'R150676865383722139', '50.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:50:54', '17000050', '2017-09-30 18:50:54', '0');
INSERT INTO `t_payment_records` VALUES ('383', '17000060', '0', 'R150676867609995511', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:51:16', '17000060', '2017-09-30 18:51:16', '0');
INSERT INTO `t_payment_records` VALUES ('384', '17000060', '0', 'R150676871737396518', '10.00', '1', null, null, null, '1', '17000060', '2017-09-30 18:51:57', '17000060', '2017-09-30 18:51:57', '0');
INSERT INTO `t_payment_records` VALUES ('385', '17000050', '0', 'R150676885239566602', '20.00', '1', null, null, null, '1', '17000050', '2017-09-30 18:54:12', '17000050', '2017-09-30 18:54:12', '0');
INSERT INTO `t_payment_records` VALUES ('386', '17000137', '0', 'R150681467058754546', '50.00', '1', null, null, null, '1', '17000137', '2017-10-01 07:37:51', '17000137', '2017-10-01 07:37:51', '0');
INSERT INTO `t_payment_records` VALUES ('387', '17000137', '0', 'R150682255722219146', '50.00', '1', null, null, null, '1', '17000137', '2017-10-01 09:49:17', '17000137', '2017-10-01 09:49:17', '0');
INSERT INTO `t_payment_records` VALUES ('388', '17000137', '0', 'R150692696286965464', '50.00', '1', null, null, null, '1', '17000137', '2017-10-02 14:49:23', '17000137', '2017-10-02 14:49:23', '0');
INSERT INTO `t_payment_records` VALUES ('389', '17000137', '0', 'R150692698152934437', '50.00', '1', null, null, null, '1', '17000137', '2017-10-02 14:49:42', '17000137', '2017-10-02 14:49:42', '0');
INSERT INTO `t_payment_records` VALUES ('390', '17000138', '0', 'R150693384520471387', '5000.00', '1', null, null, null, '1', '17000138', '2017-10-02 16:44:05', '17000138', '2017-10-02 16:44:05', '0');
INSERT INTO `t_payment_records` VALUES ('391', '17000138', '0', 'R150693386319757509', '5000.00', '1', null, null, null, '1', '17000138', '2017-10-02 16:44:23', '17000138', '2017-10-02 16:44:23', '0');
INSERT INTO `t_payment_records` VALUES ('392', '17000138', '0', 'R150693388082310426', '10000.00', '1', null, null, null, '1', '17000138', '2017-10-02 16:44:41', '17000138', '2017-10-02 16:44:41', '0');
INSERT INTO `t_payment_records` VALUES ('393', '17000141', '0', 'R150740366960019808', '20.00', '1', null, null, null, '1', '17000141', '2017-10-08 03:14:30', '17000141', '2017-10-08 03:14:30', '0');
INSERT INTO `t_payment_records` VALUES ('394', '17000137', '0', 'R150743894857212386', '50.00', '1', null, null, null, '1', '17000137', '2017-10-08 13:02:29', '17000137', '2017-10-08 13:02:29', '0');
INSERT INTO `t_payment_records` VALUES ('395', '17000142', '0', 'R150752079917958456', '100.00', '1', null, null, null, '1', '17000142', '2017-10-09 11:46:39', '17000142', '2017-10-09 11:46:39', '0');
INSERT INTO `t_payment_records` VALUES ('396', '17000060', '0', 'R150755430417239958', '1.00', '1', null, null, null, '1', '17000060', '2017-10-09 21:05:04', '17000060', '2017-10-09 21:05:04', '0');
INSERT INTO `t_payment_records` VALUES ('397', '17000046', '0', 'R150755430658344077', '1.00', '1', null, null, null, '1', '17000046', '2017-10-09 21:05:07', '17000046', '2017-10-09 21:05:07', '0');
INSERT INTO `t_payment_records` VALUES ('398', '17000046', '0', 'R150755431718456836', '1.00', '1', null, null, null, '1', '17000046', '2017-10-09 21:05:17', '17000046', '2017-10-09 21:05:17', '0');
INSERT INTO `t_payment_records` VALUES ('399', '17000060', '0', 'R150755433178517438', '1.00', '1', null, null, null, '1', '17000060', '2017-10-09 21:05:32', '17000060', '2017-10-09 21:05:32', '0');
INSERT INTO `t_payment_records` VALUES ('400', '17000137', '0', 'R150760512879033086', '50.00', '1', null, null, null, '1', '17000137', '2017-10-10 11:12:09', '17000137', '2017-10-10 11:12:09', '0');
INSERT INTO `t_payment_records` VALUES ('401', '17000046', '0', 'R150760607413715736', '1.00', '1', null, null, null, '1', '17000046', '2017-10-10 11:27:54', '17000046', '2017-10-10 11:27:54', '0');
INSERT INTO `t_payment_records` VALUES ('402', '17000046', '0', 'R150760608875774218', '1.00', '1', null, null, null, '1', '17000046', '2017-10-10 11:28:09', '17000046', '2017-10-10 11:28:09', '0');
INSERT INTO `t_payment_records` VALUES ('403', '17000075', '0', 'R150760650120652715', '10.00', '1', null, null, null, '1', '17000075', '2017-10-10 11:35:01', '17000075', '2017-10-10 11:35:01', '0');
INSERT INTO `t_payment_records` VALUES ('404', '17000075', '0', 'R150760654190862308', '10.00', '1', null, null, null, '1', '17000075', '2017-10-10 11:35:42', '17000075', '2017-10-10 11:35:42', '0');
INSERT INTO `t_payment_records` VALUES ('405', '17000075', '0', 'R150760677337632635', '50.00', '1', null, null, null, '1', '17000075', '2017-10-10 11:39:33', '17000075', '2017-10-10 11:39:33', '0');
INSERT INTO `t_payment_records` VALUES ('406', '17000060', '0', 'R150760701257374102', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:43:33', '17000060', '2017-10-10 11:43:33', '0');
INSERT INTO `t_payment_records` VALUES ('407', '17000060', '0', 'R150760702731135574', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:43:47', '17000060', '2017-10-10 11:43:47', '0');
INSERT INTO `t_payment_records` VALUES ('408', '17000060', '0', 'R150760703691219664', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:43:57', '17000060', '2017-10-10 11:43:57', '0');
INSERT INTO `t_payment_records` VALUES ('409', '17000060', '0', 'R150760707471070083', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:44:35', '17000060', '2017-10-10 11:44:35', '0');
INSERT INTO `t_payment_records` VALUES ('410', '17000060', '0', 'R150760711390014158', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:45:14', '17000060', '2017-10-10 11:45:14', '0');
INSERT INTO `t_payment_records` VALUES ('411', '17000060', '0', 'R150760715006052829', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:45:50', '17000060', '2017-10-10 11:45:50', '0');
INSERT INTO `t_payment_records` VALUES ('412', '17000060', '0', 'R150760716212556285', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:46:02', '17000060', '2017-10-10 11:46:02', '0');
INSERT INTO `t_payment_records` VALUES ('413', '17000060', '0', 'R150760717145416899', '10.00', '1', null, null, null, '1', '17000060', '2017-10-10 11:46:11', '17000060', '2017-10-10 11:46:11', '0');
INSERT INTO `t_payment_records` VALUES ('414', '17000137', '0', 'R150760836628717207', '50.00', '1', null, null, null, '1', '17000137', '2017-10-10 12:06:06', '17000137', '2017-10-10 12:06:06', '0');
INSERT INTO `t_payment_records` VALUES ('415', '17000075', '0', 'R150761846553171950', '100.00', '1', null, null, null, '1', '17000075', '2017-10-10 14:54:26', '17000075', '2017-10-10 14:54:26', '0');
INSERT INTO `t_payment_records` VALUES ('416', '17000075', '0', 'R150761847545387556', '100.00', '1', null, null, null, '1', '17000075', '2017-10-10 14:54:35', '17000075', '2017-10-10 14:54:35', '0');
INSERT INTO `t_payment_records` VALUES ('417', '17000075', '0', 'R150761850465918101', '1000.00', '1', null, null, null, '1', '17000075', '2017-10-10 14:55:05', '17000075', '2017-10-10 14:55:05', '0');
INSERT INTO `t_payment_records` VALUES ('418', '17000075', '0', 'R150761932126988532', '50.00', '1', null, null, null, '1', '17000075', '2017-10-10 15:08:41', '17000075', '2017-10-10 15:08:41', '0');
INSERT INTO `t_payment_records` VALUES ('419', '17000075', '0', 'R150761932982282455', '50.00', '1', null, null, null, '1', '17000075', '2017-10-10 15:08:50', '17000075', '2017-10-10 15:08:50', '0');
INSERT INTO `t_payment_records` VALUES ('420', '17000075', '0', 'R150761937381977664', '50.00', '1', null, null, null, '1', '17000075', '2017-10-10 15:09:34', '17000075', '2017-10-10 15:09:34', '0');
INSERT INTO `t_payment_records` VALUES ('421', '17000075', '0', 'R150761943385891033', '1000.00', '1', null, null, null, '1', '17000075', '2017-10-10 15:10:34', '17000075', '2017-10-10 15:10:34', '0');
INSERT INTO `t_payment_records` VALUES ('422', '17000060', '0', 'R150761971958725727', '1000.00', '1', null, null, null, '1', '17000060', '2017-10-10 15:15:20', '17000060', '2017-10-10 15:15:20', '0');
INSERT INTO `t_payment_records` VALUES ('423', '17000145', '0', 'R150762301033564257', '5000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:10:10', '17000145', '2017-10-10 16:10:10', '0');
INSERT INTO `t_payment_records` VALUES ('424', '17000145', '0', 'R150762304056831032', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:10:41', '17000145', '2017-10-10 16:10:41', '0');
INSERT INTO `t_payment_records` VALUES ('425', '17000145', '0', 'R150762305036453663', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:10:50', '17000145', '2017-10-10 16:10:50', '0');
INSERT INTO `t_payment_records` VALUES ('426', '17000145', '0', 'R150762307802367685', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:11:18', '17000145', '2017-10-10 16:11:18', '0');
INSERT INTO `t_payment_records` VALUES ('427', '17000145', '0', 'R150762336508866172', '500.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:16:05', '17000145', '2017-10-10 16:16:05', '0');
INSERT INTO `t_payment_records` VALUES ('428', '17000145', '0', 'R150762342680963876', '500.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:17:07', '17000145', '2017-10-10 16:17:07', '0');
INSERT INTO `t_payment_records` VALUES ('429', '17000145', '0', 'R150762344825121271', '500.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:17:28', '17000145', '2017-10-10 16:17:28', '0');
INSERT INTO `t_payment_records` VALUES ('430', '17000145', '0', 'R150762350076671569', '500.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:18:21', '17000145', '2017-10-10 16:18:21', '0');
INSERT INTO `t_payment_records` VALUES ('431', '17000145', '0', 'R150762375561536893', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:22:36', '17000145', '2017-10-10 16:22:36', '0');
INSERT INTO `t_payment_records` VALUES ('432', '17000145', '0', 'R150762376721890972', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:22:47', '17000145', '2017-10-10 16:22:47', '0');
INSERT INTO `t_payment_records` VALUES ('433', '17000145', '0', 'R150762384071858173', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:24:01', '17000145', '2017-10-10 16:24:01', '0');
INSERT INTO `t_payment_records` VALUES ('434', '17000145', '0', 'R150762403732733394', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:27:17', '17000145', '2017-10-10 16:27:17', '0');
INSERT INTO `t_payment_records` VALUES ('435', '17000145', '0', 'R150762431501475109', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:31:55', '17000145', '2017-10-10 16:31:55', '0');
INSERT INTO `t_payment_records` VALUES ('436', '17000145', '0', 'R150762438109891683', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:33:01', '17000145', '2017-10-10 16:33:01', '0');
INSERT INTO `t_payment_records` VALUES ('437', '17000145', '0', 'R150762443631363044', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:33:56', '17000145', '2017-10-10 16:33:56', '0');
INSERT INTO `t_payment_records` VALUES ('438', '17000145', '0', 'R150762466952375004', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:37:50', '17000145', '2017-10-10 16:37:50', '0');
INSERT INTO `t_payment_records` VALUES ('439', '17000145', '0', 'R150762518469265489', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:46:25', '17000145', '2017-10-10 16:46:25', '0');
INSERT INTO `t_payment_records` VALUES ('440', '17000145', '0', 'R150762525370894205', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:47:34', '17000145', '2017-10-10 16:47:34', '0');
INSERT INTO `t_payment_records` VALUES ('441', '17000145', '0', 'R150762577391451819', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:56:14', '17000145', '2017-10-10 16:56:14', '0');
INSERT INTO `t_payment_records` VALUES ('442', '17000145', '0', 'R150762579993236064', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:56:40', '17000145', '2017-10-10 16:56:40', '0');
INSERT INTO `t_payment_records` VALUES ('443', '17000145', '0', 'R150762581369291503', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 16:56:54', '17000145', '2017-10-10 16:56:54', '0');
INSERT INTO `t_payment_records` VALUES ('444', '17000145', '0', 'R150762613265988487', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:02:13', '17000145', '2017-10-10 17:02:13', '0');
INSERT INTO `t_payment_records` VALUES ('445', '17000145', '0', 'R150762618194950391', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:03:02', '17000145', '2017-10-10 17:03:02', '0');
INSERT INTO `t_payment_records` VALUES ('446', '17000145', '0', 'R150762657515010108', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:09:35', '17000145', '2017-10-10 17:09:35', '0');
INSERT INTO `t_payment_records` VALUES ('447', '17000145', '0', 'R150762661664857654', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:10:17', '17000145', '2017-10-10 17:10:17', '0');
INSERT INTO `t_payment_records` VALUES ('448', '17000145', '0', 'R150762663796322667', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:10:38', '17000145', '2017-10-10 17:10:38', '0');
INSERT INTO `t_payment_records` VALUES ('449', '17000145', '0', 'R150762686351427738', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:14:24', '17000145', '2017-10-10 17:14:24', '0');
INSERT INTO `t_payment_records` VALUES ('450', '17000145', '0', 'R150762710020519069', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:18:20', '17000145', '2017-10-10 17:18:20', '0');
INSERT INTO `t_payment_records` VALUES ('451', '17000145', '0', 'R150762794887563150', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:32:29', '17000145', '2017-10-10 17:32:29', '0');
INSERT INTO `t_payment_records` VALUES ('452', '17000145', '0', 'R150762797519158679', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:32:55', '17000145', '2017-10-10 17:32:55', '0');
INSERT INTO `t_payment_records` VALUES ('453', '17000145', '0', 'R150762798338017546', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:33:03', '17000145', '2017-10-10 17:33:03', '0');
INSERT INTO `t_payment_records` VALUES ('454', '17000145', '0', 'R150762799956755208', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:33:20', '17000145', '2017-10-10 17:33:20', '0');
INSERT INTO `t_payment_records` VALUES ('455', '17000145', '0', 'R150762801023247638', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:33:30', '17000145', '2017-10-10 17:33:30', '0');
INSERT INTO `t_payment_records` VALUES ('456', '17000145', '0', 'R150762831965881548', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:38:40', '17000145', '2017-10-10 17:38:40', '0');
INSERT INTO `t_payment_records` VALUES ('457', '17000145', '0', 'R150762832736563729', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:38:47', '17000145', '2017-10-10 17:38:47', '0');
INSERT INTO `t_payment_records` VALUES ('458', '17000145', '0', 'R150762833380855374', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:38:54', '17000145', '2017-10-10 17:38:54', '0');
INSERT INTO `t_payment_records` VALUES ('459', '17000145', '0', 'R150762833666784313', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:38:57', '17000145', '2017-10-10 17:38:57', '0');
INSERT INTO `t_payment_records` VALUES ('460', '17000145', '0', 'R150762847893793748', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:41:19', '17000145', '2017-10-10 17:41:19', '0');
INSERT INTO `t_payment_records` VALUES ('461', '17000145', '0', 'R150762852183348756', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:42:02', '17000145', '2017-10-10 17:42:02', '0');
INSERT INTO `t_payment_records` VALUES ('462', '17000145', '0', 'R150762853525433272', '5000.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:42:15', '17000145', '2017-10-10 17:42:15', '0');
INSERT INTO `t_payment_records` VALUES ('463', '17000145', '0', 'R150762902229967567', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:50:22', '17000145', '2017-10-10 17:50:22', '0');
INSERT INTO `t_payment_records` VALUES ('464', '17000145', '0', 'R150762903359037721', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:50:34', '17000145', '2017-10-10 17:50:34', '0');
INSERT INTO `t_payment_records` VALUES ('465', '17000145', '0', 'R150762903983059459', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:50:40', '17000145', '2017-10-10 17:50:40', '0');
INSERT INTO `t_payment_records` VALUES ('466', '17000145', '0', 'R150762911434031388', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 17:51:54', '17000145', '2017-10-10 17:51:54', '0');
INSERT INTO `t_payment_records` VALUES ('467', '17000145', '0', 'R150763010273558842', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:08:23', '17000145', '2017-10-10 18:08:23', '0');
INSERT INTO `t_payment_records` VALUES ('468', '17000145', '0', 'R150763026562164729', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:11:06', '17000145', '2017-10-10 18:11:06', '0');
INSERT INTO `t_payment_records` VALUES ('469', '17000145', '0', 'R150763035630228990', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:12:36', '17000145', '2017-10-10 18:12:36', '0');
INSERT INTO `t_payment_records` VALUES ('470', '17000145', '0', 'R150763075060635582', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:19:11', '17000145', '2017-10-10 18:19:11', '0');
INSERT INTO `t_payment_records` VALUES ('471', '17000145', '0', 'R150763086719684132', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:21:07', '17000145', '2017-10-10 18:21:07', '0');
INSERT INTO `t_payment_records` VALUES ('472', '17000145', '0', 'R150763095232526557', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:22:32', '17000145', '2017-10-10 18:22:32', '0');
INSERT INTO `t_payment_records` VALUES ('473', '17000145', '0', 'R150763101663275032', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:23:37', '17000145', '2017-10-10 18:23:37', '0');
INSERT INTO `t_payment_records` VALUES ('474', '17000145', '0', 'R150763264483369915', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:50:45', '17000145', '2017-10-10 18:50:45', '0');
INSERT INTO `t_payment_records` VALUES ('475', '17000145', '0', 'R150763278234620938', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:53:02', '17000145', '2017-10-10 18:53:02', '0');
INSERT INTO `t_payment_records` VALUES ('476', '17000145', '0', 'R150763288752568127', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:54:48', '17000145', '2017-10-10 18:54:48', '0');
INSERT INTO `t_payment_records` VALUES ('477', '17000145', '0', 'R150763290282325695', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:55:03', '17000145', '2017-10-10 18:55:03', '0');
INSERT INTO `t_payment_records` VALUES ('478', '17000145', '0', 'R150763298122263627', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:56:21', '17000145', '2017-10-10 18:56:21', '0');
INSERT INTO `t_payment_records` VALUES ('479', '17000145', '0', 'R150763317660010221', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 18:59:37', '17000145', '2017-10-10 18:59:37', '0');
INSERT INTO `t_payment_records` VALUES ('480', '17000145', '0', 'R150763343644630878', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:03:56', '17000145', '2017-10-10 19:03:56', '0');
INSERT INTO `t_payment_records` VALUES ('481', '17000145', '0', 'R150763354123177044', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:05:41', '17000145', '2017-10-10 19:05:41', '0');
INSERT INTO `t_payment_records` VALUES ('482', '17000145', '0', 'R150763358575651184', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:06:26', '17000145', '2017-10-10 19:06:26', '0');
INSERT INTO `t_payment_records` VALUES ('483', '17000145', '0', 'R150763371885877518', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:08:39', '17000145', '2017-10-10 19:08:39', '0');
INSERT INTO `t_payment_records` VALUES ('484', '17000145', '0', 'R150763373478346940', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:08:55', '17000145', '2017-10-10 19:08:55', '0');
INSERT INTO `t_payment_records` VALUES ('485', '17000145', '0', 'R150763385287817337', '5000.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:10:53', '17000145', '2017-10-10 19:10:53', '0');
INSERT INTO `t_payment_records` VALUES ('486', '17000145', '0', 'R150763393562080969', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:12:16', '17000145', '2017-10-10 19:12:16', '0');
INSERT INTO `t_payment_records` VALUES ('487', '17000145', '0', 'R150763402112167616', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:13:41', '17000145', '2017-10-10 19:13:41', '0');
INSERT INTO `t_payment_records` VALUES ('488', '17000145', '0', 'R150763402945799202', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:13:49', '17000145', '2017-10-10 19:13:49', '0');
INSERT INTO `t_payment_records` VALUES ('489', '17000145', '0', 'R150763406886992064', '50.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:14:29', '17000145', '2017-10-10 19:14:29', '0');
INSERT INTO `t_payment_records` VALUES ('490', '17000145', '0', 'R150763413824312104', '1000.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:15:38', '17000145', '2017-10-10 19:15:38', '0');
INSERT INTO `t_payment_records` VALUES ('491', '17000145', '0', 'R150763422455351556', '1.00', '1', null, null, null, '1', '17000145', '2017-10-10 19:17:05', '17000145', '2017-10-10 19:17:05', '0');
INSERT INTO `t_payment_records` VALUES ('492', '17000050', '0', 'R150765281109179851', '50.00', '1', null, null, null, '1', '17000050', '2017-10-11 00:26:51', '17000050', '2017-10-11 00:26:51', '0');
INSERT INTO `t_payment_records` VALUES ('493', '17000050', '0', 'R150765282854821010', '50.00', '1', null, null, null, '1', '17000050', '2017-10-11 00:27:09', '17000050', '2017-10-11 00:27:09', '0');
INSERT INTO `t_payment_records` VALUES ('494', '17000060', '0', 'R150770388598555608', '10.00', '1', null, null, null, '1', '17000060', '2017-10-11 14:38:06', '17000060', '2017-10-11 14:38:06', '0');
INSERT INTO `t_payment_records` VALUES ('495', '17000060', '0', 'R150770390819582753', '10.00', '1', null, null, null, '1', '17000060', '2017-10-11 14:38:28', '17000060', '2017-10-11 14:38:28', '0');
INSERT INTO `t_payment_records` VALUES ('496', '17000060', '0', 'R150770582445179161', '500.00', '1', null, null, null, '1', '17000060', '2017-10-11 15:10:24', '17000060', '2017-10-11 15:10:24', '0');
INSERT INTO `t_payment_records` VALUES ('497', '17000055', '0', 'R150771257335284301', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:02:53', '17000055', '2017-10-11 17:02:53', '0');
INSERT INTO `t_payment_records` VALUES ('498', '17000055', '0', 'R150771266102951216', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:04:21', '17000055', '2017-10-11 17:04:21', '0');
INSERT INTO `t_payment_records` VALUES ('499', '17000055', '0', 'R150771273956280480', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:05:40', '17000055', '2017-10-11 17:05:40', '0');
INSERT INTO `t_payment_records` VALUES ('500', '17000055', '0', 'R150771276464318474', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:06:05', '17000055', '2017-10-11 17:06:05', '0');
INSERT INTO `t_payment_records` VALUES ('501', '17000055', '0', 'R150771281017924668', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:06:50', '17000055', '2017-10-11 17:06:50', '0');
INSERT INTO `t_payment_records` VALUES ('502', '17000055', '0', 'R150771297744256776', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:09:37', '17000055', '2017-10-11 17:09:37', '0');
INSERT INTO `t_payment_records` VALUES ('503', '17000055', '0', 'R150771332548621885', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:15:25', '17000055', '2017-10-11 17:15:25', '0');
INSERT INTO `t_payment_records` VALUES ('504', '17000055', '0', 'R150771339762334576', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:16:38', '17000055', '2017-10-11 17:16:38', '0');
INSERT INTO `t_payment_records` VALUES ('505', '17000055', '0', 'R150771494776753684', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:42:28', '17000055', '2017-10-11 17:42:28', '0');
INSERT INTO `t_payment_records` VALUES ('506', '17000055', '0', 'R150771519804238318', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:46:38', '17000055', '2017-10-11 17:46:38', '0');
INSERT INTO `t_payment_records` VALUES ('507', '17000055', '0', 'R150771524730637996', '1.00', '1', null, null, null, '1', '17000055', '2017-10-11 17:47:27', '17000055', '2017-10-11 17:47:27', '0');
INSERT INTO `t_payment_records` VALUES ('508', '17000060', '0', 'R150778463877533766', '10.00', '1', null, null, null, '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_payment_records` VALUES ('509', '17000060', '0', 'R150778463897218819', '10.00', '1', null, null, null, '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_payment_records` VALUES ('510', '17000055', '0', 'R150779393881264354', '1.00', '1', null, null, null, '1', '17000055', '2017-10-12 15:38:59', '17000055', '2017-10-12 15:38:59', '0');
INSERT INTO `t_payment_records` VALUES ('511', '17000055', '0', 'R150779399394298514', '1.00', '1', null, null, null, '1', '17000055', '2017-10-12 15:39:54', '17000055', '2017-10-12 15:39:54', '0');
INSERT INTO `t_payment_records` VALUES ('512', '17000055', '0', 'R150779426922147573', '1.00', '1', null, null, null, '1', '17000055', '2017-10-12 15:44:29', '17000055', '2017-10-12 15:44:29', '0');
INSERT INTO `t_payment_records` VALUES ('513', '17000055', '0', 'R150779429817238897', '1.00', '1', null, null, null, '1', '17000055', '2017-10-12 15:44:58', '17000055', '2017-10-12 15:44:58', '0');
INSERT INTO `t_payment_records` VALUES ('514', '17000224', '0', 'R150779474944255228', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 15:52:29', '17000224', '2017-10-12 15:52:29', '0');
INSERT INTO `t_payment_records` VALUES ('515', '17000224', '0', 'R150779478938444661', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 15:53:09', '17000224', '2017-10-12 15:53:09', '0');
INSERT INTO `t_payment_records` VALUES ('516', '17000224', '0', 'R150779483631749930', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 15:53:56', '17000224', '2017-10-12 15:53:56', '0');
INSERT INTO `t_payment_records` VALUES ('517', '17000224', '0', 'R150779486805769177', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 15:54:28', '17000224', '2017-10-12 15:54:28', '0');
INSERT INTO `t_payment_records` VALUES ('518', '17000145', '0', 'R150779515193331560', '10.00', '1', null, null, null, '1', '17000145', '2017-10-12 15:59:12', '17000145', '2017-10-12 15:59:12', '0');
INSERT INTO `t_payment_records` VALUES ('519', '17000224', '0', 'R150779609812222271', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 16:14:58', '17000224', '2017-10-12 16:14:58', '0');
INSERT INTO `t_payment_records` VALUES ('520', '17000224', '0', 'R150779635222886395', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 16:19:12', '17000224', '2017-10-12 16:19:12', '0');
INSERT INTO `t_payment_records` VALUES ('521', '17000046', '0', 'R150780393655411517', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:25:37', '17000046', '2017-10-12 18:25:37', '0');
INSERT INTO `t_payment_records` VALUES ('522', '17000046', '0', 'R150780398147269221', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:26:21', '17000046', '2017-10-12 18:26:21', '0');
INSERT INTO `t_payment_records` VALUES ('523', '17000046', '0', 'R150780404586061729', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:27:26', '17000046', '2017-10-12 18:27:26', '0');
INSERT INTO `t_payment_records` VALUES ('524', '17000046', '0', 'R150780409976582941', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:28:20', '17000046', '2017-10-12 18:28:20', '0');
INSERT INTO `t_payment_records` VALUES ('525', '17000046', '0', 'R150780447535897271', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:34:35', '17000046', '2017-10-12 18:34:35', '0');
INSERT INTO `t_payment_records` VALUES ('526', '17000046', '0', 'R150780453746699709', '50.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:35:37', '17000046', '2017-10-12 18:35:37', '0');
INSERT INTO `t_payment_records` VALUES ('527', '17000046', '0', 'R150780457468810752', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:36:15', '17000046', '2017-10-12 18:36:15', '0');
INSERT INTO `t_payment_records` VALUES ('528', '17000046', '0', 'R150780461781340731', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:36:58', '17000046', '2017-10-12 18:36:58', '0');
INSERT INTO `t_payment_records` VALUES ('529', '17000073', '0', 'R150780475303154694', '10.00', '1', null, null, null, '1', '17000073', '2017-10-12 18:39:13', '17000073', '2017-10-12 18:39:13', '0');
INSERT INTO `t_payment_records` VALUES ('530', '17000046', '0', 'R150780487171450792', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 18:41:12', '17000046', '2017-10-12 18:41:12', '0');
INSERT INTO `t_payment_records` VALUES ('531', '17000224', '0', 'R150780570819211528', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 18:55:08', '17000224', '2017-10-12 18:55:08', '0');
INSERT INTO `t_payment_records` VALUES ('532', '17000224', '0', 'R150780576528997837', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 18:56:05', '17000224', '2017-10-12 18:56:05', '0');
INSERT INTO `t_payment_records` VALUES ('533', '17000224', '0', 'R150780594313116960', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 18:59:03', '17000224', '2017-10-12 18:59:03', '0');
INSERT INTO `t_payment_records` VALUES ('534', '17000224', '0', 'R150780608645351246', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 19:01:26', '17000224', '2017-10-12 19:01:26', '0');
INSERT INTO `t_payment_records` VALUES ('535', '17000043', '0', 'R150780611324617299', '1.00', '1', null, null, null, '1', '17000043', '2017-10-12 19:01:53', '17000043', '2017-10-12 19:01:53', '0');
INSERT INTO `t_payment_records` VALUES ('536', '17000224', '0', 'R150780645342719318', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 19:07:33', '17000224', '2017-10-12 19:07:33', '0');
INSERT INTO `t_payment_records` VALUES ('537', '17000043', '0', 'R150780649751387139', '1.00', '1', null, null, null, '1', '17000043', '2017-10-12 19:08:18', '17000043', '2017-10-12 19:08:18', '0');
INSERT INTO `t_payment_records` VALUES ('538', '17000043', '0', 'R150780661978747970', '1.00', '1', null, null, null, '1', '17000043', '2017-10-12 19:10:20', '17000043', '2017-10-12 19:10:20', '0');
INSERT INTO `t_payment_records` VALUES ('539', '17000043', '0', 'R150780673077718688', '1.00', '1', null, null, null, '1', '17000043', '2017-10-12 19:12:11', '17000043', '2017-10-12 19:12:11', '0');
INSERT INTO `t_payment_records` VALUES ('540', '17000046', '0', 'R150780708357488710', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 19:18:04', '17000046', '2017-10-12 19:18:04', '0');
INSERT INTO `t_payment_records` VALUES ('541', '17000055', '0', 'R150780784251949100', '1.00', '1', null, null, null, '1', '17000055', '2017-10-12 19:30:43', '17000055', '2017-10-12 19:30:43', '0');
INSERT INTO `t_payment_records` VALUES ('542', '17000224', '0', 'R150780797706334180', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 19:32:57', '17000224', '2017-10-12 19:32:57', '0');
INSERT INTO `t_payment_records` VALUES ('543', '17000224', '0', 'R150780799539433674', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 19:33:15', '17000224', '2017-10-12 19:33:15', '0');
INSERT INTO `t_payment_records` VALUES ('544', '17000043', '0', 'R150780908157896034', '1.00', '1', null, null, null, '1', '17000043', '2017-10-12 19:51:22', '17000043', '2017-10-12 19:51:22', '0');
INSERT INTO `t_payment_records` VALUES ('545', '17000046', '0', 'R150780924939946567', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 19:54:09', '17000046', '2017-10-12 19:54:09', '0');
INSERT INTO `t_payment_records` VALUES ('546', '17000060', '0', 'R150781245977760107', '10.00', '1', null, null, null, '1', '17000060', '2017-10-12 20:47:40', '17000060', '2017-10-12 20:47:40', '0');
INSERT INTO `t_payment_records` VALUES ('547', '17000046', '0', 'R150781359028041296', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:06:30', '17000046', '2017-10-12 21:06:30', '0');
INSERT INTO `t_payment_records` VALUES ('548', '17000046', '0', 'R150781361100359102', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:06:51', '17000046', '2017-10-12 21:06:51', '0');
INSERT INTO `t_payment_records` VALUES ('549', '17000148', '0', 'R150781365304128488', '1.00', '1', null, null, null, '1', '17000148', '2017-10-12 21:07:33', '17000148', '2017-10-12 21:07:33', '0');
INSERT INTO `t_payment_records` VALUES ('550', '17000046', '0', 'R150781366443241178', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:07:44', '17000046', '2017-10-12 21:07:44', '0');
INSERT INTO `t_payment_records` VALUES ('551', '17000148', '0', 'R150781368300348659', '10.00', '1', null, null, null, '1', '17000148', '2017-10-12 21:08:03', '17000148', '2017-10-12 21:08:03', '0');
INSERT INTO `t_payment_records` VALUES ('552', '17000046', '0', 'R150781369848037592', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:08:18', '17000046', '2017-10-12 21:08:18', '0');
INSERT INTO `t_payment_records` VALUES ('553', '17000148', '0', 'R150781372038868221', '1.00', '1', null, null, null, '1', '17000148', '2017-10-12 21:08:40', '17000148', '2017-10-12 21:08:40', '0');
INSERT INTO `t_payment_records` VALUES ('554', '17000046', '0', 'R150781372098788184', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:08:41', '17000046', '2017-10-12 21:08:41', '0');
INSERT INTO `t_payment_records` VALUES ('555', '17000046', '0', 'R150781373733949264', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:08:57', '17000046', '2017-10-12 21:08:57', '0');
INSERT INTO `t_payment_records` VALUES ('556', '17000046', '0', 'R150781375780292513', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:09:18', '17000046', '2017-10-12 21:09:18', '0');
INSERT INTO `t_payment_records` VALUES ('557', '17000046', '0', 'R150781378729555095', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:09:47', '17000046', '2017-10-12 21:09:47', '0');
INSERT INTO `t_payment_records` VALUES ('558', '17000148', '0', 'R150781384593539037', '10.00', '1', null, null, null, '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_payment_records` VALUES ('559', '17000148', '0', 'R150781384594251299', '10.00', '1', null, null, null, '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_payment_records` VALUES ('560', '17000046', '0', 'R150781405522563665', '2.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:14:15', '17000046', '2017-10-12 21:14:15', '0');
INSERT INTO `t_payment_records` VALUES ('561', '17000046', '0', 'R150781414476168957', '2.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:15:45', '17000046', '2017-10-12 21:15:45', '0');
INSERT INTO `t_payment_records` VALUES ('562', '17000046', '0', 'R150781417287929718', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:16:13', '17000046', '2017-10-12 21:16:13', '0');
INSERT INTO `t_payment_records` VALUES ('563', '17000060', '0', 'R150781435931137098', '10.00', '1', null, null, null, '1', '17000060', '2017-10-12 21:19:19', '17000060', '2017-10-12 21:19:19', '0');
INSERT INTO `t_payment_records` VALUES ('564', '17000060', '0', 'R150781438693226496', '1.00', '1', null, null, null, '1', '17000060', '2017-10-12 21:19:47', '17000060', '2017-10-12 21:19:47', '0');
INSERT INTO `t_payment_records` VALUES ('565', '17000224', '0', 'R150781439882042217', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 21:19:59', '17000224', '2017-10-12 21:19:59', '0');
INSERT INTO `t_payment_records` VALUES ('566', '17000060', '0', 'R150781441295744089', '1.00', '1', null, null, null, '1', '17000060', '2017-10-12 21:20:13', '17000060', '2017-10-12 21:20:13', '0');
INSERT INTO `t_payment_records` VALUES ('567', '17000046', '0', 'R150781443225335601', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:20:32', '17000046', '2017-10-12 21:20:32', '0');
INSERT INTO `t_payment_records` VALUES ('568', '17000046', '0', 'R150781451063759996', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:21:51', '17000046', '2017-10-12 21:21:51', '0');
INSERT INTO `t_payment_records` VALUES ('569', '17000046', '0', 'R150781458663444667', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:23:07', '17000046', '2017-10-12 21:23:07', '0');
INSERT INTO `t_payment_records` VALUES ('570', '17000046', '0', 'R150781461671385756', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:23:37', '17000046', '2017-10-12 21:23:37', '0');
INSERT INTO `t_payment_records` VALUES ('571', '17000046', '0', 'R150781467884071616', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:24:39', '17000046', '2017-10-12 21:24:39', '0');
INSERT INTO `t_payment_records` VALUES ('572', '17000046', '0', 'R150781474679729759', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:25:47', '17000046', '2017-10-12 21:25:47', '0');
INSERT INTO `t_payment_records` VALUES ('573', '17000046', '0', 'R150781485892673387', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:27:39', '17000046', '2017-10-12 21:27:39', '0');
INSERT INTO `t_payment_records` VALUES ('574', '17000046', '0', 'R150781503130523958', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:30:31', '17000046', '2017-10-12 21:30:31', '0');
INSERT INTO `t_payment_records` VALUES ('575', '17000046', '0', 'R150781520608272826', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:33:26', '17000046', '2017-10-12 21:33:26', '0');
INSERT INTO `t_payment_records` VALUES ('576', '17000046', '0', 'R150781527273531208', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:34:33', '17000046', '2017-10-12 21:34:33', '0');
INSERT INTO `t_payment_records` VALUES ('577', '17000046', '0', 'R150781535732569451', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:35:57', '17000046', '2017-10-12 21:35:57', '0');
INSERT INTO `t_payment_records` VALUES ('578', '17000046', '0', 'R150781544201015194', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:37:22', '17000046', '2017-10-12 21:37:22', '0');
INSERT INTO `t_payment_records` VALUES ('579', '17000224', '0', 'R150781559960769143', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 21:40:00', '17000224', '2017-10-12 21:40:00', '0');
INSERT INTO `t_payment_records` VALUES ('580', '17000046', '0', 'R150781564208118858', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:40:42', '17000046', '2017-10-12 21:40:42', '0');
INSERT INTO `t_payment_records` VALUES ('581', '17000046', '0', 'R150781582493759753', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:43:45', '17000046', '2017-10-12 21:43:45', '0');
INSERT INTO `t_payment_records` VALUES ('582', '17000046', '0', 'R150781585325321253', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:44:13', '17000046', '2017-10-12 21:44:13', '0');
INSERT INTO `t_payment_records` VALUES ('583', '17000046', '0', 'R150781616264877170', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 21:49:23', '17000046', '2017-10-12 21:49:23', '0');
INSERT INTO `t_payment_records` VALUES ('584', '17000046', '0', 'R150781951846293465', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 22:45:18', '17000046', '2017-10-12 22:45:18', '0');
INSERT INTO `t_payment_records` VALUES ('585', '17000046', '0', 'R150781954965516409', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 22:45:50', '17000046', '2017-10-12 22:45:50', '0');
INSERT INTO `t_payment_records` VALUES ('586', '17000046', '0', 'R150781957827712598', '10.00', '1', null, null, null, '1', '17000046', '2017-10-12 22:46:18', '17000046', '2017-10-12 22:46:18', '0');
INSERT INTO `t_payment_records` VALUES ('587', '17000046', '0', 'R150781961003266885', '1.00', '1', null, null, null, '1', '17000046', '2017-10-12 22:46:50', '17000046', '2017-10-12 22:46:50', '0');
INSERT INTO `t_payment_records` VALUES ('588', '17000224', '0', 'R150781976144436719', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:49:21', '17000224', '2017-10-12 22:49:21', '0');
INSERT INTO `t_payment_records` VALUES ('589', '17000224', '0', 'R150781985042762100', '10.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:50:50', '17000224', '2017-10-12 22:50:50', '0');
INSERT INTO `t_payment_records` VALUES ('590', '17000224', '0', 'R150781987765771740', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:51:18', '17000224', '2017-10-12 22:51:18', '0');
INSERT INTO `t_payment_records` VALUES ('591', '17000224', '0', 'R150781991257427486', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:51:53', '17000224', '2017-10-12 22:51:53', '0');
INSERT INTO `t_payment_records` VALUES ('592', '17000224', '0', 'R150782013190320814', '2.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:55:32', '17000224', '2017-10-12 22:55:32', '0');
INSERT INTO `t_payment_records` VALUES ('593', '17000224', '0', 'R150782015928733513', '1.00', '1', null, null, null, '1', '17000224', '2017-10-12 22:55:59', '17000224', '2017-10-12 22:55:59', '0');
INSERT INTO `t_payment_records` VALUES ('594', '17000148', '0', 'R150782016526137791', '1.00', '1', null, null, null, '1', '17000148', '2017-10-12 22:56:05', '17000148', '2017-10-12 22:56:05', '0');
INSERT INTO `t_payment_records` VALUES ('595', '17000148', '0', 'R150782019041621787', '10.00', '1', null, null, null, '1', '17000148', '2017-10-12 22:56:30', '17000148', '2017-10-12 22:56:30', '0');
INSERT INTO `t_payment_records` VALUES ('596', '17000060', '0', 'R150787483092475650', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:07:11', '17000060', '2017-10-13 14:07:11', '0');
INSERT INTO `t_payment_records` VALUES ('597', '17000060', '0', 'R150787488402888131', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:08:04', '17000060', '2017-10-13 14:08:04', '0');
INSERT INTO `t_payment_records` VALUES ('598', '17000073', '0', 'R150787492494172730', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:08:45', '17000073', '2017-10-13 14:08:45', '0');
INSERT INTO `t_payment_records` VALUES ('599', '17000044', '0', 'R150787494917052155', '1.00', '1', null, null, null, '1', '17000044', '2017-10-13 14:09:09', '17000044', '2017-10-13 14:09:09', '0');
INSERT INTO `t_payment_records` VALUES ('600', '17000073', '0', 'R150787498707450470', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:09:47', '17000073', '2017-10-13 14:09:47', '0');
INSERT INTO `t_payment_records` VALUES ('601', '17000044', '0', 'R150787499684639261', '1.00', '1', null, null, null, '1', '17000044', '2017-10-13 14:09:57', '17000044', '2017-10-13 14:09:57', '0');
INSERT INTO `t_payment_records` VALUES ('602', '17000073', '0', 'R150787513107532670', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:12:11', '17000073', '2017-10-13 14:12:11', '0');
INSERT INTO `t_payment_records` VALUES ('603', '17000073', '0', 'R150787518098919136', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:13:01', '17000073', '2017-10-13 14:13:01', '0');
INSERT INTO `t_payment_records` VALUES ('604', '17000073', '0', 'R150787523324055902', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:13:53', '17000073', '2017-10-13 14:13:53', '0');
INSERT INTO `t_payment_records` VALUES ('605', '17000224', '0', 'R150787581358044252', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:23:34', '17000224', '2017-10-13 14:23:34', '0');
INSERT INTO `t_payment_records` VALUES ('606', '17000224', '0', 'R150787584595239282', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_payment_records` VALUES ('607', '17000224', '0', 'R150787584595720355', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_payment_records` VALUES ('608', '17000224', '0', 'R150787592052664545', '10.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:25:21', '17000224', '2017-10-13 14:25:21', '0');
INSERT INTO `t_payment_records` VALUES ('609', '17000060', '0', 'R150787614481115526', '1.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:29:05', '17000060', '2017-10-13 14:29:05', '0');
INSERT INTO `t_payment_records` VALUES ('610', '17000224', '0', 'R150787617749414281', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:29:37', '17000224', '2017-10-13 14:29:37', '0');
INSERT INTO `t_payment_records` VALUES ('611', '17000224', '0', 'R150787622743421111', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:30:27', '17000224', '2017-10-13 14:30:27', '0');
INSERT INTO `t_payment_records` VALUES ('612', '17000224', '0', 'R150787624802336581', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:30:48', '17000224', '2017-10-13 14:30:48', '0');
INSERT INTO `t_payment_records` VALUES ('613', '17000060', '0', 'R150787638422210215', '1.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:33:04', '17000060', '2017-10-13 14:33:04', '0');
INSERT INTO `t_payment_records` VALUES ('614', '17000060', '0', 'R150787642641279793', '1.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:33:46', '17000060', '2017-10-13 14:33:46', '0');
INSERT INTO `t_payment_records` VALUES ('615', '17000060', '0', 'R150787649263832717', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:34:53', '17000060', '2017-10-13 14:34:53', '0');
INSERT INTO `t_payment_records` VALUES ('616', '17000073', '0', 'R150787649342943899', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:34:53', '17000073', '2017-10-13 14:34:53', '0');
INSERT INTO `t_payment_records` VALUES ('617', '17000060', '0', 'R150787656090619035', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:36:01', '17000060', '2017-10-13 14:36:01', '0');
INSERT INTO `t_payment_records` VALUES ('618', '17000073', '0', 'R150787658750367860', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 14:36:28', '17000073', '2017-10-13 14:36:28', '0');
INSERT INTO `t_payment_records` VALUES ('619', '17000060', '0', 'R150787669997798750', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:38:20', '17000060', '2017-10-13 14:38:20', '0');
INSERT INTO `t_payment_records` VALUES ('620', '17000060', '0', 'R150787679165413332', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 14:39:52', '17000060', '2017-10-13 14:39:52', '0');
INSERT INTO `t_payment_records` VALUES ('621', '17000224', '0', 'R150787691071170987', '10.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:41:51', '17000224', '2017-10-13 14:41:51', '0');
INSERT INTO `t_payment_records` VALUES ('622', '17000224', '0', 'R150787717013514636', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:46:10', '17000224', '2017-10-13 14:46:10', '0');
INSERT INTO `t_payment_records` VALUES ('623', '17000224', '0', 'R150787725601891543', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:47:36', '17000224', '2017-10-13 14:47:36', '0');
INSERT INTO `t_payment_records` VALUES ('624', '17000224', '0', 'R150787791366527539', '2.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:58:34', '17000224', '2017-10-13 14:58:34', '0');
INSERT INTO `t_payment_records` VALUES ('625', '17000224', '0', 'R150787795114771395', '2.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:59:11', '17000224', '2017-10-13 14:59:11', '0');
INSERT INTO `t_payment_records` VALUES ('626', '17000224', '0', 'R150787797371223699', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 14:59:34', '17000224', '2017-10-13 14:59:34', '0');
INSERT INTO `t_payment_records` VALUES ('627', '17000224', '0', 'R150787808630927498', '2.00', '1', null, null, null, '1', '17000224', '2017-10-13 15:01:26', '17000224', '2017-10-13 15:01:26', '0');
INSERT INTO `t_payment_records` VALUES ('628', '17000224', '0', 'R150787826778152620', '2.00', '1', null, null, null, '1', '17000224', '2017-10-13 15:04:28', '17000224', '2017-10-13 15:04:28', '0');
INSERT INTO `t_payment_records` VALUES ('629', '17000224', '0', 'R150787828267250132', '10.00', '1', null, null, null, '1', '17000224', '2017-10-13 15:04:43', '17000224', '2017-10-13 15:04:43', '0');
INSERT INTO `t_payment_records` VALUES ('630', '17000224', '0', 'R150787830811817408', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 15:05:08', '17000224', '2017-10-13 15:05:08', '0');
INSERT INTO `t_payment_records` VALUES ('631', '17000224', '0', 'R150787834587693814', '1.00', '1', null, null, null, '1', '17000224', '2017-10-13 15:05:46', '17000224', '2017-10-13 15:05:46', '0');
INSERT INTO `t_payment_records` VALUES ('632', '17000073', '0', 'R150788063060213670', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 15:43:51', '17000073', '2017-10-13 15:43:51', '0');
INSERT INTO `t_payment_records` VALUES ('633', '17000073', '0', 'R150788073132238594', '10.00', '1', null, null, null, '1', '17000073', '2017-10-13 15:45:31', '17000073', '2017-10-13 15:45:31', '0');
INSERT INTO `t_payment_records` VALUES ('634', '17000148', '0', 'R150788082454779927', '1.00', '1', null, null, null, '1', '17000148', '2017-10-13 15:47:05', '17000148', '2017-10-13 15:47:05', '0');
INSERT INTO `t_payment_records` VALUES ('635', '17000055', '0', 'R150788459868774734', '1.00', '1', null, null, null, '1', '17000055', '2017-10-13 16:49:59', '17000055', '2017-10-13 16:49:59', '0');
INSERT INTO `t_payment_records` VALUES ('636', '17000043', '0', 'R150788102984771235', '10.00', '1', null, null, null, '1', '17000043', '2017-10-13 15:50:30', '17000043', '2017-10-13 15:50:30', '0');
INSERT INTO `t_payment_records` VALUES ('637', '17000043', '0', 'R150788104791367119', '10.00', '1', null, null, null, '1', '17000043', '2017-10-13 15:50:48', '17000043', '2017-10-13 15:50:48', '0');
INSERT INTO `t_payment_records` VALUES ('638', '17000060', '0', 'R150788120061662500', '10.00', '1', null, null, null, '1', '17000060', '2017-10-13 15:53:21', '17000060', '2017-10-13 15:53:21', '0');
INSERT INTO `t_payment_records` VALUES ('639', '17000060', '0', 'R150788122717359447', '1.00', '1', null, null, null, '1', '17000060', '2017-10-13 15:53:47', '17000060', '2017-10-13 15:53:47', '0');
INSERT INTO `t_payment_records` VALUES ('640', '17000224', '0', 'R150795814583496674', '1.00', '1', null, null, null, '1', '17000224', '2017-10-14 13:15:46', '17000224', '2017-10-14 13:15:46', '0');
INSERT INTO `t_payment_records` VALUES ('641', '17000224', '0', 'R150796278959163240', '1.00', '1', null, null, null, '1', '17000224', '2017-10-14 14:33:10', '17000224', '2017-10-14 14:33:10', '0');
INSERT INTO `t_payment_records` VALUES ('642', '17000046', '0', 'R150796706915434353', '1.00', '1', null, null, null, '1', '17000046', '2017-10-14 15:44:29', '17000046', '2017-10-14 15:44:29', '0');
INSERT INTO `t_payment_records` VALUES ('643', '17000046', '0', 'R150796711448067190', '1.00', '1', null, null, null, '1', '17000046', '2017-10-14 15:45:14', '17000046', '2017-10-14 15:45:14', '0');
INSERT INTO `t_payment_records` VALUES ('644', '17000137', '0', 'R150806747860788372', '50.00', '1', null, null, null, '1', '17000137', '2017-10-15 19:37:59', '17000137', '2017-10-15 19:37:59', '0');
INSERT INTO `t_payment_records` VALUES ('645', '17000137', '0', 'R150806760131979045', '50.00', '1', null, null, null, '1', '17000137', '2017-10-15 19:40:01', '17000137', '2017-10-15 19:40:01', '0');
INSERT INTO `t_payment_records` VALUES ('646', '17000055', '0', 'R150812637800155550', '1.00', '1', null, null, null, '1', '17000055', '2017-10-16 11:59:38', '17000055', '2017-10-16 11:59:38', '0');
INSERT INTO `t_payment_records` VALUES ('647', '17000055', '0', 'R150812966080478922', '10.00', '1', null, null, null, '1', '17000055', '2017-10-16 12:54:21', '17000055', '2017-10-16 12:54:21', '0');
INSERT INTO `t_payment_records` VALUES ('648', '17000055', '0', 'R150812974109871971', '5000.00', '1', null, null, null, '1', '17000055', '2017-10-16 12:55:41', '17000055', '2017-10-16 12:55:41', '0');
INSERT INTO `t_payment_records` VALUES ('649', '17000055', '0', 'R150812977386628546', '5000.00', '1', null, null, null, '1', '17000055', '2017-10-16 12:56:14', '17000055', '2017-10-16 12:56:14', '0');
INSERT INTO `t_payment_records` VALUES ('650', '17000055', '0', 'R150814481721161147', '1.00', '1', null, null, null, '1', '17000055', '2017-10-16 17:06:57', '17000055', '2017-10-16 17:06:57', '0');
INSERT INTO `t_payment_records` VALUES ('651', '17000055', '0', 'R150814482835425331', '10.00', '1', null, null, null, '1', '17000055', '2017-10-16 17:07:08', '17000055', '2017-10-16 17:07:08', '0');
INSERT INTO `t_payment_records` VALUES ('652', '17000055', '0', 'R150814484204387776', '10.00', '1', null, null, null, '1', '17000055', '2017-10-16 17:07:22', '17000055', '2017-10-16 17:07:22', '0');
INSERT INTO `t_payment_records` VALUES ('653', '17000226', '0', 'R150814662776265915', '10.00', '1', null, null, null, '1', '17000226', '2017-10-16 17:37:08', '17000226', '2017-10-16 17:37:08', '0');
INSERT INTO `t_payment_records` VALUES ('654', '17000137', '0', 'R150816647677386537', '50.00', '1', null, null, null, '1', '17000137', '2017-10-16 23:07:57', '17000137', '2017-10-16 23:07:57', '0');
INSERT INTO `t_payment_records` VALUES ('655', '17000137', '0', 'R150816649034235325', '50.00', '1', null, null, null, '1', '17000137', '2017-10-16 23:08:10', '17000137', '2017-10-16 23:08:10', '0');
INSERT INTO `t_payment_records` VALUES ('656', '17000137', '0', 'R150816650968967387', '50.00', '1', null, null, null, '1', '17000137', '2017-10-16 23:08:30', '17000137', '2017-10-16 23:08:30', '0');
INSERT INTO `t_payment_records` VALUES ('657', '17000228', '0', 'R150839153351964765', '50.00', '1', null, null, null, '1', '17000228', '2017-10-19 13:38:54', '17000228', '2017-10-19 13:38:54', '0');
INSERT INTO `t_payment_records` VALUES ('658', '17000137', '0', 'R150866638785617162', '50.00', '1', null, null, null, '1', '17000137', '2017-10-22 17:59:48', '17000137', '2017-10-22 17:59:48', '0');
INSERT INTO `t_payment_records` VALUES ('659', '17000137', '0', 'R150874863686841858', '100.00', '1', null, null, null, '1', '17000137', '2017-10-23 16:50:37', '17000137', '2017-10-23 16:50:37', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payments
-- ----------------------------
INSERT INTO `t_payments` VALUES ('255', '5', '0', '10.00', '1', null, '314', '1', '17000060', '2017-09-21 19:41:46', '17000060', '2017-09-21 19:41:46', '0');
INSERT INTO `t_payments` VALUES ('256', '2', '0', '10.00', '1', null, '315', '1', '17000060', '2017-09-21 19:42:06', '17000060', '2017-09-21 19:42:06', '0');
INSERT INTO `t_payments` VALUES ('257', '2', '0', '10.00', '2', '11718152603459300971', '316', '2', '17000050', '2017-09-21 20:56:27', '17000050', '2017-09-21 20:56:27', '0');
INSERT INTO `t_payments` VALUES ('258', '5', '0', '10.00', '1', null, '317', '1', '17000060', '2017-09-22 11:36:55', '17000060', '2017-09-22 11:36:55', '0');
INSERT INTO `t_payments` VALUES ('259', '2', '0', '1.00', '2', '11716446571685600893', '318', '2', '17000046', '2017-09-22 12:27:14', '17000046', '2017-09-22 12:27:14', '0');
INSERT INTO `t_payments` VALUES ('260', '2', '0', '50.00', '1', null, '319', '1', '17000066', '2017-09-22 12:34:07', '17000066', '2017-09-22 12:34:07', '0');
INSERT INTO `t_payments` VALUES ('261', '2', '0', '1.00', '2', '11716551506251646870', '320', '2', '17000046', '2017-09-22 15:42:00', '17000046', '2017-09-22 16:46:08', '0');
INSERT INTO `t_payments` VALUES ('262', '1', '0', '50.00', '1', null, '321', '1', '17000060', '2017-09-22 17:33:31', '17000060', '2017-09-22 17:33:31', '0');
INSERT INTO `t_payments` VALUES ('263', '5', '0', '1.00', '1', null, '322', '1', '17000060', '2017-09-22 18:10:45', '17000060', '2017-09-22 18:10:45', '0');
INSERT INTO `t_payments` VALUES ('264', '2', '0', '1.00', '2', '11710056410190656714', '323', '2', '17000060', '2017-09-22 18:10:58', '17000060', '2017-09-22 19:13:47', '0');
INSERT INTO `t_payments` VALUES ('265', '5', '0', '10.00', '1', null, '324', '1', '17000050', '2017-09-22 23:30:03', '17000050', '2017-09-22 23:30:03', '0');
INSERT INTO `t_payments` VALUES ('266', '2', '0', '10.00', '2', '11710818225456916061', '325', '2', '17000050', '2017-09-22 23:30:26', '17000050', '2017-09-23 14:29:52', '0');
INSERT INTO `t_payments` VALUES ('267', '2', '0', '10.00', '1', null, '326', '1', '17000050', '2017-09-22 23:30:27', '17000050', '2017-09-22 23:30:27', '0');
INSERT INTO `t_payments` VALUES ('268', '2', '0', '1.00', '2', '11711597009836560915', '327', '2', '17000046', '2017-09-23 11:02:35', '17000046', '2017-09-23 12:05:45', '0');
INSERT INTO `t_payments` VALUES ('269', '2', '0', '10.00', '2', '11711627144265093138', '328', '2', '17000050', '2017-09-23 12:51:36', '17000050', '2017-09-23 12:52:10', '0');
INSERT INTO `t_payments` VALUES ('270', '2', '0', '1.00', '2', '11712621164850315871', '329', '2', '17000046', '2017-09-23 15:20:44', '17000046', '2017-09-23 16:23:44', '0');
INSERT INTO `t_payments` VALUES ('271', '1', '0', '1.00', '2', '11717040508611585081', '330', '2', '17000046', '2017-09-23 16:07:33', '17000046', '2017-09-23 17:12:05', '0');
INSERT INTO `t_payments` VALUES ('272', '2', '0', '1.00', '1', null, '331', '1', '17000046', '2017-09-23 16:41:33', '17000046', '2017-09-23 16:41:33', '0');
INSERT INTO `t_payments` VALUES ('273', '2', '0', '2.00', '1', null, '332', '1', '17000046', '2017-09-23 17:48:24', '17000046', '2017-09-23 17:48:24', '0');
INSERT INTO `t_payments` VALUES ('274', '2', '0', '500.00', '1', null, '333', '1', '17000043', '2017-09-23 18:15:26', '17000043', '2017-09-23 18:15:26', '0');
INSERT INTO `t_payments` VALUES ('275', '2', '0', '10.00', '1', null, '334', '1', '17000046', '2017-09-23 18:35:23', '17000046', '2017-09-23 18:35:23', '0');
INSERT INTO `t_payments` VALUES ('276', '2', '0', '10.00', '1', null, '335', '1', '17000046', '2017-09-23 18:35:36', '17000046', '2017-09-23 18:35:36', '0');
INSERT INTO `t_payments` VALUES ('277', '1', '0', '1000.00', '1', null, '336', '1', '17000077', '2017-09-24 20:14:44', '17000077', '2017-09-24 20:14:44', '0');
INSERT INTO `t_payments` VALUES ('278', '5', '0', '50.00', '1', null, '337', '1', '17000050', '2017-09-25 14:36:45', '17000050', '2017-09-25 14:36:45', '0');
INSERT INTO `t_payments` VALUES ('279', '2', '0', '10.00', '1', null, '338', '1', '17000060', '2017-09-25 14:36:50', '17000060', '2017-09-25 14:36:50', '0');
INSERT INTO `t_payments` VALUES ('280', '5', '0', '10.00', '1', null, '339', '1', '17000050', '2017-09-25 14:37:11', '17000050', '2017-09-25 14:37:11', '0');
INSERT INTO `t_payments` VALUES ('281', '2', '0', '10.00', '2', '11713014290721603445', '340', '2', '17000050', '2017-09-25 14:37:36', '17000050', '2017-09-25 15:41:03', '0');
INSERT INTO `t_payments` VALUES ('282', '5', '0', '50.00', '1', null, '341', '1', '17000060', '2017-09-25 14:37:39', '17000060', '2017-09-25 14:37:39', '0');
INSERT INTO `t_payments` VALUES ('283', '2', '0', '10.00', '1', null, '342', '1', '17000060', '2017-09-25 14:38:02', '17000060', '2017-09-25 14:38:02', '0');
INSERT INTO `t_payments` VALUES ('284', '1', '0', '1.00', '1', null, '343', '1', '17000060', '2017-09-25 14:38:42', '17000060', '2017-09-25 14:38:42', '0');
INSERT INTO `t_payments` VALUES ('285', '5', '0', '480.00', '1', null, '344', '1', '17000079', '2017-09-25 18:53:17', '17000079', '2017-09-25 18:53:17', '0');
INSERT INTO `t_payments` VALUES ('286', '2', '0', '480.00', '1', null, '345', '1', '17000079', '2017-09-25 18:53:39', '17000079', '2017-09-25 18:53:39', '0');
INSERT INTO `t_payments` VALUES ('287', '2', '0', '10.00', '2', '11712359683175051947', '346', '2', '17000083', '2017-09-26 11:48:41', '17000083', '2017-09-26 12:52:03', '0');
INSERT INTO `t_payments` VALUES ('288', '2', '0', '1.00', '2', '11712666086654134006', '347', '2', '17000046', '2017-09-26 14:16:08', '17000046', '2017-09-26 14:17:45', '0');
INSERT INTO `t_payments` VALUES ('289', '2', '0', '100.00', '1', null, '348', '1', '17000084', '2017-09-27 00:48:00', '17000084', '2017-09-27 00:48:00', '0');
INSERT INTO `t_payments` VALUES ('290', '2', '0', '100.00', '1', null, '349', '1', '17000084', '2017-09-27 05:21:11', '17000084', '2017-09-27 05:21:11', '0');
INSERT INTO `t_payments` VALUES ('291', '5', '0', '100.00', '1', null, '350', '1', '17000084', '2017-09-27 05:21:48', '17000084', '2017-09-27 05:21:48', '0');
INSERT INTO `t_payments` VALUES ('292', '2', '0', '50.00', '1', null, '351', '1', '17000050', '2017-09-27 14:18:45', '17000050', '2017-09-27 14:18:45', '0');
INSERT INTO `t_payments` VALUES ('293', '2', '0', '20.00', '2', '11714591340950322368', '352', '2', '17000052', '2017-09-27 14:48:13', '17000052', '2017-09-27 14:48:45', '0');
INSERT INTO `t_payments` VALUES ('294', '2', '0', '10.00', '1', null, '353', '1', '17000086', '2017-09-28 01:51:36', '17000086', '2017-09-28 01:51:36', '0');
INSERT INTO `t_payments` VALUES ('295', '1', '0', '5000.00', '1', null, '354', '1', '17000086', '2017-09-28 01:53:55', '17000086', '2017-09-28 01:53:55', '0');
INSERT INTO `t_payments` VALUES ('296', '5', '0', '10.00', '1', null, '355', '1', '17000050', '2017-09-28 08:27:48', '17000050', '2017-09-28 08:27:48', '0');
INSERT INTO `t_payments` VALUES ('297', '2', '0', '10.00', '2', '11710982510754186515', '356', '2', '17000050', '2017-09-28 08:28:21', '17000050', '2017-09-28 08:28:45', '0');
INSERT INTO `t_payments` VALUES ('298', '5', '0', '100.00', '1', null, '357', '1', '17000135', '2017-09-30 15:45:35', '17000135', '2017-09-30 15:45:35', '0');
INSERT INTO `t_payments` VALUES ('299', '2', '0', '100.00', '1', null, '358', '1', '17000135', '2017-09-30 15:47:01', '17000135', '2017-09-30 15:47:01', '0');
INSERT INTO `t_payments` VALUES ('301', '2', '0', '1.00', '1', null, '360', '1', '17000133', '2017-09-30 15:47:18', '17000133', '2017-09-30 15:47:18', '0');
INSERT INTO `t_payments` VALUES ('302', '5', '0', '100.00', '1', null, '361', '1', '17000135', '2017-09-30 15:54:27', '17000135', '2017-09-30 15:54:27', '0');
INSERT INTO `t_payments` VALUES ('303', '2', '0', '100.00', '2', '11718506652336881792', '362', '2', '17000135', '2017-09-30 15:56:24', '17000135', '2017-09-30 15:57:41', '0');
INSERT INTO `t_payments` VALUES ('304', '5', '0', '1.00', '1', null, '363', '1', '17000046', '2017-09-30 15:56:51', '17000046', '2017-09-30 15:56:51', '0');
INSERT INTO `t_payments` VALUES ('305', '2', '0', '50.00', '2', '11715656404362100751', '364', '2', '17000135', '2017-09-30 16:29:30', '17000135', '2017-09-30 17:32:19', '0');
INSERT INTO `t_payments` VALUES ('306', '5', '0', '50.00', '1', null, '365', '1', '17000050', '2017-09-30 18:22:22', '17000050', '2017-09-30 18:22:22', '0');
INSERT INTO `t_payments` VALUES ('307', '5', '0', '100.00', '1', null, '366', '1', '17000056', '2017-09-30 18:22:30', '17000056', '2017-09-30 18:22:30', '0');
INSERT INTO `t_payments` VALUES ('308', '5', '0', '10.00', '1', null, '367', '1', '17000060', '2017-09-30 18:26:29', '17000060', '2017-09-30 18:26:29', '0');
INSERT INTO `t_payments` VALUES ('309', '2', '0', '100.00', '1', null, '368', '1', '17000056', '2017-09-30 18:26:36', '17000056', '2017-09-30 18:26:36', '0');
INSERT INTO `t_payments` VALUES ('310', '5', '0', '10.00', '1', null, '369', '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_payments` VALUES ('311', '2', '0', '10.00', '1', null, '370', '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_payments` VALUES ('312', '5', '0', '1.00', '1', null, '371', '1', '17000060', '2017-09-30 18:27:44', '17000060', '2017-09-30 18:27:44', '0');
INSERT INTO `t_payments` VALUES ('313', '2', '0', '10.00', '1', null, '372', '1', '17000060', '2017-09-30 18:30:18', '17000060', '2017-09-30 18:30:18', '0');
INSERT INTO `t_payments` VALUES ('314', '2', '0', '10.00', '1', null, '373', '1', '17000060', '2017-09-30 18:30:19', '17000060', '2017-09-30 18:30:19', '0');
INSERT INTO `t_payments` VALUES ('315', '1', '0', '10.00', '1', null, '374', '1', '17000050', '2017-09-30 18:32:10', '17000050', '2017-09-30 18:32:10', '0');
INSERT INTO `t_payments` VALUES ('316', '1', '0', '10.00', '1', null, '375', '1', '17000050', '2017-09-30 18:32:50', '17000050', '2017-09-30 18:32:50', '0');
INSERT INTO `t_payments` VALUES ('317', '5', '0', '10.00', '1', null, '376', '1', '17000060', '2017-09-30 18:32:54', '17000060', '2017-09-30 18:32:54', '0');
INSERT INTO `t_payments` VALUES ('318', '5', '0', '10.00', '1', null, '377', '1', '17000060', '2017-09-30 18:33:14', '17000060', '2017-09-30 18:33:14', '0');
INSERT INTO `t_payments` VALUES ('319', '1', '0', '50.00', '1', null, '378', '1', '17000050', '2017-09-30 18:33:17', '17000050', '2017-09-30 18:33:17', '0');
INSERT INTO `t_payments` VALUES ('320', '2', '0', '10.00', '1', null, '379', '1', '17000060', '2017-09-30 18:47:30', '17000060', '2017-09-30 18:47:30', '0');
INSERT INTO `t_payments` VALUES ('321', '2', '0', '50.00', '1', null, '380', '1', '17000050', '2017-09-30 18:48:58', '17000050', '2017-09-30 18:48:58', '0');
INSERT INTO `t_payments` VALUES ('322', '2', '0', '50.00', '1', null, '381', '1', '17000050', '2017-09-30 18:49:12', '17000050', '2017-09-30 18:49:12', '0');
INSERT INTO `t_payments` VALUES ('323', '2', '0', '50.00', '1', null, '382', '1', '17000050', '2017-09-30 18:50:54', '17000050', '2017-09-30 18:50:54', '0');
INSERT INTO `t_payments` VALUES ('324', '2', '0', '10.00', '1', null, '383', '1', '17000060', '2017-09-30 18:51:16', '17000060', '2017-09-30 18:51:16', '0');
INSERT INTO `t_payments` VALUES ('325', '2', '0', '10.00', '1', null, '384', '1', '17000060', '2017-09-30 18:51:57', '17000060', '2017-09-30 18:51:57', '0');
INSERT INTO `t_payments` VALUES ('326', '2', '0', '20.00', '1', null, '385', '1', '17000050', '2017-09-30 18:54:12', '17000050', '2017-09-30 18:54:12', '0');
INSERT INTO `t_payments` VALUES ('327', '1', '0', '50.00', '1', null, '386', '1', '17000137', '2017-10-01 07:37:51', '17000137', '2017-10-01 07:37:51', '0');
INSERT INTO `t_payments` VALUES ('328', '2', '0', '50.00', '2', '11711281008602566992', '387', '2', '17000137', '2017-10-01 09:49:17', '17000137', '2017-10-01 10:52:59', '0');
INSERT INTO `t_payments` VALUES ('329', '5', '0', '50.00', '1', null, '388', '1', '17000137', '2017-10-02 14:49:23', '17000137', '2017-10-02 14:49:23', '0');
INSERT INTO `t_payments` VALUES ('330', '2', '0', '50.00', '1', null, '389', '1', '17000137', '2017-10-02 14:49:42', '17000137', '2017-10-02 14:49:42', '0');
INSERT INTO `t_payments` VALUES ('331', '1', '0', '5000.00', '1', null, '390', '1', '17000138', '2017-10-02 16:44:05', '17000138', '2017-10-02 16:44:05', '0');
INSERT INTO `t_payments` VALUES ('332', '1', '0', '5000.00', '1', null, '391', '1', '17000138', '2017-10-02 16:44:23', '17000138', '2017-10-02 16:44:23', '0');
INSERT INTO `t_payments` VALUES ('333', '2', '0', '10000.00', '1', null, '392', '1', '17000138', '2017-10-02 16:44:41', '17000138', '2017-10-02 16:44:41', '0');
INSERT INTO `t_payments` VALUES ('334', '2', '0', '20.00', '1', null, '393', '1', '17000141', '2017-10-08 03:14:30', '17000141', '2017-10-08 03:14:30', '0');
INSERT INTO `t_payments` VALUES ('335', '1', '0', '50.00', '1', null, '394', '1', '17000137', '2017-10-08 13:02:29', '17000137', '2017-10-08 13:02:29', '0');
INSERT INTO `t_payments` VALUES ('336', '5', '0', '100.00', '1', null, '395', '1', '17000142', '2017-10-09 11:46:39', '17000142', '2017-10-09 11:46:39', '0');
INSERT INTO `t_payments` VALUES ('337', '5', '0', '1.00', '1', null, '396', '1', '17000060', '2017-10-09 21:05:04', '17000060', '2017-10-09 21:05:04', '0');
INSERT INTO `t_payments` VALUES ('338', '5', '0', '1.00', '1', null, '397', '1', '17000046', '2017-10-09 21:05:07', '17000046', '2017-10-09 21:05:07', '0');
INSERT INTO `t_payments` VALUES ('339', '2', '0', '1.00', '1', null, '398', '1', '17000046', '2017-10-09 21:05:17', '17000046', '2017-10-09 21:05:17', '0');
INSERT INTO `t_payments` VALUES ('340', '2', '0', '1.00', '1', null, '399', '1', '17000060', '2017-10-09 21:05:32', '17000060', '2017-10-09 21:05:32', '0');
INSERT INTO `t_payments` VALUES ('341', '2', '0', '50.00', '1', null, '400', '1', '17000137', '2017-10-10 11:12:09', '17000137', '2017-10-10 11:12:09', '0');
INSERT INTO `t_payments` VALUES ('342', '5', '0', '1.00', '1', null, '401', '1', '17000046', '2017-10-10 11:27:54', '17000046', '2017-10-10 11:27:54', '0');
INSERT INTO `t_payments` VALUES ('343', '2', '0', '1.00', '2', '11714100166915017671', '402', '2', '17000046', '2017-10-10 11:28:09', '17000046', '2017-10-10 11:29:31', '0');
INSERT INTO `t_payments` VALUES ('344', '5', '0', '10.00', '1', null, '403', '1', '17000075', '2017-10-10 11:35:01', '17000075', '2017-10-10 11:35:01', '0');
INSERT INTO `t_payments` VALUES ('345', '5', '0', '10.00', '1', null, '404', '1', '17000075', '2017-10-10 11:35:42', '17000075', '2017-10-10 11:35:42', '0');
INSERT INTO `t_payments` VALUES ('346', '5', '0', '50.00', '1', null, '405', '1', '17000075', '2017-10-10 11:39:33', '17000075', '2017-10-10 11:39:33', '0');
INSERT INTO `t_payments` VALUES ('347', '5', '0', '10.00', '1', null, '406', '1', '17000060', '2017-10-10 11:43:33', '17000060', '2017-10-10 11:43:33', '0');
INSERT INTO `t_payments` VALUES ('348', '2', '0', '10.00', '1', null, '407', '1', '17000060', '2017-10-10 11:43:47', '17000060', '2017-10-10 11:43:47', '0');
INSERT INTO `t_payments` VALUES ('349', '2', '0', '10.00', '1', null, '408', '1', '17000060', '2017-10-10 11:43:57', '17000060', '2017-10-10 11:43:57', '0');
INSERT INTO `t_payments` VALUES ('350', '1', '0', '10.00', '1', null, '409', '1', '17000060', '2017-10-10 11:44:35', '17000060', '2017-10-10 11:44:35', '0');
INSERT INTO `t_payments` VALUES ('351', '2', '0', '10.00', '1', null, '410', '1', '17000060', '2017-10-10 11:45:14', '17000060', '2017-10-10 11:45:14', '0');
INSERT INTO `t_payments` VALUES ('352', '2', '0', '10.00', '1', null, '411', '1', '17000060', '2017-10-10 11:45:50', '17000060', '2017-10-10 11:45:50', '0');
INSERT INTO `t_payments` VALUES ('353', '2', '0', '10.00', '1', null, '412', '1', '17000060', '2017-10-10 11:46:02', '17000060', '2017-10-10 11:46:02', '0');
INSERT INTO `t_payments` VALUES ('354', '2', '0', '10.00', '1', null, '413', '1', '17000060', '2017-10-10 11:46:11', '17000060', '2017-10-10 11:46:11', '0');
INSERT INTO `t_payments` VALUES ('355', '1', '0', '50.00', '1', null, '414', '1', '17000137', '2017-10-10 12:06:06', '17000137', '2017-10-10 12:06:06', '0');
INSERT INTO `t_payments` VALUES ('356', '2', '0', '100.00', '1', null, '415', '1', '17000075', '2017-10-10 14:54:26', '17000075', '2017-10-10 14:54:26', '0');
INSERT INTO `t_payments` VALUES ('357', '2', '0', '100.00', '1', null, '416', '1', '17000075', '2017-10-10 14:54:35', '17000075', '2017-10-10 14:54:35', '0');
INSERT INTO `t_payments` VALUES ('358', '5', '0', '1000.00', '1', null, '417', '1', '17000075', '2017-10-10 14:55:05', '17000075', '2017-10-10 14:55:05', '0');
INSERT INTO `t_payments` VALUES ('359', '5', '0', '50.00', '1', null, '418', '1', '17000075', '2017-10-10 15:08:41', '17000075', '2017-10-10 15:08:41', '0');
INSERT INTO `t_payments` VALUES ('360', '5', '0', '50.00', '1', null, '419', '1', '17000075', '2017-10-10 15:08:50', '17000075', '2017-10-10 15:08:50', '0');
INSERT INTO `t_payments` VALUES ('361', '2', '0', '50.00', '1', null, '420', '1', '17000075', '2017-10-10 15:09:34', '17000075', '2017-10-10 15:09:34', '0');
INSERT INTO `t_payments` VALUES ('362', '5', '0', '1000.00', '1', null, '421', '1', '17000075', '2017-10-10 15:10:34', '17000075', '2017-10-10 15:10:34', '0');
INSERT INTO `t_payments` VALUES ('363', '5', '0', '1000.00', '1', null, '422', '1', '17000060', '2017-10-10 15:15:20', '17000060', '2017-10-10 15:15:20', '0');
INSERT INTO `t_payments` VALUES ('364', '2', '0', '5000.00', '1', null, '423', '1', '17000145', '2017-10-10 16:10:10', '17000145', '2017-10-10 16:10:10', '0');
INSERT INTO `t_payments` VALUES ('365', '5', '0', '50.00', '1', null, '424', '1', '17000145', '2017-10-10 16:10:41', '17000145', '2017-10-10 16:10:41', '0');
INSERT INTO `t_payments` VALUES ('366', '5', '0', '50.00', '1', null, '425', '1', '17000145', '2017-10-10 16:10:50', '17000145', '2017-10-10 16:10:50', '0');
INSERT INTO `t_payments` VALUES ('367', '5', '0', '1000.00', '1', null, '426', '1', '17000145', '2017-10-10 16:11:18', '17000145', '2017-10-10 16:11:18', '0');
INSERT INTO `t_payments` VALUES ('368', '2', '0', '500.00', '1', null, '427', '1', '17000145', '2017-10-10 16:16:05', '17000145', '2017-10-10 16:16:05', '0');
INSERT INTO `t_payments` VALUES ('369', '2', '0', '500.00', '1', null, '428', '1', '17000145', '2017-10-10 16:17:07', '17000145', '2017-10-10 16:17:07', '0');
INSERT INTO `t_payments` VALUES ('370', '2', '0', '500.00', '1', null, '429', '1', '17000145', '2017-10-10 16:17:28', '17000145', '2017-10-10 16:17:28', '0');
INSERT INTO `t_payments` VALUES ('371', '2', '0', '500.00', '1', null, '430', '1', '17000145', '2017-10-10 16:18:21', '17000145', '2017-10-10 16:18:21', '0');
INSERT INTO `t_payments` VALUES ('372', '5', '0', '1000.00', '1', null, '431', '1', '17000145', '2017-10-10 16:22:36', '17000145', '2017-10-10 16:22:36', '0');
INSERT INTO `t_payments` VALUES ('373', '5', '0', '1000.00', '1', null, '432', '1', '17000145', '2017-10-10 16:22:47', '17000145', '2017-10-10 16:22:47', '0');
INSERT INTO `t_payments` VALUES ('374', '5', '0', '50.00', '1', null, '433', '1', '17000145', '2017-10-10 16:24:01', '17000145', '2017-10-10 16:24:01', '0');
INSERT INTO `t_payments` VALUES ('375', '5', '0', '1000.00', '1', null, '434', '1', '17000145', '2017-10-10 16:27:17', '17000145', '2017-10-10 16:27:17', '0');
INSERT INTO `t_payments` VALUES ('376', '5', '0', '1000.00', '1', null, '435', '1', '17000145', '2017-10-10 16:31:55', '17000145', '2017-10-10 16:31:55', '0');
INSERT INTO `t_payments` VALUES ('377', '5', '0', '50.00', '1', null, '436', '1', '17000145', '2017-10-10 16:33:01', '17000145', '2017-10-10 16:33:01', '0');
INSERT INTO `t_payments` VALUES ('378', '5', '0', '50.00', '1', null, '437', '1', '17000145', '2017-10-10 16:33:56', '17000145', '2017-10-10 16:33:56', '0');
INSERT INTO `t_payments` VALUES ('379', '5', '0', '50.00', '1', null, '438', '1', '17000145', '2017-10-10 16:37:50', '17000145', '2017-10-10 16:37:50', '0');
INSERT INTO `t_payments` VALUES ('380', '5', '0', '1000.00', '1', null, '439', '1', '17000145', '2017-10-10 16:46:25', '17000145', '2017-10-10 16:46:25', '0');
INSERT INTO `t_payments` VALUES ('381', '5', '0', '1000.00', '1', null, '440', '1', '17000145', '2017-10-10 16:47:34', '17000145', '2017-10-10 16:47:34', '0');
INSERT INTO `t_payments` VALUES ('382', '5', '0', '50.00', '1', null, '441', '1', '17000145', '2017-10-10 16:56:14', '17000145', '2017-10-10 16:56:14', '0');
INSERT INTO `t_payments` VALUES ('383', '5', '0', '50.00', '1', null, '442', '1', '17000145', '2017-10-10 16:56:40', '17000145', '2017-10-10 16:56:40', '0');
INSERT INTO `t_payments` VALUES ('384', '5', '0', '50.00', '1', null, '443', '1', '17000145', '2017-10-10 16:56:54', '17000145', '2017-10-10 16:56:54', '0');
INSERT INTO `t_payments` VALUES ('385', '5', '0', '1000.00', '1', null, '444', '1', '17000145', '2017-10-10 17:02:13', '17000145', '2017-10-10 17:02:13', '0');
INSERT INTO `t_payments` VALUES ('386', '5', '0', '1000.00', '1', null, '445', '1', '17000145', '2017-10-10 17:03:02', '17000145', '2017-10-10 17:03:02', '0');
INSERT INTO `t_payments` VALUES ('387', '5', '0', '50.00', '1', null, '446', '1', '17000145', '2017-10-10 17:09:35', '17000145', '2017-10-10 17:09:35', '0');
INSERT INTO `t_payments` VALUES ('388', '5', '0', '50.00', '1', null, '447', '1', '17000145', '2017-10-10 17:10:17', '17000145', '2017-10-10 17:10:17', '0');
INSERT INTO `t_payments` VALUES ('389', '5', '0', '50.00', '1', null, '448', '1', '17000145', '2017-10-10 17:10:38', '17000145', '2017-10-10 17:10:38', '0');
INSERT INTO `t_payments` VALUES ('390', '5', '0', '1000.00', '1', null, '449', '1', '17000145', '2017-10-10 17:14:24', '17000145', '2017-10-10 17:14:24', '0');
INSERT INTO `t_payments` VALUES ('391', '5', '0', '50.00', '1', null, '450', '1', '17000145', '2017-10-10 17:18:20', '17000145', '2017-10-10 17:18:20', '0');
INSERT INTO `t_payments` VALUES ('392', '5', '0', '50.00', '1', null, '451', '1', '17000145', '2017-10-10 17:32:29', '17000145', '2017-10-10 17:32:29', '0');
INSERT INTO `t_payments` VALUES ('393', '2', '0', '50.00', '1', null, '452', '1', '17000145', '2017-10-10 17:32:55', '17000145', '2017-10-10 17:32:55', '0');
INSERT INTO `t_payments` VALUES ('394', '5', '0', '50.00', '1', null, '453', '1', '17000145', '2017-10-10 17:33:03', '17000145', '2017-10-10 17:33:03', '0');
INSERT INTO `t_payments` VALUES ('395', '5', '0', '50.00', '1', null, '454', '1', '17000145', '2017-10-10 17:33:20', '17000145', '2017-10-10 17:33:20', '0');
INSERT INTO `t_payments` VALUES ('396', '5', '0', '50.00', '1', null, '455', '1', '17000145', '2017-10-10 17:33:30', '17000145', '2017-10-10 17:33:30', '0');
INSERT INTO `t_payments` VALUES ('397', '5', '0', '50.00', '1', null, '456', '1', '17000145', '2017-10-10 17:38:40', '17000145', '2017-10-10 17:38:40', '0');
INSERT INTO `t_payments` VALUES ('398', '2', '0', '50.00', '1', null, '457', '1', '17000145', '2017-10-10 17:38:47', '17000145', '2017-10-10 17:38:47', '0');
INSERT INTO `t_payments` VALUES ('399', '5', '0', '50.00', '1', null, '458', '1', '17000145', '2017-10-10 17:38:54', '17000145', '2017-10-10 17:38:54', '0');
INSERT INTO `t_payments` VALUES ('400', '2', '0', '50.00', '1', null, '459', '1', '17000145', '2017-10-10 17:38:57', '17000145', '2017-10-10 17:38:57', '0');
INSERT INTO `t_payments` VALUES ('401', '5', '0', '50.00', '1', null, '460', '1', '17000145', '2017-10-10 17:41:19', '17000145', '2017-10-10 17:41:19', '0');
INSERT INTO `t_payments` VALUES ('402', '2', '0', '50.00', '1', null, '461', '1', '17000145', '2017-10-10 17:42:02', '17000145', '2017-10-10 17:42:02', '0');
INSERT INTO `t_payments` VALUES ('403', '2', '0', '5000.00', '1', null, '462', '1', '17000145', '2017-10-10 17:42:15', '17000145', '2017-10-10 17:42:15', '0');
INSERT INTO `t_payments` VALUES ('404', '5', '0', '50.00', '1', null, '463', '1', '17000145', '2017-10-10 17:50:22', '17000145', '2017-10-10 17:50:22', '0');
INSERT INTO `t_payments` VALUES ('405', '5', '0', '50.00', '1', null, '464', '1', '17000145', '2017-10-10 17:50:34', '17000145', '2017-10-10 17:50:34', '0');
INSERT INTO `t_payments` VALUES ('406', '5', '0', '50.00', '1', null, '465', '1', '17000145', '2017-10-10 17:50:40', '17000145', '2017-10-10 17:50:40', '0');
INSERT INTO `t_payments` VALUES ('407', '5', '0', '50.00', '1', null, '466', '1', '17000145', '2017-10-10 17:51:54', '17000145', '2017-10-10 17:51:54', '0');
INSERT INTO `t_payments` VALUES ('408', '5', '0', '50.00', '1', null, '467', '1', '17000145', '2017-10-10 18:08:23', '17000145', '2017-10-10 18:08:23', '0');
INSERT INTO `t_payments` VALUES ('409', '5', '0', '50.00', '1', null, '468', '1', '17000145', '2017-10-10 18:11:06', '17000145', '2017-10-10 18:11:06', '0');
INSERT INTO `t_payments` VALUES ('410', '5', '0', '50.00', '1', null, '469', '1', '17000145', '2017-10-10 18:12:36', '17000145', '2017-10-10 18:12:36', '0');
INSERT INTO `t_payments` VALUES ('411', '5', '0', '50.00', '1', null, '470', '1', '17000145', '2017-10-10 18:19:11', '17000145', '2017-10-10 18:19:11', '0');
INSERT INTO `t_payments` VALUES ('412', '5', '0', '50.00', '1', null, '471', '1', '17000145', '2017-10-10 18:21:07', '17000145', '2017-10-10 18:21:07', '0');
INSERT INTO `t_payments` VALUES ('413', '2', '0', '50.00', '1', null, '472', '1', '17000145', '2017-10-10 18:22:32', '17000145', '2017-10-10 18:22:32', '0');
INSERT INTO `t_payments` VALUES ('414', '5', '0', '50.00', '1', null, '473', '1', '17000145', '2017-10-10 18:23:37', '17000145', '2017-10-10 18:23:37', '0');
INSERT INTO `t_payments` VALUES ('415', '5', '0', '50.00', '1', null, '474', '1', '17000145', '2017-10-10 18:50:45', '17000145', '2017-10-10 18:50:45', '0');
INSERT INTO `t_payments` VALUES ('416', '5', '0', '50.00', '1', null, '475', '1', '17000145', '2017-10-10 18:53:02', '17000145', '2017-10-10 18:53:02', '0');
INSERT INTO `t_payments` VALUES ('417', '2', '0', '50.00', '1', null, '476', '1', '17000145', '2017-10-10 18:54:48', '17000145', '2017-10-10 18:54:48', '0');
INSERT INTO `t_payments` VALUES ('418', '5', '0', '1000.00', '1', null, '477', '1', '17000145', '2017-10-10 18:55:03', '17000145', '2017-10-10 18:55:03', '0');
INSERT INTO `t_payments` VALUES ('419', '2', '0', '50.00', '1', null, '478', '1', '17000145', '2017-10-10 18:56:21', '17000145', '2017-10-10 18:56:21', '0');
INSERT INTO `t_payments` VALUES ('420', '1', '0', '1.00', '1', null, '479', '1', '17000145', '2017-10-10 18:59:37', '17000145', '2017-10-10 18:59:37', '0');
INSERT INTO `t_payments` VALUES ('421', '5', '0', '1.00', '1', null, '480', '1', '17000145', '2017-10-10 19:03:56', '17000145', '2017-10-10 19:03:56', '0');
INSERT INTO `t_payments` VALUES ('422', '5', '0', '1.00', '1', null, '481', '1', '17000145', '2017-10-10 19:05:41', '17000145', '2017-10-10 19:05:41', '0');
INSERT INTO `t_payments` VALUES ('423', '2', '0', '1.00', '1', null, '482', '1', '17000145', '2017-10-10 19:06:26', '17000145', '2017-10-10 19:06:26', '0');
INSERT INTO `t_payments` VALUES ('424', '5', '0', '1.00', '1', null, '483', '1', '17000145', '2017-10-10 19:08:39', '17000145', '2017-10-10 19:08:39', '0');
INSERT INTO `t_payments` VALUES ('425', '2', '0', '1.00', '1', null, '484', '1', '17000145', '2017-10-10 19:08:55', '17000145', '2017-10-10 19:08:55', '0');
INSERT INTO `t_payments` VALUES ('426', '5', '0', '5000.00', '1', null, '485', '1', '17000145', '2017-10-10 19:10:53', '17000145', '2017-10-10 19:10:53', '0');
INSERT INTO `t_payments` VALUES ('427', '5', '0', '1.00', '1', null, '486', '1', '17000145', '2017-10-10 19:12:16', '17000145', '2017-10-10 19:12:16', '0');
INSERT INTO `t_payments` VALUES ('428', '5', '0', '1.00', '1', null, '487', '1', '17000145', '2017-10-10 19:13:41', '17000145', '2017-10-10 19:13:41', '0');
INSERT INTO `t_payments` VALUES ('429', '2', '0', '1.00', '1', null, '488', '1', '17000145', '2017-10-10 19:13:49', '17000145', '2017-10-10 19:13:49', '0');
INSERT INTO `t_payments` VALUES ('430', '5', '0', '50.00', '1', null, '489', '1', '17000145', '2017-10-10 19:14:29', '17000145', '2017-10-10 19:14:29', '0');
INSERT INTO `t_payments` VALUES ('431', '2', '0', '1000.00', '1', null, '490', '1', '17000145', '2017-10-10 19:15:38', '17000145', '2017-10-10 19:15:38', '0');
INSERT INTO `t_payments` VALUES ('432', '5', '0', '1.00', '1', null, '491', '1', '17000145', '2017-10-10 19:17:05', '17000145', '2017-10-10 19:17:05', '0');
INSERT INTO `t_payments` VALUES ('433', '5', '0', '50.00', '1', null, '492', '1', '17000050', '2017-10-11 00:26:51', '17000050', '2017-10-11 00:26:51', '0');
INSERT INTO `t_payments` VALUES ('434', '1', '0', '50.00', '1', null, '493', '1', '17000050', '2017-10-11 00:27:09', '17000050', '2017-10-11 00:27:09', '0');
INSERT INTO `t_payments` VALUES ('435', '5', '0', '10.00', '1', null, '494', '1', '17000060', '2017-10-11 14:38:06', '17000060', '2017-10-11 14:38:06', '0');
INSERT INTO `t_payments` VALUES ('436', '2', '0', '10.00', '1', null, '495', '1', '17000060', '2017-10-11 14:38:28', '17000060', '2017-10-11 14:38:28', '0');
INSERT INTO `t_payments` VALUES ('437', '2', '0', '500.00', '1', null, '496', '1', '17000060', '2017-10-11 15:10:24', '17000060', '2017-10-11 15:10:24', '0');
INSERT INTO `t_payments` VALUES ('438', '5', '0', '1.00', '1', null, '497', '1', '17000055', '2017-10-11 17:02:53', '17000055', '2017-10-11 17:02:53', '0');
INSERT INTO `t_payments` VALUES ('439', '5', '0', '1.00', '1', null, '498', '1', '17000055', '2017-10-11 17:04:21', '17000055', '2017-10-11 17:04:21', '0');
INSERT INTO `t_payments` VALUES ('440', '5', '0', '1.00', '1', null, '499', '1', '17000055', '2017-10-11 17:05:40', '17000055', '2017-10-11 17:05:40', '0');
INSERT INTO `t_payments` VALUES ('441', '5', '0', '1.00', '1', null, '500', '1', '17000055', '2017-10-11 17:06:05', '17000055', '2017-10-11 17:06:05', '0');
INSERT INTO `t_payments` VALUES ('442', '5', '0', '1.00', '1', null, '501', '1', '17000055', '2017-10-11 17:06:50', '17000055', '2017-10-11 17:06:50', '0');
INSERT INTO `t_payments` VALUES ('443', '5', '0', '1.00', '1', null, '502', '1', '17000055', '2017-10-11 17:09:37', '17000055', '2017-10-11 17:09:37', '0');
INSERT INTO `t_payments` VALUES ('444', '5', '0', '1.00', '1', null, '503', '1', '17000055', '2017-10-11 17:15:25', '17000055', '2017-10-11 17:15:25', '0');
INSERT INTO `t_payments` VALUES ('445', '5', '0', '1.00', '1', null, '504', '1', '17000055', '2017-10-11 17:16:38', '17000055', '2017-10-11 17:16:38', '0');
INSERT INTO `t_payments` VALUES ('446', '5', '0', '1.00', '1', null, '505', '1', '17000055', '2017-10-11 17:42:28', '17000055', '2017-10-11 17:42:28', '0');
INSERT INTO `t_payments` VALUES ('447', '5', '0', '1.00', '1', null, '506', '1', '17000055', '2017-10-11 17:46:38', '17000055', '2017-10-11 17:46:38', '0');
INSERT INTO `t_payments` VALUES ('448', '5', '0', '1.00', '1', null, '507', '1', '17000055', '2017-10-11 17:47:27', '17000055', '2017-10-11 17:47:27', '0');
INSERT INTO `t_payments` VALUES ('449', '5', '0', '10.00', '1', null, '508', '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_payments` VALUES ('450', '5', '0', '10.00', '1', null, '509', '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_payments` VALUES ('451', '2', '0', '1.00', '1', null, '510', '1', '17000055', '2017-10-12 15:38:59', '17000055', '2017-10-12 15:38:59', '0');
INSERT INTO `t_payments` VALUES ('452', '7', '0', '1.00', '1', null, '511', '1', '17000055', '2017-10-12 15:39:54', '17000055', '2017-10-12 15:39:54', '0');
INSERT INTO `t_payments` VALUES ('453', '7', '0', '1.00', '1', null, '512', '1', '17000055', '2017-10-12 15:44:29', '17000055', '2017-10-12 15:44:29', '0');
INSERT INTO `t_payments` VALUES ('454', '7', '0', '1.00', '2', '11711532700714692579', '513', '2', '17000055', '2017-10-12 15:44:58', '17000055', '2017-10-12 16:48:11', '0');
INSERT INTO `t_payments` VALUES ('455', '5', '0', '10.00', '1', null, '514', '1', '17000224', '2017-10-12 15:52:29', '17000224', '2017-10-12 15:52:29', '0');
INSERT INTO `t_payments` VALUES ('456', '5', '0', '10.00', '1', null, '515', '1', '17000224', '2017-10-12 15:53:09', '17000224', '2017-10-12 15:53:09', '0');
INSERT INTO `t_payments` VALUES ('457', '2', '0', '10.00', '1', null, '516', '1', '17000224', '2017-10-12 15:53:56', '17000224', '2017-10-12 15:53:56', '0');
INSERT INTO `t_payments` VALUES ('458', '5', '0', '10.00', '1', null, '517', '1', '17000224', '2017-10-12 15:54:28', '17000224', '2017-10-12 15:54:28', '0');
INSERT INTO `t_payments` VALUES ('459', '5', '0', '10.00', '1', null, '518', '1', '17000145', '2017-10-12 15:59:12', '17000145', '2017-10-12 15:59:12', '0');
INSERT INTO `t_payments` VALUES ('460', '5', '0', '10.00', '1', null, '519', '1', '17000224', '2017-10-12 16:14:58', '17000224', '2017-10-12 16:14:58', '0');
INSERT INTO `t_payments` VALUES ('461', '5', '0', '1.00', '1', null, '520', '1', '17000224', '2017-10-12 16:19:12', '17000224', '2017-10-12 16:19:12', '0');
INSERT INTO `t_payments` VALUES ('462', '5', '0', '1.00', '1', null, '521', '1', '17000046', '2017-10-12 18:25:37', '17000046', '2017-10-12 18:25:37', '0');
INSERT INTO `t_payments` VALUES ('463', '5', '0', '1.00', '1', null, '522', '1', '17000046', '2017-10-12 18:26:21', '17000046', '2017-10-12 18:26:21', '0');
INSERT INTO `t_payments` VALUES ('464', '5', '0', '1.00', '1', null, '523', '1', '17000046', '2017-10-12 18:27:26', '17000046', '2017-10-12 18:27:26', '0');
INSERT INTO `t_payments` VALUES ('465', '2', '0', '1.00', '1', null, '524', '1', '17000046', '2017-10-12 18:28:20', '17000046', '2017-10-12 18:28:20', '0');
INSERT INTO `t_payments` VALUES ('466', '1', '0', '10.00', '1', null, '525', '1', '17000046', '2017-10-12 18:34:35', '17000046', '2017-10-12 18:34:35', '0');
INSERT INTO `t_payments` VALUES ('467', '2', '0', '50.00', '1', null, '526', '1', '17000046', '2017-10-12 18:35:37', '17000046', '2017-10-12 18:35:37', '0');
INSERT INTO `t_payments` VALUES ('468', '5', '0', '1.00', '1', null, '527', '1', '17000046', '2017-10-12 18:36:15', '17000046', '2017-10-12 18:36:15', '0');
INSERT INTO `t_payments` VALUES ('469', '2', '0', '10.00', '1', null, '528', '1', '17000046', '2017-10-12 18:36:58', '17000046', '2017-10-12 18:36:58', '0');
INSERT INTO `t_payments` VALUES ('470', '5', '0', '10.00', '1', null, '529', '1', '17000073', '2017-10-12 18:39:13', '17000073', '2017-10-12 18:39:13', '0');
INSERT INTO `t_payments` VALUES ('471', '2', '0', '10.00', '1', null, '530', '1', '17000046', '2017-10-12 18:41:12', '17000046', '2017-10-12 18:41:12', '0');
INSERT INTO `t_payments` VALUES ('472', '5', '0', '1.00', '1', null, '531', '1', '17000224', '2017-10-12 18:55:08', '17000224', '2017-10-12 18:55:08', '0');
INSERT INTO `t_payments` VALUES ('473', '5', '0', '1.00', '1', null, '532', '1', '17000224', '2017-10-12 18:56:05', '17000224', '2017-10-12 18:56:05', '0');
INSERT INTO `t_payments` VALUES ('474', '5', '0', '1.00', '1', null, '533', '1', '17000224', '2017-10-12 18:59:03', '17000224', '2017-10-12 18:59:03', '0');
INSERT INTO `t_payments` VALUES ('475', '5', '0', '1.00', '1', null, '534', '1', '17000224', '2017-10-12 19:01:26', '17000224', '2017-10-12 19:01:26', '0');
INSERT INTO `t_payments` VALUES ('476', '2', '0', '1.00', '1', null, '535', '1', '17000043', '2017-10-12 19:01:53', '17000043', '2017-10-12 19:01:53', '0');
INSERT INTO `t_payments` VALUES ('477', '5', '0', '1.00', '1', null, '536', '1', '17000224', '2017-10-12 19:07:33', '17000224', '2017-10-12 19:07:33', '0');
INSERT INTO `t_payments` VALUES ('478', '7', '0', '1.00', '1', null, '537', '1', '17000043', '2017-10-12 19:08:18', '17000043', '2017-10-12 19:08:18', '0');
INSERT INTO `t_payments` VALUES ('479', '7', '0', '1.00', '1', null, '538', '1', '17000043', '2017-10-12 19:10:20', '17000043', '2017-10-12 19:10:20', '0');
INSERT INTO `t_payments` VALUES ('480', '7', '0', '1.00', '1', null, '539', '1', '17000043', '2017-10-12 19:12:11', '17000043', '2017-10-12 19:12:11', '0');
INSERT INTO `t_payments` VALUES ('481', '2', '0', '1.00', '1', null, '540', '1', '17000046', '2017-10-12 19:18:04', '17000046', '2017-10-12 19:18:04', '0');
INSERT INTO `t_payments` VALUES ('482', '7', '0', '1.00', '1', null, '541', '1', '17000055', '2017-10-12 19:30:43', '17000055', '2017-10-12 19:30:43', '0');
INSERT INTO `t_payments` VALUES ('483', '2', '0', '10.00', '1', null, '542', '1', '17000224', '2017-10-12 19:32:57', '17000224', '2017-10-12 19:32:57', '0');
INSERT INTO `t_payments` VALUES ('484', '5', '0', '10.00', '1', null, '543', '1', '17000224', '2017-10-12 19:33:15', '17000224', '2017-10-12 19:33:15', '0');
INSERT INTO `t_payments` VALUES ('485', '7', '0', '1.00', '1', null, '544', '1', '17000043', '2017-10-12 19:51:22', '17000043', '2017-10-12 19:51:22', '0');
INSERT INTO `t_payments` VALUES ('486', '7', '0', '1.00', '2', '11717308060497315733', '545', '2', '17000046', '2017-10-12 19:54:09', '17000046', '2017-10-12 19:54:48', '0');
INSERT INTO `t_payments` VALUES ('487', '7', '0', '10.00', '1', null, '546', '1', '17000060', '2017-10-12 20:47:40', '17000060', '2017-10-12 20:47:40', '0');
INSERT INTO `t_payments` VALUES ('488', '7', '0', '1.00', '1', null, '547', '1', '17000046', '2017-10-12 21:06:30', '17000046', '2017-10-12 21:06:30', '0');
INSERT INTO `t_payments` VALUES ('489', '2', '0', '1.00', '1', null, '548', '1', '17000046', '2017-10-12 21:06:51', '17000046', '2017-10-12 21:06:51', '0');
INSERT INTO `t_payments` VALUES ('490', '7', '0', '1.00', '1', null, '549', '1', '17000148', '2017-10-12 21:07:33', '17000148', '2017-10-12 21:07:33', '0');
INSERT INTO `t_payments` VALUES ('491', '7', '0', '10.00', '1', null, '550', '1', '17000046', '2017-10-12 21:07:44', '17000046', '2017-10-12 21:07:44', '0');
INSERT INTO `t_payments` VALUES ('492', '7', '0', '10.00', '1', null, '551', '1', '17000148', '2017-10-12 21:08:03', '17000148', '2017-10-12 21:08:03', '0');
INSERT INTO `t_payments` VALUES ('493', '7', '0', '10.00', '1', null, '552', '1', '17000046', '2017-10-12 21:08:18', '17000046', '2017-10-12 21:08:18', '0');
INSERT INTO `t_payments` VALUES ('494', '2', '0', '1.00', '1', null, '553', '1', '17000148', '2017-10-12 21:08:40', '17000148', '2017-10-12 21:08:40', '0');
INSERT INTO `t_payments` VALUES ('495', '2', '0', '10.00', '1', null, '554', '1', '17000046', '2017-10-12 21:08:41', '17000046', '2017-10-12 21:08:41', '0');
INSERT INTO `t_payments` VALUES ('496', '2', '0', '1.00', '1', null, '555', '1', '17000046', '2017-10-12 21:08:57', '17000046', '2017-10-12 21:08:57', '0');
INSERT INTO `t_payments` VALUES ('497', '7', '0', '1.00', '1', null, '556', '1', '17000046', '2017-10-12 21:09:18', '17000046', '2017-10-12 21:09:18', '0');
INSERT INTO `t_payments` VALUES ('498', '1', '0', '1.00', '1', null, '557', '1', '17000046', '2017-10-12 21:09:47', '17000046', '2017-10-12 21:09:47', '0');
INSERT INTO `t_payments` VALUES ('499', '2', '0', '10.00', '1', null, '558', '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_payments` VALUES ('500', '2', '0', '10.00', '1', null, '559', '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_payments` VALUES ('501', '7', '0', '2.00', '1', null, '560', '1', '17000046', '2017-10-12 21:14:15', '17000046', '2017-10-12 21:14:15', '0');
INSERT INTO `t_payments` VALUES ('502', '7', '0', '2.00', '1', null, '561', '1', '17000046', '2017-10-12 21:15:45', '17000046', '2017-10-12 21:15:45', '0');
INSERT INTO `t_payments` VALUES ('503', '7', '0', '1.00', '1', null, '562', '1', '17000046', '2017-10-12 21:16:13', '17000046', '2017-10-12 21:16:13', '0');
INSERT INTO `t_payments` VALUES ('504', '7', '0', '10.00', '1', null, '563', '1', '17000060', '2017-10-12 21:19:19', '17000060', '2017-10-12 21:19:19', '0');
INSERT INTO `t_payments` VALUES ('505', '2', '0', '1.00', '1', null, '564', '1', '17000060', '2017-10-12 21:19:47', '17000060', '2017-10-12 21:19:47', '0');
INSERT INTO `t_payments` VALUES ('506', '7', '0', '1.00', '1', null, '565', '1', '17000224', '2017-10-12 21:19:59', '17000224', '2017-10-12 21:19:59', '0');
INSERT INTO `t_payments` VALUES ('507', '2', '0', '1.00', '1', null, '566', '1', '17000060', '2017-10-12 21:20:13', '17000060', '2017-10-12 21:20:13', '0');
INSERT INTO `t_payments` VALUES ('508', '7', '0', '1.00', '1', null, '567', '1', '17000046', '2017-10-12 21:20:32', '17000046', '2017-10-12 21:20:32', '0');
INSERT INTO `t_payments` VALUES ('509', '2', '0', '1.00', '1', null, '568', '1', '17000046', '2017-10-12 21:21:51', '17000046', '2017-10-12 21:21:51', '0');
INSERT INTO `t_payments` VALUES ('510', '7', '0', '10.00', '1', null, '569', '1', '17000046', '2017-10-12 21:23:07', '17000046', '2017-10-12 21:23:07', '0');
INSERT INTO `t_payments` VALUES ('511', '7', '0', '10.00', '1', null, '570', '1', '17000046', '2017-10-12 21:23:37', '17000046', '2017-10-12 21:23:37', '0');
INSERT INTO `t_payments` VALUES ('512', '2', '0', '10.00', '1', null, '571', '1', '17000046', '2017-10-12 21:24:39', '17000046', '2017-10-12 21:24:39', '0');
INSERT INTO `t_payments` VALUES ('513', '1', '0', '10.00', '1', null, '572', '1', '17000046', '2017-10-12 21:25:47', '17000046', '2017-10-12 21:25:47', '0');
INSERT INTO `t_payments` VALUES ('514', '7', '0', '1.00', '1', null, '573', '1', '17000046', '2017-10-12 21:27:39', '17000046', '2017-10-12 21:27:39', '0');
INSERT INTO `t_payments` VALUES ('515', '7', '0', '10.00', '1', null, '574', '1', '17000046', '2017-10-12 21:30:31', '17000046', '2017-10-12 21:30:31', '0');
INSERT INTO `t_payments` VALUES ('516', '7', '0', '1.00', '1', null, '575', '1', '17000046', '2017-10-12 21:33:26', '17000046', '2017-10-12 21:33:26', '0');
INSERT INTO `t_payments` VALUES ('517', '7', '0', '1.00', '1', null, '576', '1', '17000046', '2017-10-12 21:34:33', '17000046', '2017-10-12 21:34:33', '0');
INSERT INTO `t_payments` VALUES ('518', '7', '0', '1.00', '1', null, '577', '1', '17000046', '2017-10-12 21:35:57', '17000046', '2017-10-12 21:35:57', '0');
INSERT INTO `t_payments` VALUES ('519', '7', '0', '1.00', '1', null, '578', '1', '17000046', '2017-10-12 21:37:22', '17000046', '2017-10-12 21:37:22', '0');
INSERT INTO `t_payments` VALUES ('520', '7', '0', '1.00', '1', null, '579', '1', '17000224', '2017-10-12 21:40:00', '17000224', '2017-10-12 21:40:00', '0');
INSERT INTO `t_payments` VALUES ('521', '7', '0', '1.00', '1', null, '580', '1', '17000046', '2017-10-12 21:40:42', '17000046', '2017-10-12 21:40:42', '0');
INSERT INTO `t_payments` VALUES ('522', '7', '0', '1.00', '1', null, '581', '1', '17000046', '2017-10-12 21:43:45', '17000046', '2017-10-12 21:43:45', '0');
INSERT INTO `t_payments` VALUES ('523', '2', '0', '1.00', '1', null, '582', '1', '17000046', '2017-10-12 21:44:13', '17000046', '2017-10-12 21:44:13', '0');
INSERT INTO `t_payments` VALUES ('524', '2', '0', '10.00', '1', null, '583', '1', '17000046', '2017-10-12 21:49:23', '17000046', '2017-10-12 21:49:23', '0');
INSERT INTO `t_payments` VALUES ('525', '2', '0', '10.00', '1', null, '584', '1', '17000046', '2017-10-12 22:45:18', '17000046', '2017-10-12 22:45:18', '0');
INSERT INTO `t_payments` VALUES ('526', '2', '0', '1.00', '1', null, '585', '1', '17000046', '2017-10-12 22:45:50', '17000046', '2017-10-12 22:45:50', '0');
INSERT INTO `t_payments` VALUES ('527', '7', '0', '10.00', '1', null, '586', '1', '17000046', '2017-10-12 22:46:18', '17000046', '2017-10-12 22:46:18', '0');
INSERT INTO `t_payments` VALUES ('528', '2', '0', '1.00', '1', null, '587', '1', '17000046', '2017-10-12 22:46:50', '17000046', '2017-10-12 22:46:50', '0');
INSERT INTO `t_payments` VALUES ('529', '7', '0', '10.00', '1', null, '588', '1', '17000224', '2017-10-12 22:49:21', '17000224', '2017-10-12 22:49:21', '0');
INSERT INTO `t_payments` VALUES ('530', '2', '0', '10.00', '1', null, '589', '1', '17000224', '2017-10-12 22:50:50', '17000224', '2017-10-12 22:50:50', '0');
INSERT INTO `t_payments` VALUES ('531', '7', '0', '1.00', '1', null, '590', '1', '17000224', '2017-10-12 22:51:18', '17000224', '2017-10-12 22:51:18', '0');
INSERT INTO `t_payments` VALUES ('532', '2', '0', '1.00', '1', null, '591', '1', '17000224', '2017-10-12 22:51:53', '17000224', '2017-10-12 22:51:53', '0');
INSERT INTO `t_payments` VALUES ('533', '7', '0', '2.00', '1', null, '592', '1', '17000224', '2017-10-12 22:55:32', '17000224', '2017-10-12 22:55:32', '0');
INSERT INTO `t_payments` VALUES ('534', '2', '0', '1.00', '1', null, '593', '1', '17000224', '2017-10-12 22:55:59', '17000224', '2017-10-12 22:55:59', '0');
INSERT INTO `t_payments` VALUES ('535', '7', '0', '1.00', '1', null, '594', '1', '17000148', '2017-10-12 22:56:05', '17000148', '2017-10-12 22:56:05', '0');
INSERT INTO `t_payments` VALUES ('536', '2', '0', '10.00', '1', null, '595', '1', '17000148', '2017-10-12 22:56:30', '17000148', '2017-10-12 22:56:30', '0');
INSERT INTO `t_payments` VALUES ('537', '7', '0', '10.00', '1', null, '596', '1', '17000060', '2017-10-13 14:07:11', '17000060', '2017-10-13 14:07:11', '0');
INSERT INTO `t_payments` VALUES ('538', '7', '0', '10.00', '1', null, '597', '1', '17000060', '2017-10-13 14:08:04', '17000060', '2017-10-13 14:08:04', '0');
INSERT INTO `t_payments` VALUES ('539', '7', '0', '10.00', '1', null, '598', '1', '17000073', '2017-10-13 14:08:45', '17000073', '2017-10-13 14:08:45', '0');
INSERT INTO `t_payments` VALUES ('540', '7', '0', '1.00', '1', null, '599', '1', '17000044', '2017-10-13 14:09:09', '17000044', '2017-10-13 14:09:09', '0');
INSERT INTO `t_payments` VALUES ('541', '7', '0', '10.00', '1', null, '600', '1', '17000073', '2017-10-13 14:09:47', '17000073', '2017-10-13 14:09:47', '0');
INSERT INTO `t_payments` VALUES ('542', '7', '0', '1.00', '2', '11710007751585850325', '601', '2', '17000044', '2017-10-13 14:09:57', '17000044', '2017-10-13 15:12:51', '0');
INSERT INTO `t_payments` VALUES ('543', '7', '0', '10.00', '1', null, '602', '1', '17000073', '2017-10-13 14:12:11', '17000073', '2017-10-13 14:12:11', '0');
INSERT INTO `t_payments` VALUES ('544', '7', '0', '10.00', '1', null, '603', '1', '17000073', '2017-10-13 14:13:01', '17000073', '2017-10-13 14:13:01', '0');
INSERT INTO `t_payments` VALUES ('545', '7', '0', '10.00', '1', null, '604', '1', '17000073', '2017-10-13 14:13:53', '17000073', '2017-10-13 14:13:53', '0');
INSERT INTO `t_payments` VALUES ('546', '7', '0', '1.00', '1', null, '605', '1', '17000224', '2017-10-13 14:23:34', '17000224', '2017-10-13 14:23:34', '0');
INSERT INTO `t_payments` VALUES ('547', '7', '0', '1.00', '1', null, '606', '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_payments` VALUES ('548', '7', '0', '1.00', '1', null, '607', '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_payments` VALUES ('549', '7', '0', '10.00', '1', null, '608', '1', '17000224', '2017-10-13 14:25:21', '17000224', '2017-10-13 14:25:21', '0');
INSERT INTO `t_payments` VALUES ('550', '7', '0', '1.00', '1', null, '609', '1', '17000060', '2017-10-13 14:29:05', '17000060', '2017-10-13 14:29:05', '0');
INSERT INTO `t_payments` VALUES ('551', '7', '0', '1.00', '1', null, '610', '1', '17000224', '2017-10-13 14:29:37', '17000224', '2017-10-13 14:29:37', '0');
INSERT INTO `t_payments` VALUES ('552', '7', '0', '1.00', '1', null, '611', '1', '17000224', '2017-10-13 14:30:27', '17000224', '2017-10-13 14:30:27', '0');
INSERT INTO `t_payments` VALUES ('553', '7', '0', '1.00', '1', null, '612', '1', '17000224', '2017-10-13 14:30:48', '17000224', '2017-10-13 14:30:48', '0');
INSERT INTO `t_payments` VALUES ('554', '2', '0', '1.00', '1', null, '613', '1', '17000060', '2017-10-13 14:33:04', '17000060', '2017-10-13 14:33:04', '0');
INSERT INTO `t_payments` VALUES ('555', '7', '0', '1.00', '1', null, '614', '1', '17000060', '2017-10-13 14:33:46', '17000060', '2017-10-13 14:33:46', '0');
INSERT INTO `t_payments` VALUES ('556', '2', '0', '10.00', '1', null, '615', '1', '17000060', '2017-10-13 14:34:53', '17000060', '2017-10-13 14:34:53', '0');
INSERT INTO `t_payments` VALUES ('557', '7', '0', '10.00', '1', null, '616', '1', '17000073', '2017-10-13 14:34:53', '17000073', '2017-10-13 14:34:53', '0');
INSERT INTO `t_payments` VALUES ('558', '2', '0', '10.00', '1', null, '617', '1', '17000060', '2017-10-13 14:36:01', '17000060', '2017-10-13 14:36:01', '0');
INSERT INTO `t_payments` VALUES ('559', '7', '0', '10.00', '1', null, '618', '1', '17000073', '2017-10-13 14:36:28', '17000073', '2017-10-13 14:36:28', '0');
INSERT INTO `t_payments` VALUES ('560', '1', '0', '10.00', '1', null, '619', '1', '17000060', '2017-10-13 14:38:20', '17000060', '2017-10-13 14:38:20', '0');
INSERT INTO `t_payments` VALUES ('561', '7', '0', '10.00', '1', null, '620', '1', '17000060', '2017-10-13 14:39:52', '17000060', '2017-10-13 14:39:52', '0');
INSERT INTO `t_payments` VALUES ('562', '7', '0', '10.00', '1', null, '621', '1', '17000224', '2017-10-13 14:41:51', '17000224', '2017-10-13 14:41:51', '0');
INSERT INTO `t_payments` VALUES ('563', '7', '0', '1.00', '1', null, '622', '1', '17000224', '2017-10-13 14:46:10', '17000224', '2017-10-13 14:46:10', '0');
INSERT INTO `t_payments` VALUES ('564', '7', '0', '1.00', '1', null, '623', '1', '17000224', '2017-10-13 14:47:36', '17000224', '2017-10-13 14:47:36', '0');
INSERT INTO `t_payments` VALUES ('565', '7', '0', '2.00', '1', null, '624', '1', '17000224', '2017-10-13 14:58:34', '17000224', '2017-10-13 14:58:34', '0');
INSERT INTO `t_payments` VALUES ('566', '7', '0', '2.00', '1', null, '625', '1', '17000224', '2017-10-13 14:59:11', '17000224', '2017-10-13 14:59:11', '0');
INSERT INTO `t_payments` VALUES ('567', '7', '0', '1.00', '1', null, '626', '1', '17000224', '2017-10-13 14:59:34', '17000224', '2017-10-13 14:59:34', '0');
INSERT INTO `t_payments` VALUES ('568', '7', '0', '2.00', '1', null, '627', '1', '17000224', '2017-10-13 15:01:26', '17000224', '2017-10-13 15:01:26', '0');
INSERT INTO `t_payments` VALUES ('569', '7', '0', '2.00', '1', null, '628', '1', '17000224', '2017-10-13 15:04:28', '17000224', '2017-10-13 15:04:28', '0');
INSERT INTO `t_payments` VALUES ('570', '7', '0', '10.00', '1', null, '629', '1', '17000224', '2017-10-13 15:04:43', '17000224', '2017-10-13 15:04:43', '0');
INSERT INTO `t_payments` VALUES ('571', '7', '0', '1.00', '1', null, '630', '1', '17000224', '2017-10-13 15:05:08', '17000224', '2017-10-13 15:05:08', '0');
INSERT INTO `t_payments` VALUES ('572', '2', '0', '1.00', '1', null, '631', '1', '17000224', '2017-10-13 15:05:46', '17000224', '2017-10-13 15:05:46', '0');
INSERT INTO `t_payments` VALUES ('573', '7', '0', '10.00', '1', null, '632', '1', '17000073', '2017-10-13 15:43:51', '17000073', '2017-10-13 15:43:51', '0');
INSERT INTO `t_payments` VALUES ('574', '7', '0', '10.00', '1', null, '633', '1', '17000073', '2017-10-13 15:45:31', '17000073', '2017-10-13 15:45:31', '0');
INSERT INTO `t_payments` VALUES ('575', '7', '0', '1.00', '1', null, '634', '1', '17000148', '2017-10-13 15:47:05', '17000148', '2017-10-13 15:47:05', '0');
INSERT INTO `t_payments` VALUES ('576', '7', '0', '1.00', '1', null, '635', '1', '17000055', '2017-10-13 16:49:59', '17000055', '2017-10-13 16:49:59', '0');
INSERT INTO `t_payments` VALUES ('577', '7', '0', '10.00', '1', null, '636', '1', '17000043', '2017-10-13 15:50:30', '17000043', '2017-10-13 15:50:30', '0');
INSERT INTO `t_payments` VALUES ('578', '2', '0', '10.00', '1', null, '637', '1', '17000043', '2017-10-13 15:50:48', '17000043', '2017-10-13 15:50:48', '0');
INSERT INTO `t_payments` VALUES ('579', '7', '0', '10.00', '1', null, '638', '1', '17000060', '2017-10-13 15:53:21', '17000060', '2017-10-13 15:53:21', '0');
INSERT INTO `t_payments` VALUES ('580', '2', '0', '1.00', '1', null, '639', '1', '17000060', '2017-10-13 15:53:47', '17000060', '2017-10-13 15:53:47', '0');
INSERT INTO `t_payments` VALUES ('581', '7', '0', '1.00', '1', null, '640', '1', '17000224', '2017-10-14 13:15:46', '17000224', '2017-10-14 13:15:46', '0');
INSERT INTO `t_payments` VALUES ('582', '7', '0', '1.00', '1', null, '641', '1', '17000224', '2017-10-14 14:33:10', '17000224', '2017-10-14 14:33:10', '0');
INSERT INTO `t_payments` VALUES ('583', '7', '0', '1.00', '1', null, '642', '1', '17000046', '2017-10-14 15:44:29', '17000046', '2017-10-14 15:44:29', '0');
INSERT INTO `t_payments` VALUES ('584', '2', '0', '1.00', '1', null, '643', '1', '17000046', '2017-10-14 15:45:14', '17000046', '2017-10-14 15:45:14', '0');
INSERT INTO `t_payments` VALUES ('585', '7', '0', '50.00', '1', null, '644', '1', '17000137', '2017-10-15 19:37:59', '17000137', '2017-10-15 19:37:59', '0');
INSERT INTO `t_payments` VALUES ('586', '1', '0', '50.00', '1', null, '645', '1', '17000137', '2017-10-15 19:40:01', '17000137', '2017-10-15 19:40:01', '0');
INSERT INTO `t_payments` VALUES ('587', '2', '0', '1.00', '1', null, '646', '1', '17000055', '2017-10-16 11:59:38', '17000055', '2017-10-16 11:59:38', '0');
INSERT INTO `t_payments` VALUES ('588', '7', '0', '10.00', '1', null, '647', '1', '17000055', '2017-10-16 12:54:21', '17000055', '2017-10-16 12:54:21', '0');
INSERT INTO `t_payments` VALUES ('589', '2', '0', '5000.00', '1', null, '648', '1', '17000055', '2017-10-16 12:55:41', '17000055', '2017-10-16 12:55:41', '0');
INSERT INTO `t_payments` VALUES ('590', '1', '0', '5000.00', '1', null, '649', '1', '17000055', '2017-10-16 12:56:14', '17000055', '2017-10-16 12:56:14', '0');
INSERT INTO `t_payments` VALUES ('591', '1', '0', '1.00', '1', null, '650', '1', '17000055', '2017-10-16 17:06:57', '17000055', '2017-10-16 17:06:57', '0');
INSERT INTO `t_payments` VALUES ('592', '7', '0', '10.00', '1', null, '651', '1', '17000055', '2017-10-16 17:07:08', '17000055', '2017-10-16 17:07:08', '0');
INSERT INTO `t_payments` VALUES ('593', '2', '0', '10.00', '1', null, '652', '1', '17000055', '2017-10-16 17:07:22', '17000055', '2017-10-16 17:07:22', '0');
INSERT INTO `t_payments` VALUES ('594', '7', '0', '10.00', '1', null, '653', '1', '17000226', '2017-10-16 17:37:08', '17000226', '2017-10-16 17:37:08', '0');
INSERT INTO `t_payments` VALUES ('595', '2', '0', '50.00', '1', null, '654', '1', '17000137', '2017-10-16 23:07:57', '17000137', '2017-10-16 23:07:57', '0');
INSERT INTO `t_payments` VALUES ('596', '1', '0', '50.00', '1', null, '655', '1', '17000137', '2017-10-16 23:08:10', '17000137', '2017-10-16 23:08:10', '0');
INSERT INTO `t_payments` VALUES ('597', '2', '0', '50.00', '1', null, '656', '1', '17000137', '2017-10-16 23:08:30', '17000137', '2017-10-16 23:08:30', '0');
INSERT INTO `t_payments` VALUES ('598', '2', '0', '50.00', '1', null, '657', '1', '17000228', '2017-10-19 13:38:54', '17000228', '2017-10-19 13:38:54', '0');
INSERT INTO `t_payments` VALUES ('599', '2', '0', '50.00', '1', null, '658', '1', '17000137', '2017-10-22 17:59:48', '17000137', '2017-10-22 17:59:48', '0');
INSERT INTO `t_payments` VALUES ('600', '2', '0', '100.00', '1', null, '659', '1', '17000137', '2017-10-23 16:50:37', '17000137', '2017-10-23 16:50:37', '0');

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
  `iap_receipt` text CHARACTER SET utf8 COMMENT '苹果支付凭证',
  `item_id` bigint(255) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000357 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';

-- ----------------------------
-- Records of t_recharges
-- ----------------------------
INSERT INTO `t_recharges` VALUES ('100000001', '17000050', 'R150545483865874066', '1', '50.00', '测试', null, '0', '1', '1', '2017-09-15 13:53:59', '1', '2017-09-15 13:53:59', '0');
INSERT INTO `t_recharges` VALUES ('100000002', '17000050', 'R150579599259173009', '1', '300.00', '', null, '0', '1', '1', '2017-09-19 12:39:53', '1', '2017-09-19 12:39:53', '0');
INSERT INTO `t_recharges` VALUES ('100000003', '17000057', 'R150579800927356958', '1', '200.00', '测试赠送', null, '0', '1', '1', '2017-09-19 13:13:29', '1', '2017-09-19 13:13:29', '0');
INSERT INTO `t_recharges` VALUES ('100000004', '17000057', 'R150579801412975160', '1', '200.00', '', null, '0', '1', '1', '2017-09-19 13:13:34', '1', '2017-09-19 13:13:34', '0');
INSERT INTO `t_recharges` VALUES ('100000005', '17000056', 'R150580895820281914', '1', '200.00', '', null, '0', '1', '1', '2017-09-19 16:15:58', '1', '2017-09-19 16:15:58', '0');
INSERT INTO `t_recharges` VALUES ('100000006', '17000058', 'R150580899380024432', '1', '200.00', '', null, '0', '1', '1', '2017-09-19 16:16:34', '1', '2017-09-19 16:16:34', '0');
INSERT INTO `t_recharges` VALUES ('100000007', '17000057', 'R150587478991132938', '1', '420.00', '', null, '0', '1', '1', '2017-09-20 10:33:10', '1', '2017-09-20 10:33:10', '0');
INSERT INTO `t_recharges` VALUES ('100000008', '17000060', 'R150599410565873635', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-21 19:41:46', '17000060', '2017-09-21 19:41:46', '0');
INSERT INTO `t_recharges` VALUES ('100000009', '17000060', 'R150599412599697931', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-21 19:42:06', '17000060', '2017-09-21 19:42:06', '0');
INSERT INTO `t_recharges` VALUES ('100000010', '17000050', 'R150599858703597516', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"316\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150599858703597516\",\"partner_id\":\"108830\",\"sign\":\"f49905bc07d037ca987dbb51e866ee8a\",\"trade_no\":\"11718152603459300971\"}', null, '0', '2', '17000050', '2017-09-21 20:56:27', '17000050', '2017-09-21 20:56:27', '0');
INSERT INTO `t_recharges` VALUES ('100000011', '17000060', 'R150605141473517700', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-22 11:36:55', '17000060', '2017-09-22 11:36:55', '0');
INSERT INTO `t_recharges` VALUES ('100000012', '17000046', 'R150605443444840157', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"318\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150605443444840157\",\"partner_id\":\"108830\",\"sign\":\"e5c18a49915f3e9abaf5ad26daf92786\",\"trade_no\":\"11716446571685600893\"}', null, '0', '2', '17000046', '2017-09-22 12:27:14', '17000046', '2017-09-22 12:27:14', '0');
INSERT INTO `t_recharges` VALUES ('100000013', '17000066', 'R150605484723117343', '0', '50.00', null, null, '0', '1', '17000066', '2017-09-22 12:34:07', '17000066', '2017-09-22 12:34:07', '0');
INSERT INTO `t_recharges` VALUES ('100000014', '17000046', 'R150606611961611442', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"320\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150606611961611442\",\"partner_id\":\"108830\",\"sign\":\"47ca2438ae5f76e22917e26aec9a7c68\",\"trade_no\":\"11716551506251646870\"}', null, '0', '2', '17000046', '2017-09-22 15:42:00', '17000046', '2017-09-22 16:46:08', '0');
INSERT INTO `t_recharges` VALUES ('100000015', '17000060', 'R150607281089652126', '0', '50.00', null, null, '0', '1', '17000060', '2017-09-22 17:33:31', '17000060', '2017-09-22 17:33:31', '0');
INSERT INTO `t_recharges` VALUES ('100000016', '17000060', 'R150607504540188598', '0', '1.00', null, null, '0', '1', '17000060', '2017-09-22 18:10:45', '17000060', '2017-09-22 18:10:45', '0');
INSERT INTO `t_recharges` VALUES ('100000017', '17000060', 'R150607505769963503', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"323\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150607505769963503\",\"partner_id\":\"108830\",\"sign\":\"aa7376caa2a4f064ca52308f01743cd1\",\"trade_no\":\"11710056410190656714\"}', null, '0', '2', '17000060', '2017-09-22 18:10:58', '17000060', '2017-09-22 19:13:47', '0');
INSERT INTO `t_recharges` VALUES ('100000018', '17000050', 'R150609420256547049', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-22 23:30:03', '17000050', '2017-09-22 23:30:03', '0');
INSERT INTO `t_recharges` VALUES ('100000019', '17000050', 'R150609422620751215', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"325\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150609422620751215\",\"partner_id\":\"108830\",\"sign\":\"1eba424a2121984a8960df15f9a52a65\",\"trade_no\":\"11710818225456916061\"}', null, '0', '2', '17000050', '2017-09-22 23:30:26', '17000050', '2017-09-23 14:29:52', '0');
INSERT INTO `t_recharges` VALUES ('100000020', '17000050', 'R150609422651590217', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-22 23:30:27', '17000050', '2017-09-22 23:30:27', '0');
INSERT INTO `t_recharges` VALUES ('100000021', '17000046', 'R150613575529840748', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"327\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150613575529840748\",\"partner_id\":\"108830\",\"sign\":\"b236e64b4fa5ca1c36b27773c6fcad1a\",\"trade_no\":\"11711597009836560915\"}', null, '0', '2', '17000046', '2017-09-23 11:02:35', '17000046', '2017-09-23 12:05:45', '0');
INSERT INTO `t_recharges` VALUES ('100000022', '17000050', 'R150614229601336897', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"328\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150614229601336897\",\"partner_id\":\"108830\",\"sign\":\"cbbdd7244ddd90fd4d04f0eae9095281\",\"trade_no\":\"11711627144265093138\"}', null, '0', '2', '17000050', '2017-09-23 12:51:36', '17000050', '2017-09-23 12:52:10', '0');
INSERT INTO `t_recharges` VALUES ('100000023', '17000046', 'R150615124351283006', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"329\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150615124351283006\",\"partner_id\":\"108830\",\"sign\":\"9878273d85631d7f774062b834d576b0\",\"trade_no\":\"11712621164850315871\"}', null, '0', '2', '17000046', '2017-09-23 15:20:44', '17000046', '2017-09-23 16:23:44', '0');
INSERT INTO `t_recharges` VALUES ('100000024', '17000046', 'R150615405320492119', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"330\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150615405320492119\",\"partner_id\":\"108830\",\"sign\":\"67d6efbf6ab2c6c0d8f6cbc070e90d3b\",\"trade_no\":\"11717040508611585081\"}', null, '0', '2', '17000046', '2017-09-23 16:07:33', '17000046', '2017-09-23 17:12:05', '0');
INSERT INTO `t_recharges` VALUES ('100000025', '17000046', 'R150615609335962853', '0', '1.00', null, null, '0', '1', '17000046', '2017-09-23 16:41:33', '17000046', '2017-09-23 16:41:33', '0');
INSERT INTO `t_recharges` VALUES ('100000026', '17000046', 'R150616010421265189', '0', '2.00', null, null, '0', '1', '17000046', '2017-09-23 17:48:24', '17000046', '2017-09-23 17:48:24', '0');
INSERT INTO `t_recharges` VALUES ('100000027', '17000043', 'R150616172591586974', '0', '500.00', null, null, '0', '1', '17000043', '2017-09-23 18:15:26', '17000043', '2017-09-23 18:15:26', '0');
INSERT INTO `t_recharges` VALUES ('100000028', '17000046', 'R150616292286980624', '0', '10.00', null, null, '0', '1', '17000046', '2017-09-23 18:35:23', '17000046', '2017-09-23 18:35:23', '0');
INSERT INTO `t_recharges` VALUES ('100000029', '17000046', 'R150616293569673528', '0', '10.00', null, null, '0', '1', '17000046', '2017-09-23 18:35:36', '17000046', '2017-09-23 18:35:36', '0');
INSERT INTO `t_recharges` VALUES ('100000030', '17000077', 'R150625528410819303', '0', '1000.00', null, null, '0', '1', '17000077', '2017-09-24 20:14:44', '17000077', '2017-09-24 20:14:44', '0');
INSERT INTO `t_recharges` VALUES ('100000031', '17000050', 'R150632140505331420', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-25 14:36:45', '17000050', '2017-09-25 14:36:45', '0');
INSERT INTO `t_recharges` VALUES ('100000032', '17000060', 'R150632140982265872', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-25 14:36:50', '17000060', '2017-09-25 14:36:50', '0');
INSERT INTO `t_recharges` VALUES ('100000033', '17000050', 'R150632143122719637', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-25 14:37:11', '17000050', '2017-09-25 14:37:11', '0');
INSERT INTO `t_recharges` VALUES ('100000034', '17000050', 'R150632145605466042', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"340\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150632145605466042\",\"partner_id\":\"108830\",\"sign\":\"ee0baf363ba49f4cf05fc96e46aa9f5c\",\"trade_no\":\"11713014290721603445\"}', null, '0', '2', '17000050', '2017-09-25 14:37:36', '17000050', '2017-09-25 15:41:03', '0');
INSERT INTO `t_recharges` VALUES ('100000035', '17000060', 'R150632145925159571', '0', '50.00', null, null, '0', '1', '17000060', '2017-09-25 14:37:39', '17000060', '2017-09-25 14:37:39', '0');
INSERT INTO `t_recharges` VALUES ('100000036', '17000060', 'R150632148177025036', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-25 14:38:02', '17000060', '2017-09-25 14:38:02', '0');
INSERT INTO `t_recharges` VALUES ('100000037', '17000060', 'R150632152243439397', '0', '1.00', null, null, '0', '1', '17000060', '2017-09-25 14:38:42', '17000060', '2017-09-25 14:38:42', '0');
INSERT INTO `t_recharges` VALUES ('100000038', '17000079', 'R150633679701940706', '0', '480.00', null, null, '0', '1', '17000079', '2017-09-25 18:53:17', '17000079', '2017-09-25 18:53:17', '0');
INSERT INTO `t_recharges` VALUES ('100000039', '17000079', 'R150633681916329072', '0', '480.00', null, null, '0', '1', '17000079', '2017-09-25 18:53:39', '17000079', '2017-09-25 18:53:39', '0');
INSERT INTO `t_recharges` VALUES ('100000040', '17000083', 'R150639772062838738', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"346\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150639772062838738\",\"partner_id\":\"108830\",\"sign\":\"eb3813e55a5968060f3eb86c213113eb\",\"trade_no\":\"11712359683175051947\"}', null, '0', '2', '17000083', '2017-09-26 11:48:41', '17000083', '2017-09-26 12:52:03', '0');
INSERT INTO `t_recharges` VALUES ('100000041', '17000046', 'R150640656802661460', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"347\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150640656802661460\",\"partner_id\":\"108830\",\"sign\":\"d089c6185528df6d2e4a35a6f5fb51a3\",\"trade_no\":\"11712666086654134006\"}', null, '0', '2', '17000046', '2017-09-26 14:16:08', '17000046', '2017-09-26 14:17:45', '0');
INSERT INTO `t_recharges` VALUES ('100000042', '17000084', 'R150644448041585781', '0', '100.00', null, null, '0', '1', '17000084', '2017-09-27 00:48:00', '17000084', '2017-09-27 00:48:00', '0');
INSERT INTO `t_recharges` VALUES ('100000043', '17000084', 'R150646087109070470', '0', '100.00', null, null, '0', '1', '17000084', '2017-09-27 05:21:11', '17000084', '2017-09-27 05:21:11', '0');
INSERT INTO `t_recharges` VALUES ('100000044', '17000084', 'R150646090828627762', '0', '100.00', null, null, '0', '1', '17000084', '2017-09-27 05:21:48', '17000084', '2017-09-27 05:21:48', '0');
INSERT INTO `t_recharges` VALUES ('100000045', '17000050', 'R150649312496391631', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-27 14:18:45', '17000050', '2017-09-27 14:18:45', '0');
INSERT INTO `t_recharges` VALUES ('100000046', '17000052', 'R150649489265437583', '1', '20.00', '{\"amount\":\"20.0000\",\"attach\":\"352\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150649489265437583\",\"partner_id\":\"108830\",\"sign\":\"9f28f3e281806a2810b2de2f65830c2a\",\"trade_no\":\"11714591340950322368\"}', null, '0', '2', '17000052', '2017-09-27 14:48:13', '17000052', '2017-09-27 14:48:45', '0');
INSERT INTO `t_recharges` VALUES ('100000047', '17000086', 'R150653469646951727', '0', '10.00', null, null, '0', '1', '17000086', '2017-09-28 01:51:36', '17000086', '2017-09-28 01:51:36', '0');
INSERT INTO `t_recharges` VALUES ('100000048', '17000086', 'R150653483503027431', '0', '5000.00', null, null, '0', '1', '17000086', '2017-09-28 01:53:55', '17000086', '2017-09-28 01:53:55', '0');
INSERT INTO `t_recharges` VALUES ('100000049', '17000050', 'R150655846761099424', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-28 08:27:48', '17000050', '2017-09-28 08:27:48', '0');
INSERT INTO `t_recharges` VALUES ('100000050', '17000050', 'R150655850092516955', '1', '10.00', '{\"amount\":\"10.0000\",\"attach\":\"356\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150655850092516955\",\"partner_id\":\"108830\",\"sign\":\"cf3635ce8825d11294dddb13e4ad8d95\",\"trade_no\":\"11710982510754186515\"}', null, '0', '2', '17000050', '2017-09-28 08:28:21', '17000050', '2017-09-28 08:28:45', '0');
INSERT INTO `t_recharges` VALUES ('100000051', '17000135', 'R150675753494081870', '0', '100.00', null, null, '0', '1', '17000135', '2017-09-30 15:45:35', '17000135', '2017-09-30 15:45:35', '0');
INSERT INTO `t_recharges` VALUES ('100000052', '17000135', 'R150675762057277508', '0', '100.00', null, null, '0', '1', '17000135', '2017-09-30 15:47:01', '17000135', '2017-09-30 15:47:01', '0');
INSERT INTO `t_recharges` VALUES ('100000054', '17000133', 'R150675763847963019', '0', '1.00', null, null, '0', '1', '17000133', '2017-09-30 15:47:18', '17000133', '2017-09-30 15:47:18', '0');
INSERT INTO `t_recharges` VALUES ('100000055', '17000135', 'R150675806723138655', '0', '100.00', null, null, '0', '1', '17000135', '2017-09-30 15:54:27', '17000135', '2017-09-30 15:54:27', '0');
INSERT INTO `t_recharges` VALUES ('100000056', '17000135', 'R150675818420137525', '1', '100.00', '{\"amount\":\"100.0000\",\"attach\":\"362\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150675818420137525\",\"partner_id\":\"108830\",\"sign\":\"211660683b9847102582a790e853041d\",\"trade_no\":\"11718506652336881792\"}', null, '0', '2', '17000135', '2017-09-30 15:56:24', '17000135', '2017-09-30 15:57:41', '0');
INSERT INTO `t_recharges` VALUES ('100000057', '17000046', 'R150675821117213453', '0', '1.00', null, null, '0', '1', '17000046', '2017-09-30 15:56:51', '17000046', '2017-09-30 15:56:51', '0');
INSERT INTO `t_recharges` VALUES ('100000058', '17000135', 'R150676016975014062', '1', '50.00', '{\"amount\":\"50.0000\",\"attach\":\"364\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150676016975014062\",\"partner_id\":\"108830\",\"sign\":\"70fefa61073658eebde27ba83a3fc9b3\",\"trade_no\":\"11715656404362100751\"}', null, '0', '2', '17000135', '2017-09-30 16:29:30', '17000135', '2017-09-30 17:32:19', '0');
INSERT INTO `t_recharges` VALUES ('100000059', '17000060', 'R150676898874249903', '1', '100.00', '游戏测试', null, '0', '1', '1', '2017-09-30 18:56:29', '1', '2017-09-30 18:56:29', '0');
INSERT INTO `t_recharges` VALUES ('100000060', '17000050', 'R150676694219335852', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-30 18:22:22', '17000050', '2017-09-30 18:22:22', '0');
INSERT INTO `t_recharges` VALUES ('100000061', '17000056', 'R150676694995794362', '0', '100.00', null, null, '0', '1', '17000056', '2017-09-30 18:22:30', '17000056', '2017-09-30 18:22:30', '0');
INSERT INTO `t_recharges` VALUES ('100000062', '17000060', 'R150676718881673848', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:26:29', '17000060', '2017-09-30 18:26:29', '0');
INSERT INTO `t_recharges` VALUES ('100000063', '17000056', 'R150676719601677258', '0', '100.00', null, null, '0', '1', '17000056', '2017-09-30 18:26:36', '17000056', '2017-09-30 18:26:36', '0');
INSERT INTO `t_recharges` VALUES ('100000064', '17000060', 'R150676724030936471', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_recharges` VALUES ('100000065', '17000060', 'R150676724046451240', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0');
INSERT INTO `t_recharges` VALUES ('100000066', '17000060', 'R150676726410574845', '0', '1.00', null, null, '0', '1', '17000060', '2017-09-30 18:27:44', '17000060', '2017-09-30 18:27:44', '0');
INSERT INTO `t_recharges` VALUES ('100000067', '17000060', 'R150676741802471294', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:30:18', '17000060', '2017-09-30 18:30:18', '0');
INSERT INTO `t_recharges` VALUES ('100000068', '17000060', 'R150676741939899994', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:30:19', '17000060', '2017-09-30 18:30:19', '0');
INSERT INTO `t_recharges` VALUES ('100000069', '17000050', 'R150676753009879565', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-30 18:32:10', '17000050', '2017-09-30 18:32:10', '0');
INSERT INTO `t_recharges` VALUES ('100000070', '17000050', 'R150676757000073413', '0', '10.00', null, null, '0', '1', '17000050', '2017-09-30 18:32:50', '17000050', '2017-09-30 18:32:50', '0');
INSERT INTO `t_recharges` VALUES ('100000071', '17000060', 'R150676757366797192', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:32:54', '17000060', '2017-09-30 18:32:54', '0');
INSERT INTO `t_recharges` VALUES ('100000072', '17000060', 'R150676759422450577', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:33:14', '17000060', '2017-09-30 18:33:14', '0');
INSERT INTO `t_recharges` VALUES ('100000073', '17000050', 'R150676759700213777', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-30 18:33:17', '17000050', '2017-09-30 18:33:17', '0');
INSERT INTO `t_recharges` VALUES ('100000074', '17000060', 'R150676844977238950', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:47:30', '17000060', '2017-09-30 18:47:30', '0');
INSERT INTO `t_recharges` VALUES ('100000075', '17000050', 'R150676853797544560', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-30 18:48:58', '17000050', '2017-09-30 18:48:58', '0');
INSERT INTO `t_recharges` VALUES ('100000076', '17000050', 'R150676855167676363', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-30 18:49:12', '17000050', '2017-09-30 18:49:12', '0');
INSERT INTO `t_recharges` VALUES ('100000077', '17000050', 'R150676865383722139', '0', '50.00', null, null, '0', '1', '17000050', '2017-09-30 18:50:54', '17000050', '2017-09-30 18:50:54', '0');
INSERT INTO `t_recharges` VALUES ('100000078', '17000060', 'R150676867609995511', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:51:16', '17000060', '2017-09-30 18:51:16', '0');
INSERT INTO `t_recharges` VALUES ('100000079', '17000060', 'R150676871737396518', '0', '10.00', null, null, '0', '1', '17000060', '2017-09-30 18:51:57', '17000060', '2017-09-30 18:51:57', '0');
INSERT INTO `t_recharges` VALUES ('100000080', '17000050', 'R150676885239566602', '0', '20.00', null, null, '0', '1', '17000050', '2017-09-30 18:54:12', '17000050', '2017-09-30 18:54:12', '0');
INSERT INTO `t_recharges` VALUES ('100000081', '17000137', 'R150681467058754546', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-01 07:37:51', '17000137', '2017-10-01 07:37:51', '0');
INSERT INTO `t_recharges` VALUES ('100000082', '17000137', 'R150682255722219146', '1', '50.00', '{\"amount\":\"50.0000\",\"attach\":\"387\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150682255722219146\",\"partner_id\":\"108830\",\"sign\":\"40c67986def098c0543f6c0aa935e0f2\",\"trade_no\":\"11711281008602566992\"}', null, '0', '2', '17000137', '2017-10-01 09:49:17', '17000137', '2017-10-01 10:52:59', '0');
INSERT INTO `t_recharges` VALUES ('100000083', '17000137', 'R150692696286965464', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-02 14:49:23', '17000137', '2017-10-02 14:49:23', '0');
INSERT INTO `t_recharges` VALUES ('100000084', '17000137', 'R150692698152934437', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-02 14:49:42', '17000137', '2017-10-02 14:49:42', '0');
INSERT INTO `t_recharges` VALUES ('100000085', '17000138', 'R150693384520471387', '0', '5000.00', null, null, '0', '1', '17000138', '2017-10-02 16:44:05', '17000138', '2017-10-02 16:44:05', '0');
INSERT INTO `t_recharges` VALUES ('100000086', '17000138', 'R150693386319757509', '0', '5000.00', null, null, '0', '1', '17000138', '2017-10-02 16:44:23', '17000138', '2017-10-02 16:44:23', '0');
INSERT INTO `t_recharges` VALUES ('100000087', '17000138', 'R150693388082310426', '0', '10000.00', null, null, '0', '1', '17000138', '2017-10-02 16:44:41', '17000138', '2017-10-02 16:44:41', '0');
INSERT INTO `t_recharges` VALUES ('100000088', '17000141', 'R150740366960019808', '0', '20.00', null, null, '0', '1', '17000141', '2017-10-08 03:14:30', '17000141', '2017-10-08 03:14:30', '0');
INSERT INTO `t_recharges` VALUES ('100000089', '17000137', 'R150743894857212386', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-08 13:02:29', '17000137', '2017-10-08 13:02:29', '0');
INSERT INTO `t_recharges` VALUES ('100000090', '17000142', 'R150752079917958456', '0', '100.00', null, null, '0', '1', '17000142', '2017-10-09 11:46:39', '17000142', '2017-10-09 11:46:39', '0');
INSERT INTO `t_recharges` VALUES ('100000091', '17000060', 'R150755430417239958', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-09 21:05:04', '17000060', '2017-10-09 21:05:04', '0');
INSERT INTO `t_recharges` VALUES ('100000092', '17000046', 'R150755430658344077', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-09 21:05:07', '17000046', '2017-10-09 21:05:07', '0');
INSERT INTO `t_recharges` VALUES ('100000093', '17000046', 'R150755431718456836', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-09 21:05:17', '17000046', '2017-10-09 21:05:17', '0');
INSERT INTO `t_recharges` VALUES ('100000094', '17000060', 'R150755433178517438', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-09 21:05:32', '17000060', '2017-10-09 21:05:32', '0');
INSERT INTO `t_recharges` VALUES ('100000095', '17000137', 'R150760512879033086', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-10 11:12:09', '17000137', '2017-10-10 11:12:09', '0');
INSERT INTO `t_recharges` VALUES ('100000096', '17000046', 'R150760607413715736', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-10 11:27:54', '17000046', '2017-10-10 11:27:54', '0');
INSERT INTO `t_recharges` VALUES ('100000097', '17000046', 'R150760608875774218', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"402\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150760608875774218\",\"partner_id\":\"108830\",\"sign\":\"3711361755447ac3cd319ffe79ab0608\",\"trade_no\":\"11714100166915017671\"}', null, '0', '2', '17000046', '2017-10-10 11:28:09', '17000046', '2017-10-10 11:29:31', '0');
INSERT INTO `t_recharges` VALUES ('100000098', '17000075', 'R150760650120652715', '0', '10.00', null, null, '0', '1', '17000075', '2017-10-10 11:35:01', '17000075', '2017-10-10 11:35:01', '0');
INSERT INTO `t_recharges` VALUES ('100000099', '17000075', 'R150760654190862308', '0', '10.00', null, null, '0', '1', '17000075', '2017-10-10 11:35:42', '17000075', '2017-10-10 11:35:42', '0');
INSERT INTO `t_recharges` VALUES ('100000100', '17000075', 'R150760677337632635', '0', '50.00', null, null, '0', '1', '17000075', '2017-10-10 11:39:33', '17000075', '2017-10-10 11:39:33', '0');
INSERT INTO `t_recharges` VALUES ('100000101', '17000060', 'R150760701257374102', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:43:33', '17000060', '2017-10-10 11:43:33', '0');
INSERT INTO `t_recharges` VALUES ('100000102', '17000060', 'R150760702731135574', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:43:47', '17000060', '2017-10-10 11:43:47', '0');
INSERT INTO `t_recharges` VALUES ('100000103', '17000060', 'R150760703691219664', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:43:57', '17000060', '2017-10-10 11:43:57', '0');
INSERT INTO `t_recharges` VALUES ('100000104', '17000060', 'R150760707471070083', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:44:35', '17000060', '2017-10-10 11:44:35', '0');
INSERT INTO `t_recharges` VALUES ('100000105', '17000060', 'R150760711390014158', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:45:14', '17000060', '2017-10-10 11:45:14', '0');
INSERT INTO `t_recharges` VALUES ('100000106', '17000060', 'R150760715006052829', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:45:50', '17000060', '2017-10-10 11:45:50', '0');
INSERT INTO `t_recharges` VALUES ('100000107', '17000060', 'R150760716212556285', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:46:02', '17000060', '2017-10-10 11:46:02', '0');
INSERT INTO `t_recharges` VALUES ('100000108', '17000060', 'R150760717145416899', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-10 11:46:11', '17000060', '2017-10-10 11:46:11', '0');
INSERT INTO `t_recharges` VALUES ('100000109', '17000137', 'R150760836628717207', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-10 12:06:06', '17000137', '2017-10-10 12:06:06', '0');
INSERT INTO `t_recharges` VALUES ('100000110', '17000075', 'R150761846553171950', '0', '100.00', null, null, '0', '1', '17000075', '2017-10-10 14:54:26', '17000075', '2017-10-10 14:54:26', '0');
INSERT INTO `t_recharges` VALUES ('100000111', '17000075', 'R150761847545387556', '0', '100.00', null, null, '0', '1', '17000075', '2017-10-10 14:54:35', '17000075', '2017-10-10 14:54:35', '0');
INSERT INTO `t_recharges` VALUES ('100000112', '17000075', 'R150761850465918101', '0', '1000.00', null, null, '0', '1', '17000075', '2017-10-10 14:55:05', '17000075', '2017-10-10 14:55:05', '0');
INSERT INTO `t_recharges` VALUES ('100000113', '17000075', 'R150761932126988532', '0', '50.00', null, null, '0', '1', '17000075', '2017-10-10 15:08:41', '17000075', '2017-10-10 15:08:41', '0');
INSERT INTO `t_recharges` VALUES ('100000114', '17000075', 'R150761932982282455', '0', '50.00', null, null, '0', '1', '17000075', '2017-10-10 15:08:50', '17000075', '2017-10-10 15:08:50', '0');
INSERT INTO `t_recharges` VALUES ('100000115', '17000075', 'R150761937381977664', '0', '50.00', null, null, '0', '1', '17000075', '2017-10-10 15:09:34', '17000075', '2017-10-10 15:09:34', '0');
INSERT INTO `t_recharges` VALUES ('100000116', '17000075', 'R150761943385891033', '0', '1000.00', null, null, '0', '1', '17000075', '2017-10-10 15:10:34', '17000075', '2017-10-10 15:10:34', '0');
INSERT INTO `t_recharges` VALUES ('100000117', '17000060', 'R150761971958725727', '0', '1000.00', null, null, '0', '1', '17000060', '2017-10-10 15:15:20', '17000060', '2017-10-10 15:15:20', '0');
INSERT INTO `t_recharges` VALUES ('100000118', '17000148', 'R150762649033159775', '1', '20.00', 'ceshi', null, '0', '1', '1', '2017-10-10 17:08:10', '1', '2017-10-10 17:08:10', '0');
INSERT INTO `t_recharges` VALUES ('100000119', '17000145', 'R150762301033564257', '0', '5000.00', null, null, '0', '1', '17000145', '2017-10-10 16:10:10', '17000145', '2017-10-10 16:10:10', '0');
INSERT INTO `t_recharges` VALUES ('100000120', '17000145', 'R150762304056831032', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:10:41', '17000145', '2017-10-10 16:10:41', '0');
INSERT INTO `t_recharges` VALUES ('100000121', '17000145', 'R150762305036453663', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:10:50', '17000145', '2017-10-10 16:10:50', '0');
INSERT INTO `t_recharges` VALUES ('100000122', '17000145', 'R150762307802367685', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:11:18', '17000145', '2017-10-10 16:11:18', '0');
INSERT INTO `t_recharges` VALUES ('100000123', '17000145', 'R150762336508866172', '0', '500.00', null, null, '0', '1', '17000145', '2017-10-10 16:16:05', '17000145', '2017-10-10 16:16:05', '0');
INSERT INTO `t_recharges` VALUES ('100000124', '17000145', 'R150762342680963876', '0', '500.00', null, null, '0', '1', '17000145', '2017-10-10 16:17:07', '17000145', '2017-10-10 16:17:07', '0');
INSERT INTO `t_recharges` VALUES ('100000125', '17000145', 'R150762344825121271', '0', '500.00', null, null, '0', '1', '17000145', '2017-10-10 16:17:28', '17000145', '2017-10-10 16:17:28', '0');
INSERT INTO `t_recharges` VALUES ('100000126', '17000145', 'R150762350076671569', '0', '500.00', null, null, '0', '1', '17000145', '2017-10-10 16:18:21', '17000145', '2017-10-10 16:18:21', '0');
INSERT INTO `t_recharges` VALUES ('100000127', '17000145', 'R150762375561536893', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:22:36', '17000145', '2017-10-10 16:22:36', '0');
INSERT INTO `t_recharges` VALUES ('100000128', '17000145', 'R150762376721890972', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:22:47', '17000145', '2017-10-10 16:22:47', '0');
INSERT INTO `t_recharges` VALUES ('100000129', '17000145', 'R150762384071858173', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:24:01', '17000145', '2017-10-10 16:24:01', '0');
INSERT INTO `t_recharges` VALUES ('100000130', '17000145', 'R150762403732733394', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:27:17', '17000145', '2017-10-10 16:27:17', '0');
INSERT INTO `t_recharges` VALUES ('100000131', '17000145', 'R150762431501475109', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:31:55', '17000145', '2017-10-10 16:31:55', '0');
INSERT INTO `t_recharges` VALUES ('100000132', '17000145', 'R150762438109891683', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:33:01', '17000145', '2017-10-10 16:33:01', '0');
INSERT INTO `t_recharges` VALUES ('100000133', '17000145', 'R150762443631363044', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:33:56', '17000145', '2017-10-10 16:33:56', '0');
INSERT INTO `t_recharges` VALUES ('100000134', '17000145', 'R150762466952375004', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:37:50', '17000145', '2017-10-10 16:37:50', '0');
INSERT INTO `t_recharges` VALUES ('100000135', '17000145', 'R150762518469265489', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:46:25', '17000145', '2017-10-10 16:46:25', '0');
INSERT INTO `t_recharges` VALUES ('100000136', '17000145', 'R150762525370894205', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 16:47:34', '17000145', '2017-10-10 16:47:34', '0');
INSERT INTO `t_recharges` VALUES ('100000137', '17000145', 'R150762577391451819', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:56:14', '17000145', '2017-10-10 16:56:14', '0');
INSERT INTO `t_recharges` VALUES ('100000138', '17000145', 'R150762579993236064', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:56:40', '17000145', '2017-10-10 16:56:40', '0');
INSERT INTO `t_recharges` VALUES ('100000139', '17000145', 'R150762581369291503', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 16:56:54', '17000145', '2017-10-10 16:56:54', '0');
INSERT INTO `t_recharges` VALUES ('100000140', '17000145', 'R150762613265988487', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 17:02:13', '17000145', '2017-10-10 17:02:13', '0');
INSERT INTO `t_recharges` VALUES ('100000141', '17000145', 'R150762618194950391', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 17:03:02', '17000145', '2017-10-10 17:03:02', '0');
INSERT INTO `t_recharges` VALUES ('100000142', '17000145', 'R150762657515010108', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:09:35', '17000145', '2017-10-10 17:09:35', '0');
INSERT INTO `t_recharges` VALUES ('100000143', '17000145', 'R150762661664857654', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:10:17', '17000145', '2017-10-10 17:10:17', '0');
INSERT INTO `t_recharges` VALUES ('100000144', '17000145', 'R150762663796322667', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:10:38', '17000145', '2017-10-10 17:10:38', '0');
INSERT INTO `t_recharges` VALUES ('100000145', '17000145', 'R150762686351427738', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 17:14:24', '17000145', '2017-10-10 17:14:24', '0');
INSERT INTO `t_recharges` VALUES ('100000146', '17000145', 'R150762710020519069', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:18:20', '17000145', '2017-10-10 17:18:20', '0');
INSERT INTO `t_recharges` VALUES ('100000147', '17000145', 'R150762794887563150', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:32:29', '17000145', '2017-10-10 17:32:29', '0');
INSERT INTO `t_recharges` VALUES ('100000148', '17000145', 'R150762797519158679', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:32:55', '17000145', '2017-10-10 17:32:55', '0');
INSERT INTO `t_recharges` VALUES ('100000149', '17000145', 'R150762798338017546', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:33:03', '17000145', '2017-10-10 17:33:03', '0');
INSERT INTO `t_recharges` VALUES ('100000150', '17000145', 'R150762799956755208', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:33:20', '17000145', '2017-10-10 17:33:20', '0');
INSERT INTO `t_recharges` VALUES ('100000151', '17000145', 'R150762801023247638', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:33:30', '17000145', '2017-10-10 17:33:30', '0');
INSERT INTO `t_recharges` VALUES ('100000152', '17000145', 'R150762831965881548', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:38:40', '17000145', '2017-10-10 17:38:40', '0');
INSERT INTO `t_recharges` VALUES ('100000153', '17000145', 'R150762832736563729', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:38:47', '17000145', '2017-10-10 17:38:47', '0');
INSERT INTO `t_recharges` VALUES ('100000154', '17000145', 'R150762833380855374', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:38:54', '17000145', '2017-10-10 17:38:54', '0');
INSERT INTO `t_recharges` VALUES ('100000155', '17000145', 'R150762833666784313', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:38:57', '17000145', '2017-10-10 17:38:57', '0');
INSERT INTO `t_recharges` VALUES ('100000156', '17000145', 'R150762847893793748', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:41:19', '17000145', '2017-10-10 17:41:19', '0');
INSERT INTO `t_recharges` VALUES ('100000157', '17000145', 'R150762852183348756', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:42:02', '17000145', '2017-10-10 17:42:02', '0');
INSERT INTO `t_recharges` VALUES ('100000158', '17000145', 'R150762853525433272', '0', '5000.00', null, null, '0', '1', '17000145', '2017-10-10 17:42:15', '17000145', '2017-10-10 17:42:15', '0');
INSERT INTO `t_recharges` VALUES ('100000159', '17000145', 'R150762902229967567', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:50:22', '17000145', '2017-10-10 17:50:22', '0');
INSERT INTO `t_recharges` VALUES ('100000160', '17000145', 'R150762903359037721', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:50:34', '17000145', '2017-10-10 17:50:34', '0');
INSERT INTO `t_recharges` VALUES ('100000161', '17000145', 'R150762903983059459', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:50:40', '17000145', '2017-10-10 17:50:40', '0');
INSERT INTO `t_recharges` VALUES ('100000162', '17000145', 'R150762911434031388', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 17:51:54', '17000145', '2017-10-10 17:51:54', '0');
INSERT INTO `t_recharges` VALUES ('100000163', '17000145', 'R150763010273558842', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:08:23', '17000145', '2017-10-10 18:08:23', '0');
INSERT INTO `t_recharges` VALUES ('100000164', '17000145', 'R150763026562164729', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:11:06', '17000145', '2017-10-10 18:11:06', '0');
INSERT INTO `t_recharges` VALUES ('100000165', '17000145', 'R150763035630228990', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:12:36', '17000145', '2017-10-10 18:12:36', '0');
INSERT INTO `t_recharges` VALUES ('100000166', '17000145', 'R150763075060635582', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:19:11', '17000145', '2017-10-10 18:19:11', '0');
INSERT INTO `t_recharges` VALUES ('100000167', '17000145', 'R150763086719684132', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:21:07', '17000145', '2017-10-10 18:21:07', '0');
INSERT INTO `t_recharges` VALUES ('100000168', '17000145', 'R150763095232526557', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:22:32', '17000145', '2017-10-10 18:22:32', '0');
INSERT INTO `t_recharges` VALUES ('100000169', '17000145', 'R150763101663275032', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:23:37', '17000145', '2017-10-10 18:23:37', '0');
INSERT INTO `t_recharges` VALUES ('100000170', '17000145', 'R150763264483369915', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:50:45', '17000145', '2017-10-10 18:50:45', '0');
INSERT INTO `t_recharges` VALUES ('100000171', '17000145', 'R150763278234620938', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:53:02', '17000145', '2017-10-10 18:53:02', '0');
INSERT INTO `t_recharges` VALUES ('100000172', '17000145', 'R150763288752568127', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:54:48', '17000145', '2017-10-10 18:54:48', '0');
INSERT INTO `t_recharges` VALUES ('100000173', '17000145', 'R150763290282325695', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 18:55:03', '17000145', '2017-10-10 18:55:03', '0');
INSERT INTO `t_recharges` VALUES ('100000174', '17000145', 'R150763298122263627', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 18:56:21', '17000145', '2017-10-10 18:56:21', '0');
INSERT INTO `t_recharges` VALUES ('100000175', '17000145', 'R150763317660010221', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 18:59:37', '17000145', '2017-10-10 18:59:37', '0');
INSERT INTO `t_recharges` VALUES ('100000176', '17000145', 'R150763343644630878', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:03:56', '17000145', '2017-10-10 19:03:56', '0');
INSERT INTO `t_recharges` VALUES ('100000177', '17000145', 'R150763354123177044', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:05:41', '17000145', '2017-10-10 19:05:41', '0');
INSERT INTO `t_recharges` VALUES ('100000178', '17000145', 'R150763358575651184', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:06:26', '17000145', '2017-10-10 19:06:26', '0');
INSERT INTO `t_recharges` VALUES ('100000179', '17000145', 'R150763371885877518', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:08:39', '17000145', '2017-10-10 19:08:39', '0');
INSERT INTO `t_recharges` VALUES ('100000180', '17000145', 'R150763373478346940', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:08:55', '17000145', '2017-10-10 19:08:55', '0');
INSERT INTO `t_recharges` VALUES ('100000181', '17000145', 'R150763385287817337', '0', '5000.00', null, null, '0', '1', '17000145', '2017-10-10 19:10:53', '17000145', '2017-10-10 19:10:53', '0');
INSERT INTO `t_recharges` VALUES ('100000182', '17000145', 'R150763393562080969', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:12:16', '17000145', '2017-10-10 19:12:16', '0');
INSERT INTO `t_recharges` VALUES ('100000183', '17000145', 'R150763402112167616', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:13:41', '17000145', '2017-10-10 19:13:41', '0');
INSERT INTO `t_recharges` VALUES ('100000184', '17000145', 'R150763402945799202', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:13:49', '17000145', '2017-10-10 19:13:49', '0');
INSERT INTO `t_recharges` VALUES ('100000185', '17000145', 'R150763406886992064', '0', '50.00', null, null, '0', '1', '17000145', '2017-10-10 19:14:29', '17000145', '2017-10-10 19:14:29', '0');
INSERT INTO `t_recharges` VALUES ('100000186', '17000145', 'R150763413824312104', '0', '1000.00', null, null, '0', '1', '17000145', '2017-10-10 19:15:38', '17000145', '2017-10-10 19:15:38', '0');
INSERT INTO `t_recharges` VALUES ('100000187', '17000145', 'R150763422455351556', '0', '1.00', null, null, '0', '1', '17000145', '2017-10-10 19:17:05', '17000145', '2017-10-10 19:17:05', '0');
INSERT INTO `t_recharges` VALUES ('100000188', '17000050', 'R150765281109179851', '0', '50.00', null, null, '0', '1', '17000050', '2017-10-11 00:26:51', '17000050', '2017-10-11 00:26:51', '0');
INSERT INTO `t_recharges` VALUES ('100000189', '17000050', 'R150765282854821010', '0', '50.00', null, null, '0', '1', '17000050', '2017-10-11 00:27:09', '17000050', '2017-10-11 00:27:09', '0');
INSERT INTO `t_recharges` VALUES ('100000190', '17000060', 'R150770388598555608', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-11 14:38:06', '17000060', '2017-10-11 14:38:06', '0');
INSERT INTO `t_recharges` VALUES ('100000191', '17000060', 'R150770390819582753', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-11 14:38:28', '17000060', '2017-10-11 14:38:28', '0');
INSERT INTO `t_recharges` VALUES ('100000192', '17000060', 'R150770582445179161', '0', '500.00', null, null, '0', '1', '17000060', '2017-10-11 15:10:24', '17000060', '2017-10-11 15:10:24', '0');
INSERT INTO `t_recharges` VALUES ('100000193', '17000055', 'R150771257335284301', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:02:53', '17000055', '2017-10-11 17:02:53', '0');
INSERT INTO `t_recharges` VALUES ('100000194', '17000055', 'R150771266102951216', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:04:21', '17000055', '2017-10-11 17:04:21', '0');
INSERT INTO `t_recharges` VALUES ('100000195', '17000055', 'R150771273956280480', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:05:40', '17000055', '2017-10-11 17:05:40', '0');
INSERT INTO `t_recharges` VALUES ('100000196', '17000055', 'R150771276464318474', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:06:05', '17000055', '2017-10-11 17:06:05', '0');
INSERT INTO `t_recharges` VALUES ('100000197', '17000055', 'R150771281017924668', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:06:50', '17000055', '2017-10-11 17:06:50', '0');
INSERT INTO `t_recharges` VALUES ('100000198', '17000055', 'R150771297744256776', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:09:37', '17000055', '2017-10-11 17:09:37', '0');
INSERT INTO `t_recharges` VALUES ('100000199', '17000055', 'R150771332548621885', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:15:25', '17000055', '2017-10-11 17:15:25', '0');
INSERT INTO `t_recharges` VALUES ('100000200', '17000055', 'R150771339762334576', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:16:38', '17000055', '2017-10-11 17:16:38', '0');
INSERT INTO `t_recharges` VALUES ('100000201', '17000055', 'R150771494776753684', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:42:28', '17000055', '2017-10-11 17:42:28', '0');
INSERT INTO `t_recharges` VALUES ('100000202', '17000055', 'R150771519804238318', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:46:38', '17000055', '2017-10-11 17:46:38', '0');
INSERT INTO `t_recharges` VALUES ('100000203', '17000055', 'R150771524730637996', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-11 17:47:27', '17000055', '2017-10-11 17:47:27', '0');
INSERT INTO `t_recharges` VALUES ('100000204', '17000060', 'R150778463877533766', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_recharges` VALUES ('100000205', '17000060', 'R150778463897218819', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0');
INSERT INTO `t_recharges` VALUES ('100000206', '17000055', 'R150779393881264354', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-12 15:38:59', '17000055', '2017-10-12 15:38:59', '0');
INSERT INTO `t_recharges` VALUES ('100000207', '17000055', 'R150779399394298514', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-12 15:39:54', '17000055', '2017-10-12 15:39:54', '0');
INSERT INTO `t_recharges` VALUES ('100000208', '17000055', 'R150779426922147573', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-12 15:44:29', '17000055', '2017-10-12 15:44:29', '0');
INSERT INTO `t_recharges` VALUES ('100000209', '17000055', 'R150779429817238897', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"513\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150779429817238897\",\"partner_id\":\"108830\",\"sign\":\"480931d2968504a0ed6cdf1ac22a5d47\",\"trade_no\":\"11711532700714692579\"}', null, '0', '2', '17000055', '2017-10-12 15:44:58', '17000055', '2017-10-12 16:48:11', '0');
INSERT INTO `t_recharges` VALUES ('100000210', '17000224', 'R150779474944255228', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 15:52:29', '17000224', '2017-10-12 15:52:29', '0');
INSERT INTO `t_recharges` VALUES ('100000211', '17000224', 'R150779478938444661', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 15:53:09', '17000224', '2017-10-12 15:53:09', '0');
INSERT INTO `t_recharges` VALUES ('100000212', '17000224', 'R150779483631749930', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 15:53:56', '17000224', '2017-10-12 15:53:56', '0');
INSERT INTO `t_recharges` VALUES ('100000213', '17000224', 'R150779486805769177', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 15:54:28', '17000224', '2017-10-12 15:54:28', '0');
INSERT INTO `t_recharges` VALUES ('100000214', '17000145', 'R150779515193331560', '0', '10.00', null, null, '0', '1', '17000145', '2017-10-12 15:59:12', '17000145', '2017-10-12 15:59:12', '0');
INSERT INTO `t_recharges` VALUES ('100000215', '17000224', 'R150779609812222271', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 16:14:58', '17000224', '2017-10-12 16:14:58', '0');
INSERT INTO `t_recharges` VALUES ('100000216', '17000224', 'R150779635222886395', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 16:19:12', '17000224', '2017-10-12 16:19:12', '0');
INSERT INTO `t_recharges` VALUES ('100000217', '17000046', 'R150780393655411517', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 18:25:37', '17000046', '2017-10-12 18:25:37', '0');
INSERT INTO `t_recharges` VALUES ('100000218', '17000046', 'R150780398147269221', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 18:26:21', '17000046', '2017-10-12 18:26:21', '0');
INSERT INTO `t_recharges` VALUES ('100000219', '17000046', 'R150780404586061729', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 18:27:26', '17000046', '2017-10-12 18:27:26', '0');
INSERT INTO `t_recharges` VALUES ('100000220', '17000046', 'R150780409976582941', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 18:28:20', '17000046', '2017-10-12 18:28:20', '0');
INSERT INTO `t_recharges` VALUES ('100000221', '17000046', 'R150780447535897271', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 18:34:35', '17000046', '2017-10-12 18:34:35', '0');
INSERT INTO `t_recharges` VALUES ('100000222', '17000046', 'R150780453746699709', '0', '50.00', null, null, '0', '1', '17000046', '2017-10-12 18:35:37', '17000046', '2017-10-12 18:35:37', '0');
INSERT INTO `t_recharges` VALUES ('100000223', '17000046', 'R150780457468810752', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 18:36:15', '17000046', '2017-10-12 18:36:15', '0');
INSERT INTO `t_recharges` VALUES ('100000224', '17000046', 'R150780461781340731', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 18:36:58', '17000046', '2017-10-12 18:36:58', '0');
INSERT INTO `t_recharges` VALUES ('100000225', '17000073', 'R150780475303154694', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-12 18:39:13', '17000073', '2017-10-12 18:39:13', '0');
INSERT INTO `t_recharges` VALUES ('100000226', '17000046', 'R150780487171450792', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 18:41:12', '17000046', '2017-10-12 18:41:12', '0');
INSERT INTO `t_recharges` VALUES ('100000227', '17000224', 'R150780570819211528', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 18:55:08', '17000224', '2017-10-12 18:55:08', '0');
INSERT INTO `t_recharges` VALUES ('100000228', '17000224', 'R150780576528997837', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 18:56:05', '17000224', '2017-10-12 18:56:05', '0');
INSERT INTO `t_recharges` VALUES ('100000229', '17000224', 'R150780594313116960', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 18:59:03', '17000224', '2017-10-12 18:59:03', '0');
INSERT INTO `t_recharges` VALUES ('100000230', '17000224', 'R150780608645351246', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 19:01:26', '17000224', '2017-10-12 19:01:26', '0');
INSERT INTO `t_recharges` VALUES ('100000231', '17000043', 'R150780611324617299', '0', '1.00', null, null, '0', '1', '17000043', '2017-10-12 19:01:53', '17000043', '2017-10-12 19:01:53', '0');
INSERT INTO `t_recharges` VALUES ('100000232', '17000224', 'R150780645342719318', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 19:07:33', '17000224', '2017-10-12 19:07:33', '0');
INSERT INTO `t_recharges` VALUES ('100000233', '17000043', 'R150780649751387139', '0', '1.00', null, null, '0', '1', '17000043', '2017-10-12 19:08:18', '17000043', '2017-10-12 19:08:18', '0');
INSERT INTO `t_recharges` VALUES ('100000234', '17000043', 'R150780661978747970', '0', '1.00', null, null, '0', '1', '17000043', '2017-10-12 19:10:20', '17000043', '2017-10-12 19:10:20', '0');
INSERT INTO `t_recharges` VALUES ('100000235', '17000043', 'R150780673077718688', '0', '1.00', null, null, '0', '1', '17000043', '2017-10-12 19:12:11', '17000043', '2017-10-12 19:12:11', '0');
INSERT INTO `t_recharges` VALUES ('100000236', '17000046', 'R150780708357488710', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 19:18:04', '17000046', '2017-10-12 19:18:04', '0');
INSERT INTO `t_recharges` VALUES ('100000237', '17000055', 'R150780784251949100', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-12 19:30:43', '17000055', '2017-10-12 19:30:43', '0');
INSERT INTO `t_recharges` VALUES ('100000238', '17000224', 'R150780797706334180', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 19:32:57', '17000224', '2017-10-12 19:32:57', '0');
INSERT INTO `t_recharges` VALUES ('100000239', '17000224', 'R150780799539433674', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 19:33:15', '17000224', '2017-10-12 19:33:15', '0');
INSERT INTO `t_recharges` VALUES ('100000240', '17000043', 'R150780908157896034', '0', '1.00', null, null, '0', '1', '17000043', '2017-10-12 19:51:22', '17000043', '2017-10-12 19:51:22', '0');
INSERT INTO `t_recharges` VALUES ('100000241', '17000046', 'R150780924939946567', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"545\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150780924939946567\",\"partner_id\":\"108830\",\"sign\":\"a08b4b14716a36bb896d61f9a774d247\",\"trade_no\":\"11717308060497315733\"}', null, '0', '2', '17000046', '2017-10-12 19:54:09', '17000046', '2017-10-12 19:54:48', '0');
INSERT INTO `t_recharges` VALUES ('100000242', '17000060', 'R150781245977760107', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-12 20:47:40', '17000060', '2017-10-12 20:47:40', '0');
INSERT INTO `t_recharges` VALUES ('100000243', '17000046', 'R150781359028041296', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:06:30', '17000046', '2017-10-12 21:06:30', '0');
INSERT INTO `t_recharges` VALUES ('100000244', '17000046', 'R150781361100359102', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:06:51', '17000046', '2017-10-12 21:06:51', '0');
INSERT INTO `t_recharges` VALUES ('100000245', '17000148', 'R150781365304128488', '0', '1.00', null, null, '0', '1', '17000148', '2017-10-12 21:07:33', '17000148', '2017-10-12 21:07:33', '0');
INSERT INTO `t_recharges` VALUES ('100000246', '17000046', 'R150781366443241178', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:07:44', '17000046', '2017-10-12 21:07:44', '0');
INSERT INTO `t_recharges` VALUES ('100000247', '17000148', 'R150781368300348659', '0', '10.00', null, null, '0', '1', '17000148', '2017-10-12 21:08:03', '17000148', '2017-10-12 21:08:03', '0');
INSERT INTO `t_recharges` VALUES ('100000248', '17000046', 'R150781369848037592', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:08:18', '17000046', '2017-10-12 21:08:18', '0');
INSERT INTO `t_recharges` VALUES ('100000249', '17000148', 'R150781372038868221', '0', '1.00', null, null, '0', '1', '17000148', '2017-10-12 21:08:40', '17000148', '2017-10-12 21:08:40', '0');
INSERT INTO `t_recharges` VALUES ('100000250', '17000046', 'R150781372098788184', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:08:41', '17000046', '2017-10-12 21:08:41', '0');
INSERT INTO `t_recharges` VALUES ('100000251', '17000046', 'R150781373733949264', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:08:57', '17000046', '2017-10-12 21:08:57', '0');
INSERT INTO `t_recharges` VALUES ('100000252', '17000046', 'R150781375780292513', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:09:18', '17000046', '2017-10-12 21:09:18', '0');
INSERT INTO `t_recharges` VALUES ('100000253', '17000046', 'R150781378729555095', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:09:47', '17000046', '2017-10-12 21:09:47', '0');
INSERT INTO `t_recharges` VALUES ('100000254', '17000148', 'R150781384593539037', '0', '10.00', null, null, '0', '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_recharges` VALUES ('100000255', '17000148', 'R150781384594251299', '0', '10.00', null, null, '0', '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0');
INSERT INTO `t_recharges` VALUES ('100000256', '17000046', 'R150781405522563665', '0', '2.00', null, null, '0', '1', '17000046', '2017-10-12 21:14:15', '17000046', '2017-10-12 21:14:15', '0');
INSERT INTO `t_recharges` VALUES ('100000257', '17000046', 'R150781414476168957', '0', '2.00', null, null, '0', '1', '17000046', '2017-10-12 21:15:45', '17000046', '2017-10-12 21:15:45', '0');
INSERT INTO `t_recharges` VALUES ('100000258', '17000046', 'R150781417287929718', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:16:13', '17000046', '2017-10-12 21:16:13', '0');
INSERT INTO `t_recharges` VALUES ('100000259', '17000060', 'R150781435931137098', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-12 21:19:19', '17000060', '2017-10-12 21:19:19', '0');
INSERT INTO `t_recharges` VALUES ('100000260', '17000060', 'R150781438693226496', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-12 21:19:47', '17000060', '2017-10-12 21:19:47', '0');
INSERT INTO `t_recharges` VALUES ('100000261', '17000224', 'R150781439882042217', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 21:19:59', '17000224', '2017-10-12 21:19:59', '0');
INSERT INTO `t_recharges` VALUES ('100000262', '17000060', 'R150781441295744089', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-12 21:20:13', '17000060', '2017-10-12 21:20:13', '0');
INSERT INTO `t_recharges` VALUES ('100000263', '17000046', 'R150781443225335601', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:20:32', '17000046', '2017-10-12 21:20:32', '0');
INSERT INTO `t_recharges` VALUES ('100000264', '17000046', 'R150781451063759996', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:21:51', '17000046', '2017-10-12 21:21:51', '0');
INSERT INTO `t_recharges` VALUES ('100000265', '17000046', 'R150781458663444667', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:23:07', '17000046', '2017-10-12 21:23:07', '0');
INSERT INTO `t_recharges` VALUES ('100000266', '17000046', 'R150781461671385756', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:23:37', '17000046', '2017-10-12 21:23:37', '0');
INSERT INTO `t_recharges` VALUES ('100000267', '17000046', 'R150781467884071616', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:24:39', '17000046', '2017-10-12 21:24:39', '0');
INSERT INTO `t_recharges` VALUES ('100000268', '17000046', 'R150781474679729759', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:25:47', '17000046', '2017-10-12 21:25:47', '0');
INSERT INTO `t_recharges` VALUES ('100000269', '17000046', 'R150781485892673387', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:27:39', '17000046', '2017-10-12 21:27:39', '0');
INSERT INTO `t_recharges` VALUES ('100000270', '17000046', 'R150781503130523958', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:30:31', '17000046', '2017-10-12 21:30:31', '0');
INSERT INTO `t_recharges` VALUES ('100000271', '17000046', 'R150781520608272826', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:33:26', '17000046', '2017-10-12 21:33:26', '0');
INSERT INTO `t_recharges` VALUES ('100000272', '17000046', 'R150781527273531208', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:34:33', '17000046', '2017-10-12 21:34:33', '0');
INSERT INTO `t_recharges` VALUES ('100000273', '17000046', 'R150781535732569451', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:35:57', '17000046', '2017-10-12 21:35:57', '0');
INSERT INTO `t_recharges` VALUES ('100000274', '17000046', 'R150781544201015194', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:37:22', '17000046', '2017-10-12 21:37:22', '0');
INSERT INTO `t_recharges` VALUES ('100000275', '17000224', 'R150781559960769143', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 21:40:00', '17000224', '2017-10-12 21:40:00', '0');
INSERT INTO `t_recharges` VALUES ('100000276', '17000046', 'R150781564208118858', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:40:42', '17000046', '2017-10-12 21:40:42', '0');
INSERT INTO `t_recharges` VALUES ('100000277', '17000046', 'R150781582493759753', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:43:45', '17000046', '2017-10-12 21:43:45', '0');
INSERT INTO `t_recharges` VALUES ('100000278', '17000046', 'R150781585325321253', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 21:44:13', '17000046', '2017-10-12 21:44:13', '0');
INSERT INTO `t_recharges` VALUES ('100000279', '17000046', 'R150781616264877170', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 21:49:23', '17000046', '2017-10-12 21:49:23', '0');
INSERT INTO `t_recharges` VALUES ('100000280', '17000046', 'R150781951846293465', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 22:45:18', '17000046', '2017-10-12 22:45:18', '0');
INSERT INTO `t_recharges` VALUES ('100000281', '17000046', 'R150781954965516409', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 22:45:50', '17000046', '2017-10-12 22:45:50', '0');
INSERT INTO `t_recharges` VALUES ('100000282', '17000046', 'R150781957827712598', '0', '10.00', null, null, '0', '1', '17000046', '2017-10-12 22:46:18', '17000046', '2017-10-12 22:46:18', '0');
INSERT INTO `t_recharges` VALUES ('100000283', '17000046', 'R150781961003266885', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-12 22:46:50', '17000046', '2017-10-12 22:46:50', '0');
INSERT INTO `t_recharges` VALUES ('100000284', '17000224', 'R150781976144436719', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 22:49:21', '17000224', '2017-10-12 22:49:21', '0');
INSERT INTO `t_recharges` VALUES ('100000285', '17000224', 'R150781985042762100', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-12 22:50:50', '17000224', '2017-10-12 22:50:50', '0');
INSERT INTO `t_recharges` VALUES ('100000286', '17000224', 'R150781987765771740', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 22:51:18', '17000224', '2017-10-12 22:51:18', '0');
INSERT INTO `t_recharges` VALUES ('100000287', '17000224', 'R150781991257427486', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 22:51:53', '17000224', '2017-10-12 22:51:53', '0');
INSERT INTO `t_recharges` VALUES ('100000288', '17000224', 'R150782013190320814', '0', '2.00', null, null, '0', '1', '17000224', '2017-10-12 22:55:32', '17000224', '2017-10-12 22:55:32', '0');
INSERT INTO `t_recharges` VALUES ('100000289', '17000224', 'R150782015928733513', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-12 22:55:59', '17000224', '2017-10-12 22:55:59', '0');
INSERT INTO `t_recharges` VALUES ('100000290', '17000148', 'R150782016526137791', '0', '1.00', null, null, '0', '1', '17000148', '2017-10-12 22:56:05', '17000148', '2017-10-12 22:56:05', '0');
INSERT INTO `t_recharges` VALUES ('100000291', '17000148', 'R150782019041621787', '0', '10.00', null, null, '0', '1', '17000148', '2017-10-12 22:56:30', '17000148', '2017-10-12 22:56:30', '0');
INSERT INTO `t_recharges` VALUES ('100000292', '17000060', 'R150787483092475650', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:07:11', '17000060', '2017-10-13 14:07:11', '0');
INSERT INTO `t_recharges` VALUES ('100000293', '17000060', 'R150787488402888131', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:08:04', '17000060', '2017-10-13 14:08:04', '0');
INSERT INTO `t_recharges` VALUES ('100000294', '17000073', 'R150787492494172730', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:08:45', '17000073', '2017-10-13 14:08:45', '0');
INSERT INTO `t_recharges` VALUES ('100000295', '17000044', 'R150787494917052155', '0', '1.00', null, null, '0', '1', '17000044', '2017-10-13 14:09:09', '17000044', '2017-10-13 14:09:09', '0');
INSERT INTO `t_recharges` VALUES ('100000296', '17000073', 'R150787498707450470', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:09:47', '17000073', '2017-10-13 14:09:47', '0');
INSERT INTO `t_recharges` VALUES ('100000297', '17000044', 'R150787499684639261', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"601\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150787499684639261\",\"partner_id\":\"108830\",\"sign\":\"995413a5fb2fd8e66ed1522893e9a5dc\",\"trade_no\":\"11710007751585850325\"}', null, '0', '2', '17000044', '2017-10-13 14:09:57', '17000044', '2017-10-13 15:12:51', '0');
INSERT INTO `t_recharges` VALUES ('100000298', '17000073', 'R150787513107532670', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:12:11', '17000073', '2017-10-13 14:12:11', '0');
INSERT INTO `t_recharges` VALUES ('100000299', '17000073', 'R150787518098919136', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:13:01', '17000073', '2017-10-13 14:13:01', '0');
INSERT INTO `t_recharges` VALUES ('100000300', '17000073', 'R150787523324055902', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:13:53', '17000073', '2017-10-13 14:13:53', '0');
INSERT INTO `t_recharges` VALUES ('100000301', '17000224', 'R150787581358044252', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:23:34', '17000224', '2017-10-13 14:23:34', '0');
INSERT INTO `t_recharges` VALUES ('100000302', '17000224', 'R150787584595239282', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_recharges` VALUES ('100000303', '17000224', 'R150787584595720355', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0');
INSERT INTO `t_recharges` VALUES ('100000304', '17000224', 'R150787592052664545', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-13 14:25:21', '17000224', '2017-10-13 14:25:21', '0');
INSERT INTO `t_recharges` VALUES ('100000305', '17000060', 'R150787614481115526', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-13 14:29:05', '17000060', '2017-10-13 14:29:05', '0');
INSERT INTO `t_recharges` VALUES ('100000306', '17000224', 'R150787617749414281', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:29:37', '17000224', '2017-10-13 14:29:37', '0');
INSERT INTO `t_recharges` VALUES ('100000307', '17000224', 'R150787622743421111', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:30:27', '17000224', '2017-10-13 14:30:27', '0');
INSERT INTO `t_recharges` VALUES ('100000308', '17000224', 'R150787624802336581', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:30:48', '17000224', '2017-10-13 14:30:48', '0');
INSERT INTO `t_recharges` VALUES ('100000309', '17000060', 'R150787638422210215', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-13 14:33:04', '17000060', '2017-10-13 14:33:04', '0');
INSERT INTO `t_recharges` VALUES ('100000310', '17000060', 'R150787642641279793', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-13 14:33:46', '17000060', '2017-10-13 14:33:46', '0');
INSERT INTO `t_recharges` VALUES ('100000311', '17000060', 'R150787649263832717', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:34:53', '17000060', '2017-10-13 14:34:53', '0');
INSERT INTO `t_recharges` VALUES ('100000312', '17000073', 'R150787649342943899', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:34:53', '17000073', '2017-10-13 14:34:53', '0');
INSERT INTO `t_recharges` VALUES ('100000313', '17000060', 'R150787656090619035', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:36:01', '17000060', '2017-10-13 14:36:01', '0');
INSERT INTO `t_recharges` VALUES ('100000314', '17000073', 'R150787658750367860', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 14:36:28', '17000073', '2017-10-13 14:36:28', '0');
INSERT INTO `t_recharges` VALUES ('100000315', '17000060', 'R150787669997798750', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:38:20', '17000060', '2017-10-13 14:38:20', '0');
INSERT INTO `t_recharges` VALUES ('100000316', '17000060', 'R150787679165413332', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 14:39:52', '17000060', '2017-10-13 14:39:52', '0');
INSERT INTO `t_recharges` VALUES ('100000317', '17000224', 'R150787691071170987', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-13 14:41:51', '17000224', '2017-10-13 14:41:51', '0');
INSERT INTO `t_recharges` VALUES ('100000318', '17000224', 'R150787717013514636', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:46:10', '17000224', '2017-10-13 14:46:10', '0');
INSERT INTO `t_recharges` VALUES ('100000319', '17000224', 'R150787725601891543', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:47:36', '17000224', '2017-10-13 14:47:36', '0');
INSERT INTO `t_recharges` VALUES ('100000320', '17000224', 'R150787791366527539', '0', '2.00', null, null, '0', '1', '17000224', '2017-10-13 14:58:34', '17000224', '2017-10-13 14:58:34', '0');
INSERT INTO `t_recharges` VALUES ('100000321', '17000224', 'R150787795114771395', '0', '2.00', null, null, '0', '1', '17000224', '2017-10-13 14:59:11', '17000224', '2017-10-13 14:59:11', '0');
INSERT INTO `t_recharges` VALUES ('100000322', '17000224', 'R150787797371223699', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 14:59:34', '17000224', '2017-10-13 14:59:34', '0');
INSERT INTO `t_recharges` VALUES ('100000323', '17000224', 'R150787808630927498', '0', '2.00', null, null, '0', '1', '17000224', '2017-10-13 15:01:26', '17000224', '2017-10-13 15:01:26', '0');
INSERT INTO `t_recharges` VALUES ('100000324', '17000224', 'R150787826778152620', '0', '2.00', null, null, '0', '1', '17000224', '2017-10-13 15:04:28', '17000224', '2017-10-13 15:04:28', '0');
INSERT INTO `t_recharges` VALUES ('100000325', '17000224', 'R150787828267250132', '0', '10.00', null, null, '0', '1', '17000224', '2017-10-13 15:04:43', '17000224', '2017-10-13 15:04:43', '0');
INSERT INTO `t_recharges` VALUES ('100000326', '17000224', 'R150787830811817408', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 15:05:08', '17000224', '2017-10-13 15:05:08', '0');
INSERT INTO `t_recharges` VALUES ('100000327', '17000224', 'R150787834587693814', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-13 15:05:46', '17000224', '2017-10-13 15:05:46', '0');
INSERT INTO `t_recharges` VALUES ('100000328', '17000051', 'R150788226102889791', '1', '100.00', '测试用的', null, '0', '1', '1', '2017-10-13 16:11:01', '1', '2017-10-13 16:11:01', '0');
INSERT INTO `t_recharges` VALUES ('100000329', '17000073', 'R150788063060213670', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 15:43:51', '17000073', '2017-10-13 15:43:51', '0');
INSERT INTO `t_recharges` VALUES ('100000330', '17000073', 'R150788073132238594', '0', '10.00', null, null, '0', '1', '17000073', '2017-10-13 15:45:31', '17000073', '2017-10-13 15:45:31', '0');
INSERT INTO `t_recharges` VALUES ('100000331', '17000148', 'R150788082454779927', '0', '1.00', null, null, '0', '1', '17000148', '2017-10-13 15:47:05', '17000148', '2017-10-13 15:47:05', '0');
INSERT INTO `t_recharges` VALUES ('100000332', '17000055', 'R150788459868774734', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-13 16:49:59', '17000055', '2017-10-13 16:49:59', '0');
INSERT INTO `t_recharges` VALUES ('100000333', '17000043', 'R150788102984771235', '0', '10.00', null, null, '0', '1', '17000043', '2017-10-13 15:50:30', '17000043', '2017-10-13 15:50:30', '0');
INSERT INTO `t_recharges` VALUES ('100000334', '17000043', 'R150788104791367119', '0', '10.00', null, null, '0', '1', '17000043', '2017-10-13 15:50:48', '17000043', '2017-10-13 15:50:48', '0');
INSERT INTO `t_recharges` VALUES ('100000335', '17000060', 'R150788120061662500', '0', '10.00', null, null, '0', '1', '17000060', '2017-10-13 15:53:21', '17000060', '2017-10-13 15:53:21', '0');
INSERT INTO `t_recharges` VALUES ('100000336', '17000060', 'R150788122717359447', '0', '1.00', null, null, '0', '1', '17000060', '2017-10-13 15:53:47', '17000060', '2017-10-13 15:53:47', '0');
INSERT INTO `t_recharges` VALUES ('100000337', '17000224', 'R150795814583496674', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-14 13:15:46', '17000224', '2017-10-14 13:15:46', '0');
INSERT INTO `t_recharges` VALUES ('100000338', '17000224', 'R150796278959163240', '0', '1.00', null, null, '0', '1', '17000224', '2017-10-14 14:33:10', '17000224', '2017-10-14 14:33:10', '0');
INSERT INTO `t_recharges` VALUES ('100000339', '17000046', 'R150796706915434353', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-14 15:44:29', '17000046', '2017-10-14 15:44:29', '0');
INSERT INTO `t_recharges` VALUES ('100000340', '17000046', 'R150796711448067190', '0', '1.00', null, null, '0', '1', '17000046', '2017-10-14 15:45:14', '17000046', '2017-10-14 15:45:14', '0');
INSERT INTO `t_recharges` VALUES ('100000341', '17000137', 'R150806747860788372', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-15 19:37:59', '17000137', '2017-10-15 19:37:59', '0');
INSERT INTO `t_recharges` VALUES ('100000342', '17000137', 'R150806760131979045', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-15 19:40:01', '17000137', '2017-10-15 19:40:01', '0');
INSERT INTO `t_recharges` VALUES ('100000343', '17000055', 'R150812637800155550', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-16 11:59:38', '17000055', '2017-10-16 11:59:38', '0');
INSERT INTO `t_recharges` VALUES ('100000344', '17000055', 'R150812966080478922', '0', '10.00', null, null, '0', '1', '17000055', '2017-10-16 12:54:21', '17000055', '2017-10-16 12:54:21', '0');
INSERT INTO `t_recharges` VALUES ('100000345', '17000055', 'R150812974109871971', '0', '5000.00', null, null, '0', '1', '17000055', '2017-10-16 12:55:41', '17000055', '2017-10-16 12:55:41', '0');
INSERT INTO `t_recharges` VALUES ('100000346', '17000055', 'R150812977386628546', '0', '5000.00', null, null, '0', '1', '17000055', '2017-10-16 12:56:14', '17000055', '2017-10-16 12:56:14', '0');
INSERT INTO `t_recharges` VALUES ('100000347', '17000055', 'R150814481721161147', '0', '1.00', null, null, '0', '1', '17000055', '2017-10-16 17:06:57', '17000055', '2017-10-16 17:06:57', '0');
INSERT INTO `t_recharges` VALUES ('100000348', '17000055', 'R150814482835425331', '0', '10.00', null, null, '0', '1', '17000055', '2017-10-16 17:07:08', '17000055', '2017-10-16 17:07:08', '0');
INSERT INTO `t_recharges` VALUES ('100000349', '17000055', 'R150814484204387776', '0', '10.00', null, null, '0', '1', '17000055', '2017-10-16 17:07:22', '17000055', '2017-10-16 17:07:22', '0');
INSERT INTO `t_recharges` VALUES ('100000350', '17000226', 'R150814662776265915', '0', '10.00', null, null, '0', '1', '17000226', '2017-10-16 17:37:08', '17000226', '2017-10-16 17:37:08', '0');
INSERT INTO `t_recharges` VALUES ('100000351', '17000137', 'R150816647677386537', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-16 23:07:57', '17000137', '2017-10-16 23:07:57', '0');
INSERT INTO `t_recharges` VALUES ('100000352', '17000137', 'R150816649034235325', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-16 23:08:10', '17000137', '2017-10-16 23:08:10', '0');
INSERT INTO `t_recharges` VALUES ('100000353', '17000137', 'R150816650968967387', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-16 23:08:30', '17000137', '2017-10-16 23:08:30', '0');
INSERT INTO `t_recharges` VALUES ('100000354', '17000228', 'R150839153351964765', '0', '50.00', null, null, '0', '1', '17000228', '2017-10-19 13:38:54', '17000228', '2017-10-19 13:38:54', '0');
INSERT INTO `t_recharges` VALUES ('100000355', '17000137', 'R150866638785617162', '0', '50.00', null, null, '0', '1', '17000137', '2017-10-22 17:59:48', '17000137', '2017-10-22 17:59:48', '0');
INSERT INTO `t_recharges` VALUES ('100000356', '17000137', 'R150874863686841858', '0', '100.00', null, null, '0', '1', '17000137', '2017-10-23 16:50:37', '17000137', '2017-10-23 16:50:37', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('58', '17000043', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '170', '17000043', '2017-09-13 11:25:26', '17000043', '2017-10-13 15:50:48', '0');
INSERT INTO `t_user_account` VALUES ('59', '17000044', '1', '0', '1.00', '3.00', '0.00', '0.00', '0.00', '0.00', '70', '17000044', '2017-09-13 22:39:38', '17000044', '2017-10-13 15:12:51', '0');
INSERT INTO `t_user_account` VALUES ('60', '17000045', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '13', '17000045', '2017-09-14 02:26:10', '17000045', '2017-09-14 02:26:10', '0');
INSERT INTO `t_user_account` VALUES ('61', '17000046', '1', '0', '2.00', '8.00', '6.00', '0.00', '0.00', '0.00', '530', '17000046', '2017-09-14 15:59:48', '17000046', '2017-10-14 15:45:14', '0');
INSERT INTO `t_user_account` VALUES ('62', '17000050', '1', '0', '9.05', '400.00', '841.00', '0.00', '0.00', '0.00', '263', '17000050', '2017-09-15 12:45:38', '17000050', '2017-10-11 00:27:09', '0');
INSERT INTO `t_user_account` VALUES ('63', '17000054', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '35', '17000054', '2017-09-15 21:37:15', '17000054', '2017-09-15 21:37:15', '0');
INSERT INTO `t_user_account` VALUES ('64', '17000055', '1', '0', '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '328', '17000055', '2017-09-18 02:44:27', '17000055', '2017-10-16 17:07:22', '0');
INSERT INTO `t_user_account` VALUES ('65', '17000057', '1', '0', '80.00', '820.00', '0.00', '0.00', '0.00', '0.00', '23', '17000057', '2017-09-19 13:10:40', '17000057', '2017-09-20 10:33:10', '0');
INSERT INTO `t_user_account` VALUES ('66', '17000056', '1', '0', '290.00', '200.00', '0.00', '0.00', '0.00', '0.00', '19', '17000056', '2017-09-19 16:15:49', '17000056', '2017-09-30 18:26:36', '0');
INSERT INTO `t_user_account` VALUES ('67', '17000059', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000059', '2017-09-19 16:15:56', '17000059', '2017-09-19 16:15:56', '0');
INSERT INTO `t_user_account` VALUES ('68', '17000058', '1', '0', '0.00', '200.00', '0.00', '0.00', '0.00', '0.00', '5', '17000058', '2017-09-19 16:16:26', '17000058', '2017-09-19 16:16:34', '0');
INSERT INTO `t_user_account` VALUES ('69', '17000060', '1', '0', '177.50', '101.00', '2.00', '0.00', '0.00', '0.00', '426', '17000060', '2017-09-21 19:41:35', '17000060', '2017-10-13 15:53:47', '0');
INSERT INTO `t_user_account` VALUES ('70', '17000062', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '10', '17000062', '2017-09-21 21:19:00', '17000062', '2017-09-21 21:19:00', '0');
INSERT INTO `t_user_account` VALUES ('71', '17000063', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000063', '2017-09-21 21:20:29', '17000063', '2017-09-21 21:20:29', '0');
INSERT INTO `t_user_account` VALUES ('72', '17000065', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9', '17000065', '2017-09-21 21:27:51', '17000065', '2017-09-21 21:27:51', '0');
INSERT INTO `t_user_account` VALUES ('73', '17000069', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000069', '2017-09-21 21:45:07', '17000069', '2017-09-21 21:45:07', '0');
INSERT INTO `t_user_account` VALUES ('74', '17000066', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '59', '17000066', '2017-09-22 01:10:44', '17000066', '2017-09-22 12:34:07', '0');
INSERT INTO `t_user_account` VALUES ('75', '17000070', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '13', '17000070', '2017-09-22 02:59:54', '17000070', '2017-09-22 02:59:54', '0');
INSERT INTO `t_user_account` VALUES ('76', '17000051', '1', '0', '49.00', '100.00', '0.00', '0.00', '0.00', '0.00', '86', '17000051', '2017-09-22 12:20:53', '17000051', '2017-10-13 16:11:01', '0');
INSERT INTO `t_user_account` VALUES ('77', '17000072', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000072', '2017-09-22 17:21:48', '17000072', '2017-09-22 17:21:48', '0');
INSERT INTO `t_user_account` VALUES ('78', '17000073', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '30', '17000073', '2017-09-22 19:00:52', '17000073', '2017-10-13 15:45:31', '0');
INSERT INTO `t_user_account` VALUES ('79', '17000074', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000074', '2017-09-22 23:59:13', '17000074', '2017-09-22 23:59:13', '0');
INSERT INTO `t_user_account` VALUES ('80', '17000075', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '119', '17000075', '2017-09-23 16:25:49', '17000075', '2017-10-10 15:10:34', '0');
INSERT INTO `t_user_account` VALUES ('81', '17000077', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '15', '17000077', '2017-09-24 20:13:19', '17000077', '2017-09-24 20:14:44', '0');
INSERT INTO `t_user_account` VALUES ('82', '17000076', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000076', '2017-09-24 20:19:18', '17000076', '2017-09-24 20:19:18', '0');
INSERT INTO `t_user_account` VALUES ('83', '17000078', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000078', '2017-09-24 23:00:18', '17000078', '2017-09-24 23:00:18', '0');
INSERT INTO `t_user_account` VALUES ('84', '17000079', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '28', '17000079', '2017-09-24 23:06:00', '17000079', '2017-09-25 18:53:39', '0');
INSERT INTO `t_user_account` VALUES ('85', '17000080', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000080', '2017-09-24 23:52:20', '17000080', '2017-09-24 23:52:20', '0');
INSERT INTO `t_user_account` VALUES ('86', '17000081', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000081', '2017-09-25 11:02:08', '17000081', '2017-09-25 11:02:08', '0');
INSERT INTO `t_user_account` VALUES ('87', '17000083', '1', '0', '10.00', '10.00', '0.00', '0.00', '0.00', '0.00', '23', '17000083', '2017-09-26 11:47:25', '17000083', '2017-09-26 12:52:03', '0');
INSERT INTO `t_user_account` VALUES ('88', '17000084', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12', '17000084', '2017-09-27 00:46:53', '17000084', '2017-09-27 05:21:48', '0');
INSERT INTO `t_user_account` VALUES ('89', '17000052', '1', '0', '40.00', '20.00', '0.00', '0.00', '0.00', '0.00', '13', '17000052', '2017-09-27 14:47:17', '17000052', '2017-09-27 14:48:45', '0');
INSERT INTO `t_user_account` VALUES ('90', '17000086', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '23', '17000086', '2017-09-28 01:46:58', '17000086', '2017-09-28 01:53:55', '0');
INSERT INTO `t_user_account` VALUES ('91', '17000082', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000082', '2017-09-28 17:37:33', '17000082', '2017-09-28 17:37:33', '0');
INSERT INTO `t_user_account` VALUES ('92', '17000132', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000132', '2017-09-30 15:03:29', '17000132', '2017-09-30 15:03:29', '0');
INSERT INTO `t_user_account` VALUES ('93', '17000133', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '14', '17000133', '2017-09-30 15:10:18', '17000133', '2017-09-30 15:47:18', '0');
INSERT INTO `t_user_account` VALUES ('94', '17000135', '1', '0', '0.50', '150.00', '50.00', '0.00', '0.00', '0.00', '37', '17000135', '2017-09-30 15:45:02', '17000135', '2017-09-30 17:32:19', '0');
INSERT INTO `t_user_account` VALUES ('95', '17000136', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '5', '17000136', '2017-09-30 18:44:40', '17000136', '2017-09-30 18:44:40', '0');
INSERT INTO `t_user_account` VALUES ('96', '17000137', '1', '0', '0.00', '50.00', '0.00', '0.00', '0.00', '0.00', '44', '17000137', '2017-10-01 07:37:42', '17000137', '2017-10-23 16:50:37', '0');
INSERT INTO `t_user_account` VALUES ('97', '17000138', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12', '17000138', '2017-10-02 16:43:46', '17000138', '2017-10-02 16:44:41', '0');
INSERT INTO `t_user_account` VALUES ('98', '17000141', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000141', '2017-10-08 03:14:15', '17000141', '2017-10-08 03:14:30', '0');
INSERT INTO `t_user_account` VALUES ('99', '17000142', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '5', '17000142', '2017-10-09 11:46:20', '17000142', '2017-10-09 11:46:39', '0');
INSERT INTO `t_user_account` VALUES ('100', '17000143', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000143', '2017-10-10 01:25:26', '17000143', '2017-10-10 01:25:26', '0');
INSERT INTO `t_user_account` VALUES ('101', '17000140', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000140', '2017-10-10 11:42:12', '17000140', '2017-10-10 11:42:12', '0');
INSERT INTO `t_user_account` VALUES ('102', '17000145', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '193', '17000145', '2017-10-10 15:40:52', '17000145', '2017-10-12 15:59:12', '0');
INSERT INTO `t_user_account` VALUES ('103', '17000147', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000147', '2017-10-10 16:00:39', '17000147', '2017-10-10 16:00:39', '0');
INSERT INTO `t_user_account` VALUES ('104', '17000148', '1', '0', '0.00', '20.00', '0.00', '0.00', '0.00', '0.00', '32', '17000148', '2017-10-10 16:04:19', '17000148', '2017-10-13 15:47:05', '0');
INSERT INTO `t_user_account` VALUES ('105', '17000222', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '14', '17000222', '2017-10-10 21:45:58', '17000222', '2017-10-10 21:45:58', '0');
INSERT INTO `t_user_account` VALUES ('106', '17000223', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '17', '17000223', '2017-10-10 22:07:03', '17000223', '2017-10-10 22:07:03', '0');
INSERT INTO `t_user_account` VALUES ('107', '17000224', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '139', '17000224', '2017-10-12 15:02:50', '17000224', '2017-10-14 14:33:10', '0');
INSERT INTO `t_user_account` VALUES ('108', '17000226', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '13', '17000226', '2017-10-16 17:36:56', '17000226', '2017-10-16 17:37:08', '0');
INSERT INTO `t_user_account` VALUES ('109', '17000227', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '15', '17000227', '2017-10-18 21:55:51', '17000227', '2017-10-18 21:55:51', '0');
INSERT INTO `t_user_account` VALUES ('110', '17000228', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '19', '17000228', '2017-10-19 13:29:48', '17000228', '2017-10-19 13:38:54', '0');
INSERT INTO `t_user_account` VALUES ('111', '17000229', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000229', '2017-10-19 15:23:38', '17000229', '2017-10-19 15:23:38', '0');
INSERT INTO `t_user_account` VALUES ('112', '17000234', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000234', '2017-10-22 19:22:39', '17000234', '2017-10-22 19:22:39', '0');
INSERT INTO `t_user_account` VALUES ('113', '17000235', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000235', '2017-10-23 23:23:41', '17000235', '2017-10-23 23:23:41', '0');

-- ----------------------------
-- Table structure for `t_user_account_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account_detail`;
CREATE TABLE `t_user_account_detail` (
  `trade_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '交易明细ID',
  `account_id` bigint(20) NOT NULL COMMENT '所属账户ID',
  `user_id` bigint(20) NOT NULL COMMENT '所属用户ID',
  `trade_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一交易单号  yyMMddHHmm+userid+4位随机数',
  `trade_kind` int(11) NOT NULL DEFAULT '1' COMMENT '事件区分 1：入金 -2：出金区分',
  `amount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易收支金额',
  `trade_currency` int(11) DEFAULT NULL COMMENT '出入金方式：1-支付宝，2-微信，3-银行卡',
  `new_balance` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '账户余额（收支计算后）',
  `trade_type` int(11) NOT NULL DEFAULT '10' COMMENT '交易类型\r\n10：充值\r\n20：游戏转码（下注）\r\n30：游戏赢利\r\n40：游戏赔付\r\n50：提现',
  `trade_status` int(11) NOT NULL DEFAULT '10' COMMENT '交易状态\r\n 10：已提交\r\n 20：审核中\r\n 30：已完成\r\n 40：审核不通过\r\n 50：已关闭？？？',
  `remarks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_id` bigint(11) DEFAULT NULL COMMENT '审核步骤',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `is_notification` int(11) DEFAULT '0',
  PRIMARY KEY (`trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户交易明细';

-- ----------------------------
-- Records of t_user_account_detail
-- ----------------------------
INSERT INTO `t_user_account_detail` VALUES ('51', '59', '17000044', 'R150537260506243789', '1', '2.00', null, '2.00', '11', '2', '', null, '1', '17000044', '2017-09-14 15:03:25', '17000044', '2017-09-14 15:03:25', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('52', '62', '17000050', 'R150544930027114226', '1', '50.00', null, '50.00', '11', '2', '测试', null, '1', '17000050', '2017-09-15 12:43:11', '17000050', '2017-09-15 12:43:11', '1', '0');
INSERT INTO `t_user_account_detail` VALUES ('53', '62', '17000050', 'R150545059069054950', '1', '150.00', null, '200.00', '11', '2', '', null, '1', '17000050', '2017-09-15 12:43:12', '17000050', '2017-09-15 12:43:12', '1', '0');
INSERT INTO `t_user_account_detail` VALUES ('54', '62', '17000050', 'R150545437003588060', '1', '50.00', null, '50.00', '11', '2', '测试', null, '1', '17000050', '2017-09-15 12:45:23', '17000050', '2017-09-15 12:45:23', '1', '0');
INSERT INTO `t_user_account_detail` VALUES ('55', '62', '17000050', 'R150545483865874066', '1', '50.00', null, '50.00', '11', '2', '测试', null, '1', '17000050', '2017-09-15 13:53:59', '17000050', '2017-09-15 13:53:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('56', '62', '17000050', 'R150579599259173009', '1', '300.00', null, '300.50', '11', '2', '', null, '1', '17000050', '2017-09-19 12:39:53', '17000050', '2017-09-19 12:39:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('57', '65', '17000057', 'R150579800927356958', '1', '200.00', null, '200.00', '11', '2', '测试赠送', null, '1', '17000057', '2017-09-19 13:13:29', '17000057', '2017-09-19 13:13:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('58', '65', '17000057', 'R150579801412975160', '1', '200.00', null, '400.00', '11', '2', '', null, '1', '17000057', '2017-09-19 13:13:34', '17000057', '2017-09-19 13:13:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('59', '66', '17000056', 'R150580895820281914', '1', '200.00', null, '200.00', '11', '2', '', null, '1', '17000056', '2017-09-19 16:15:58', '17000056', '2017-09-19 16:15:58', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('60', '68', '17000058', 'R150580899380024432', '1', '200.00', null, '200.00', '11', '2', '', null, '1', '17000058', '2017-09-19 16:16:34', '17000058', '2017-09-19 16:16:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('61', '65', '17000057', 'R150587478991132938', '1', '420.00', null, '420.00', '11', '2', '', null, '1', '17000057', '2017-09-20 10:33:10', '17000057', '2017-09-20 10:33:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('62', '69', '17000060', 'R150599410565873635', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-21 19:41:46', '17000060', '2017-09-21 19:41:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('63', '69', '17000060', 'R150599412599697931', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-21 19:42:06', '17000060', '2017-09-21 19:42:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('64', '62', '17000050', 'W150599750708748974', '-1', '840.00', null, '0.00', '50', '0', null, '1', '1', '17000050', '2017-09-21 20:38:27', '17000050', '2017-09-21 20:38:27', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('65', '62', '17000050', 'R150599858703597516', '1', '10.00', null, '19.50', '10', '2', '玩家充值', null, '2', '17000050', '2017-09-21 20:56:27', '17000050', '2017-09-22 13:23:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('66', '69', '17000060', 'R150605141473517700', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-22 11:36:55', '17000060', '2017-09-22 11:36:55', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('67', '61', '17000046', 'R150605443444840157', '1', '1.00', null, '1.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-22 12:27:14', '17000046', '2017-09-22 15:04:31', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('68', '74', '17000066', 'R150605484723117343', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000066', '2017-09-22 12:34:07', '17000066', '2017-09-22 12:34:07', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('69', '61', '17000046', 'R150606611961611442', '1', '1.00', null, '2.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-22 15:42:00', '17000046', '2017-09-22 16:46:08', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('70', '61', '17000046', 'W150606837981777504', '-1', '1.00', null, '0.00', '50', '1', '什么鬼，测试你也想要钱', '2', '1', '17000046', '2017-09-23 17:33:56', '17000071', '2017-09-23 18:36:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('71', '69', '17000060', 'R150607281089652126', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-22 17:33:31', '17000060', '2017-09-22 17:33:31', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('72', '69', '17000060', 'R150607504540188598', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-22 18:10:45', '17000060', '2017-09-22 18:10:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('73', '69', '17000060', 'R150607505769963503', '1', '1.00', null, '1.00', '10', '2', '玩家充值', null, '2', '17000060', '2017-09-22 18:10:58', '17000060', '2017-09-22 19:13:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('74', '69', '17000060', 'W150607515142869439', '-1', '1.00', null, '0.00', '50', '1', '测试通过 ', '1', '1', '17000060', '2017-09-22 18:12:31', '3', '2017-09-27 22:23:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('75', '62', '17000050', 'R150609420256547049', '1', '10.00', null, '19.50', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-22 23:30:03', '17000050', '2017-09-22 23:30:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('76', '62', '17000050', 'R150609422620751215', '1', '10.00', null, '19.50', '10', '2', '玩家充值', null, '2', '17000050', '2017-09-22 23:30:26', '17000050', '2017-09-23 14:29:52', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('77', '62', '17000050', 'R150609422651590217', '1', '10.00', null, '19.50', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-22 23:30:27', '17000050', '2017-09-22 23:30:27', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('78', '61', '17000046', 'R150613575529840748', '1', '1.00', null, '2.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-23 11:02:35', '17000046', '2017-09-23 12:05:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('79', '62', '17000050', 'R150614229601336897', '1', '10.00', null, '29.50', '10', '2', '玩家充值', null, '2', '17000050', '2017-09-23 12:51:36', '17000050', '2017-09-23 12:52:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('80', '61', '17000046', 'R150615124351283006', '1', '1.00', null, '3.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-23 15:20:44', '17000046', '2017-09-23 16:23:44', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('81', '61', '17000046', 'R150615405320492119', '1', '1.00', null, '4.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-23 16:07:33', '17000046', '2017-09-23 17:12:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('82', '61', '17000046', 'R150615609335962853', '1', '1.00', null, '4.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-09-23 16:41:33', '17000046', '2017-09-23 16:41:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('83', '61', '17000046', 'W150615955599596930', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000046', '2017-09-23 17:47:05', '17000071', '2017-09-27 22:02:25', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('84', '61', '17000046', 'R150616010421265189', '1', '2.00', null, '4.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-09-23 17:48:24', '17000046', '2017-09-23 17:48:24', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('85', '58', '17000043', 'R150616172591586974', '1', '500.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-09-23 18:15:26', '17000043', '2017-09-23 18:15:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('86', '61', '17000046', 'R150616292286980624', '1', '10.00', null, '4.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-09-23 18:35:23', '17000046', '2017-09-23 18:35:23', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('87', '61', '17000046', 'R150616293569673528', '1', '10.00', null, '4.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-09-23 18:35:36', '17000046', '2017-09-23 18:35:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('88', '81', '17000077', 'R150625528410819303', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000077', '2017-09-24 20:14:44', '17000077', '2017-09-24 20:14:44', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('89', '62', '17000050', 'R150632140505331420', '1', '50.00', null, '19.50', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-25 14:36:45', '17000050', '2017-09-25 14:36:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('90', '69', '17000060', 'R150632140982265872', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-25 14:36:50', '17000060', '2017-09-25 14:36:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('91', '62', '17000050', 'R150632143122719637', '1', '10.00', null, '19.50', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-25 14:37:11', '17000050', '2017-09-25 14:37:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('92', '62', '17000050', 'R150632145605466042', '1', '10.00', null, '29.50', '10', '2', '玩家充值', null, '2', '17000050', '2017-09-25 14:37:36', '17000050', '2017-09-25 15:41:04', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('93', '69', '17000060', 'R150632145925159571', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-25 14:37:39', '17000060', '2017-09-25 14:37:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('94', '69', '17000060', 'R150632148177025036', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-25 14:38:02', '17000060', '2017-09-25 14:38:02', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('95', '69', '17000060', 'R150632152243439397', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-25 14:38:42', '17000060', '2017-09-25 14:38:42', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('96', '84', '17000079', 'R150633679701940706', '1', '480.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000079', '2017-09-25 18:53:17', '17000079', '2017-09-25 18:53:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('97', '84', '17000079', 'R150633681916329072', '1', '480.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000079', '2017-09-25 18:53:39', '17000079', '2017-09-25 18:53:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('98', '87', '17000083', 'R150639772062838738', '1', '10.00', null, '10.00', '10', '2', '玩家充值', null, '2', '17000083', '2017-09-26 11:48:41', '17000083', '2017-09-26 12:52:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('99', '61', '17000046', 'R150640656802661460', '1', '1.00', null, '5.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-09-26 14:16:08', '17000046', '2017-09-26 14:17:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('100', '61', '17000046', 'W150640673627450459', '-1', '1.00', null, '0.00', '50', '2', '傻妞测试测试', '2', '1', '17000046', '2017-09-26 14:18:56', '17000071', '2017-09-27 21:59:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('101', '61', '17000046', 'W150640721817378536', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000046', '2017-09-26 14:26:58', '17000071', '2017-09-28 09:29:00', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('102', '88', '17000084', 'R150644448041585781', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000084', '2017-09-27 00:48:00', '17000084', '2017-09-27 00:48:00', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('103', '88', '17000084', 'R150646087109070470', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000084', '2017-09-27 05:21:11', '17000084', '2017-09-27 05:21:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('104', '88', '17000084', 'R150646090828627762', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000084', '2017-09-27 05:21:48', '17000084', '2017-09-27 05:21:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('105', '62', '17000050', 'R150649312496391631', '1', '50.00', null, '0.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-27 14:18:45', '17000050', '2017-09-27 14:18:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('106', '89', '17000052', 'R150649489265437583', '1', '20.00', null, '20.00', '10', '2', '玩家充值', null, '2', '17000052', '2017-09-27 14:48:13', '17000052', '2017-09-27 14:48:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('107', '90', '17000086', 'R150653469646951727', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000086', '2017-09-28 01:51:36', '17000086', '2017-09-28 01:51:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('108', '90', '17000086', 'R150653483503027431', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000086', '2017-09-28 01:53:55', '17000086', '2017-09-28 01:53:55', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('109', '62', '17000050', 'R150655846761099424', '1', '10.00', null, '0.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-28 08:27:48', '17000050', '2017-09-28 08:27:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('110', '62', '17000050', 'R150655850092516955', '1', '10.00', null, '10.05', '10', '2', '玩家充值', null, '2', '17000050', '2017-09-28 08:28:21', '17000050', '2017-09-28 08:28:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('111', '62', '17000050', 'W150655856727257842', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000050', '2017-09-28 08:29:27', '1', '2017-09-30 17:45:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('112', '61', '17000046', 'W150674071690177810', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000046', '2017-09-30 11:05:17', '17000071', '2017-09-30 17:34:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('113', '94', '17000135', 'R150675753494081870', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000135', '2017-09-30 15:45:35', '17000135', '2017-09-30 15:45:35', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('114', '94', '17000135', 'R150675762057277508', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000135', '2017-09-30 15:47:01', '17000135', '2017-09-30 15:47:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('115', '93', '17000133', 'R150675763847963019', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000133', '2017-09-30 15:47:18', '17000133', '2017-09-30 15:47:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('116', '94', '17000135', 'R150675806723138655', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000135', '2017-09-30 15:54:27', '17000135', '2017-09-30 15:54:27', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('117', '94', '17000135', 'R150675818420137525', '1', '100.00', null, '100.00', '10', '2', '玩家充值', null, '2', '17000135', '2017-09-30 15:56:24', '17000135', '2017-09-30 15:57:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('118', '61', '17000046', 'R150675821117213453', '1', '1.00', null, '3.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-09-30 15:56:51', '17000046', '2017-09-30 15:56:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('119', '94', '17000135', 'W150675861874723663', '-1', '50.00', null, '0.00', '50', '2', '', '2', '1', '17000135', '2017-09-30 16:03:39', '1', '2017-09-30 17:45:42', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('120', '94', '17000135', 'R150676016975014062', '1', '50.00', null, '50.00', '10', '2', '玩家充值', null, '2', '17000135', '2017-09-30 16:29:30', '17000135', '2017-09-30 17:32:19', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('121', '69', '17000060', 'R150676898874249903', '1', '100.00', null, '100.00', '11', '2', '游戏测试', null, '1', '17000060', '2017-09-30 18:56:29', '17000060', '2017-09-30 18:56:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('122', '62', '17000050', 'R150676694219335852', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:22:22', '17000050', '2017-09-30 18:22:22', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('123', '66', '17000056', 'R150676694995794362', '1', '100.00', null, '342.50', '10', '5', '玩家充值', null, '1', '17000056', '2017-09-30 18:22:30', '17000056', '2017-09-30 18:22:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('124', '69', '17000060', 'W150676705236320887', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000060', '2017-09-30 18:24:12', '17000071', '2017-09-30 19:30:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('125', '69', '17000060', 'R150676718881673848', '1', '10.00', null, '79.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:26:29', '17000060', '2017-09-30 18:26:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('126', '66', '17000056', 'R150676719601677258', '1', '100.00', null, '342.50', '10', '5', '玩家充值', null, '1', '17000056', '2017-09-30 18:26:36', '17000056', '2017-09-30 18:26:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('127', '69', '17000060', 'R150676724030936471', '1', '10.00', null, '79.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('128', '69', '17000060', 'R150676724046451240', '1', '10.00', null, '79.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:27:20', '17000060', '2017-09-30 18:27:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('129', '69', '17000060', 'R150676726410574845', '1', '1.00', null, '79.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:27:44', '17000060', '2017-09-30 18:27:44', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('130', '69', '17000060', 'R150676741802471294', '1', '10.00', null, '98.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:30:18', '17000060', '2017-09-30 18:30:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('131', '69', '17000060', 'R150676741939899994', '1', '10.00', null, '98.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:30:19', '17000060', '2017-09-30 18:30:19', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('132', '62', '17000050', 'R150676753009879565', '1', '10.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:32:10', '17000050', '2017-09-30 18:32:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('133', '62', '17000050', 'R150676757000073413', '1', '10.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:32:50', '17000050', '2017-09-30 18:32:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('134', '69', '17000060', 'R150676757366797192', '1', '10.00', null, '98.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:32:54', '17000060', '2017-09-30 18:32:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('135', '69', '17000060', 'R150676759422450577', '1', '10.00', null, '98.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:33:14', '17000060', '2017-09-30 18:33:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('136', '62', '17000050', 'R150676759700213777', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:33:17', '17000050', '2017-09-30 18:33:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('137', '69', '17000060', 'W150676827227912150', '-1', '2.00', null, '0.00', '50', '0', null, '1', '1', '17000060', '2017-09-30 18:44:32', '17000060', '2017-09-30 18:44:32', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('138', '69', '17000060', 'R150676844977238950', '1', '10.00', null, '98.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:47:30', '17000060', '2017-09-30 18:47:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('139', '62', '17000050', 'R150676853797544560', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:48:58', '17000050', '2017-09-30 18:48:58', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('140', '62', '17000050', 'R150676855167676363', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:49:12', '17000050', '2017-09-30 18:49:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('141', '62', '17000050', 'R150676865383722139', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:50:54', '17000050', '2017-09-30 18:50:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('142', '69', '17000060', 'R150676867609995511', '1', '10.00', null, '118.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:51:16', '17000060', '2017-09-30 18:51:16', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('143', '69', '17000060', 'R150676871737396518', '1', '10.00', null, '118.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-09-30 18:51:57', '17000060', '2017-09-30 18:51:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('144', '62', '17000050', 'R150676885239566602', '1', '20.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-09-30 18:54:12', '17000050', '2017-09-30 18:54:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('145', '61', '17000046', 'W150677387410442397', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000046', '2017-09-30 20:17:54', '17000071', '2017-10-10 12:48:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('146', '96', '17000137', 'R150681467058754546', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-01 07:37:51', '17000137', '2017-10-01 07:37:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('147', '96', '17000137', 'R150682255722219146', '1', '50.00', null, '50.00', '10', '2', '玩家充值', null, '2', '17000137', '2017-10-01 09:49:17', '17000137', '2017-10-01 10:52:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('148', '96', '17000137', 'R150692696286965464', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-02 14:49:23', '17000137', '2017-10-02 14:49:23', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('149', '96', '17000137', 'R150692698152934437', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-02 14:49:42', '17000137', '2017-10-02 14:49:42', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('150', '97', '17000138', 'R150693384520471387', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000138', '2017-10-02 16:44:05', '17000138', '2017-10-02 16:44:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('151', '97', '17000138', 'R150693386319757509', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000138', '2017-10-02 16:44:23', '17000138', '2017-10-02 16:44:23', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('152', '97', '17000138', 'R150693388082310426', '1', '10000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000138', '2017-10-02 16:44:41', '17000138', '2017-10-02 16:44:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('153', '98', '17000141', 'R150740366960019808', '1', '20.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000141', '2017-10-08 03:14:30', '17000141', '2017-10-08 03:14:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('154', '96', '17000137', 'R150743894857212386', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-08 13:02:29', '17000137', '2017-10-08 13:02:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('155', '99', '17000142', 'R150752079917958456', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000142', '2017-10-09 11:46:39', '17000142', '2017-10-09 11:46:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('156', '61', '17000046', 'W150755343659385627', '-1', '1.00', null, '0.00', '50', '2', '', '2', '1', '17000046', '2017-10-09 20:50:37', '17000071', '2017-10-10 12:46:49', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('157', '69', '17000060', 'R150755430417239958', '1', '1.00', null, '118.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-09 21:05:04', '17000060', '2017-10-09 21:05:04', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('158', '61', '17000046', 'R150755430658344077', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-09 21:05:07', '17000046', '2017-10-09 21:05:07', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('159', '61', '17000046', 'R150755431718456836', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-09 21:05:17', '17000046', '2017-10-09 21:05:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('160', '69', '17000060', 'R150755433178517438', '1', '1.00', null, '118.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-09 21:05:32', '17000060', '2017-10-09 21:05:32', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('161', '96', '17000137', 'R150760512879033086', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-10 11:12:09', '17000137', '2017-10-10 11:12:09', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('162', '61', '17000046', 'R150760607413715736', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-10 11:27:54', '17000046', '2017-10-10 11:27:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('163', '61', '17000046', 'R150760608875774218', '1', '1.00', null, '3.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-10-10 11:28:09', '17000046', '2017-10-10 11:29:31', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('164', '80', '17000075', 'R150760650120652715', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 11:35:01', '17000075', '2017-10-10 11:35:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('165', '80', '17000075', 'R150760654190862308', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 11:35:42', '17000075', '2017-10-10 11:35:42', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('166', '80', '17000075', 'R150760677337632635', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 11:39:33', '17000075', '2017-10-10 11:39:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('167', '69', '17000060', 'R150760701257374102', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:43:33', '17000060', '2017-10-10 11:43:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('168', '69', '17000060', 'R150760702731135574', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:43:47', '17000060', '2017-10-10 11:43:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('169', '69', '17000060', 'R150760703691219664', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:43:57', '17000060', '2017-10-10 11:43:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('170', '69', '17000060', 'R150760707471070083', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:44:35', '17000060', '2017-10-10 11:44:35', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('171', '69', '17000060', 'R150760711390014158', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:45:14', '17000060', '2017-10-10 11:45:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('172', '69', '17000060', 'R150760715006052829', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:45:50', '17000060', '2017-10-10 11:45:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('173', '69', '17000060', 'R150760716212556285', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:46:02', '17000060', '2017-10-10 11:46:02', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('174', '69', '17000060', 'R150760717145416899', '1', '10.00', null, '105.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 11:46:11', '17000060', '2017-10-10 11:46:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('175', '61', '17000046', 'W150760739509518058', '-1', '1.00', null, '0.00', '50', '1', 'ceshi', '2', '1', '17000046', '2017-10-10 11:49:55', '17000071', '2017-10-10 17:18:52', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('176', '96', '17000137', 'R150760836628717207', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-10 12:06:06', '17000137', '2017-10-10 12:06:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('177', '80', '17000075', 'R150761846553171950', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 14:54:26', '17000075', '2017-10-10 14:54:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('178', '80', '17000075', 'R150761847545387556', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 14:54:35', '17000075', '2017-10-10 14:54:35', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('179', '80', '17000075', 'R150761850465918101', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 14:55:05', '17000075', '2017-10-10 14:55:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('180', '80', '17000075', 'R150761932126988532', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 15:08:41', '17000075', '2017-10-10 15:08:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('181', '80', '17000075', 'R150761932982282455', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 15:08:50', '17000075', '2017-10-10 15:08:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('182', '80', '17000075', 'R150761937381977664', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 15:09:34', '17000075', '2017-10-10 15:09:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('183', '80', '17000075', 'R150761943385891033', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000075', '2017-10-10 15:10:34', '17000075', '2017-10-10 15:10:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('184', '69', '17000060', 'R150761971958725727', '1', '1000.00', null, '125.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-10 15:15:20', '17000060', '2017-10-10 15:15:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('185', '104', '17000148', 'R150762649033159775', '1', '20.00', null, '20.00', '11', '2', 'ceshi', null, '1', '17000148', '2017-10-10 17:08:10', '17000148', '2017-10-10 17:08:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('186', '102', '17000145', 'R150762301033564257', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:10:10', '17000145', '2017-10-10 16:10:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('187', '102', '17000145', 'R150762304056831032', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:10:41', '17000145', '2017-10-10 16:10:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('188', '102', '17000145', 'R150762305036453663', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:10:50', '17000145', '2017-10-10 16:10:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('189', '102', '17000145', 'R150762307802367685', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:11:18', '17000145', '2017-10-10 16:11:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('190', '102', '17000145', 'R150762336508866172', '1', '500.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:16:05', '17000145', '2017-10-10 16:16:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('191', '102', '17000145', 'R150762342680963876', '1', '500.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:17:07', '17000145', '2017-10-10 16:17:07', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('192', '102', '17000145', 'R150762344825121271', '1', '500.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:17:28', '17000145', '2017-10-10 16:17:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('193', '102', '17000145', 'R150762350076671569', '1', '500.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:18:21', '17000145', '2017-10-10 16:18:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('194', '102', '17000145', 'R150762375561536893', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:22:36', '17000145', '2017-10-10 16:22:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('195', '102', '17000145', 'R150762376721890972', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:22:47', '17000145', '2017-10-10 16:22:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('196', '102', '17000145', 'R150762384071858173', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:24:01', '17000145', '2017-10-10 16:24:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('197', '102', '17000145', 'R150762403732733394', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:27:17', '17000145', '2017-10-10 16:27:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('198', '102', '17000145', 'R150762431501475109', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:31:55', '17000145', '2017-10-10 16:31:55', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('199', '102', '17000145', 'R150762438109891683', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:33:01', '17000145', '2017-10-10 16:33:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('200', '102', '17000145', 'R150762443631363044', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:33:56', '17000145', '2017-10-10 16:33:56', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('201', '102', '17000145', 'R150762466952375004', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:37:50', '17000145', '2017-10-10 16:37:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('202', '102', '17000145', 'R150762518469265489', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:46:25', '17000145', '2017-10-10 16:46:25', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('203', '102', '17000145', 'R150762525370894205', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:47:34', '17000145', '2017-10-10 16:47:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('204', '102', '17000145', 'R150762577391451819', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:56:14', '17000145', '2017-10-10 16:56:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('205', '102', '17000145', 'R150762579993236064', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:56:40', '17000145', '2017-10-10 16:56:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('206', '102', '17000145', 'R150762581369291503', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 16:56:54', '17000145', '2017-10-10 16:56:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('207', '102', '17000145', 'R150762613265988487', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:02:13', '17000145', '2017-10-10 17:02:13', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('208', '102', '17000145', 'R150762618194950391', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:03:02', '17000145', '2017-10-10 17:03:02', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('209', '102', '17000145', 'R150762657515010108', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:09:35', '17000145', '2017-10-10 17:09:35', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('210', '102', '17000145', 'R150762661664857654', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:10:17', '17000145', '2017-10-10 17:10:17', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('211', '102', '17000145', 'R150762663796322667', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:10:38', '17000145', '2017-10-10 17:10:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('212', '102', '17000145', 'R150762686351427738', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:14:24', '17000145', '2017-10-10 17:14:24', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('213', '102', '17000145', 'R150762710020519069', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:18:20', '17000145', '2017-10-10 17:18:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('214', '102', '17000145', 'R150762794887563150', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:32:29', '17000145', '2017-10-10 17:32:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('215', '102', '17000145', 'R150762797519158679', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:32:55', '17000145', '2017-10-10 17:32:55', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('216', '102', '17000145', 'R150762798338017546', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:33:03', '17000145', '2017-10-10 17:33:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('217', '102', '17000145', 'R150762799956755208', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:33:20', '17000145', '2017-10-10 17:33:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('218', '102', '17000145', 'R150762801023247638', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:33:30', '17000145', '2017-10-10 17:33:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('219', '102', '17000145', 'R150762831965881548', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:38:40', '17000145', '2017-10-10 17:38:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('220', '102', '17000145', 'R150762832736563729', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:38:47', '17000145', '2017-10-10 17:38:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('221', '102', '17000145', 'R150762833380855374', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:38:54', '17000145', '2017-10-10 17:38:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('222', '102', '17000145', 'R150762833666784313', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:38:57', '17000145', '2017-10-10 17:38:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('223', '102', '17000145', 'R150762847893793748', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:41:19', '17000145', '2017-10-10 17:41:19', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('224', '102', '17000145', 'R150762852183348756', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:42:02', '17000145', '2017-10-10 17:42:02', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('225', '102', '17000145', 'R150762853525433272', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:42:15', '17000145', '2017-10-10 17:42:15', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('226', '102', '17000145', 'R150762902229967567', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:50:22', '17000145', '2017-10-10 17:50:22', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('227', '102', '17000145', 'R150762903359037721', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:50:34', '17000145', '2017-10-10 17:50:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('228', '102', '17000145', 'R150762903983059459', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:50:40', '17000145', '2017-10-10 17:50:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('229', '102', '17000145', 'R150762911434031388', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 17:51:54', '17000145', '2017-10-10 17:51:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('230', '102', '17000145', 'R150763010273558842', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:08:23', '17000145', '2017-10-10 18:08:23', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('231', '102', '17000145', 'R150763026562164729', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:11:06', '17000145', '2017-10-10 18:11:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('232', '102', '17000145', 'R150763035630228990', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:12:36', '17000145', '2017-10-10 18:12:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('233', '102', '17000145', 'R150763075060635582', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:19:11', '17000145', '2017-10-10 18:19:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('234', '102', '17000145', 'R150763086719684132', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:21:07', '17000145', '2017-10-10 18:21:07', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('235', '102', '17000145', 'R150763095232526557', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:22:32', '17000145', '2017-10-10 18:22:32', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('236', '102', '17000145', 'R150763101663275032', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:23:37', '17000145', '2017-10-10 18:23:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('237', '102', '17000145', 'R150763264483369915', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:50:45', '17000145', '2017-10-10 18:50:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('238', '102', '17000145', 'R150763278234620938', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:53:02', '17000145', '2017-10-10 18:53:02', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('239', '102', '17000145', 'R150763288752568127', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:54:48', '17000145', '2017-10-10 18:54:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('240', '102', '17000145', 'R150763290282325695', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:55:03', '17000145', '2017-10-10 18:55:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('241', '102', '17000145', 'R150763298122263627', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:56:21', '17000145', '2017-10-10 18:56:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('242', '102', '17000145', 'R150763317660010221', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 18:59:37', '17000145', '2017-10-10 18:59:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('243', '102', '17000145', 'R150763343644630878', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:03:56', '17000145', '2017-10-10 19:03:56', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('244', '102', '17000145', 'R150763354123177044', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:05:41', '17000145', '2017-10-10 19:05:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('245', '102', '17000145', 'R150763358575651184', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:06:26', '17000145', '2017-10-10 19:06:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('246', '102', '17000145', 'R150763371885877518', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:08:39', '17000145', '2017-10-10 19:08:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('247', '102', '17000145', 'R150763373478346940', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:08:55', '17000145', '2017-10-10 19:08:55', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('248', '102', '17000145', 'R150763385287817337', '1', '5000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:10:53', '17000145', '2017-10-10 19:10:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('249', '102', '17000145', 'R150763393562080969', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:12:16', '17000145', '2017-10-10 19:12:16', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('250', '102', '17000145', 'R150763402112167616', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:13:41', '17000145', '2017-10-10 19:13:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('251', '102', '17000145', 'R150763402945799202', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:13:49', '17000145', '2017-10-10 19:13:49', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('252', '102', '17000145', 'R150763406886992064', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:14:29', '17000145', '2017-10-10 19:14:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('253', '102', '17000145', 'R150763413824312104', '1', '1000.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:15:38', '17000145', '2017-10-10 19:15:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('254', '102', '17000145', 'R150763422455351556', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-10 19:17:05', '17000145', '2017-10-10 19:17:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('255', '62', '17000050', 'R150765281109179851', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-10-11 00:26:51', '17000050', '2017-10-11 00:26:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('256', '62', '17000050', 'R150765282854821010', '1', '50.00', null, '9.05', '10', '5', '玩家充值', null, '1', '17000050', '2017-10-11 00:27:09', '17000050', '2017-10-11 00:27:09', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('257', '69', '17000060', 'R150770388598555608', '1', '10.00', null, '181.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-11 14:38:06', '17000060', '2017-10-11 14:38:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('258', '69', '17000060', 'R150770390819582753', '1', '10.00', null, '181.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-11 14:38:28', '17000060', '2017-10-11 14:38:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('259', '69', '17000060', 'R150770582445179161', '1', '500.00', null, '181.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-11 15:10:24', '17000060', '2017-10-11 15:10:24', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('260', '64', '17000055', 'R150771257335284301', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:02:53', '17000055', '2017-10-11 17:02:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('261', '64', '17000055', 'R150771266102951216', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:04:21', '17000055', '2017-10-11 17:04:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('262', '64', '17000055', 'R150771273956280480', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:05:40', '17000055', '2017-10-11 17:05:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('263', '64', '17000055', 'R150771276464318474', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:06:05', '17000055', '2017-10-11 17:06:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('264', '64', '17000055', 'R150771281017924668', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:06:50', '17000055', '2017-10-11 17:06:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('265', '64', '17000055', 'R150771297744256776', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:09:37', '17000055', '2017-10-11 17:09:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('266', '64', '17000055', 'R150771332548621885', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:15:25', '17000055', '2017-10-11 17:15:25', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('267', '64', '17000055', 'R150771339762334576', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:16:38', '17000055', '2017-10-11 17:16:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('268', '64', '17000055', 'R150771494776753684', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:42:28', '17000055', '2017-10-11 17:42:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('269', '64', '17000055', 'R150771519804238318', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:46:38', '17000055', '2017-10-11 17:46:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('270', '64', '17000055', 'R150771524730637996', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-11 17:47:27', '17000055', '2017-10-11 17:47:27', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('271', '69', '17000060', 'R150778463877533766', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('272', '69', '17000060', 'R150778463897218819', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 13:03:59', '17000060', '2017-10-12 13:03:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('273', '64', '17000055', 'R150779393881264354', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-12 15:38:59', '17000055', '2017-10-12 15:38:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('274', '64', '17000055', 'R150779399394298514', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-12 15:39:54', '17000055', '2017-10-12 15:39:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('275', '64', '17000055', 'R150779426922147573', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-12 15:44:29', '17000055', '2017-10-12 15:44:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('276', '64', '17000055', 'R150779429817238897', '1', '1.00', null, '1.00', '10', '2', '玩家充值', null, '2', '17000055', '2017-10-12 15:44:58', '17000055', '2017-10-12 16:48:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('277', '107', '17000224', 'R150779474944255228', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 15:52:29', '17000224', '2017-10-12 15:52:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('278', '107', '17000224', 'R150779478938444661', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 15:53:09', '17000224', '2017-10-12 15:53:09', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('279', '107', '17000224', 'R150779483631749930', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 15:53:56', '17000224', '2017-10-12 15:53:56', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('280', '107', '17000224', 'R150779486805769177', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 15:54:28', '17000224', '2017-10-12 15:54:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('281', '102', '17000145', 'R150779515193331560', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000145', '2017-10-12 15:59:12', '17000145', '2017-10-12 15:59:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('282', '107', '17000224', 'R150779609812222271', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 16:14:58', '17000224', '2017-10-12 16:14:58', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('283', '107', '17000224', 'R150779635222886395', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 16:19:12', '17000224', '2017-10-12 16:19:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('284', '61', '17000046', 'R150780393655411517', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:25:37', '17000046', '2017-10-12 18:25:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('285', '61', '17000046', 'R150780398147269221', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:26:21', '17000046', '2017-10-12 18:26:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('286', '61', '17000046', 'R150780404586061729', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:27:26', '17000046', '2017-10-12 18:27:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('287', '61', '17000046', 'R150780409976582941', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:28:20', '17000046', '2017-10-12 18:28:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('288', '61', '17000046', 'R150780447535897271', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:34:35', '17000046', '2017-10-12 18:34:35', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('289', '61', '17000046', 'R150780453746699709', '1', '50.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:35:37', '17000046', '2017-10-12 18:35:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('290', '61', '17000046', 'R150780457468810752', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:36:15', '17000046', '2017-10-12 18:36:15', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('291', '61', '17000046', 'R150780461781340731', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:36:58', '17000046', '2017-10-12 18:36:58', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('292', '78', '17000073', 'R150780475303154694', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-12 18:39:13', '17000073', '2017-10-12 18:39:13', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('293', '61', '17000046', 'R150780487171450792', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 18:41:12', '17000046', '2017-10-12 18:41:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('294', '107', '17000224', 'R150780570819211528', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 18:55:08', '17000224', '2017-10-12 18:55:08', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('295', '107', '17000224', 'R150780576528997837', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 18:56:05', '17000224', '2017-10-12 18:56:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('296', '107', '17000224', 'R150780594313116960', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 18:59:03', '17000224', '2017-10-12 18:59:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('297', '107', '17000224', 'R150780608645351246', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 19:01:26', '17000224', '2017-10-12 19:01:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('298', '58', '17000043', 'R150780611324617299', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-12 19:01:53', '17000043', '2017-10-12 19:01:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('299', '107', '17000224', 'R150780645342719318', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 19:07:33', '17000224', '2017-10-12 19:07:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('300', '58', '17000043', 'R150780649751387139', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-12 19:08:18', '17000043', '2017-10-12 19:08:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('301', '58', '17000043', 'R150780661978747970', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-12 19:10:20', '17000043', '2017-10-12 19:10:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('302', '58', '17000043', 'R150780673077718688', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-12 19:12:11', '17000043', '2017-10-12 19:12:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('303', '61', '17000046', 'R150780708357488710', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 19:18:04', '17000046', '2017-10-12 19:18:04', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('304', '64', '17000055', 'R150780784251949100', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-12 19:30:43', '17000055', '2017-10-12 19:30:43', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('305', '107', '17000224', 'R150780797706334180', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 19:32:57', '17000224', '2017-10-12 19:32:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('306', '107', '17000224', 'R150780799539433674', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 19:33:15', '17000224', '2017-10-12 19:33:15', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('307', '58', '17000043', 'R150780908157896034', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-12 19:51:22', '17000043', '2017-10-12 19:51:22', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('308', '61', '17000046', 'R150780924939946567', '1', '1.00', null, '2.00', '10', '2', '玩家充值', null, '2', '17000046', '2017-10-12 19:54:09', '17000046', '2017-10-12 19:54:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('309', '69', '17000060', 'R150781245977760107', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 20:47:40', '17000060', '2017-10-12 20:47:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('310', '61', '17000046', 'R150781359028041296', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:06:30', '17000046', '2017-10-12 21:06:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('311', '61', '17000046', 'R150781361100359102', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:06:51', '17000046', '2017-10-12 21:06:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('312', '104', '17000148', 'R150781365304128488', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 21:07:33', '17000148', '2017-10-12 21:07:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('313', '61', '17000046', 'R150781366443241178', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:07:44', '17000046', '2017-10-12 21:07:44', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('314', '104', '17000148', 'R150781368300348659', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 21:08:03', '17000148', '2017-10-12 21:08:03', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('315', '61', '17000046', 'R150781369848037592', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:08:18', '17000046', '2017-10-12 21:08:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('316', '104', '17000148', 'R150781372038868221', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 21:08:40', '17000148', '2017-10-12 21:08:40', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('317', '61', '17000046', 'R150781372098788184', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:08:41', '17000046', '2017-10-12 21:08:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('318', '61', '17000046', 'R150781373733949264', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:08:57', '17000046', '2017-10-12 21:08:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('319', '61', '17000046', 'R150781375780292513', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:09:18', '17000046', '2017-10-12 21:09:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('320', '61', '17000046', 'R150781378729555095', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:09:47', '17000046', '2017-10-12 21:09:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('321', '104', '17000148', 'R150781384593539037', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('322', '104', '17000148', 'R150781384594251299', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 21:10:46', '17000148', '2017-10-12 21:10:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('323', '61', '17000046', 'R150781405522563665', '1', '2.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:14:15', '17000046', '2017-10-12 21:14:15', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('324', '61', '17000046', 'R150781414476168957', '1', '2.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:15:45', '17000046', '2017-10-12 21:15:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('325', '61', '17000046', 'R150781417287929718', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:16:13', '17000046', '2017-10-12 21:16:13', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('326', '69', '17000060', 'R150781435931137098', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 21:19:19', '17000060', '2017-10-12 21:19:19', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('327', '69', '17000060', 'R150781438693226496', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 21:19:47', '17000060', '2017-10-12 21:19:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('328', '107', '17000224', 'R150781439882042217', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 21:19:59', '17000224', '2017-10-12 21:19:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('329', '69', '17000060', 'R150781441295744089', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-12 21:20:13', '17000060', '2017-10-12 21:20:13', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('330', '61', '17000046', 'R150781443225335601', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:20:32', '17000046', '2017-10-12 21:20:32', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('331', '61', '17000046', 'R150781451063759996', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:21:51', '17000046', '2017-10-12 21:21:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('332', '61', '17000046', 'R150781458663444667', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:23:07', '17000046', '2017-10-12 21:23:07', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('333', '61', '17000046', 'R150781461671385756', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:23:37', '17000046', '2017-10-12 21:23:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('334', '61', '17000046', 'R150781467884071616', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:24:39', '17000046', '2017-10-12 21:24:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('335', '61', '17000046', 'R150781474679729759', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:25:47', '17000046', '2017-10-12 21:25:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('336', '61', '17000046', 'R150781485892673387', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:27:39', '17000046', '2017-10-12 21:27:39', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('337', '61', '17000046', 'R150781503130523958', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:30:31', '17000046', '2017-10-12 21:30:31', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('338', '61', '17000046', 'R150781520608272826', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:33:26', '17000046', '2017-10-12 21:33:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('339', '61', '17000046', 'R150781527273531208', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:34:33', '17000046', '2017-10-12 21:34:33', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('340', '61', '17000046', 'R150781535732569451', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:35:57', '17000046', '2017-10-12 21:35:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('341', '61', '17000046', 'R150781544201015194', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:37:22', '17000046', '2017-10-12 21:37:22', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('342', '107', '17000224', 'R150781559960769143', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 21:40:00', '17000224', '2017-10-12 21:40:00', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('343', '61', '17000046', 'R150781564208118858', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:40:42', '17000046', '2017-10-12 21:40:42', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('344', '61', '17000046', 'R150781582493759753', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:43:45', '17000046', '2017-10-12 21:43:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('345', '61', '17000046', 'R150781585325321253', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:44:13', '17000046', '2017-10-12 21:44:13', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('346', '61', '17000046', 'R150781616264877170', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 21:49:23', '17000046', '2017-10-12 21:49:23', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('347', '61', '17000046', 'R150781951846293465', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 22:45:18', '17000046', '2017-10-12 22:45:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('348', '61', '17000046', 'R150781954965516409', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 22:45:50', '17000046', '2017-10-12 22:45:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('349', '61', '17000046', 'R150781957827712598', '1', '10.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 22:46:18', '17000046', '2017-10-12 22:46:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('350', '61', '17000046', 'R150781961003266885', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-12 22:46:50', '17000046', '2017-10-12 22:46:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('351', '107', '17000224', 'R150781976144436719', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:49:21', '17000224', '2017-10-12 22:49:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('352', '107', '17000224', 'R150781985042762100', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:50:50', '17000224', '2017-10-12 22:50:50', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('353', '107', '17000224', 'R150781987765771740', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:51:18', '17000224', '2017-10-12 22:51:18', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('354', '107', '17000224', 'R150781991257427486', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:51:53', '17000224', '2017-10-12 22:51:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('355', '107', '17000224', 'R150782013190320814', '1', '2.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:55:32', '17000224', '2017-10-12 22:55:32', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('356', '107', '17000224', 'R150782015928733513', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-12 22:55:59', '17000224', '2017-10-12 22:55:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('357', '104', '17000148', 'R150782016526137791', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 22:56:05', '17000148', '2017-10-12 22:56:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('358', '104', '17000148', 'R150782019041621787', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-12 22:56:30', '17000148', '2017-10-12 22:56:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('359', '69', '17000060', 'R150787483092475650', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:07:11', '17000060', '2017-10-13 14:07:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('360', '69', '17000060', 'R150787488402888131', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:08:04', '17000060', '2017-10-13 14:08:04', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('361', '78', '17000073', 'R150787492494172730', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:08:45', '17000073', '2017-10-13 14:08:45', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('362', '59', '17000044', 'R150787494917052155', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000044', '2017-10-13 14:09:09', '17000044', '2017-10-13 14:09:09', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('363', '78', '17000073', 'R150787498707450470', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:09:47', '17000073', '2017-10-13 14:09:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('364', '59', '17000044', 'R150787499684639261', '1', '1.00', null, '1.00', '10', '2', '玩家充值', null, '2', '17000044', '2017-10-13 14:09:57', '17000044', '2017-10-13 15:12:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('365', '78', '17000073', 'R150787513107532670', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:12:11', '17000073', '2017-10-13 14:12:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('366', '78', '17000073', 'R150787518098919136', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:13:01', '17000073', '2017-10-13 14:13:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('367', '78', '17000073', 'R150787523324055902', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:13:53', '17000073', '2017-10-13 14:13:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('368', '107', '17000224', 'R150787581358044252', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:23:34', '17000224', '2017-10-13 14:23:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('369', '107', '17000224', 'R150787584595239282', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('370', '107', '17000224', 'R150787584595720355', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:24:06', '17000224', '2017-10-13 14:24:06', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('371', '107', '17000224', 'R150787592052664545', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:25:21', '17000224', '2017-10-13 14:25:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('372', '69', '17000060', 'R150787614481115526', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:29:05', '17000060', '2017-10-13 14:29:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('373', '107', '17000224', 'R150787617749414281', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:29:37', '17000224', '2017-10-13 14:29:37', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('374', '107', '17000224', 'R150787622743421111', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:30:27', '17000224', '2017-10-13 14:30:27', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('375', '107', '17000224', 'R150787624802336581', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:30:48', '17000224', '2017-10-13 14:30:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('376', '69', '17000060', 'R150787638422210215', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:33:04', '17000060', '2017-10-13 14:33:04', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('377', '69', '17000060', 'R150787642641279793', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:33:46', '17000060', '2017-10-13 14:33:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('378', '69', '17000060', 'R150787649263832717', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:34:53', '17000060', '2017-10-13 14:34:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('379', '78', '17000073', 'R150787649342943899', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:34:53', '17000073', '2017-10-13 14:34:53', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('380', '69', '17000060', 'R150787656090619035', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:36:01', '17000060', '2017-10-13 14:36:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('381', '78', '17000073', 'R150787658750367860', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 14:36:28', '17000073', '2017-10-13 14:36:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('382', '69', '17000060', 'R150787669997798750', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:38:20', '17000060', '2017-10-13 14:38:20', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('383', '69', '17000060', 'R150787679165413332', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 14:39:52', '17000060', '2017-10-13 14:39:52', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('384', '107', '17000224', 'R150787691071170987', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:41:51', '17000224', '2017-10-13 14:41:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('385', '107', '17000224', 'R150787717013514636', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:46:10', '17000224', '2017-10-13 14:46:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('386', '107', '17000224', 'R150787725601891543', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:47:36', '17000224', '2017-10-13 14:47:36', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('387', '107', '17000224', 'R150787791366527539', '1', '2.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:58:34', '17000224', '2017-10-13 14:58:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('388', '107', '17000224', 'R150787795114771395', '1', '2.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:59:11', '17000224', '2017-10-13 14:59:11', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('389', '107', '17000224', 'R150787797371223699', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 14:59:34', '17000224', '2017-10-13 14:59:34', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('390', '107', '17000224', 'R150787808630927498', '1', '2.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 15:01:26', '17000224', '2017-10-13 15:01:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('391', '107', '17000224', 'R150787826778152620', '1', '2.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 15:04:28', '17000224', '2017-10-13 15:04:28', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('392', '107', '17000224', 'R150787828267250132', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 15:04:43', '17000224', '2017-10-13 15:04:43', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('393', '107', '17000224', 'R150787830811817408', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 15:05:08', '17000224', '2017-10-13 15:05:08', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('394', '107', '17000224', 'R150787834587693814', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-13 15:05:46', '17000224', '2017-10-13 15:05:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('395', '76', '17000051', 'R150788226102889791', '1', '100.00', null, '100.00', '11', '2', '测试用的', null, '1', '17000051', '2017-10-13 16:11:01', '17000051', '2017-10-13 16:11:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('396', '78', '17000073', 'R150788063060213670', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 15:43:51', '17000073', '2017-10-13 15:43:51', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('397', '78', '17000073', 'R150788073132238594', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000073', '2017-10-13 15:45:31', '17000073', '2017-10-13 15:45:31', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('398', '104', '17000148', 'R150788082454779927', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000148', '2017-10-13 15:47:05', '17000148', '2017-10-13 15:47:05', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('399', '64', '17000055', 'R150788459868774734', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-13 16:49:59', '17000055', '2017-10-13 16:49:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('400', '58', '17000043', 'R150788102984771235', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-13 15:50:30', '17000043', '2017-10-13 15:50:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('401', '58', '17000043', 'R150788104791367119', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000043', '2017-10-13 15:50:48', '17000043', '2017-10-13 15:50:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('402', '69', '17000060', 'R150788120061662500', '1', '10.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 15:53:21', '17000060', '2017-10-13 15:53:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('403', '69', '17000060', 'R150788122717359447', '1', '1.00', null, '168.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-13 15:53:47', '17000060', '2017-10-13 15:53:47', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('404', '107', '17000224', 'R150795814583496674', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-14 13:15:46', '17000224', '2017-10-14 13:15:46', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('405', '107', '17000224', 'R150796278959163240', '1', '1.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000224', '2017-10-14 14:33:10', '17000224', '2017-10-14 14:33:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('406', '61', '17000046', 'R150796706915434353', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-14 15:44:29', '17000046', '2017-10-14 15:44:29', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('407', '61', '17000046', 'R150796711448067190', '1', '1.00', null, '2.00', '10', '5', '玩家充值', null, '1', '17000046', '2017-10-14 15:45:14', '17000046', '2017-10-14 15:45:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('408', '96', '17000137', 'R150806747860788372', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-15 19:37:59', '17000137', '2017-10-15 19:37:59', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('409', '96', '17000137', 'R150806760131979045', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-15 19:40:01', '17000137', '2017-10-15 19:40:01', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('410', '64', '17000055', 'R150812637800155550', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 11:59:38', '17000055', '2017-10-16 11:59:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('411', '64', '17000055', 'R150812966080478922', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 12:54:21', '17000055', '2017-10-16 12:54:21', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('412', '64', '17000055', 'R150812974109871971', '1', '5000.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 12:55:41', '17000055', '2017-10-16 12:55:41', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('413', '64', '17000055', 'R150812977386628546', '1', '5000.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 12:56:14', '17000055', '2017-10-16 12:56:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('414', '64', '17000055', 'R150814481721161147', '1', '1.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 17:06:57', '17000055', '2017-10-16 17:06:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('415', '64', '17000055', 'R150814482835425331', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 17:07:08', '17000055', '2017-10-16 17:07:08', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('416', '64', '17000055', 'R150814484204387776', '1', '10.00', null, '1.00', '10', '5', '玩家充值', null, '1', '17000055', '2017-10-16 17:07:22', '17000055', '2017-10-16 17:07:22', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('417', '108', '17000226', 'R150814662776265915', '1', '10.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000226', '2017-10-16 17:37:08', '17000226', '2017-10-16 17:37:08', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('418', '96', '17000137', 'R150816647677386537', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-16 23:07:57', '17000137', '2017-10-16 23:07:57', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('419', '96', '17000137', 'R150816649034235325', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-16 23:08:10', '17000137', '2017-10-16 23:08:10', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('420', '96', '17000137', 'R150816650968967387', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-16 23:08:30', '17000137', '2017-10-16 23:08:30', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('421', '110', '17000228', 'R150839153351964765', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000228', '2017-10-19 13:38:54', '17000228', '2017-10-19 13:38:54', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('422', '96', '17000137', 'R150866638785617162', '1', '50.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-22 17:59:48', '17000137', '2017-10-22 17:59:48', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('423', '96', '17000137', 'R150874863686841858', '1', '100.00', null, '0.00', '10', '5', '玩家充值', null, '1', '17000137', '2017-10-23 16:50:37', '17000137', '2017-10-23 16:50:37', '0', '0');

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
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `card_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户绑定卡片';

-- ----------------------------
-- Records of t_user_cards
-- ----------------------------
INSERT INTO `t_user_cards` VALUES ('10', '17000050', '6214855740979907', '宁波招商银行鄞州支行', '21', '1', '1', '0000-00-00 00:00:00', null, null, '0', '陈斌');
INSERT INTO `t_user_cards` VALUES ('11', '17000060', '6214345710587484', '杭州银行武林支行', '21', '1', '1', '0000-00-00 00:00:00', '1', '2017-10-09 22:13:00', '0', '李小李');
INSERT INTO `t_user_cards` VALUES ('12', '17000046', '6228480352202673112', '农行', '1', '1', '1', '0000-00-00 00:00:00', null, null, '0', '一一一');
INSERT INTO `t_user_cards` VALUES ('13', '17000079', '6228480318100652078', '宁波中河支行', '1', '1', '1', '2017-09-25 18:52:51', null, null, '0', '方明');
INSERT INTO `t_user_cards` VALUES ('14', '17000086', '6342323454545656565', '工商银行北京运河支行', '2', '1', '1', '2017-09-30 13:16:01', '1', null, '0', '李小明');
INSERT INTO `t_user_cards` VALUES ('15', '17000133', '', '', '1', '1', '1', '2017-09-30 15:14:51', '1', '2017-09-30 15:15:12', '0', '');
INSERT INTO `t_user_cards` VALUES ('16', '17000135', '6217566200015710508', '舟山沈家门支行', '14', '1', '1', '2017-09-30 16:03:10', null, null, '0', '王琦俊');
INSERT INTO `t_user_cards` VALUES ('17', '17000044', '6464383848384838393', '杭州支行', '21', '1', '1', '2017-10-10 10:46:16', '1', null, '0', '');

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
  `bg_user_id` bigint(20) DEFAULT NULL COMMENT 'BG会员ID',
  `bg_reg_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BG用户注册类型',
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bg_login_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qq` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17000236 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'c33367701511b4f6020ec61ded352059', '超级管理员', '17767077763', '1', '0', '1', '1', null, '2017-10-09 20:06:05', '0', null, null, null, '5', '1', '2017-09-14 15:59:31', '1', '2017-10-06 16:26:54', '0', null, null);
INSERT INTO `t_users` VALUES ('3', 'KF0002', 'e10adc3949ba59abbe56e057f20f883e', '客服002', '13588276084', '0', '0', '3', '3', null, '2017-09-30 20:15:28', '0', '4', '0', null, '1', '1', '2017-09-22 16:23:29', null, '2017-09-30 20:15:28', '0', null, '239799722');
INSERT INTO `t_users` VALUES ('4', 'KF0001', 'e10adc3949ba59abbe56e057f20f883e', '客服001', '17767077763', '0', '0', '3', '4', null, '2017-09-29 14:08:34', '0', '4', null, null, '1', '1', '2017-09-22 16:23:29', null, '2017-09-29 14:08:34', '0', null, '203707655');
INSERT INTO `t_users` VALUES ('5', 'agdress', 'e10adc3949ba59abbe56e057f20f883e', '星河娱乐测试SN', '15901794296', '2', '0', '5', '5', '', '2017-09-29 14:08:09', '0', '1', null, '', '1', '1', '2017-09-25 11:16:09', null, '2017-09-29 14:08:09', '1', '', '');
INSERT INTO `t_users` VALUES ('6', 'agdress1', '81dc9bdb52d04dc20036dbd8313ed055', '我自己', '15260282340', '2', '0', '5', '6', '', '2017-09-29 14:08:10', '0', '2', null, '', '3', '1', '2017-09-25 11:16:12', null, '2017-09-29 14:08:10', '1', '', '');
INSERT INTO `t_users` VALUES ('7', 'ix00_601134', '81dc9bdb52d04dc20036dbd8313ed055', '星河娱乐', '15260282341', '2', '0', '5', '7', '', '2017-09-29 14:06:26', '0', '4', null, '', '3', '1', '2017-09-25 11:16:12', null, '2017-09-29 14:06:26', '0', '', '');
INSERT INTO `t_users` VALUES ('17000043', '15901794296', '198796', '阳光雨露', '15901794296', '-1', '1', '0', '3', '2017091301354484702241.jpeg', '2017-10-18 20:25:48', '0', '4', '22433956', 'n', '4', '1', '2017-09-13 10:23:51', '17000043', '2017-10-18 20:25:48', '0', 'XH002429617000043', null);
INSERT INTO `t_users` VALUES ('17000044', '13330908360', '193720', '爱丝寂寞人', '13330908360', '-1', '1', '0', '4', null, '2017-10-14 16:41:28', '0', '4', '22474688', 'n', '2', '1', '2017-09-13 21:37:13', '17000044', '2017-10-14 16:41:28', '0', 'XH002836017000044', null);
INSERT INTO `t_users` VALUES ('17000045', '13276720611', '381143', '13276720611', '13276720611', '-1', '1', '0', '4', null, '2017-10-10 10:39:00', '0', '4', '22490056', 'n', '1', '1', '2017-09-14 01:23:52', '17000045', '2017-10-10 10:39:00', '0', 'XH002061117000045', null);
INSERT INTO `t_users` VALUES ('17000046', '17767077763', '518539', '17767077763', '17767077763', '-1', '1', '0', '3', '2017101011505392801751.jpeg', '2017-10-16 16:43:03', '0', '4', '22524114', 'n', '2', '1', '2017-09-14 14:57:18', '17000046', '2017-10-16 16:43:03', '0', 'XH002776317000046', null);
INSERT INTO `t_users` VALUES ('17000050', '13906685744', '402098', '将军', '13906685744', '-1', '1', '0', '4', null, '2017-10-10 19:02:59', '0', '4', '22544263', 'n', '3', '1', '2017-09-14 20:26:09', '17000050', '2017-10-10 19:02:59', '0', 'XH002574417000050', null);
INSERT INTO `t_users` VALUES ('17000051', '18668223750', '127611', '小胡子', '18668223750', '-1', '1', '0', '3', '2017092212380346604671.jpeg', '2017-10-20 11:02:58', '0', '4', '22595280', 'n', '3', '1', '2017-09-15 10:30:38', '17000051', '2017-10-20 11:02:58', '0', 'XH002375017000051', null);
INSERT INTO `t_users` VALUES ('17000052', '13956582795', '461728', '13956582795', '13956582795', '-1', '1', '0', '4', null, '2017-09-27 14:47:00', '0', '4', '22608651', 'n', '1', '1', '2017-09-15 13:54:46', '17000052', '2017-09-27 14:47:00', '0', 'XH002279517000052', null);
INSERT INTO `t_users` VALUES ('17000053', '13567896999', '823282', '13567896999', '13567896999', '-1', '1', '0', '3', null, '2017-09-15 18:24:04', '0', '4', '22618320', 'n', '1', '1', '2017-09-15 17:21:49', '0', '2017-09-15 18:24:04', '0', 'XH002699917000053', null);
INSERT INTO `t_users` VALUES ('17000054', '13732218112', '207721', '13732218112', '13732218112', '-1', '1', '0', '3', '2017101012143684109861.jpeg', '2017-10-11 01:47:39', '0', '4', '22624722', 'n', '6', '1', '2017-09-15 20:34:32', '17000054', '2017-10-11 01:47:39', '0', 'XH002811217000054', null);
INSERT INTO `t_users` VALUES ('17000055', '18550473963', '464365', '地主婆', '18550473963', '-1', '1', '0', '4', '2017093011163279202611.jpeg', '2017-10-16 17:06:31', '0', '4', '22817152', 'n', '13', '1', '2017-09-18 01:37:25', '17000055', '2017-10-16 17:06:31', '0', 'XH002396317000055', null);
INSERT INTO `t_users` VALUES ('17000056', '15558296177', '239173', '15558296177', '15558296177', '-1', '1', '0', '3', null, '2017-10-21 20:47:20', '0', '4', '22858996', 'n', '1', '1', '2017-09-18 15:23:27', '17000056', '2017-10-21 20:47:20', '0', 'XH002617717000056', null);
INSERT INTO `t_users` VALUES ('17000057', '17062576299', '119242', '17062576299', '17062576299', '-1', '1', '0', '3', null, '2017-09-20 22:20:01', '0', '4', '22930347', 'n', '1', '1', '2017-09-19 12:01:29', '17000057', '2017-09-20 22:20:01', '0', 'XH002629917000057', null);
INSERT INTO `t_users` VALUES ('17000058', '15558286899', '350290', '15558286899', '15558286899', '-1', '1', '0', '3', null, '2017-09-19 16:09:22', '0', '4', '22938582', 'n', '1', '1', '2017-09-19 15:07:09', '0', '2017-09-19 16:09:22', '0', 'XH002689917000058', null);
INSERT INTO `t_users` VALUES ('17000059', '13666606938', '275188', '13666606938', '13666606938', '-1', '1', '0', '3', null, '2017-09-19 16:15:51', '0', '4', '22938848', 'n', '1', '1', '2017-09-19 15:13:35', '0', '2017-09-19 16:15:51', '0', 'XH002693817000059', null);
INSERT INTO `t_users` VALUES ('17000060', '13173682708', '280668', '小小测试员', '13173682708', '-1', '1', '0', '3', '2017092502473240008811.jpeg', '2017-10-16 23:55:18', '0', '4', '23120570', 'n', '4', '1', '2017-09-21 19:41:29', '17000060', '2017-10-16 23:55:18', '0', 'XH002270817000060', null);
INSERT INTO `t_users` VALUES ('17000061', '15528935950', '856195', '15528935950', '15528935950', '-1', '1', '0', '3', null, '2017-09-21 20:49:13', '0', '4', '23123951', 'n', '1', '1', '2017-09-21 20:49:12', '0', '2017-09-21 20:49:13', '0', 'XH002595017000061', null);
INSERT INTO `t_users` VALUES ('17000062', '13590702673', '579937', '13590702673', '13590702673', '-1', '1', '0', '4', null, '2017-09-25 20:15:04', '0', '4', '23125409', 'n', '1', '1', '2017-09-21 21:18:48', '17000062', '2017-09-25 20:15:04', '0', 'XH002267317000062', null);
INSERT INTO `t_users` VALUES ('17000063', '13016316660', '401309', '13016316660', '13016316660', '-1', '1', '0', '4', null, '2017-09-25 13:27:51', '0', '4', '23125445', 'n', '1', '1', '2017-09-21 21:19:12', '17000063', '2017-09-25 13:27:51', '0', 'XH002666017000063', null);
INSERT INTO `t_users` VALUES ('17000064', '13113434428', '345053', '13113434428', '13113434428', '-1', '1', '0', '3', null, '2017-09-21 21:21:44', '0', '4', '23125572', 'n', '1', '1', '2017-09-21 21:21:43', '0', '2017-09-21 21:21:44', '0', 'XH002442817000064', null);
INSERT INTO `t_users` VALUES ('17000065', '13729221155', '506525', '13729221155', '13729221155', '-1', '1', '0', '4', null, '2017-09-21 21:25:19', '0', '4', '23125765', 'n', '1', '1', '2017-09-21 21:25:18', '0', '2017-09-21 21:25:19', '0', 'XH002115517000065', null);
INSERT INTO `t_users` VALUES ('17000066', '18312610031', '819406', 'K', '18312610031', '-1', '1', '0', '3', null, '2017-10-18 10:34:04', '0', '4', '23111987', 'n', '2', '1', '2017-09-21 21:26:17', '17000066', '2017-10-18 10:34:04', '0', 'XH002003117000066', null);
INSERT INTO `t_users` VALUES ('17000067', '13680383885', '300719', '13680383885', '13680383885', '-1', '1', '0', '4', null, '2017-09-21 21:35:18', '0', '4', '23126231', 'n', '1', '1', '2017-09-21 21:35:18', '0', '2017-09-21 21:35:18', '0', 'XH002388517000067', null);
INSERT INTO `t_users` VALUES ('17000068', '13612227234', '305310', '13612227234', '13612227234', '-1', '1', '0', '3', null, '2017-09-21 21:39:01', '0', '4', '23126444', 'n', '1', '1', '2017-09-21 21:39:01', '0', '2017-09-21 21:39:01', '0', 'XH002723417000068', null);
INSERT INTO `t_users` VALUES ('17000069', '15363599222', '650104', '15363599222', '15363599222', '-1', '1', '0', '4', null, '2017-09-21 21:42:10', '0', '4', '23127240', 'n', '1', '1', '2017-09-21 21:42:10', '0', '2017-09-21 21:42:10', '0', 'XH002922217000069', null);
INSERT INTO `t_users` VALUES ('17000070', '13708029055', '357484', '13708029055', '13708029055', '-1', '1', '0', '4', null, '2017-10-12 17:28:10', '0', '4', '23145866', 'n', '1', '1', '2017-09-22 02:59:39', '17000070', '2017-10-12 17:28:10', '0', 'XH002905517000070', null);
INSERT INTO `t_users` VALUES ('17000071', 'CW001', 'e10adc3949ba59abbe56e057f20f883e', '财务专员', '15355046527', '0', '0', '4', '17000071', null, '2017-09-30 20:15:39', '0', null, null, null, '1', '1', '2017-09-23 17:35:25', null, '2017-09-30 20:15:39', '0', null, '');
INSERT INTO `t_users` VALUES ('17000072', '13881977996', '888046', '13881977996', '13881977996', '-1', '1', '0', '3', null, '2017-09-22 17:19:55', '0', '4', '23195306', 'n', '1', '1', '2017-09-22 17:19:55', '0', '2017-09-22 17:19:55', '0', 'XH002799617000072', null);
INSERT INTO `t_users` VALUES ('17000073', '18058159956', '372232', '18058159956', '18058159956', '-1', '1', '0', '3', null, '2017-10-13 14:34:47', '0', '4', '23197014', 'n', '1', '1', '2017-09-22 17:55:15', '17000073', '2017-10-13 14:34:47', '0', 'XH002995617000073', null);
INSERT INTO `t_users` VALUES ('17000074', '15812635666', '850926', '15812635666', '15812635666', '-1', '1', '0', '4', null, '2017-09-22 23:54:28', '0', '4', '23219188', 'n', '1', '1', '2017-09-22 23:54:28', '0', '2017-09-22 23:54:28', '0', 'XH002566617000074', null);
INSERT INTO `t_users` VALUES ('17000075', '18379198801', '591154', '18379198801', '18379198801', '-1', '1', '0', '3', '2017101002165755909188.jpeg', '2017-10-10 15:53:23', '0', '4', '23278714', 'n', '3', '1', '2017-09-23 16:25:36', '17000075', '2017-10-10 15:53:23', '0', 'XH002880117000075', null);
INSERT INTO `t_users` VALUES ('17000076', '17775820578', '769418', '17775820578', '17775820578', '-1', '1', '0', '3', null, '2017-09-24 19:23:01', '0', '4', '23361493', 'n', '1', '1', '2017-09-24 19:23:01', '0', '2017-09-24 19:23:01', '0', 'XH002057817000076', null);
INSERT INTO `t_users` VALUES ('17000077', '15344815708', '440502', '15344815708', '15344815708', '-1', '1', '0', '4', null, '2017-09-24 20:12:55', '0', '4', '23373747', 'n', '1', '1', '2017-09-24 20:12:55', '0', '2017-09-24 20:12:55', '0', 'XH002570817000077', null);
INSERT INTO `t_users` VALUES ('17000078', '15857802417', '947460', '15857802417', '15857802417', '-1', '1', '0', '3', null, '2017-09-24 22:59:55', '0', '4', '23386602', 'n', '1', '1', '2017-09-24 22:59:55', '0', '2017-09-24 22:59:55', '0', 'XH002241717000078', null);
INSERT INTO `t_users` VALUES ('17000079', '13586512297', '776003', '13586512297', '13586512297', '-1', '1', '0', '3', null, '2017-09-25 18:48:21', '0', '4', '23380006', 'n', '1', '1', '2017-09-24 23:05:49', '17000079', '2017-09-25 18:48:21', '0', 'XH002229717000079', null);
INSERT INTO `t_users` VALUES ('17000080', '15058898844', '913828', '15058898844', '15058898844', '-1', '1', '0', '4', null, '2017-09-26 04:46:20', '0', '4', '23388974', 'n', '1', '1', '2017-09-24 23:52:08', '17000080', '2017-09-26 04:46:20', '0', 'XH002884417000080', null);
INSERT INTO `t_users` VALUES ('17000081', '13780020789', '794794', '13780020789', '13780020789', '-1', '1', '0', '4', null, '2017-09-25 11:01:39', '0', '4', '23418719', 'n', '1', '1', '2017-09-25 11:01:39', '0', '2017-09-25 11:01:39', '0', 'XH002078917000081', null);
INSERT INTO `t_users` VALUES ('17000082', '13989898901', '611338', '13989898901', '13989898901', '-1', '1', '0', '4', null, '2017-09-26 00:48:13', '0', '4', '23468502', 'n', '1', '1', '2017-09-26 00:47:52', '17000082', '2017-09-26 00:48:13', '0', 'XH002890117000082', null);
INSERT INTO `t_users` VALUES ('17000083', '18857408866', '906035', '18857408866', '18857408866', '-1', '1', '0', '3', null, '2017-09-26 15:44:49', '0', '4', '23501180', 'n', '1', '1', '2017-09-26 11:46:26', '17000083', '2017-09-26 15:44:49', '0', 'XH002886617000083', null);
INSERT INTO `t_users` VALUES ('17000084', '13697766056', '550302', '13697766056', '13697766056', '-1', '1', '0', '4', null, '2017-09-27 05:20:42', '0', '4', '23552876', 'n', '1', '1', '2017-09-27 00:44:58', '17000084', '2017-09-27 05:20:42', '0', 'XH002605617000084', null);
INSERT INTO `t_users` VALUES ('17000085', '13929999391', '429793', '13929999391', '13929999391', '-1', '1', '0', '4', null, '2017-09-28 00:53:39', '0', '4', '23633438', 'n', '1', '1', '2017-09-28 00:53:38', '0', '2017-09-28 00:53:39', '0', 'XH002939117000085', null);
INSERT INTO `t_users` VALUES ('17000086', '13043086229', '973696', '测试用户', '13043086229', '-1', '1', '0', '3', '2017092801523485704247.jpeg', '2017-09-30 13:16:08', '0', '4', '23642406', 'n', '2', '1', '2017-09-28 01:45:52', '1', '2017-09-30 13:16:08', '0', 'XH002622917000086', null);
INSERT INTO `t_users` VALUES ('17000132', '15260282340_1', '457514', '开发测试', '15260282340_1', '-1', '1', null, '3', null, '2017-10-10 16:32:23', '0', '4', '23838078', 'n', '1', '1', '2017-09-30 14:59:05', '17000132', '2017-10-10 16:32:23', '0', 'XH002234017000132', null);
INSERT INTO `t_users` VALUES ('17000133', '13018912571', '655390', '13018912571', '13018912571', '-1', '1', null, '4', null, '2017-09-30 15:15:46', '0', '4', '23842283', 'n', '1', '1', '2017-09-30 15:09:41', '1', '2017-09-30 15:15:46', '0', 'XH002257117000133', null);
INSERT INTO `t_users` VALUES ('17000134', 'fh', 'e10adc3949ba59abbe56e057f20f883e', 'houlai', '13333333333', '2', '0', '5', null, null, null, '0', '5', null, null, '1', '1', '2017-09-30 15:37:12', null, null, '0', null, null);
INSERT INTO `t_users` VALUES ('17000135', '15883532221', '282335', '15883532221', '15883532221', '-1', '1', null, '4', null, '2017-10-10 20:28:25', '0', '5', '23843975', 'n', '1', '1', '2017-09-30 15:44:54', '17000135', '2017-10-10 20:28:25', '0', 'XH002222117000135', null);
INSERT INTO `t_users` VALUES ('17000136', '15355046527', '342065', '15355046527', '15355046527', '-1', '1', null, '3', null, '2017-10-10 15:58:12', '0', '4', '23851951', 'n', '1', '1', '2017-09-30 18:41:22', '17000136', '2017-10-10 15:58:12', '0', 'XH002652717000136', null);
INSERT INTO `t_users` VALUES ('17000137', '15558296377', '839004', '15558296377', '15558296377', '-1', '1', null, '4', null, '2017-10-22 00:00:07', '0', '4', '23895777', 'n', '1', '1', '2017-10-01 07:37:38', '17000137', '2017-10-22 00:00:07', '0', 'XH002637717000137', null);
INSERT INTO `t_users` VALUES ('17000138', '18977021600', '365083', '18977021600', '18977021600', '-1', '1', null, '4', null, '2017-10-02 16:41:29', '0', '4', '24016679', 'n', '1', '1', '2017-10-02 16:41:28', '0', '2017-10-02 16:41:29', '0', 'XH002160017000138', null);
INSERT INTO `t_users` VALUES ('17000139', '18683685360', '941035', '18683685360', '18683685360', '-1', '1', null, '3', null, '2017-10-06 23:55:52', '0', '4', '24029098', 'n', '1', '1', '2017-10-02 19:11:59', '17000139', '2017-10-06 23:55:52', '0', 'XH002536017000139', null);
INSERT INTO `t_users` VALUES ('17000140', '13232230792', '521157', '13232230792', '13232230792', '-1', '1', null, '4', null, '2017-10-23 21:23:57', '0', '4', '24076167', 'n', '1', '1', '2017-10-03 13:23:42', '17000140', '2017-10-23 21:23:57', '0', 'XH002079217000140', null);
INSERT INTO `t_users` VALUES ('17000141', '13420534991', '255259', '13420534991', '13420534991', '-1', '1', null, '3', null, '2017-10-08 03:12:37', '0', '4', '24450725', 'n', '1', '1', '2017-10-08 03:12:37', '0', '2017-10-08 03:12:37', '0', 'XH002499117000141', null);
INSERT INTO `t_users` VALUES ('17000142', '15057184591', '795334', '15057184591', '15057184591', '-1', '1', null, '3', null, '2017-10-12 18:40:52', '0', '4', '24556745', 'n', '1', '1', '2017-10-09 11:44:49', '17000142', '2017-10-12 18:40:52', '0', 'XH002459117000142', null);
INSERT INTO `t_users` VALUES ('17000143', '13532211555', '369237', '13532211555', '13532211555', '-1', '1', null, '3', null, '2017-10-10 01:25:16', '0', '4', '24607521', 'n', '1', '1', '2017-10-10 01:25:15', '0', '2017-10-10 01:25:16', '0', 'XH002155517000143', null);
INSERT INTO `t_users` VALUES ('17000144', '13146622590', '794859', '13146622590', '13146622590', '-1', '1', null, '4', null, '2017-10-10 10:40:57', '0', '4', '24630498', 'n', '1', '1', '2017-10-10 10:40:56', '0', '2017-10-10 10:40:57', '0', 'XH002259017000144', null);
INSERT INTO `t_users` VALUES ('17000145', '17606545069', '376478', '17606545069', '17606545069', '-1', '1', null, '4', '201710100656146880332.jpeg', '2017-10-10 19:05:27', '0', '4', '24646102', 'n', '3', '1', '2017-10-10 15:23:33', '17000145', '2017-10-10 19:05:27', '0', 'XH002506917000145', null);
INSERT INTO `t_users` VALUES ('17000146', '18258448588', '562620', '18258448588', '18258448588', '-1', '1', null, '4', null, '2017-10-10 16:27:05', '0', '4', '24646147', 'n', '1', '1', '2017-10-10 15:24:44', '0', '2017-10-10 16:27:05', '0', 'XH002858817000146', null);
INSERT INTO `t_users` VALUES ('17000147', '13276720566', '589121', '13276720566', '13276720566', '-1', '1', null, '3', null, '2017-10-10 16:00:08', '0', '5', '24647583', 'n', '1', '1', '2017-10-10 16:00:07', '0', '2017-10-10 16:00:08', '0', 'XH002056617000147', null);
INSERT INTO `t_users` VALUES ('17000148', '13588276084', '536245', '13588276084', '13588276084', '-1', '1', null, '4', null, '2017-10-12 21:07:24', '0', '5', '24647758', 'n', '1', '1', '2017-10-10 16:04:07', '17000148', '2017-10-12 21:07:24', '0', 'XH002608417000148', null);
INSERT INTO `t_users` VALUES ('17000222', '13928071250', '987016', '玩', '13928071250', '-1', '1', null, '3', null, '2017-10-10 21:45:01', '0', '4', '24667266', 'n', '2', '1', '2017-10-10 21:45:01', '0', '2017-10-10 21:45:01', '0', 'XH002125017000222', null);
INSERT INTO `t_users` VALUES ('17000223', '18683908899', '482087', '18683908899', '18683908899', '-1', '1', null, '4', null, '2017-10-18 12:01:43', '0', '4', '24668253', 'n', '1', '1', '2017-10-10 22:05:46', '17000223', '2017-10-18 12:01:43', '0', 'XH002889917000223', null);
INSERT INTO `t_users` VALUES ('17000224', '13033603728', '366917', '13033603728', '13033603728', '-1', '1', null, '3', null, '2017-10-14 14:33:03', '0', '4', '24788686', 'n', '1', '1', '2017-10-12 15:02:29', '17000224', '2017-10-14 14:33:03', '0', 'XH002372817000224', null);
INSERT INTO `t_users` VALUES ('17000225', '15868115555', '623694', '15868115555', '15868115555', '-1', '1', null, '4', null, '2017-10-14 09:54:09', '0', '4', '24927705', 'n', '1', '1', '2017-10-14 09:54:09', '0', '2017-10-14 09:54:09', '0', 'XH002555517000225', null);
INSERT INTO `t_users` VALUES ('17000226', '18357100901', '898797', '18357100901', '18357100901', '-1', '1', null, '3', null, '2017-10-16 17:36:45', '0', '4', '25118258', 'n', '1', '1', '2017-10-16 17:36:45', '0', '2017-10-16 17:36:45', '0', 'XH002090117000226', null);
INSERT INTO `t_users` VALUES ('17000227', '17605811755', '727749', '赌神', '17605811755', '-1', '1', null, '4', '2017101809565049904385.jpeg', '2017-10-18 21:55:41', '0', '4', '25296998', 'n', '4', '1', '2017-10-18 21:55:41', '0', '2017-10-18 21:55:41', '0', 'XH002175517000227', null);
INSERT INTO `t_users` VALUES ('17000228', '15814540457', '149216', '15814540457', '15814540457', '-1', '1', null, '3', null, '2017-10-19 13:29:34', '0', '4', '25346401', 'n', '1', '1', '2017-10-19 13:29:33', '0', '2017-10-19 13:29:34', '0', 'XH002045717000228', null);
INSERT INTO `t_users` VALUES ('17000229', '13881255462', '827590', '13881255462', '13881255462', '-1', '1', null, '4', null, '2017-10-19 15:22:14', '0', '4', '25351548', 'n', '1', '1', '2017-10-19 15:22:14', '0', '2017-10-19 15:22:14', '0', 'XH002546217000229', null);
INSERT INTO `t_users` VALUES ('17000230', '13957826061', '649092', '13957826061', '13957826061', '-1', '1', null, '3', null, '2017-10-20 16:45:47', '0', '4', '25457015', 'n', '1', '1', '2017-10-20 16:45:28', '17000230', '2017-10-20 16:45:47', '0', 'XH002606117000230', null);
INSERT INTO `t_users` VALUES ('17000231', '13252283977', '205233', '13252283977', '13252283977', '-1', '1', null, '4', null, '2017-10-22 16:19:25', '0', '4', '25608714', 'n', '1', '1', '2017-10-22 16:19:24', '0', '2017-10-22 16:19:25', '0', 'XH002397717000231', null);
INSERT INTO `t_users` VALUES ('17000232', '13252296977', '323578', '13252296977', '13252296977', '-1', '1', null, '4', null, '2017-10-22 16:35:06', '0', '4', '25609234', 'n', '1', '1', '2017-10-22 16:29:38', '17000232', '2017-10-22 16:35:06', '0', 'XH002697717000232', null);
INSERT INTO `t_users` VALUES ('17000233', '13520308686', '959584', '13520308686', '13520308686', '-1', '1', null, '4', null, '2017-10-22 18:08:46', '0', '4', '25613589', 'n', '1', '1', '2017-10-22 18:08:45', '0', '2017-10-22 18:08:46', '0', 'XH002868617000233', null);
INSERT INTO `t_users` VALUES ('17000234', '17858600860', '156358', '17858600860', '17858600860', '-1', '1', null, '3', null, '2017-10-22 19:22:01', '0', '4', '25617103', 'n', '1', '1', '2017-10-22 19:18:36', '17000234', '2017-10-22 19:22:01', '0', 'XH002086017000234', null);
INSERT INTO `t_users` VALUES ('17000235', '15035598887', '689200', '15035598887', '15035598887', '-1', '1', null, '3', null, '2017-10-23 21:22:14', '0', '4', '25705191', 'n', '1', '1', '2017-10-23 21:22:13', '0', '2017-10-23 21:22:14', '0', 'XH002888717000235', null);
