/*
Navicat MySQL Data Transfer

Source Server         : agdress
Source Server Version : 50637
Source Host           : 192.168.1.43:3306
Source Database       : agdress

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-08-30 09:09:57
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
INSERT INTO `m_activitys` VALUES ('3', '超多游戏，一次玩个够', '2017-08-22 18:30:22', '2018-08-22 00:00:00', 'banners/activity_03.jpg', 'http://cdn.sztchx.com/help/index.html?locale=zh_CN', '超多游戏，一次玩个够', '超多游戏，一次玩个够', '1', '1', '1', '2017-08-29 14:56:27', '1', '2017-08-29 14:56:27', '0');

-- ----------------------------
-- Table structure for `m_agents`
-- ----------------------------
DROP TABLE IF EXISTS `m_agents`;
CREATE TABLE `m_agents` (
  `agent_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '代理商ID',
  `agent_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代理商名称',
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代理商';

-- ----------------------------
-- Records of m_agents
-- ----------------------------
INSERT INTO `m_agents` VALUES ('1', '星河娱乐', 'agdress', '123456', '1', '1', '2017-08-11 18:49:16', '0', '2017-08-17 19:01:25', '0', '20361889');
INSERT INTO `m_agents` VALUES ('2', '我自己', 'agdress1', '123456', '1', '1', '2017-08-25 14:14:27', null, '2017-08-25 14:14:27', '0', '2036190');

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
  PRIMARY KEY (`bank_type`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='银行类型';

-- ----------------------------
-- Records of m_bank_types
-- ----------------------------
INSERT INTO `m_bank_types` VALUES ('1', '农业银行', 'bank/info/nongye.png', 'bank/pay/nongye.png', '1', '1', '2017-08-29 17:40:17', null, '2017-08-29 17:40:17', '1', 'ABC', '中国农业银行');
INSERT INTO `m_bank_types` VALUES ('2', '工商银行', 'bank/info/gongshang.png', 'bank/pay/gongshang.png', '1', '1', '2017-08-29 17:40:29', null, '2017-08-29 17:40:29', '1', 'ICBC', '中国工商银行');
INSERT INTO `m_bank_types` VALUES ('3', '建设银行', 'bank/info/jianshe.png', 'bank/pay/jianshe.png', '1', '1', '2017-08-28 19:00:35', null, '2017-08-28 19:00:35', '0', 'CCB', '中国建设银行');
INSERT INTO `m_bank_types` VALUES ('14', '中国银行', 'bank/info/zhongguo.png', 'bank/pay/zhongguo.png', '1', '1', '2017-08-29 17:40:30', null, '2017-08-29 17:40:30', '1', 'BOC', '中国银行');
INSERT INTO `m_bank_types` VALUES ('15', '浦发银行', 'bank/info/pufa.png', 'bank/pay/pufa.png', '1', '1', '2017-08-29 17:40:32', null, '2017-08-29 17:40:32', '1', 'SPDB', '浦发银行');
INSERT INTO `m_bank_types` VALUES ('16', '光大银行', 'bank/info/guangda.png', 'bank/pay/guangda.png', '1', '1', '2017-08-29 17:40:34', null, '2017-08-29 17:40:34', '1', 'CEB', '光大银行');
INSERT INTO `m_bank_types` VALUES ('17', '平安银行', 'bank/info/pingan.png', 'bank/pay/pingan.png', '1', '1', '2017-08-29 17:40:35', null, '2017-08-29 17:40:35', '1', 'PINGAN', '中国平安银行');
INSERT INTO `m_bank_types` VALUES ('18', '兴业银行', 'bank/info/xingye.png', 'bank/pay/xingye.png', '1', '1', '2017-08-29 17:40:37', null, '2017-08-29 17:40:37', '1', 'CIB', '兴业银行');
INSERT INTO `m_bank_types` VALUES ('19', '邮政储蓄', 'bank/info/youzheng.png', 'bank/pay/youzheng.png', '1', '1', '2017-08-29 17:40:38', null, '2017-08-29 17:40:38', '1', 'POST', '中国邮政储蓄');
INSERT INTO `m_bank_types` VALUES ('20', '华夏银行', 'bank/info/huaxia.png', 'bank/pay/huaxia.png', '1', '1', '2017-08-29 17:40:40', null, '2017-08-29 17:40:40', '1', 'HXB', '华夏银行');
INSERT INTO `m_bank_types` VALUES ('21', '招商银行', 'bank/info/zhaoshang.png', 'bank/pay/zhaoshang.png', '1', '1', '2017-08-28 19:00:35', null, '2017-08-28 19:00:35', '0', 'CMB', '中国招商银行');
INSERT INTO `m_bank_types` VALUES ('22', '民生银行', 'bank/info/minsheng.png', 'bank/pay/minsheng.png', '1', '1', '2017-08-29 17:40:43', null, '2017-08-29 17:40:43', '1', 'CMBC', '中国民生银行');
INSERT INTO `m_bank_types` VALUES ('23', '北京银行', 'bank/info/beijing.png', 'bank/pay/beijing.png', '1', '1', '2017-08-29 17:40:45', null, '2017-08-29 17:40:45', '1', 'BCCB', '北京银行');
INSERT INTO `m_bank_types` VALUES ('24', '中信银行', 'bank/info/zhongxin.png', 'bank/pay/zhongxin.png', '1', '1', '2017-08-29 17:40:47', null, '2017-08-29 17:40:47', '1', 'CITIC', '中信银行');
INSERT INTO `m_bank_types` VALUES ('25', '交通银行', 'bank/info/jiaotong.png', 'bank/pay/jiaotong.png', '1', '1', '2017-08-29 17:40:50', null, '2017-08-29 17:40:50', '1', 'BOCOM', '中国交通银行');

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
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m_items
-- ----------------------------
INSERT INTO `m_items` VALUES ('1', 'R10', '充10元', '0', '10.00', null, null, '1', '1', '2017-08-22 18:35:19', '1', '2017-08-22 18:35:19', '0');
INSERT INTO `m_items` VALUES ('2', 'R50', '充50元', '0', '50.00', null, null, '1', '1', '2017-08-22 18:37:17', '1', '2017-08-22 18:37:17', '0');
INSERT INTO `m_items` VALUES ('3', 'R100', '充100元', '0', '100.00', null, null, '1', '1', '2017-08-22 18:39:00', '1', '2017-08-22 18:39:00', '0');
INSERT INTO `m_items` VALUES ('4', 'R500', '充500元', '0', '500.00', null, null, '1', '1', '2017-08-22 18:39:02', '1', '2017-08-22 18:39:02', '0');

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
  `seq` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `opened` int(11) NOT NULL DEFAULT '0' COMMENT '是否打开新窗口（1：打开 0：不打开）',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '资源状态（1：有效 0：无效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='资源模块';

-- ----------------------------
-- Records of m_modules
-- ----------------------------
INSERT INTO `m_modules` VALUES ('1', '用户管理', '0', null, '0', '1', 'look', 'fa fa-user', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('2', '用户查询', '1', null, '20', '2', 'search', null, '2', '0', '1');
INSERT INTO `m_modules` VALUES ('3', '用户详情', '1', null, '20', '2', 'detail', null, '3', '1', '1');
INSERT INTO `m_modules` VALUES ('4', '用户修改', '1', null, '20', '2', 'update', null, '4', '1', '1');
INSERT INTO `m_modules` VALUES ('5', '账户出入金明细', '0', 'ss_ac_detail/manager', '21', '1', 'look', 'fa fa-calendar-check-o', '5', '1', '1');
INSERT INTO `m_modules` VALUES ('6', '账户出入金明细查询', '1', null, '5', '2', 'search', null, '6', '0', '1');
INSERT INTO `m_modules` VALUES ('7', '账户出入金明细审核', '1', null, '5', '2', 'examine', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('8', '账户出金打款表', '0', 'ss_ac_detail/upmanager', '21', '1', 'look', 'fa fa-calendar-check-o', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('9', '账户出金打款表查询', '1', null, '8', '2', 'search', null, '1', '0', '1');
INSERT INTO `m_modules` VALUES ('10', '账户出金打款表打款', '1', null, '8', '2', 'mademoney', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('11', '业务员管理', '0', null, '0', '1', 'look', 'fa fa-user', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('12', '业务员查询', '1', null, '23', '2', 'search', null, '1', '0', '1');
INSERT INTO `m_modules` VALUES ('13', '账号列表', '0', 'ss_user/xtmanager', '24', '1', 'look', 'fa fa-map', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('14', '账号新增', '1', null, '13', '2', 'add', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('15', '账号查询', '1', null, '13', '2', 'search', null, '1', '0', '1');
INSERT INTO `m_modules` VALUES ('16', '账号修改', '1', null, '13', '2', 'update', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('17', '角色列表', '0', 'ss_role/manager', '25', '1', 'look', 'fa fa-map', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('18', '角色新增', '1', null, '17', '2', 'add', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('19', '角色权限设置', '1', null, '17', '2', 'update', null, '1', '1', '1');
INSERT INTO `m_modules` VALUES ('20', '用户列表', '0', 'ss_user/manager', '1', '1', 'look', 'fa fa-user', '1', '1', '1');
INSERT INTO `m_modules` VALUES ('21', '账户管理', '0', null, '0', '1', 'look', 'fa fa-calendar-check-o', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('23', '业务员列表', '0', 'ss_user/ywmanager', '11', '1', 'look', 'fa fa-user', '1', '1', '1');
INSERT INTO `m_modules` VALUES ('24', '账号管理', null, null, '0', '1', 'look', 'fa fa-map', '1', '0', '1');
INSERT INTO `m_modules` VALUES ('25', '角色管理', null, null, '0', '1', 'look', 'fa fa-map', '1', '1', '1');

-- ----------------------------
-- Table structure for `m_role_modules`
-- ----------------------------
DROP TABLE IF EXISTS `m_role_modules`;
CREATE TABLE `m_role_modules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `module_id` bigint(20) NOT NULL COMMENT '模块ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限';

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
INSERT INTO `m_role_modules` VALUES ('29', '5', '1');

-- ----------------------------
-- Table structure for `m_roles`
-- ----------------------------
DROP TABLE IF EXISTS `m_roles`;
CREATE TABLE `m_roles` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';

-- ----------------------------
-- Records of m_roles
-- ----------------------------
INSERT INTO `m_roles` VALUES ('1', '超级管理员', '1', '2017-08-11 18:28:02', '1', '2017-08-11 18:28:09', '0');
INSERT INTO `m_roles` VALUES ('2', '系统运营账户', '1', '2017-08-11 18:29:01', '1', '2017-08-11 18:29:01', '0');
INSERT INTO `m_roles` VALUES ('3', '业务员', '1', '2017-08-28 14:12:46', '1', '2017-08-28 14:12:47', '0');
INSERT INTO `m_roles` VALUES ('4', '财务', '1', '2017-08-28 14:12:49', '1', '2017-08-28 14:12:49', '0');
INSERT INTO `m_roles` VALUES ('5', '客服', '1', '2017-08-28 11:40:24', null, null, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payment_records
-- ----------------------------
INSERT INTO `t_payment_records` VALUES ('15', '0', '0', 'R150365123351684547', '50.00', '1', null, null, null, '0', '3', '2017-08-25 16:53:54', '3', '2017-08-25 16:53:54', '0');
INSERT INTO `t_payment_records` VALUES ('16', '0', '0', 'R150365233940262273', '1000.00', '1', null, null, null, '0', '3', '2017-08-25 17:12:19', '3', '2017-08-25 17:12:19', '0');
INSERT INTO `t_payment_records` VALUES ('17', '0', '0', 'R150365332228570662', '1000.00', '1', null, null, null, '0', '3', '2017-08-25 17:28:42', '3', '2017-08-25 17:28:42', '0');
INSERT INTO `t_payment_records` VALUES ('18', '0', '0', 'R150365353049761051', '1000.00', '1', null, null, null, '0', '3', '2017-08-25 17:32:11', '3', '2017-08-25 17:32:11', '0');
INSERT INTO `t_payment_records` VALUES ('19', '0', '0', 'R150365361925643840', '1000.00', '1', null, null, null, '0', '3', '2017-08-25 17:33:39', '3', '2017-08-25 17:33:39', '0');
INSERT INTO `t_payment_records` VALUES ('20', '0', '0', 'R150365477202927115', '10.00', '1', null, null, null, '0', '3', '2017-08-25 17:52:52', '3', '2017-08-25 17:52:52', '0');
INSERT INTO `t_payment_records` VALUES ('21', '0', '0', 'R150365561898854238', '100.00', '1', null, null, null, '0', '3', '2017-08-25 18:06:59', '3', '2017-08-25 18:06:59', '0');
INSERT INTO `t_payment_records` VALUES ('22', '0', '0', 'R150365567194145197', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:07:52', '3', '2017-08-25 18:07:52', '0');
INSERT INTO `t_payment_records` VALUES ('23', '0', '0', 'R150365576437180969', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:09:24', '3', '2017-08-25 18:09:24', '0');
INSERT INTO `t_payment_records` VALUES ('24', '0', '0', 'R150365606343848032', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:14:23', '3', '2017-08-25 18:14:23', '0');
INSERT INTO `t_payment_records` VALUES ('25', '0', '0', 'R150365607086147705', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:14:31', '3', '2017-08-25 18:14:31', '0');
INSERT INTO `t_payment_records` VALUES ('26', '0', '0', 'R150365650488985454', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:21:45', '3', '2017-08-25 18:21:45', '0');
INSERT INTO `t_payment_records` VALUES ('27', '0', '0', 'R150365774164567213', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:42:22', '3', '2017-08-25 18:42:22', '0');
INSERT INTO `t_payment_records` VALUES ('28', '0', '0', 'R150365803878165795', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:47:19', '3', '2017-08-25 18:47:19', '0');
INSERT INTO `t_payment_records` VALUES ('29', '0', '0', 'R150365805514761642', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:47:35', '3', '2017-08-25 18:47:35', '0');
INSERT INTO `t_payment_records` VALUES ('30', '0', '0', 'R150365813482059837', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:48:55', '3', '2017-08-25 18:48:55', '0');
INSERT INTO `t_payment_records` VALUES ('31', '0', '0', 'R150365816175983108', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:49:22', '3', '2017-08-25 18:49:22', '0');
INSERT INTO `t_payment_records` VALUES ('32', '0', '0', 'R150365825209318447', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:50:52', '3', '2017-08-25 18:50:52', '0');
INSERT INTO `t_payment_records` VALUES ('33', '0', '0', 'R150365831281243720', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:51:53', '3', '2017-08-25 18:51:53', '0');
INSERT INTO `t_payment_records` VALUES ('34', '0', '0', 'R150365837491261527', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:52:55', '3', '2017-08-25 18:52:55', '0');
INSERT INTO `t_payment_records` VALUES ('35', '0', '0', 'R150365853007620012', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:55:30', '3', '2017-08-25 18:55:30', '0');
INSERT INTO `t_payment_records` VALUES ('36', '0', '0', 'R150365854494557523', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:55:45', '3', '2017-08-25 18:55:45', '0');
INSERT INTO `t_payment_records` VALUES ('37', '0', '0', 'R150365854767394021', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:55:48', '3', '2017-08-25 18:55:48', '0');
INSERT INTO `t_payment_records` VALUES ('38', '0', '0', 'R150365855411296163', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:55:54', '3', '2017-08-25 18:55:54', '0');
INSERT INTO `t_payment_records` VALUES ('39', '0', '0', 'R150365859608454615', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:56:36', '3', '2017-08-25 18:56:36', '0');
INSERT INTO `t_payment_records` VALUES ('40', '0', '0', 'R150365861876769832', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:56:59', '3', '2017-08-25 18:56:59', '0');
INSERT INTO `t_payment_records` VALUES ('41', '0', '0', 'R150365863130178163', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:57:11', '3', '2017-08-25 18:57:11', '0');
INSERT INTO `t_payment_records` VALUES ('42', '0', '0', 'R150365864874469039', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:57:29', '3', '2017-08-25 18:57:29', '0');
INSERT INTO `t_payment_records` VALUES ('43', '0', '0', 'R150365872271213532', '10.00', '1', null, null, null, '0', '3', '2017-08-25 18:58:43', '3', '2017-08-25 18:58:43', '0');
INSERT INTO `t_payment_records` VALUES ('44', '0', '0', 'R150365880576134708', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:00:06', '3', '2017-08-25 19:00:06', '0');
INSERT INTO `t_payment_records` VALUES ('45', '0', '0', 'R150365883370090533', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:00:34', '3', '2017-08-25 19:00:34', '0');
INSERT INTO `t_payment_records` VALUES ('46', '0', '0', 'R150365890144210609', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:01:41', '3', '2017-08-25 19:01:41', '0');
INSERT INTO `t_payment_records` VALUES ('47', '0', '0', 'R150365899073874046', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:03:11', '3', '2017-08-25 19:03:11', '0');
INSERT INTO `t_payment_records` VALUES ('48', '0', '0', 'R150365906863421874', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:04:29', '3', '2017-08-25 19:04:29', '0');
INSERT INTO `t_payment_records` VALUES ('49', '0', '0', 'R150365912457934269', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:05:25', '3', '2017-08-25 19:05:25', '0');
INSERT INTO `t_payment_records` VALUES ('50', '0', '0', 'R150365915266076214', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:05:53', '3', '2017-08-25 19:05:53', '0');
INSERT INTO `t_payment_records` VALUES ('51', '0', '0', 'R150365972037245559', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:15:20', '3', '2017-08-25 19:15:20', '0');
INSERT INTO `t_payment_records` VALUES ('52', '0', '0', 'R150365984488232709', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:17:25', '3', '2017-08-25 19:17:25', '0');
INSERT INTO `t_payment_records` VALUES ('53', '0', '0', 'R150366038572536462', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:26:26', '3', '2017-08-25 19:26:26', '0');
INSERT INTO `t_payment_records` VALUES ('54', '0', '0', 'R150366040586638413', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:26:46', '3', '2017-08-25 19:26:46', '0');
INSERT INTO `t_payment_records` VALUES ('55', '0', '0', 'R150366044539333391', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:27:25', '3', '2017-08-25 19:27:25', '0');
INSERT INTO `t_payment_records` VALUES ('56', '0', '0', 'R150366045784074744', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:27:38', '3', '2017-08-25 19:27:38', '0');
INSERT INTO `t_payment_records` VALUES ('57', '0', '0', 'R150366046438727803', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:27:44', '3', '2017-08-25 19:27:44', '0');
INSERT INTO `t_payment_records` VALUES ('58', '0', '0', 'R150366047628663403', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:27:56', '3', '2017-08-25 19:27:56', '0');
INSERT INTO `t_payment_records` VALUES ('59', '0', '0', 'R150366051714270895', '10.00', '1', null, null, null, '0', '3', '2017-08-25 19:28:37', '3', '2017-08-25 19:28:37', '0');
INSERT INTO `t_payment_records` VALUES ('61', '0', '0', 'R150374275630679326', '1.00', '1', null, null, null, '0', '17000004', '2017-08-26 18:19:16', '17000004', '2017-08-26 18:19:16', '0');
INSERT INTO `t_payment_records` VALUES ('62', '0', '0', 'R150374279781876146', '10.00', '1', null, null, null, '0', '17000001', '2017-08-26 18:19:58', '17000001', '2017-08-26 18:19:58', '0');
INSERT INTO `t_payment_records` VALUES ('63', '0', '0', 'R150374280242128546', '10.00', '1', null, null, null, '0', '17000001', '2017-08-26 18:20:02', '17000001', '2017-08-26 18:20:02', '0');
INSERT INTO `t_payment_records` VALUES ('64', '0', '0', 'R150374284338567800', '10.00', '1', null, null, null, '0', '17000004', '2017-08-26 18:20:43', '17000004', '2017-08-26 18:20:43', '0');
INSERT INTO `t_payment_records` VALUES ('65', '0', '0', 'R150374288150051025', '1.00', '1', null, null, null, '0', '17000004', '2017-08-26 18:21:22', '17000004', '2017-08-26 18:21:22', '0');
INSERT INTO `t_payment_records` VALUES ('66', '0', '0', 'R150374292337726584', '10.00', '1', null, null, null, '0', '17000004', '2017-08-26 18:22:03', '17000004', '2017-08-26 18:22:03', '0');
INSERT INTO `t_payment_records` VALUES ('67', '0', '0', 'R150388531491096769', '10.00', '1', null, null, null, '0', '17000002', '2017-08-28 09:55:16', '17000002', '2017-08-28 09:55:16', '0');
INSERT INTO `t_payment_records` VALUES ('68', '0', '0', 'R150389899596724656', '50.00', '1', null, null, null, '0', '17000001', '2017-08-28 13:43:16', '17000001', '2017-08-28 13:43:16', '0');
INSERT INTO `t_payment_records` VALUES ('69', '0', '0', 'R150390379094153009', '50.00', '1', null, null, null, '0', '17000002', '2017-08-28 15:03:11', '17000002', '2017-08-28 15:03:11', '0');
INSERT INTO `t_payment_records` VALUES ('70', '0', '0', 'R150390388905495843', '50.00', '1', null, null, null, '0', '17000002', '2017-08-28 15:04:49', '17000002', '2017-08-28 15:04:49', '0');
INSERT INTO `t_payment_records` VALUES ('71', '0', '0', 'R150390410913042454', '50.00', '1', null, null, null, '0', '17000002', '2017-08-28 15:08:29', '17000002', '2017-08-28 15:08:29', '0');
INSERT INTO `t_payment_records` VALUES ('72', '0', '0', 'R150391707450853073', '10.00', '1', null, null, null, '0', '17000002', '2017-08-28 18:44:35', '17000002', '2017-08-28 18:44:35', '0');
INSERT INTO `t_payment_records` VALUES ('73', '0', '0', 'R150391870369496478', '10.00', '1', null, null, null, '0', '17000002', '2017-08-28 19:11:44', '17000002', '2017-08-28 19:11:44', '0');
INSERT INTO `t_payment_records` VALUES ('74', '0', '0', 'R150391880873425990', '10.00', '1', null, null, null, '0', '17000003', '2017-08-28 19:13:29', '17000003', '2017-08-28 19:13:29', '0');
INSERT INTO `t_payment_records` VALUES ('75', '0', '0', 'R150397158928177861', '10.00', '1', null, null, null, '0', '17000002', '2017-08-29 09:53:09', '17000002', '2017-08-29 09:53:09', '0');
INSERT INTO `t_payment_records` VALUES ('76', '0', '0', 'R150399060510734517', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payment_records` VALUES ('77', '0', '0', 'R150399060511585594', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payment_records` VALUES ('78', '0', '0', 'R150399060511862551', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payment_records` VALUES ('79', '0', '0', 'R150399060512297556', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payment_records` VALUES ('80', '0', '0', 'R150399060978488218', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:10:10', '17000007', '2017-08-29 15:10:10', '0');
INSERT INTO `t_payment_records` VALUES ('81', '0', '0', 'R150399096029334015', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:16:00', '17000007', '2017-08-29 15:16:00', '0');
INSERT INTO `t_payment_records` VALUES ('82', '0', '0', 'R150399096077372887', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_payment_records` VALUES ('83', '0', '0', 'R150399096110864111', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_payment_records` VALUES ('84', '0', '0', 'R150399097256945239', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:16:13', '17000007', '2017-08-29 15:16:13', '0');
INSERT INTO `t_payment_records` VALUES ('85', '0', '0', 'R150399098758968930', '5000.00', '1', null, null, null, '0', '17000007', '2017-08-29 15:16:28', '17000007', '2017-08-29 15:16:28', '0');
INSERT INTO `t_payment_records` VALUES ('86', '0', '0', 'R150399550939786108', '22.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:31:49', '17000007', '2017-08-29 16:31:49', '0');
INSERT INTO `t_payment_records` VALUES ('87', '0', '0', 'R150399617605572302', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:42:56', '17000007', '2017-08-29 16:42:56', '0');
INSERT INTO `t_payment_records` VALUES ('88', '0', '0', 'R150399620525235004', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:43:25', '17000007', '2017-08-29 16:43:25', '0');
INSERT INTO `t_payment_records` VALUES ('89', '0', '0', 'R150399623197146763', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:43:52', '17000007', '2017-08-29 16:43:52', '0');
INSERT INTO `t_payment_records` VALUES ('90', '0', '0', 'R150399626590521873', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:44:26', '17000007', '2017-08-29 16:44:26', '0');
INSERT INTO `t_payment_records` VALUES ('91', '0', '0', 'R150399628643930949', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:44:46', '17000007', '2017-08-29 16:44:46', '0');
INSERT INTO `t_payment_records` VALUES ('92', '0', '0', 'R150399634962750838', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:45:50', '17000007', '2017-08-29 16:45:50', '0');
INSERT INTO `t_payment_records` VALUES ('93', '0', '0', 'R150399636993794867', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:46:10', '17000007', '2017-08-29 16:46:10', '0');
INSERT INTO `t_payment_records` VALUES ('94', '0', '0', 'R150399643120365663', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:47:11', '17000007', '2017-08-29 16:47:11', '0');
INSERT INTO `t_payment_records` VALUES ('95', '0', '0', 'R150399646947356783', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:47:49', '17000007', '2017-08-29 16:47:49', '0');
INSERT INTO `t_payment_records` VALUES ('96', '0', '0', 'R150399648742369190', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:48:07', '17000007', '2017-08-29 16:48:07', '0');
INSERT INTO `t_payment_records` VALUES ('97', '0', '0', 'R150399650681225986', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:48:27', '17000007', '2017-08-29 16:48:27', '0');
INSERT INTO `t_payment_records` VALUES ('98', '0', '0', 'R150399654630990557', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:49:06', '17000007', '2017-08-29 16:49:06', '0');
INSERT INTO `t_payment_records` VALUES ('99', '0', '0', 'R150399656718260661', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:49:27', '17000007', '2017-08-29 16:49:27', '0');
INSERT INTO `t_payment_records` VALUES ('100', '0', '0', 'R150399660698628836', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:50:07', '17000001', '2017-08-29 16:50:07', '0');
INSERT INTO `t_payment_records` VALUES ('101', '0', '0', 'R150399662206860377', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:50:22', '17000007', '2017-08-29 16:50:22', '0');
INSERT INTO `t_payment_records` VALUES ('102', '0', '0', 'R150399662709818608', '10.00', '1', null, null, null, '0', '17000002', '2017-08-29 16:50:27', '17000002', '2017-08-29 16:50:27', '0');
INSERT INTO `t_payment_records` VALUES ('103', '0', '0', 'R150399663610163282', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:50:36', '17000001', '2017-08-29 16:50:36', '0');
INSERT INTO `t_payment_records` VALUES ('104', '0', '0', 'R150399665376058066', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:50:54', '17000007', '2017-08-29 16:50:54', '0');
INSERT INTO `t_payment_records` VALUES ('105', '0', '0', 'R150399665441317664', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:50:54', '17000001', '2017-08-29 16:50:54', '0');
INSERT INTO `t_payment_records` VALUES ('106', '0', '0', 'R150399667895342060', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:51:19', '17000001', '2017-08-29 16:51:19', '0');
INSERT INTO `t_payment_records` VALUES ('107', '0', '0', 'R150399668356798260', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:51:24', '17000007', '2017-08-29 16:51:24', '0');
INSERT INTO `t_payment_records` VALUES ('108', '0', '0', 'R150399671839583774', '10.00', '1', null, null, null, '0', '17000002', '2017-08-29 16:51:58', '17000002', '2017-08-29 16:51:58', '0');
INSERT INTO `t_payment_records` VALUES ('109', '0', '0', 'R150399674528086289', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:52:25', '17000001', '2017-08-29 16:52:25', '0');
INSERT INTO `t_payment_records` VALUES ('110', '0', '0', 'R150399676426977273', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:52:44', '17000001', '2017-08-29 16:52:44', '0');
INSERT INTO `t_payment_records` VALUES ('111', '0', '0', 'R150399677068526697', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:52:51', '17000001', '2017-08-29 16:52:51', '0');
INSERT INTO `t_payment_records` VALUES ('112', '0', '0', 'R150399678206077635', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:53:02', '17000001', '2017-08-29 16:53:02', '0');
INSERT INTO `t_payment_records` VALUES ('113', '0', '0', 'R150399678537769887', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 16:53:05', '17000007', '2017-08-29 16:53:05', '0');
INSERT INTO `t_payment_records` VALUES ('114', '0', '0', 'R150399679750559884', '1000.00', '1', null, null, null, '0', '17000002', '2017-08-29 16:53:18', '17000002', '2017-08-29 16:53:18', '0');
INSERT INTO `t_payment_records` VALUES ('115', '0', '0', 'R150399711079148113', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 16:58:31', '17000001', '2017-08-29 16:58:31', '0');
INSERT INTO `t_payment_records` VALUES ('116', '0', '0', 'R150399730675938242', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:01:47', '17000001', '2017-08-29 17:01:47', '0');
INSERT INTO `t_payment_records` VALUES ('117', '0', '0', 'R150399748473768850', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:04:45', '17000001', '2017-08-29 17:04:45', '0');
INSERT INTO `t_payment_records` VALUES ('118', '0', '0', 'R150399751968184468', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:05:20', '17000001', '2017-08-29 17:05:20', '0');
INSERT INTO `t_payment_records` VALUES ('119', '0', '0', 'R150399756619354002', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:06:06', '17000001', '2017-08-29 17:06:06', '0');
INSERT INTO `t_payment_records` VALUES ('120', '0', '0', 'R150399766906356543', '10.00', '1', null, null, null, '0', '17000005', '2017-08-29 17:07:49', '17000005', '2017-08-29 17:07:49', '0');
INSERT INTO `t_payment_records` VALUES ('121', '0', '0', 'R150399772834824960', '10.00', '1', null, null, null, '0', '17000005', '2017-08-29 17:08:48', '17000005', '2017-08-29 17:08:48', '0');
INSERT INTO `t_payment_records` VALUES ('122', '0', '0', 'R150399801483367380', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:13:35', '17000007', '2017-08-29 17:13:35', '0');
INSERT INTO `t_payment_records` VALUES ('123', '0', '0', 'R150399808842945875', '10.00', '1', null, null, null, '0', '17000005', '2017-08-29 17:14:48', '17000005', '2017-08-29 17:14:48', '0');
INSERT INTO `t_payment_records` VALUES ('124', '0', '0', 'R150399809457410109', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:14:55', '17000007', '2017-08-29 17:14:55', '0');
INSERT INTO `t_payment_records` VALUES ('125', '0', '0', 'R150399815145769346', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:15:51', '17000007', '2017-08-29 17:15:51', '0');
INSERT INTO `t_payment_records` VALUES ('126', '0', '0', 'R150399822008031606', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:17:00', '17000007', '2017-08-29 17:17:00', '0');
INSERT INTO `t_payment_records` VALUES ('127', '0', '0', 'R150399825787447385', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:17:38', '17000007', '2017-08-29 17:17:38', '0');
INSERT INTO `t_payment_records` VALUES ('128', '0', '0', 'R150399830057951674', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:18:21', '17000007', '2017-08-29 17:18:21', '0');
INSERT INTO `t_payment_records` VALUES ('129', '0', '0', 'R150399833341181453', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:18:53', '17000007', '2017-08-29 17:18:53', '0');
INSERT INTO `t_payment_records` VALUES ('130', '0', '0', 'R150399835665926108', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:19:17', '17000007', '2017-08-29 17:19:17', '0');
INSERT INTO `t_payment_records` VALUES ('131', '0', '0', 'R150399837318614669', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:19:33', '17000007', '2017-08-29 17:19:33', '0');
INSERT INTO `t_payment_records` VALUES ('132', '0', '0', 'R150399839046476270', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:19:50', '17000007', '2017-08-29 17:19:50', '0');
INSERT INTO `t_payment_records` VALUES ('133', '0', '0', 'R150399853418685181', '500.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:22:14', '17000007', '2017-08-29 17:22:14', '0');
INSERT INTO `t_payment_records` VALUES ('134', '0', '0', 'R150399860887236259', '500.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:23:29', '17000007', '2017-08-29 17:23:29', '0');
INSERT INTO `t_payment_records` VALUES ('135', '0', '0', 'R150399938213455099', '1000.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:36:22', '17000007', '2017-08-29 17:36:22', '0');
INSERT INTO `t_payment_records` VALUES ('136', '0', '0', 'R150399941936078882', '10.00', '1', null, null, null, '0', '17000007', '2017-08-29 17:36:59', '17000007', '2017-08-29 17:36:59', '0');
INSERT INTO `t_payment_records` VALUES ('137', '0', '0', 'R150399944414370725', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:37:24', '17000001', '2017-08-29 17:37:24', '0');
INSERT INTO `t_payment_records` VALUES ('138', '0', '0', 'R150399946707259002', '10.00', '1', null, null, null, '0', '17000001', '2017-08-29 17:37:47', '17000001', '2017-08-29 17:37:47', '0');
INSERT INTO `t_payment_records` VALUES ('139', '0', '0', 'R150400149791621326', '1.00', '1', null, null, null, '0', '17000007', '2017-08-29 18:11:38', '17000007', '2017-08-29 18:11:38', '0');
INSERT INTO `t_payment_records` VALUES ('140', '0', '0', 'R150400181264257854', '1.00', '1', null, null, null, '0', '17000007', '2017-08-29 18:16:53', '17000007', '2017-08-29 18:16:53', '0');
INSERT INTO `t_payment_records` VALUES ('141', '0', '0', 'R150400194691267741', '1.00', '1', null, null, null, '0', '17000007', '2017-08-29 18:19:07', '17000007', '2017-08-29 18:19:07', '0');
INSERT INTO `t_payment_records` VALUES ('142', '0', '0', 'R150401591896357635', '1.00', '1', null, null, null, '0', '17000002', '2017-08-29 22:11:59', '17000002', '2017-08-29 22:11:59', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payments
-- ----------------------------
INSERT INTO `t_payments` VALUES ('2', '1', '0', '1.00', '1', null, '61', '0', '17000004', '2017-08-26 18:19:16', '17000004', '2017-08-26 18:19:16', '0');
INSERT INTO `t_payments` VALUES ('3', '2', '0', '10.00', '1', null, '62', '0', '17000001', '2017-08-26 18:19:58', '17000001', '2017-08-26 18:19:58', '0');
INSERT INTO `t_payments` VALUES ('4', '2', '0', '10.00', '1', null, '63', '0', '17000001', '2017-08-26 18:20:02', '17000001', '2017-08-26 18:20:02', '0');
INSERT INTO `t_payments` VALUES ('5', '5', '0', '10.00', '1', null, '64', '0', '17000004', '2017-08-26 18:20:43', '17000004', '2017-08-26 18:20:43', '0');
INSERT INTO `t_payments` VALUES ('6', '1', '0', '1.00', '1', null, '65', '0', '17000004', '2017-08-26 18:21:22', '17000004', '2017-08-26 18:21:22', '0');
INSERT INTO `t_payments` VALUES ('7', '1', '0', '10.00', '1', null, '66', '0', '17000004', '2017-08-26 18:22:03', '17000004', '2017-08-26 18:22:03', '0');
INSERT INTO `t_payments` VALUES ('8', '2', '0', '10.00', '1', null, '67', '0', '17000002', '2017-08-28 09:55:16', '17000002', '2017-08-28 09:55:16', '0');
INSERT INTO `t_payments` VALUES ('9', '5', '0', '50.00', '1', null, '68', '0', '17000001', '2017-08-28 13:43:16', '17000001', '2017-08-28 13:43:16', '0');
INSERT INTO `t_payments` VALUES ('10', '2', '0', '50.00', '1', null, '69', '0', '17000002', '2017-08-28 15:03:11', '17000002', '2017-08-28 15:03:11', '0');
INSERT INTO `t_payments` VALUES ('11', '1', '0', '50.00', '1', null, '70', '0', '17000002', '2017-08-28 15:04:49', '17000002', '2017-08-28 15:04:49', '0');
INSERT INTO `t_payments` VALUES ('12', '1', '0', '50.00', '1', null, '71', '0', '17000002', '2017-08-28 15:08:29', '17000002', '2017-08-28 15:08:29', '0');
INSERT INTO `t_payments` VALUES ('13', '2', '0', '10.00', '1', null, '72', '0', '17000002', '2017-08-28 18:44:35', '17000002', '2017-08-28 18:44:35', '0');
INSERT INTO `t_payments` VALUES ('14', '1', '0', '10.00', '1', null, '73', '0', '17000002', '2017-08-28 19:11:44', '17000002', '2017-08-28 19:11:44', '0');
INSERT INTO `t_payments` VALUES ('15', '1', '0', '10.00', '1', null, '74', '0', '17000003', '2017-08-28 19:13:29', '17000003', '2017-08-28 19:13:29', '0');
INSERT INTO `t_payments` VALUES ('16', '2', '0', '10.00', '1', null, '75', '0', '17000002', '2017-08-29 09:53:09', '17000002', '2017-08-29 09:53:09', '0');
INSERT INTO `t_payments` VALUES ('17', '5', '0', '5000.00', '1', null, '76', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payments` VALUES ('18', '2', '0', '5000.00', '1', null, '77', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payments` VALUES ('19', '2', '0', '5000.00', '1', null, '78', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payments` VALUES ('20', '2', '0', '5000.00', '1', null, '79', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_payments` VALUES ('21', '2', '0', '5000.00', '1', null, '80', '0', '17000007', '2017-08-29 15:10:10', '17000007', '2017-08-29 15:10:10', '0');
INSERT INTO `t_payments` VALUES ('22', '2', '0', '5000.00', '1', null, '81', '0', '17000007', '2017-08-29 15:16:00', '17000007', '2017-08-29 15:16:00', '0');
INSERT INTO `t_payments` VALUES ('23', '2', '0', '5000.00', '1', null, '82', '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_payments` VALUES ('24', '2', '0', '5000.00', '1', null, '83', '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_payments` VALUES ('25', '2', '0', '5000.00', '1', null, '84', '0', '17000007', '2017-08-29 15:16:13', '17000007', '2017-08-29 15:16:13', '0');
INSERT INTO `t_payments` VALUES ('26', '5', '0', '5000.00', '1', null, '85', '0', '17000007', '2017-08-29 15:16:28', '17000007', '2017-08-29 15:16:28', '0');
INSERT INTO `t_payments` VALUES ('27', '2', '0', '22.00', '1', null, '86', '0', '17000007', '2017-08-29 16:31:49', '17000007', '2017-08-29 16:31:49', '0');
INSERT INTO `t_payments` VALUES ('28', '1', '0', '1000.00', '1', null, '87', '0', '17000007', '2017-08-29 16:42:56', '17000007', '2017-08-29 16:42:56', '0');
INSERT INTO `t_payments` VALUES ('29', '1', '0', '1000.00', '1', null, '88', '0', '17000007', '2017-08-29 16:43:25', '17000007', '2017-08-29 16:43:25', '0');
INSERT INTO `t_payments` VALUES ('30', '1', '0', '1000.00', '1', null, '89', '0', '17000007', '2017-08-29 16:43:52', '17000007', '2017-08-29 16:43:52', '0');
INSERT INTO `t_payments` VALUES ('31', '1', '0', '1000.00', '1', null, '90', '0', '17000007', '2017-08-29 16:44:26', '17000007', '2017-08-29 16:44:26', '0');
INSERT INTO `t_payments` VALUES ('32', '1', '0', '1000.00', '1', null, '91', '0', '17000007', '2017-08-29 16:44:46', '17000007', '2017-08-29 16:44:46', '0');
INSERT INTO `t_payments` VALUES ('33', '1', '0', '1000.00', '1', null, '92', '0', '17000007', '2017-08-29 16:45:50', '17000007', '2017-08-29 16:45:50', '0');
INSERT INTO `t_payments` VALUES ('34', '1', '0', '1000.00', '1', null, '93', '0', '17000007', '2017-08-29 16:46:10', '17000007', '2017-08-29 16:46:10', '0');
INSERT INTO `t_payments` VALUES ('35', '5', '0', '1000.00', '1', null, '94', '0', '17000007', '2017-08-29 16:47:11', '17000007', '2017-08-29 16:47:11', '0');
INSERT INTO `t_payments` VALUES ('36', '1', '0', '1000.00', '1', null, '95', '0', '17000007', '2017-08-29 16:47:49', '17000007', '2017-08-29 16:47:49', '0');
INSERT INTO `t_payments` VALUES ('37', '1', '0', '1000.00', '1', null, '96', '0', '17000007', '2017-08-29 16:48:07', '17000007', '2017-08-29 16:48:07', '0');
INSERT INTO `t_payments` VALUES ('38', '1', '0', '1000.00', '1', null, '97', '0', '17000007', '2017-08-29 16:48:27', '17000007', '2017-08-29 16:48:27', '0');
INSERT INTO `t_payments` VALUES ('39', '1', '0', '1000.00', '1', null, '98', '0', '17000007', '2017-08-29 16:49:06', '17000007', '2017-08-29 16:49:06', '0');
INSERT INTO `t_payments` VALUES ('40', '1', '0', '1000.00', '1', null, '99', '0', '17000007', '2017-08-29 16:49:27', '17000007', '2017-08-29 16:49:27', '0');
INSERT INTO `t_payments` VALUES ('41', '1', '0', '10.00', '1', null, '100', '0', '17000001', '2017-08-29 16:50:07', '17000001', '2017-08-29 16:50:07', '0');
INSERT INTO `t_payments` VALUES ('42', '1', '0', '1000.00', '1', null, '101', '0', '17000007', '2017-08-29 16:50:22', '17000007', '2017-08-29 16:50:22', '0');
INSERT INTO `t_payments` VALUES ('43', '1', '0', '10.00', '1', null, '102', '0', '17000002', '2017-08-29 16:50:27', '17000002', '2017-08-29 16:50:27', '0');
INSERT INTO `t_payments` VALUES ('44', '1', '0', '10.00', '1', null, '103', '0', '17000001', '2017-08-29 16:50:36', '17000001', '2017-08-29 16:50:36', '0');
INSERT INTO `t_payments` VALUES ('45', '1', '0', '1000.00', '1', null, '104', '0', '17000007', '2017-08-29 16:50:54', '17000007', '2017-08-29 16:50:54', '0');
INSERT INTO `t_payments` VALUES ('46', '1', '0', '10.00', '1', null, '105', '0', '17000001', '2017-08-29 16:50:54', '17000001', '2017-08-29 16:50:54', '0');
INSERT INTO `t_payments` VALUES ('47', '1', '0', '10.00', '1', null, '106', '0', '17000001', '2017-08-29 16:51:19', '17000001', '2017-08-29 16:51:19', '0');
INSERT INTO `t_payments` VALUES ('48', '1', '0', '1000.00', '1', null, '107', '0', '17000007', '2017-08-29 16:51:24', '17000007', '2017-08-29 16:51:24', '0');
INSERT INTO `t_payments` VALUES ('49', '1', '0', '10.00', '1', null, '108', '0', '17000002', '2017-08-29 16:51:58', '17000002', '2017-08-29 16:51:58', '0');
INSERT INTO `t_payments` VALUES ('50', '1', '0', '10.00', '1', null, '109', '0', '17000001', '2017-08-29 16:52:25', '17000001', '2017-08-29 16:52:25', '0');
INSERT INTO `t_payments` VALUES ('51', '1', '0', '10.00', '1', null, '110', '0', '17000001', '2017-08-29 16:52:44', '17000001', '2017-08-29 16:52:44', '0');
INSERT INTO `t_payments` VALUES ('52', '1', '0', '10.00', '1', null, '111', '0', '17000001', '2017-08-29 16:52:51', '17000001', '2017-08-29 16:52:51', '0');
INSERT INTO `t_payments` VALUES ('53', '1', '0', '10.00', '1', null, '112', '0', '17000001', '2017-08-29 16:53:02', '17000001', '2017-08-29 16:53:02', '0');
INSERT INTO `t_payments` VALUES ('54', '1', '0', '1000.00', '1', null, '113', '0', '17000007', '2017-08-29 16:53:05', '17000007', '2017-08-29 16:53:05', '0');
INSERT INTO `t_payments` VALUES ('55', '1', '0', '1000.00', '1', null, '114', '0', '17000002', '2017-08-29 16:53:18', '17000002', '2017-08-29 16:53:18', '0');
INSERT INTO `t_payments` VALUES ('56', '1', '0', '10.00', '1', null, '115', '0', '17000001', '2017-08-29 16:58:31', '17000001', '2017-08-29 16:58:31', '0');
INSERT INTO `t_payments` VALUES ('57', '1', '0', '10.00', '1', null, '116', '0', '17000001', '2017-08-29 17:01:47', '17000001', '2017-08-29 17:01:47', '0');
INSERT INTO `t_payments` VALUES ('58', '1', '0', '10.00', '1', null, '117', '0', '17000001', '2017-08-29 17:04:45', '17000001', '2017-08-29 17:04:45', '0');
INSERT INTO `t_payments` VALUES ('59', '1', '0', '10.00', '1', null, '118', '0', '17000001', '2017-08-29 17:05:20', '17000001', '2017-08-29 17:05:20', '0');
INSERT INTO `t_payments` VALUES ('60', '5', '0', '10.00', '1', null, '119', '0', '17000001', '2017-08-29 17:06:06', '17000001', '2017-08-29 17:06:06', '0');
INSERT INTO `t_payments` VALUES ('61', '1', '0', '10.00', '1', null, '120', '0', '17000005', '2017-08-29 17:07:49', '17000005', '2017-08-29 17:07:49', '0');
INSERT INTO `t_payments` VALUES ('62', '1', '0', '10.00', '1', null, '121', '0', '17000005', '2017-08-29 17:08:48', '17000005', '2017-08-29 17:08:48', '0');
INSERT INTO `t_payments` VALUES ('63', '1', '0', '1000.00', '1', null, '122', '0', '17000007', '2017-08-29 17:13:35', '17000007', '2017-08-29 17:13:35', '0');
INSERT INTO `t_payments` VALUES ('64', '2', '0', '10.00', '1', null, '123', '0', '17000005', '2017-08-29 17:14:48', '17000005', '2017-08-29 17:14:48', '0');
INSERT INTO `t_payments` VALUES ('65', '1', '0', '1000.00', '1', null, '124', '0', '17000007', '2017-08-29 17:14:55', '17000007', '2017-08-29 17:14:55', '0');
INSERT INTO `t_payments` VALUES ('66', '1', '0', '1000.00', '1', null, '125', '0', '17000007', '2017-08-29 17:15:51', '17000007', '2017-08-29 17:15:51', '0');
INSERT INTO `t_payments` VALUES ('67', '1', '0', '1000.00', '1', null, '126', '0', '17000007', '2017-08-29 17:17:00', '17000007', '2017-08-29 17:17:00', '0');
INSERT INTO `t_payments` VALUES ('68', '1', '0', '1000.00', '1', null, '127', '0', '17000007', '2017-08-29 17:17:38', '17000007', '2017-08-29 17:17:38', '0');
INSERT INTO `t_payments` VALUES ('69', '1', '0', '1000.00', '1', null, '128', '0', '17000007', '2017-08-29 17:18:21', '17000007', '2017-08-29 17:18:21', '0');
INSERT INTO `t_payments` VALUES ('70', '1', '0', '1000.00', '1', null, '129', '0', '17000007', '2017-08-29 17:18:53', '17000007', '2017-08-29 17:18:53', '0');
INSERT INTO `t_payments` VALUES ('71', '1', '0', '1000.00', '1', null, '130', '0', '17000007', '2017-08-29 17:19:17', '17000007', '2017-08-29 17:19:17', '0');
INSERT INTO `t_payments` VALUES ('72', '1', '0', '1000.00', '1', null, '131', '0', '17000007', '2017-08-29 17:19:33', '17000007', '2017-08-29 17:19:33', '0');
INSERT INTO `t_payments` VALUES ('73', '1', '0', '1000.00', '1', null, '132', '0', '17000007', '2017-08-29 17:19:50', '17000007', '2017-08-29 17:19:50', '0');
INSERT INTO `t_payments` VALUES ('74', '1', '0', '500.00', '1', null, '133', '0', '17000007', '2017-08-29 17:22:14', '17000007', '2017-08-29 17:22:14', '0');
INSERT INTO `t_payments` VALUES ('75', '1', '0', '500.00', '1', null, '134', '0', '17000007', '2017-08-29 17:23:29', '17000007', '2017-08-29 17:23:29', '0');
INSERT INTO `t_payments` VALUES ('76', '1', '0', '1000.00', '1', null, '135', '0', '17000007', '2017-08-29 17:36:22', '17000007', '2017-08-29 17:36:22', '0');
INSERT INTO `t_payments` VALUES ('77', '1', '0', '10.00', '1', null, '136', '0', '17000007', '2017-08-29 17:36:59', '17000007', '2017-08-29 17:36:59', '0');
INSERT INTO `t_payments` VALUES ('78', '1', '0', '10.00', '1', null, '137', '0', '17000001', '2017-08-29 17:37:24', '17000001', '2017-08-29 17:37:24', '0');
INSERT INTO `t_payments` VALUES ('79', '1', '0', '10.00', '1', null, '138', '0', '17000001', '2017-08-29 17:37:47', '17000001', '2017-08-29 17:37:47', '0');
INSERT INTO `t_payments` VALUES ('80', '5', '0', '1.00', '1', null, '139', '0', '17000007', '2017-08-29 18:11:38', '17000007', '2017-08-29 18:11:38', '0');
INSERT INTO `t_payments` VALUES ('81', '5', '0', '1.00', '1', null, '140', '0', '17000007', '2017-08-29 18:16:53', '17000007', '2017-08-29 18:16:53', '0');
INSERT INTO `t_payments` VALUES ('82', '2', '0', '1.00', '1', null, '141', '0', '17000007', '2017-08-29 18:19:07', '17000007', '2017-08-29 18:19:07', '0');
INSERT INTO `t_payments` VALUES ('83', '5', '0', '1.00', '1', null, '142', '0', '17000002', '2017-08-29 22:11:59', '17000002', '2017-08-29 22:11:59', '0');

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
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';

-- ----------------------------
-- Records of t_recharges
-- ----------------------------
INSERT INTO `t_recharges` VALUES ('2', '17000004', 'R150374275630679326', '0', '1.00', null, '0', '0', '17000004', '2017-08-26 18:19:16', '17000004', '2017-08-26 18:19:16', '0');
INSERT INTO `t_recharges` VALUES ('3', '17000001', 'R150374279781876146', '0', '10.00', null, '0', '0', '17000001', '2017-08-26 18:19:58', '17000001', '2017-08-26 18:19:58', '0');
INSERT INTO `t_recharges` VALUES ('4', '17000001', 'R150374280242128546', '0', '10.00', null, '0', '0', '17000001', '2017-08-26 18:20:02', '17000001', '2017-08-26 18:20:02', '0');
INSERT INTO `t_recharges` VALUES ('5', '17000004', 'R150374284338567800', '0', '10.00', null, '0', '0', '17000004', '2017-08-26 18:20:43', '17000004', '2017-08-26 18:20:43', '0');
INSERT INTO `t_recharges` VALUES ('6', '17000004', 'R150374288150051025', '0', '1.00', null, '0', '0', '17000004', '2017-08-26 18:21:22', '17000004', '2017-08-26 18:21:22', '0');
INSERT INTO `t_recharges` VALUES ('7', '17000004', 'R150374292337726584', '0', '10.00', null, '0', '0', '17000004', '2017-08-26 18:22:03', '17000004', '2017-08-26 18:22:03', '0');
INSERT INTO `t_recharges` VALUES ('8', '17000002', 'R150388531491096769', '0', '10.00', null, '0', '0', '17000002', '2017-08-28 09:55:15', '17000002', '2017-08-28 09:55:15', '0');
INSERT INTO `t_recharges` VALUES ('9', '17000001', 'R150389899596724656', '0', '50.00', null, '0', '0', '17000001', '2017-08-28 13:43:16', '17000001', '2017-08-28 13:43:16', '0');
INSERT INTO `t_recharges` VALUES ('10', '17000002', 'R150390379094153009', '0', '50.00', null, '0', '0', '17000002', '2017-08-28 15:03:11', '17000002', '2017-08-28 15:03:11', '0');
INSERT INTO `t_recharges` VALUES ('11', '17000002', 'R150390388905495843', '0', '50.00', null, '0', '0', '17000002', '2017-08-28 15:04:49', '17000002', '2017-08-28 15:04:49', '0');
INSERT INTO `t_recharges` VALUES ('12', '17000002', 'R150390410913042454', '0', '50.00', null, '0', '0', '17000002', '2017-08-28 15:08:29', '17000002', '2017-08-28 15:08:29', '0');
INSERT INTO `t_recharges` VALUES ('13', '17000002', 'R150391707450853073', '0', '10.00', null, '0', '0', '17000002', '2017-08-28 18:44:35', '17000002', '2017-08-28 18:44:35', '0');
INSERT INTO `t_recharges` VALUES ('14', '17000002', 'R150391870369496478', '0', '10.00', null, '0', '0', '17000002', '2017-08-28 19:11:44', '17000002', '2017-08-28 19:11:44', '0');
INSERT INTO `t_recharges` VALUES ('15', '17000003', 'R150391880873425990', '0', '10.00', null, '0', '0', '17000003', '2017-08-28 19:13:29', '17000003', '2017-08-28 19:13:29', '0');
INSERT INTO `t_recharges` VALUES ('16', '17000002', 'R150397158928177861', '0', '10.00', null, '0', '0', '17000002', '2017-08-29 09:53:09', '17000002', '2017-08-29 09:53:09', '0');
INSERT INTO `t_recharges` VALUES ('17', '17000007', 'R150399060510734517', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('18', '17000007', 'R150399060511585594', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('19', '17000007', 'R150399060511862551', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('20', '17000007', 'R150399060512297556', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('21', '17000007', 'R150399060978488218', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:10:10', '17000007', '2017-08-29 15:10:10', '0');
INSERT INTO `t_recharges` VALUES ('22', '17000007', 'R150399096029334015', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:16:00', '17000007', '2017-08-29 15:16:00', '0');
INSERT INTO `t_recharges` VALUES ('23', '17000007', 'R150399096077372887', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_recharges` VALUES ('24', '17000007', 'R150399096110864111', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_recharges` VALUES ('25', '17000007', 'R150399097256945239', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:16:13', '17000007', '2017-08-29 15:16:13', '0');
INSERT INTO `t_recharges` VALUES ('26', '17000007', 'R150399098758968930', '0', '5000.00', null, '0', '0', '17000007', '2017-08-29 15:16:28', '17000007', '2017-08-29 15:16:28', '0');
INSERT INTO `t_recharges` VALUES ('27', '17000007', 'R150399550939786108', '0', '22.00', null, '0', '0', '17000007', '2017-08-29 16:31:49', '17000007', '2017-08-29 16:31:49', '0');
INSERT INTO `t_recharges` VALUES ('28', '17000007', 'R150399617605572302', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:42:56', '17000007', '2017-08-29 16:42:56', '0');
INSERT INTO `t_recharges` VALUES ('29', '17000007', 'R150399620525235004', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:43:25', '17000007', '2017-08-29 16:43:25', '0');
INSERT INTO `t_recharges` VALUES ('30', '17000007', 'R150399623197146763', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:43:52', '17000007', '2017-08-29 16:43:52', '0');
INSERT INTO `t_recharges` VALUES ('31', '17000007', 'R150399626590521873', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:44:26', '17000007', '2017-08-29 16:44:26', '0');
INSERT INTO `t_recharges` VALUES ('32', '17000007', 'R150399628643930949', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:44:46', '17000007', '2017-08-29 16:44:46', '0');
INSERT INTO `t_recharges` VALUES ('33', '17000007', 'R150399634962750838', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:45:50', '17000007', '2017-08-29 16:45:50', '0');
INSERT INTO `t_recharges` VALUES ('34', '17000007', 'R150399636993794867', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:46:10', '17000007', '2017-08-29 16:46:10', '0');
INSERT INTO `t_recharges` VALUES ('35', '17000007', 'R150399643120365663', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:47:11', '17000007', '2017-08-29 16:47:11', '0');
INSERT INTO `t_recharges` VALUES ('36', '17000007', 'R150399646947356783', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:47:49', '17000007', '2017-08-29 16:47:49', '0');
INSERT INTO `t_recharges` VALUES ('37', '17000007', 'R150399648742369190', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:48:07', '17000007', '2017-08-29 16:48:07', '0');
INSERT INTO `t_recharges` VALUES ('38', '17000007', 'R150399650681225986', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:48:27', '17000007', '2017-08-29 16:48:27', '0');
INSERT INTO `t_recharges` VALUES ('39', '17000007', 'R150399654630990557', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:49:06', '17000007', '2017-08-29 16:49:06', '0');
INSERT INTO `t_recharges` VALUES ('40', '17000007', 'R150399656718260661', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:49:27', '17000007', '2017-08-29 16:49:27', '0');
INSERT INTO `t_recharges` VALUES ('41', '17000001', 'R150399660698628836', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:50:07', '17000001', '2017-08-29 16:50:07', '0');
INSERT INTO `t_recharges` VALUES ('42', '17000007', 'R150399662206860377', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:50:22', '17000007', '2017-08-29 16:50:22', '0');
INSERT INTO `t_recharges` VALUES ('43', '17000002', 'R150399662709818608', '0', '10.00', null, '0', '0', '17000002', '2017-08-29 16:50:27', '17000002', '2017-08-29 16:50:27', '0');
INSERT INTO `t_recharges` VALUES ('44', '17000001', 'R150399663610163282', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:50:36', '17000001', '2017-08-29 16:50:36', '0');
INSERT INTO `t_recharges` VALUES ('45', '17000007', 'R150399665376058066', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:50:54', '17000007', '2017-08-29 16:50:54', '0');
INSERT INTO `t_recharges` VALUES ('46', '17000001', 'R150399665441317664', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:50:54', '17000001', '2017-08-29 16:50:54', '0');
INSERT INTO `t_recharges` VALUES ('47', '17000001', 'R150399667895342060', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:51:19', '17000001', '2017-08-29 16:51:19', '0');
INSERT INTO `t_recharges` VALUES ('48', '17000007', 'R150399668356798260', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:51:24', '17000007', '2017-08-29 16:51:24', '0');
INSERT INTO `t_recharges` VALUES ('49', '17000002', 'R150399671839583774', '0', '10.00', null, '0', '0', '17000002', '2017-08-29 16:51:58', '17000002', '2017-08-29 16:51:58', '0');
INSERT INTO `t_recharges` VALUES ('50', '17000001', 'R150399674528086289', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:52:25', '17000001', '2017-08-29 16:52:25', '0');
INSERT INTO `t_recharges` VALUES ('51', '17000001', 'R150399676426977273', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:52:44', '17000001', '2017-08-29 16:52:44', '0');
INSERT INTO `t_recharges` VALUES ('52', '17000001', 'R150399677068526697', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:52:51', '17000001', '2017-08-29 16:52:51', '0');
INSERT INTO `t_recharges` VALUES ('53', '17000001', 'R150399678206077635', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:53:02', '17000001', '2017-08-29 16:53:02', '0');
INSERT INTO `t_recharges` VALUES ('54', '17000007', 'R150399678537769887', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 16:53:05', '17000007', '2017-08-29 16:53:05', '0');
INSERT INTO `t_recharges` VALUES ('55', '17000002', 'R150399679750559884', '0', '1000.00', null, '0', '0', '17000002', '2017-08-29 16:53:18', '17000002', '2017-08-29 16:53:18', '0');
INSERT INTO `t_recharges` VALUES ('56', '17000001', 'R150399711079148113', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 16:58:31', '17000001', '2017-08-29 16:58:31', '0');
INSERT INTO `t_recharges` VALUES ('57', '17000001', 'R150399730675938242', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:01:47', '17000001', '2017-08-29 17:01:47', '0');
INSERT INTO `t_recharges` VALUES ('58', '17000001', 'R150399748473768850', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:04:45', '17000001', '2017-08-29 17:04:45', '0');
INSERT INTO `t_recharges` VALUES ('59', '17000001', 'R150399751968184468', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:05:20', '17000001', '2017-08-29 17:05:20', '0');
INSERT INTO `t_recharges` VALUES ('60', '17000001', 'R150399756619354002', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:06:06', '17000001', '2017-08-29 17:06:06', '0');
INSERT INTO `t_recharges` VALUES ('61', '17000005', 'R150399766906356543', '0', '10.00', null, '0', '0', '17000005', '2017-08-29 17:07:49', '17000005', '2017-08-29 17:07:49', '0');
INSERT INTO `t_recharges` VALUES ('62', '17000005', 'R150399772834824960', '0', '10.00', null, '0', '0', '17000005', '2017-08-29 17:08:48', '17000005', '2017-08-29 17:08:48', '0');
INSERT INTO `t_recharges` VALUES ('63', '17000007', 'R150399801483367380', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:13:35', '17000007', '2017-08-29 17:13:35', '0');
INSERT INTO `t_recharges` VALUES ('64', '17000005', 'R150399808842945875', '0', '10.00', null, '0', '0', '17000005', '2017-08-29 17:14:48', '17000005', '2017-08-29 17:14:48', '0');
INSERT INTO `t_recharges` VALUES ('65', '17000007', 'R150399809457410109', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:14:55', '17000007', '2017-08-29 17:14:55', '0');
INSERT INTO `t_recharges` VALUES ('66', '17000007', 'R150399815145769346', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:15:51', '17000007', '2017-08-29 17:15:51', '0');
INSERT INTO `t_recharges` VALUES ('67', '17000007', 'R150399822008031606', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:17:00', '17000007', '2017-08-29 17:17:00', '0');
INSERT INTO `t_recharges` VALUES ('68', '17000007', 'R150399825787447385', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:17:38', '17000007', '2017-08-29 17:17:38', '0');
INSERT INTO `t_recharges` VALUES ('69', '17000007', 'R150399830057951674', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:18:21', '17000007', '2017-08-29 17:18:21', '0');
INSERT INTO `t_recharges` VALUES ('70', '17000007', 'R150399833341181453', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:18:53', '17000007', '2017-08-29 17:18:53', '0');
INSERT INTO `t_recharges` VALUES ('71', '17000007', 'R150399835665926108', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:19:17', '17000007', '2017-08-29 17:19:17', '0');
INSERT INTO `t_recharges` VALUES ('72', '17000007', 'R150399837318614669', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:19:33', '17000007', '2017-08-29 17:19:33', '0');
INSERT INTO `t_recharges` VALUES ('73', '17000007', 'R150399839046476270', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:19:50', '17000007', '2017-08-29 17:19:50', '0');
INSERT INTO `t_recharges` VALUES ('74', '17000007', 'R150399853418685181', '0', '500.00', null, '0', '0', '17000007', '2017-08-29 17:22:14', '17000007', '2017-08-29 17:22:14', '0');
INSERT INTO `t_recharges` VALUES ('75', '17000007', 'R150399860887236259', '0', '500.00', null, '0', '0', '17000007', '2017-08-29 17:23:29', '17000007', '2017-08-29 17:23:29', '0');
INSERT INTO `t_recharges` VALUES ('76', '17000007', 'R150399938213455099', '0', '1000.00', null, '0', '0', '17000007', '2017-08-29 17:36:22', '17000007', '2017-08-29 17:36:22', '0');
INSERT INTO `t_recharges` VALUES ('77', '17000007', 'R150399941936078882', '0', '10.00', null, '0', '0', '17000007', '2017-08-29 17:36:59', '17000007', '2017-08-29 17:36:59', '0');
INSERT INTO `t_recharges` VALUES ('78', '17000001', 'R150399944414370725', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:37:24', '17000001', '2017-08-29 17:37:24', '0');
INSERT INTO `t_recharges` VALUES ('79', '17000001', 'R150399946707259002', '0', '10.00', null, '0', '0', '17000001', '2017-08-29 17:37:47', '17000001', '2017-08-29 17:37:47', '0');
INSERT INTO `t_recharges` VALUES ('80', '17000007', 'R150400149791621326', '0', '1.00', null, '0', '0', '17000007', '2017-08-29 18:11:38', '17000007', '2017-08-29 18:11:38', '0');
INSERT INTO `t_recharges` VALUES ('81', '17000007', 'R150400181264257854', '0', '1.00', null, '0', '0', '17000007', '2017-08-29 18:16:53', '17000007', '2017-08-29 18:16:53', '0');
INSERT INTO `t_recharges` VALUES ('82', '17000007', 'R150400194691267741', '0', '1.00', null, '0', '0', '17000007', '2017-08-29 18:19:07', '17000007', '2017-08-29 18:19:07', '0');
INSERT INTO `t_recharges` VALUES ('83', '17000002', 'R150401591896357635', '0', '1.00', null, '0', '0', '17000002', '2017-08-29 22:11:59', '17000002', '2017-08-29 22:11:59', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('1', '17000001', '1', '0', '10.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '1', '2017-08-29 20:58:14', '1', '2017-08-29 20:58:14', '0');
INSERT INTO `t_user_account` VALUES ('2', '17000002', '0', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000002', '2017-08-28 18:35:12', '17000002', '2017-08-28 18:36:39', '0');

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
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `is_notification` int(11) DEFAULT '0' COMMENT '0-未通知，1-已通知',
  PRIMARY KEY (`trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户交易明细';

-- ----------------------------
-- Records of t_user_account_detail
-- ----------------------------
INSERT INTO `t_user_account_detail` VALUES ('1', '1', '17000001', '1', '1', '0.00', '1', '0.00', '0', '2', '1', '1', '2017-08-28 18:30:14', '1', '2017-08-28 18:30:14', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('2', '1', '17000001', '1', '2', '0.00', null, '0.00', '1', '2', '1', '1', '2017-08-28 18:30:12', '1', '2017-08-28 18:30:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('3', '1', '17000001', '1', '2', '0.00', null, '0.00', '2', '2', '1', '1', '2017-08-26 18:02:22', '1', '2017-08-26 18:02:22', '0', '1');
INSERT INTO `t_user_account_detail` VALUES ('4', '1', '17000001', '1', '2', '0.00', null, '0.00', '2', '0', '1', '1', '2017-08-26 18:02:24', null, '2017-08-26 18:02:24', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('5', '1', '17000001', '1', '2', '0.00', null, '0.00', '2', '1', '1', '1', '2017-08-26 18:02:26', null, '2017-08-26 18:02:26', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('6', '1', '17000001', 'W150389926369649233', '-1', '0.00', null, '0.00', '1', '0', '0', '17000001', '0000-00-00 00:00:00', '17000001', '2017-08-28 13:47:44', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('7', '2', '17000002', 'W150391651175583208', '-1', '0.00', null, '0.00', '50', '0', '0', '17000002', '0000-00-00 00:00:00', '17000002', '2017-08-28 18:35:12', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('8', '2', '17000002', 'W150391659834841015', '-1', '0.00', null, '0.00', '50', '0', '0', '17000002', '0000-00-00 00:00:00', '17000002', '2017-08-28 18:36:38', '0', '0');
INSERT INTO `t_user_account_detail` VALUES ('9', '2', '17000002', 'W150391659863113193', '-1', '0.00', null, '0.00', '50', '0', '0', '17000002', '0000-00-00 00:00:00', '17000002', '2017-08-28 18:36:39', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户绑定卡片';

-- ----------------------------
-- Records of t_user_cards
-- ----------------------------
INSERT INTO `t_user_cards` VALUES ('1', '17000001', '62228938489555552312', '城西支行', '2', '0', '0', '2017-08-25 15:52:52', '1', '2017-08-25 15:52:52', '0', 'Damon 风');
INSERT INTO `t_user_cards` VALUES ('2', '17000004', '52121212321324324325', '杭州分行', '3', '0', '0', '0000-00-00 00:00:00', '0', null, '0', '阳光测试');
INSERT INTO `t_user_cards` VALUES ('3', '17000002', '3423423423423', '城西支行', '1', '0', '0', '0000-00-00 00:00:00', '0', null, '0', 'Damon 风');
INSERT INTO `t_user_cards` VALUES ('4', '17000007', '332533623365332', '交通银行杭州分行中山支行', '25', '0', '0', '0000-00-00 00:00:00', '0', null, '0', '吴胡子');
INSERT INTO `t_user_cards` VALUES ('5', '17000005', '62284866688866', '城西支行', '18', '0', '0', '0000-00-00 00:00:00', '0', null, '0', 'Damon');

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
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  `bg_login_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qq` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17000009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', null, '2', '0', '1', null, 'http://img.jsqq.net/uploads/allimg/150111/1_150111080328_19.jpg', '2017-08-29 18:11:49', '0', null, null, null, '1', '1', '2017-08-29 18:11:49', '1', '2017-08-29 18:11:49', '0', null, '2');
INSERT INTO `t_users` VALUES ('2', 'yunying', '123456', '系统运营账户', null, '2', '0', '2', null, 'http://img.jsqq.net/uploads/allimg/150111/1_150111080328_19.jpg', '2017-08-25 19:56:01', '0', null, null, null, '1', '1', '2017-08-25 19:56:01', '1', '2017-08-25 19:56:01', '0', null, '2');
INSERT INTO `t_users` VALUES ('3', 'KF001', '123456', '业务员001', null, '2', '0', '3', null, null, '2017-08-28 17:28:19', '0', null, null, null, '1', '1', '2017-08-28 17:28:19', '1', '2017-08-28 17:28:19', '0', null, '1977704195');
INSERT INTO `t_users` VALUES ('4', 'KF002', '123456', '业务员002', null, '2', '0', '3', null, null, '2017-08-28 17:28:19', '0', null, null, null, '1', '1', '2017-08-28 17:28:19', '1', '2017-08-28 17:28:19', '0', null, '1977704195');
INSERT INTO `t_users` VALUES ('17000001', '15901794296', '423350', '阳光大佬', '15901794296', '-1', '1', '0', '4', '2017082902360680508763.jpeg', '2017-08-29 20:58:03', '0', '1', '20361890', 'n', '3', '0', '2017-08-29 20:58:03', '17000001', '2017-08-29 20:58:03', '0', '17000001_760e07b3-6075-4ad4-b13b-183230becda5', '9');
INSERT INTO `t_users` VALUES ('17000002', '18550473963', '242700', 'Damon 风', '18550473963', '-1', '1', '0', '3', '2017082611083122104027.jpeg', '2017-08-29 22:11:30', '0', '1', '20533559', 'n', '14', '0', '2017-08-25 19:56:08', '17000002', '2017-08-29 22:11:30', '0', '17000002_9c0333b4-35cd-40a5-9e58-d55989788c1d', '11');
INSERT INTO `t_users` VALUES ('17000003', '18058159956', '646398', '18058159956', '18058159956', '-1', '1', '0', '3', null, '2017-08-28 18:52:19', '0', '1', '20575939', 'n', '1', '0', '2017-08-25 19:56:10', '17000003', '2017-08-28 18:52:19', '0', '17000003_a5eace0e-0280-439a-a159-d60ef6aaf602', '10');
INSERT INTO `t_users` VALUES ('17000004', '18321755892', '210281', '18321755892', '18321755892', '-1', '1', '0', null, null, '2017-08-26 18:13:56', '0', '1', '20695319', 'n', '0', '0', '2017-08-26 17:48:20', '17000004', '2017-08-26 18:13:56', '0', 'XH002589217000004', null);
INSERT INTO `t_users` VALUES ('17000005', '18050473963', '464782', '18050473963', '18050473963', '-1', '1', '0', '3', null, '2017-08-29 14:13:09', '0', '1', '20819946', 'n', '1', '0', '2017-08-29 14:13:09', '0', '2017-08-29 14:13:09', '0', 'XH002396317000005', null);
INSERT INTO `t_users` VALUES ('17000007', '18668223750', '584576', '胡子侠', '18668223750', '-1', '1', '0', '4', '2017082903460476309467.jpeg', '2017-08-29 19:15:21', '0', '1', '20820787', 'n', '6', '0', '2017-08-29 15:01:07', '17000007', '2017-08-29 19:15:21', '0', 'XH002375017000007', null);
INSERT INTO `t_users` VALUES ('17000008', 'asda', '49f0bad299687c62334182178bfd75d8', null, null, '2', '0', '1', null, null, '2017-08-29 20:03:09', '0', null, null, null, '1', '1', '2017-08-29 20:03:09', null, '2017-08-29 20:03:09', '0', null, 'asda');
