/*
Navicat MySQL Data Transfer

Source Server         : agdress
Source Server Version : 50637
Source Host           : 192.168.1.43:3306
Source Database       : agdress

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-10-16 17:06:56
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
INSERT INTO `m_modules` VALUES ('43', '消息查询', '1', null, '42', '1', 'search', null, '0', '1', '1');
INSERT INTO `m_modules` VALUES ('44', '消息更新', '1', null, '42', '1', 'update', null, '0', '1', '1');
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
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限';

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
INSERT INTO `m_role_modules` VALUES ('299', '1', '46');

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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

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
INSERT INTO `t_audit_logs` VALUES ('56', '14', '1', '1', '出金审核通过', '1', '4', '2017-10-10 15:19:25', '4', '2017-10-10 15:19:25', '0');
INSERT INTO `t_audit_logs` VALUES ('57', '12', '1', '1', '出金审核通过', '1', '4', '2017-10-10 15:21:02', '4', '2017-10-10 15:21:02', '0');
INSERT INTO `t_audit_logs` VALUES ('58', '13', '1', '1', '出金审核通过', '1', '4', '2017-10-10 15:22:56', '4', '2017-10-10 15:22:56', '0');
INSERT INTO `t_audit_logs` VALUES ('59', '15', '1', '1', '测试不通过', '1', '4', '2017-10-12 16:42:01', '4', '2017-10-12 16:42:01', '0');
INSERT INTO `t_audit_logs` VALUES ('60', '12', '1', '1', '测试不通过', '1', '4', '2017-10-12 16:42:12', '4', '2017-10-12 16:42:12', '0');
INSERT INTO `t_audit_logs` VALUES ('61', '11', '1', '1', '出金审核通过', '1', '4', '2017-10-12 16:46:03', '4', '2017-10-12 16:46:03', '0');

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
INSERT INTO `t_audit_template_step` VALUES ('1', '1', '1', '3', '1', '1', '2017-09-22 11:01:17', '1', '2017-09-22 11:01:17', '0');
INSERT INTO `t_audit_template_step` VALUES ('2', '1', '2', '4', '1', '1', '2017-09-22 11:01:19', '1', '2017-09-22 11:01:19', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('1', '50', 'fa fa-user text-red', '28', '1', '1', '2017-09-28 10:24:53', '1', '2017-09-28 10:24:53', '0');
INSERT INTO `t_message` VALUES ('2', '50', 'fa fa-user text-red', '15', '1', '1', '2017-09-28 10:25:14', null, '2017-09-28 10:25:14', '0');
INSERT INTO `t_message` VALUES ('3', '50', 'fa fa-user text-red', '10', '1', '1', '2017-09-28 10:25:34', null, '2017-09-28 10:25:34', '0');
INSERT INTO `t_message` VALUES ('4', '50', 'fa fa-user text-red', '11', '1', '1', '2017-09-28 10:25:35', null, '2017-09-28 10:25:35', '0');
INSERT INTO `t_message` VALUES ('5', '10', 'fa fa-user text-red', '187', '1', '1', '2017-09-28 18:06:37', null, '2017-09-28 18:06:37', '0');
INSERT INTO `t_message` VALUES ('6', '10', 'fa fa-user text-red', '188', '1', '1', '2017-09-29 12:04:33', null, '2017-09-29 12:04:33', '0');
INSERT INTO `t_message` VALUES ('7', '10', 'fa fa-user text-red', '189', '1', '4', '2017-09-29 13:30:30', null, '2017-09-29 13:30:30', '0');
INSERT INTO `t_message` VALUES ('8', '10', 'fa fa-users text-aqua', '190', '1', '4', '2017-09-30 17:19:10', null, '2017-09-30 17:19:10', '0');
INSERT INTO `t_message` VALUES ('9', '10', 'fa fa-users text-aqua', '191', '1', '1', '2017-10-09 11:45:43', null, '2017-10-09 11:45:43', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_content
-- ----------------------------
INSERT INTO `t_message_content` VALUES ('1', '28', '3', '4', '你 有 一 笔 订 单 (W150450675145482207) 待审 核', '1', '2', '1', '2017-10-10 15:18:34', '4', '2017-10-10 15:18:34', '0');
INSERT INTO `t_message_content` VALUES ('2', '15', '3', '4', '你有一笔订单（R150407330550765201）待审核', '1', '3', '1', '2017-10-10 15:18:35', '4', '2017-10-12 16:42:01', '0');
INSERT INTO `t_message_content` VALUES ('3', '10', '3', '4', '你有一笔订单（R150407330550765201）待审核', '1', '4', '1', '2017-10-10 15:18:37', '4', '2017-10-10 15:18:37', '0');
INSERT INTO `t_message_content` VALUES ('4', '11', '3', '4', '你有一笔订单（R150407330550765201）待审核', '1', '10', '1', '2017-10-10 15:18:37', '4', '2017-10-12 16:46:03', '0');
INSERT INTO `t_message_content` VALUES ('5', '28', '3', '4', '你有一笔订单（W150450675145482207）待审核。', '1', '1', '4', '2017-10-10 15:18:31', null, '2017-10-10 15:18:31', '0');
INSERT INTO `t_message_content` VALUES ('27', '28', '4', null, '你有一笔新的提现审核，编号：W150450675145482207。', '0', '1', '4', '2017-10-10 11:36:04', '4', '2017-10-10 11:36:04', '0');
INSERT INTO `t_message_content` VALUES ('28', '190', '1', '1', '阳光大佬2]充值了111.0元，订单编号：R150676314947856715。', '1', '1', '4', '2017-10-10 12:26:39', null, '2017-10-10 12:26:39', '0');
INSERT INTO `t_message_content` VALUES ('29', '10', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-10 11:36:05', '4', '2017-10-10 11:36:05', '0');
INSERT INTO `t_message_content` VALUES ('30', '15', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-10 11:36:05', '4', '2017-10-10 11:36:05', '0');
INSERT INTO `t_message_content` VALUES ('31', '191', '1', '1', '阳光大佬2 ]充值了111.0元，订单编号：R150752074327839455。', '1', '1', '1', '2017-10-10 12:26:42', null, '2017-10-10 12:26:42', '0');
INSERT INTO `t_message_content` VALUES ('32', '14', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-10 15:19:25', '4', '2017-10-10 15:19:25', '0');
INSERT INTO `t_message_content` VALUES ('33', '12', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-10 15:21:02', '4', '2017-10-10 15:21:02', '0');
INSERT INTO `t_message_content` VALUES ('34', '13', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-10 15:21:47', '4', '2017-10-10 15:21:47', '0');
INSERT INTO `t_message_content` VALUES ('35', '11', '4', null, '你有一笔新的提现审核，编号：R150407330550765201。', '0', '1', '4', '2017-10-12 16:46:03', '4', '2017-10-12 16:46:03', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `t_payment_records` VALUES ('143', '0', '0', 'R150407318355373813', '1.00', '1', null, null, null, '0', '17000001', '2017-08-30 14:06:24', '17000001', '2017-08-30 14:06:24', '0');
INSERT INTO `t_payment_records` VALUES ('144', '0', '0', 'R150407318701321506', '1.00', '1', null, null, null, '0', '17000001', '2017-08-30 14:06:27', '17000001', '2017-08-30 14:06:27', '0');
INSERT INTO `t_payment_records` VALUES ('145', '0', '0', 'R150407324445273025', '1.00', '1', null, null, null, '0', '17000001', '2017-08-30 14:07:24', '17000001', '2017-08-30 14:07:24', '0');
INSERT INTO `t_payment_records` VALUES ('146', '0', '0', 'R150407330550765201', '1.00', '1', null, null, null, '0', '17000001', '2017-08-30 14:08:26', '17000001', '2017-08-30 14:08:26', '0');
INSERT INTO `t_payment_records` VALUES ('147', '0', '0', 'R150415557010634556', '10.00', '1', null, null, null, '0', '17000002', '2017-08-31 12:59:30', '17000002', '2017-08-31 12:59:30', '0');
INSERT INTO `t_payment_records` VALUES ('148', '0', '0', 'R150415557544596656', '10.00', '1', null, null, null, '0', '17000002', '2017-08-31 12:59:35', '17000002', '2017-08-31 12:59:35', '0');
INSERT INTO `t_payment_records` VALUES ('149', '0', '0', 'R150415558891951587', '10.00', '1', null, null, null, '0', '17000002', '2017-08-31 12:59:49', '17000002', '2017-08-31 12:59:49', '0');
INSERT INTO `t_payment_records` VALUES ('150', '0', '0', 'R150415565426182555', '10.00', '1', null, null, null, '0', '17000002', '2017-08-31 13:00:54', '17000002', '2017-08-31 13:00:54', '0');
INSERT INTO `t_payment_records` VALUES ('151', '0', '0', 'R150415567572439886', '10.00', '1', null, null, null, '0', '17000002', '2017-08-31 13:01:16', '17000002', '2017-08-31 13:01:16', '0');
INSERT INTO `t_payment_records` VALUES ('152', '0', '0', 'R150426618919486153', '10.00', '1', null, null, null, '1', '17000003', '2017-09-01 19:43:09', '17000003', '2017-09-01 19:43:09', '0');
INSERT INTO `t_payment_records` VALUES ('153', '0', '0', 'R150426620193741171', '10.00', '1', null, null, null, '1', '17000003', '2017-09-01 19:43:22', '17000003', '2017-09-01 19:43:22', '0');
INSERT INTO `t_payment_records` VALUES ('154', '17000002', '0', 'R150459942377870751', '30.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:17:04', '17000002', '2017-09-05 16:17:04', '0');
INSERT INTO `t_payment_records` VALUES ('155', '17000002', '0', 'R150459945953551109', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:17:40', '17000002', '2017-09-05 16:17:40', '0');
INSERT INTO `t_payment_records` VALUES ('156', '17000002', '0', 'R150459957003524269', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:19:30', '17000002', '2017-09-05 16:19:30', '0');
INSERT INTO `t_payment_records` VALUES ('157', '17000002', '0', 'R150459992311058387', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:25:23', '17000002', '2017-09-05 16:25:23', '0');
INSERT INTO `t_payment_records` VALUES ('158', '17000002', '0', 'R150460010812656025', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:28:28', '17000002', '2017-09-05 16:28:28', '0');
INSERT INTO `t_payment_records` VALUES ('159', '17000002', '0', 'R150460021640413572', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:30:16', '17000002', '2017-09-05 16:30:16', '0');
INSERT INTO `t_payment_records` VALUES ('160', '17000002', '0', 'R150460025437717796', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:30:54', '17000002', '2017-09-05 16:30:54', '0');
INSERT INTO `t_payment_records` VALUES ('161', '17000002', '0', 'R150460028093788170', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:31:21', '17000002', '2017-09-05 16:31:21', '0');
INSERT INTO `t_payment_records` VALUES ('162', '17000002', '0', 'R150460033538420738', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:32:15', '17000002', '2017-09-05 16:32:15', '0');
INSERT INTO `t_payment_records` VALUES ('163', '17000002', '0', 'R150460033752325761', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_payment_records` VALUES ('164', '17000002', '0', 'R150460033799647011', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_payment_records` VALUES ('165', '17000002', '0', 'R150460037392322089', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:32:54', '17000002', '2017-09-05 16:32:54', '0');
INSERT INTO `t_payment_records` VALUES ('166', '17000002', '0', 'R150460051681562701', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:35:17', '17000002', '2017-09-05 16:35:17', '0');
INSERT INTO `t_payment_records` VALUES ('167', '17000002', '0', 'R150460053498329950', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:35:35', '17000002', '2017-09-05 16:35:35', '0');
INSERT INTO `t_payment_records` VALUES ('168', '17000002', '0', 'R150460064898661837', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:37:29', '17000002', '2017-09-05 16:37:29', '0');
INSERT INTO `t_payment_records` VALUES ('169', '17000002', '0', 'R150460065472217906', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_payment_records` VALUES ('170', '17000002', '0', 'R150460065488526942', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_payment_records` VALUES ('171', '17000002', '0', 'R150460067761038791', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:37:58', '17000002', '2017-09-05 16:37:58', '0');
INSERT INTO `t_payment_records` VALUES ('172', '17000002', '0', 'R150460073214426285', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:38:52', '17000002', '2017-09-05 16:38:52', '0');
INSERT INTO `t_payment_records` VALUES ('173', '17000002', '0', 'R150460073294520038', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_payment_records` VALUES ('174', '17000002', '0', 'R150460073316232700', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_payment_records` VALUES ('175', '17000002', '0', 'R150460074223070559', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:39:02', '17000002', '2017-09-05 16:39:02', '0');
INSERT INTO `t_payment_records` VALUES ('176', '17000002', '0', 'R150460101266484137', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:43:33', '17000002', '2017-09-05 16:43:33', '0');
INSERT INTO `t_payment_records` VALUES ('177', '17000002', '0', 'R150460107085236490', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payment_records` VALUES ('178', '17000002', '0', 'R150460107106183582', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payment_records` VALUES ('179', '17000002', '0', 'R150460107122511936', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payment_records` VALUES ('180', '17000002', '0', 'R150460107140193255', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payment_records` VALUES ('181', '17000002', '0', 'R150460107156939536', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:32', '17000002', '2017-09-05 16:44:32', '0');
INSERT INTO `t_payment_records` VALUES ('182', '17000002', '0', 'R150460107321155489', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:33', '17000002', '2017-09-05 16:44:33', '0');
INSERT INTO `t_payment_records` VALUES ('183', '17000002', '0', 'R150460109720651730', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:44:57', '17000002', '2017-09-05 16:44:57', '0');
INSERT INTO `t_payment_records` VALUES ('184', '17000002', '0', 'R150460110238933109', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:45:02', '17000002', '2017-09-05 16:45:02', '0');
INSERT INTO `t_payment_records` VALUES ('185', '17000002', '0', 'R150460147996260674', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:51:20', '17000002', '2017-09-05 16:51:20', '0');
INSERT INTO `t_payment_records` VALUES ('186', '17000002', '0', 'R150460156158260175', '500.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:52:42', '17000002', '2017-09-05 16:52:42', '0');
INSERT INTO `t_payment_records` VALUES ('187', '17000002', '0', 'R150460169594536315', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:54:56', '17000002', '2017-09-05 16:54:56', '0');
INSERT INTO `t_payment_records` VALUES ('188', '17000002', '0', 'R150460177738154457', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:56:17', '17000002', '2017-09-05 16:56:17', '0');
INSERT INTO `t_payment_records` VALUES ('189', '17000002', '0', 'R150460177777255129', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:56:18', '17000002', '2017-09-05 16:56:18', '0');
INSERT INTO `t_payment_records` VALUES ('190', '17000002', '0', 'R150460178916051656', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:56:29', '17000002', '2017-09-05 16:56:29', '0');
INSERT INTO `t_payment_records` VALUES ('191', '17000002', '0', 'R150460179330816727', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 16:56:33', '17000002', '2017-09-05 16:56:33', '0');
INSERT INTO `t_payment_records` VALUES ('192', '17000002', '0', 'R150460213116255205', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:02:11', '17000002', '2017-09-05 17:02:11', '0');
INSERT INTO `t_payment_records` VALUES ('193', '17000002', '0', 'R150460216332765538', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:02:43', '17000002', '2017-09-05 17:02:43', '0');
INSERT INTO `t_payment_records` VALUES ('194', '17000002', '0', 'R150460217761159362', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:02:58', '17000002', '2017-09-05 17:02:58', '0');
INSERT INTO `t_payment_records` VALUES ('195', '17000002', '0', 'R150460222164545184', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:03:42', '17000002', '2017-09-05 17:03:42', '0');
INSERT INTO `t_payment_records` VALUES ('196', '17000002', '0', 'R150460241609623496', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:06:56', '17000002', '2017-09-05 17:06:56', '0');
INSERT INTO `t_payment_records` VALUES ('197', '17000002', '0', 'R150460278303744002', '500.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:13:03', '17000002', '2017-09-05 17:13:03', '0');
INSERT INTO `t_payment_records` VALUES ('198', '17000002', '0', 'R150460294497933844', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:15:45', '17000002', '2017-09-05 17:15:45', '0');
INSERT INTO `t_payment_records` VALUES ('199', '17000002', '0', 'R150460304974188412', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:17:30', '17000002', '2017-09-05 17:17:30', '0');
INSERT INTO `t_payment_records` VALUES ('200', '17000002', '0', 'R150460330857835719', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:21:49', '17000002', '2017-09-05 17:21:49', '0');
INSERT INTO `t_payment_records` VALUES ('201', '17000002', '0', 'R150460352132043020', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:25:21', '17000002', '2017-09-05 17:25:21', '0');
INSERT INTO `t_payment_records` VALUES ('202', '17000002', '0', 'R150460417720055340', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 17:36:17', '17000002', '2017-09-05 17:36:17', '0');
INSERT INTO `t_payment_records` VALUES ('203', '17000002', '0', 'R150461215563811015', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 19:49:16', '17000002', '2017-09-05 19:49:16', '0');
INSERT INTO `t_payment_records` VALUES ('204', '17000002', '0', 'R150461267731257575', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 19:57:57', '17000002', '2017-09-05 19:57:57', '0');
INSERT INTO `t_payment_records` VALUES ('205', '17000002', '0', 'R150461357307193115', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:12:53', '17000002', '2017-09-05 20:12:53', '0');
INSERT INTO `t_payment_records` VALUES ('206', '17000002', '0', 'R150461491657179950', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:35:17', '17000002', '2017-09-05 20:35:17', '0');
INSERT INTO `t_payment_records` VALUES ('207', '17000002', '0', 'R150461493040635194', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:35:30', '17000002', '2017-09-05 20:35:30', '0');
INSERT INTO `t_payment_records` VALUES ('208', '17000002', '0', 'R150461493695181556', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:35:37', '17000002', '2017-09-05 20:35:37', '0');
INSERT INTO `t_payment_records` VALUES ('209', '17000002', '0', 'R150461506386786260', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:37:44', '17000002', '2017-09-05 20:37:44', '0');
INSERT INTO `t_payment_records` VALUES ('210', '17000002', '0', 'R150461506923489056', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:37:49', '17000002', '2017-09-05 20:37:49', '0');
INSERT INTO `t_payment_records` VALUES ('211', '17000002', '0', 'R150461517424420157', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:39:34', '17000002', '2017-09-05 20:39:34', '0');
INSERT INTO `t_payment_records` VALUES ('212', '17000002', '0', 'R150461524572942174', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:40:46', '17000002', '2017-09-05 20:40:46', '0');
INSERT INTO `t_payment_records` VALUES ('213', '17000002', '0', 'R150461525367283245', '1000.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:40:54', '17000002', '2017-09-05 20:40:54', '0');
INSERT INTO `t_payment_records` VALUES ('214', '17000002', '0', 'R150461534348062528', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:42:23', '17000002', '2017-09-05 20:42:23', '0');
INSERT INTO `t_payment_records` VALUES ('215', '17000002', '0', 'R150461540960037091', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:43:30', '17000002', '2017-09-05 20:43:30', '0');
INSERT INTO `t_payment_records` VALUES ('216', '17000002', '0', 'R150461542863952421', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:43:49', '17000002', '2017-09-05 20:43:49', '0');
INSERT INTO `t_payment_records` VALUES ('217', '17000002', '0', 'R150461543372529835', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:43:54', '17000002', '2017-09-05 20:43:54', '0');
INSERT INTO `t_payment_records` VALUES ('218', '17000002', '0', 'R150461547171887650', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:44:32', '17000002', '2017-09-05 20:44:32', '0');
INSERT INTO `t_payment_records` VALUES ('219', '17000002', '0', 'R150461560712746082', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:46:47', '17000002', '2017-09-05 20:46:47', '0');
INSERT INTO `t_payment_records` VALUES ('220', '17000002', '0', 'R150461566987475828', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:47:50', '17000002', '2017-09-05 20:47:50', '0');
INSERT INTO `t_payment_records` VALUES ('221', '17000002', '0', 'R150461573546286224', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:48:55', '17000002', '2017-09-05 20:48:55', '0');
INSERT INTO `t_payment_records` VALUES ('222', '17000002', '0', 'R150461585058820448', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 20:50:51', '17000002', '2017-09-05 20:50:51', '0');
INSERT INTO `t_payment_records` VALUES ('223', '17000002', '0', 'R150461738339619295', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:16:23', '17000002', '2017-09-05 21:16:23', '0');
INSERT INTO `t_payment_records` VALUES ('224', '17000002', '0', 'R150461775153119394', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:22:32', '17000002', '2017-09-05 21:22:32', '0');
INSERT INTO `t_payment_records` VALUES ('225', '17000002', '0', 'R150461831675824378', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:31:57', '17000002', '2017-09-05 21:31:57', '0');
INSERT INTO `t_payment_records` VALUES ('226', '17000002', '0', 'R150461874757483596', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:39:08', '17000002', '2017-09-05 21:39:08', '0');
INSERT INTO `t_payment_records` VALUES ('227', '17000002', '0', 'R150461877823254141', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:39:38', '17000002', '2017-09-05 21:39:38', '0');
INSERT INTO `t_payment_records` VALUES ('228', '17000002', '0', 'R150461884557327556', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:40:46', '17000002', '2017-09-05 21:40:46', '0');
INSERT INTO `t_payment_records` VALUES ('229', '17000002', '0', 'R150461898609879467', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:43:06', '17000002', '2017-09-05 21:43:06', '0');
INSERT INTO `t_payment_records` VALUES ('230', '17000002', '0', 'R150461902004343910', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:43:40', '17000002', '2017-09-05 21:43:40', '0');
INSERT INTO `t_payment_records` VALUES ('231', '17000002', '0', 'R150461902515984320', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:43:45', '17000002', '2017-09-05 21:43:45', '0');
INSERT INTO `t_payment_records` VALUES ('232', '17000002', '0', 'R150461927029373972', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:47:50', '17000002', '2017-09-05 21:47:50', '0');
INSERT INTO `t_payment_records` VALUES ('233', '17000002', '0', 'R150461962316843438', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:53:43', '17000002', '2017-09-05 21:53:43', '0');
INSERT INTO `t_payment_records` VALUES ('234', '17000002', '0', 'R150461965385339518', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:54:14', '17000002', '2017-09-05 21:54:14', '0');
INSERT INTO `t_payment_records` VALUES ('235', '17000002', '0', 'R150461972221761319', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:55:22', '17000002', '2017-09-05 21:55:22', '0');
INSERT INTO `t_payment_records` VALUES ('236', '17000002', '0', 'R150461983132775008', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:57:11', '17000002', '2017-09-05 21:57:11', '0');
INSERT INTO `t_payment_records` VALUES ('237', '17000002', '0', 'R150461985994843995', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:57:40', '17000002', '2017-09-05 21:57:40', '0');
INSERT INTO `t_payment_records` VALUES ('238', '17000002', '0', 'R150461988997543047', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:58:10', '17000002', '2017-09-05 21:58:10', '0');
INSERT INTO `t_payment_records` VALUES ('239', '17000002', '0', 'R150461990042882452', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 21:58:20', '17000002', '2017-09-05 21:58:20', '0');
INSERT INTO `t_payment_records` VALUES ('240', '17000002', '0', 'R150462000310063873', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:00:03', '17000002', '2017-09-05 22:00:03', '0');
INSERT INTO `t_payment_records` VALUES ('241', '17000002', '0', 'R150462003572570613', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:00:36', '17000002', '2017-09-05 22:00:36', '0');
INSERT INTO `t_payment_records` VALUES ('242', '17000002', '0', 'R150462022394288431', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:03:44', '17000002', '2017-09-05 22:03:44', '0');
INSERT INTO `t_payment_records` VALUES ('243', '17000002', '0', 'R150462027295582935', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:04:33', '17000002', '2017-09-05 22:04:33', '0');
INSERT INTO `t_payment_records` VALUES ('244', '17000002', '0', 'R150462030125167179', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:05:01', '17000002', '2017-09-05 22:05:01', '0');
INSERT INTO `t_payment_records` VALUES ('245', '17000002', '0', 'R150462033803144948', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:05:38', '17000002', '2017-09-05 22:05:38', '0');
INSERT INTO `t_payment_records` VALUES ('246', '17000002', '0', 'R150462034353334755', '1.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:05:44', '17000002', '2017-09-05 22:05:44', '0');
INSERT INTO `t_payment_records` VALUES ('247', '17000002', '0', 'R150462117963122460', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:19:40', '17000002', '2017-09-05 22:19:40', '0');
INSERT INTO `t_payment_records` VALUES ('248', '17000002', '0', 'R150462166618616195', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:27:46', '17000002', '2017-09-05 22:27:46', '0');
INSERT INTO `t_payment_records` VALUES ('249', '17000002', '0', 'R150462177509991291', '10.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:29:35', '17000002', '2017-09-05 22:29:35', '0');
INSERT INTO `t_payment_records` VALUES ('250', '17000002', '0', 'R150462225003289003', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:37:30', '17000002', '2017-09-05 22:37:30', '0');
INSERT INTO `t_payment_records` VALUES ('251', '17000002', '0', 'R150462230026473798', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:38:20', '17000002', '2017-09-05 22:38:20', '0');
INSERT INTO `t_payment_records` VALUES ('252', '17000002', '0', 'R150462282666328459', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:47:07', '17000002', '2017-09-05 22:47:07', '0');
INSERT INTO `t_payment_records` VALUES ('253', '17000002', '0', 'R150462353859762359', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:58:59', '17000002', '2017-09-05 22:58:59', '0');
INSERT INTO `t_payment_records` VALUES ('254', '17000002', '0', 'R150462355298850551', '50.00', '1', null, null, null, '1', '17000002', '2017-09-05 22:59:13', '17000002', '2017-09-05 22:59:13', '0');
INSERT INTO `t_payment_records` VALUES ('255', '17000002', '0', 'R150463084234644376', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:00:42', '17000002', '2017-09-06 01:00:42', '0');
INSERT INTO `t_payment_records` VALUES ('256', '17000002', '0', 'R150463085870328271', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:00:59', '17000002', '2017-09-06 01:00:59', '0');
INSERT INTO `t_payment_records` VALUES ('257', '17000002', '0', 'R150463086074731164', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_payment_records` VALUES ('258', '17000002', '0', 'R150463086141856391', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_payment_records` VALUES ('259', '17000002', '0', 'R150463086394581755', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:04', '17000002', '2017-09-06 01:01:04', '0');
INSERT INTO `t_payment_records` VALUES ('260', '17000002', '0', 'R150463086748256536', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:08', '17000002', '2017-09-06 01:01:08', '0');
INSERT INTO `t_payment_records` VALUES ('261', '17000002', '0', 'R150463089988276706', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:40', '17000002', '2017-09-06 01:01:40', '0');
INSERT INTO `t_payment_records` VALUES ('262', '17000002', '0', 'R150463091547086276', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:55', '17000002', '2017-09-06 01:01:55', '0');
INSERT INTO `t_payment_records` VALUES ('263', '17000002', '0', 'R150463091632210465', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:01:56', '17000002', '2017-09-06 01:01:56', '0');
INSERT INTO `t_payment_records` VALUES ('264', '17000002', '0', 'R150463094439021382', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:02:24', '17000002', '2017-09-06 01:02:24', '0');
INSERT INTO `t_payment_records` VALUES ('265', '17000002', '0', 'R150463097293059788', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:02:53', '17000002', '2017-09-06 01:02:53', '0');
INSERT INTO `t_payment_records` VALUES ('266', '17000002', '0', 'R150463102797061230', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:03:48', '17000002', '2017-09-06 01:03:48', '0');
INSERT INTO `t_payment_records` VALUES ('267', '17000002', '0', 'R150463108300960727', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:04:43', '17000002', '2017-09-06 01:04:43', '0');
INSERT INTO `t_payment_records` VALUES ('268', '17000002', '0', 'R150463114851451050', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:05:49', '17000002', '2017-09-06 01:05:49', '0');
INSERT INTO `t_payment_records` VALUES ('269', '17000002', '0', 'R150463116067115389', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:06:01', '17000002', '2017-09-06 01:06:01', '0');
INSERT INTO `t_payment_records` VALUES ('270', '17000002', '0', 'R150463123858227228', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:07:19', '17000002', '2017-09-06 01:07:19', '0');
INSERT INTO `t_payment_records` VALUES ('271', '17000002', '0', 'R150463124115039295', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:07:21', '17000002', '2017-09-06 01:07:21', '0');
INSERT INTO `t_payment_records` VALUES ('272', '17000002', '0', 'R150463124389339650', '50.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:07:24', '17000002', '2017-09-06 01:07:24', '0');
INSERT INTO `t_payment_records` VALUES ('273', '17000002', '0', 'R150463125645189716', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:07:36', '17000002', '2017-09-06 01:07:36', '0');
INSERT INTO `t_payment_records` VALUES ('274', '17000002', '0', 'R150463140622818211', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:06', '17000002', '2017-09-06 01:10:06', '0');
INSERT INTO `t_payment_records` VALUES ('275', '17000002', '0', 'R150463140759018821', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_payment_records` VALUES ('276', '17000002', '0', 'R150463140814244560', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_payment_records` VALUES ('277', '17000002', '0', 'R150463140875033309', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_payment_records` VALUES ('278', '17000002', '0', 'R150463140930529071', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_payment_records` VALUES ('279', '17000002', '0', 'R150463140980574968', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_payment_records` VALUES ('280', '17000002', '0', 'R150463141029421478', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_payment_records` VALUES ('281', '17000002', '0', 'R150463141081456384', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_payment_records` VALUES ('282', '17000002', '0', 'R150463141133129767', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_payment_records` VALUES ('283', '17000002', '0', 'R150463141185889827', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:12', '17000002', '2017-09-06 01:10:12', '0');
INSERT INTO `t_payment_records` VALUES ('284', '17000002', '0', 'R150463142580429432', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:10:26', '17000002', '2017-09-06 01:10:26', '0');
INSERT INTO `t_payment_records` VALUES ('285', '17000002', '0', 'R150463244007568988', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:27:20', '17000002', '2017-09-06 01:27:20', '0');
INSERT INTO `t_payment_records` VALUES ('286', '17000002', '0', 'R150463244056696288', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_payment_records` VALUES ('287', '17000002', '0', 'R150463244097226087', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_payment_records` VALUES ('288', '17000002', '0', 'R150463244164263424', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_payment_records` VALUES ('289', '17000002', '0', 'R150463244213866455', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_payment_records` VALUES ('290', '17000002', '0', 'R150463355587082858', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:45:56', '17000002', '2017-09-06 01:45:56', '0');
INSERT INTO `t_payment_records` VALUES ('291', '17000002', '0', 'R150463355659948920', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:45:57', '17000002', '2017-09-06 01:45:57', '0');
INSERT INTO `t_payment_records` VALUES ('292', '17000002', '0', 'R150463362183486796', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:47:02', '17000002', '2017-09-06 01:47:02', '0');
INSERT INTO `t_payment_records` VALUES ('293', '17000002', '0', 'R150463362254770188', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payment_records` VALUES ('294', '17000002', '0', 'R150463362276452436', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payment_records` VALUES ('295', '17000002', '0', 'R150463362294651521', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payment_records` VALUES ('296', '17000002', '0', 'R150463362310858898', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payment_records` VALUES ('297', '17000002', '0', 'R150469133566826196', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:48:56', '17000002', '2017-09-06 17:48:56', '0');
INSERT INTO `t_payment_records` VALUES ('298', '17000002', '0', 'R150469134848355455', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:49:08', '17000002', '2017-09-06 17:49:08', '0');
INSERT INTO `t_payment_records` VALUES ('299', '17000002', '0', 'R150469141602038957', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:50:16', '17000002', '2017-09-06 17:50:16', '0');
INSERT INTO `t_payment_records` VALUES ('300', '17000002', '0', 'R150469147452746549', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:51:15', '17000002', '2017-09-06 17:51:15', '0');
INSERT INTO `t_payment_records` VALUES ('301', '17000002', '0', 'R150469150991542917', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:51:50', '17000002', '2017-09-06 17:51:50', '0');
INSERT INTO `t_payment_records` VALUES ('302', '17000002', '0', 'R150469155130333207', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:52:31', '17000002', '2017-09-06 17:52:31', '0');
INSERT INTO `t_payment_records` VALUES ('303', '17000002', '0', 'R150469165796011724', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:54:18', '17000002', '2017-09-06 17:54:18', '0');
INSERT INTO `t_payment_records` VALUES ('304', '17000002', '0', 'R150469169468917073', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:54:55', '17000002', '2017-09-06 17:54:55', '0');
INSERT INTO `t_payment_records` VALUES ('305', '17000002', '0', 'R150469172275210554', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:55:23', '17000002', '2017-09-06 17:55:23', '0');
INSERT INTO `t_payment_records` VALUES ('306', '17000002', '0', 'R150469174516981803', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:55:45', '17000002', '2017-09-06 17:55:45', '0');
INSERT INTO `t_payment_records` VALUES ('307', '17000002', '0', 'R150469176888963495', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:56:09', '17000002', '2017-09-06 17:56:09', '0');
INSERT INTO `t_payment_records` VALUES ('308', '17000002', '0', 'R150469178662015748', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:56:27', '17000002', '2017-09-06 17:56:27', '0');
INSERT INTO `t_payment_records` VALUES ('309', '17000002', '0', 'R150469179666733650', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:56:37', '17000002', '2017-09-06 17:56:37', '0');
INSERT INTO `t_payment_records` VALUES ('310', '17000002', '0', 'R150469182886319323', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:57:09', '17000002', '2017-09-06 17:57:09', '0');
INSERT INTO `t_payment_records` VALUES ('311', '17000002', '0', 'R150469185493025707', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 17:57:35', '17000002', '2017-09-06 17:57:35', '0');
INSERT INTO `t_payment_records` VALUES ('312', '17000002', '0', 'R150469239354615236', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 18:06:34', '17000002', '2017-09-06 18:06:34', '0');
INSERT INTO `t_payment_records` VALUES ('313', '17000002', '0', 'R150469255182899028', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 18:09:12', '17000002', '2017-09-06 18:09:12', '0');
INSERT INTO `t_payment_records` VALUES ('314', '17000002', '0', 'R150469262343060471', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 18:10:23', '17000002', '2017-09-06 18:10:23', '0');
INSERT INTO `t_payment_records` VALUES ('315', '17000002', '0', 'R150469263946223156', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 18:10:39', '17000002', '2017-09-06 18:10:39', '0');
INSERT INTO `t_payment_records` VALUES ('316', '17000002', '0', 'R150469266123211858', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 18:11:01', '17000002', '2017-09-06 18:11:01', '0');
INSERT INTO `t_payment_records` VALUES ('317', '17000002', '0', 'R150469609518833754', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 19:08:15', '17000002', '2017-09-06 19:08:15', '0');
INSERT INTO `t_payment_records` VALUES ('318', '17000002', '0', 'R150469611183896195', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 19:08:32', '17000002', '2017-09-06 19:08:32', '0');
INSERT INTO `t_payment_records` VALUES ('319', '17000002', '0', 'R150469612224243874', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 19:08:42', '17000002', '2017-09-06 19:08:42', '0');
INSERT INTO `t_payment_records` VALUES ('320', '17000002', '0', 'R150469702096733872', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 19:23:41', '17000002', '2017-09-06 19:23:41', '0');
INSERT INTO `t_payment_records` VALUES ('321', '17000002', '0', 'R150470251029190204', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 20:55:10', '17000002', '2017-09-06 20:55:10', '0');
INSERT INTO `t_payment_records` VALUES ('322', '17000002', '0', 'R150470255215487950', '1.00', '1', null, null, null, '1', '17000002', '2017-09-06 20:55:52', '17000002', '2017-09-06 20:55:52', '0');
INSERT INTO `t_payment_records` VALUES ('323', '17000002', '0', 'R150470268725942218', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 20:58:07', '17000002', '2017-09-06 20:58:07', '0');
INSERT INTO `t_payment_records` VALUES ('324', '17000002', '0', 'R150470289635171826', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 21:01:36', '17000002', '2017-09-06 21:01:36', '0');
INSERT INTO `t_payment_records` VALUES ('325', '17000002', '0', 'R150470356296257427', '10.00', '1', null, null, null, '1', '17000002', '2017-09-06 21:12:43', '17000002', '2017-09-06 21:12:43', '0');
INSERT INTO `t_payment_records` VALUES ('336', '17000003', '0', 'R150486163784756063', '30.00', '2', null, null, null, '1', '17000003', '2017-09-08 17:07:18', '17000003', '2017-09-08 17:07:18', '0');
INSERT INTO `t_payment_records` VALUES ('337', '17000003', '0', 'R150486312628189270', '30.00', '2', null, null, null, '1', '17000003', '2017-09-08 17:32:06', '17000003', '2017-09-08 17:32:06', '0');
INSERT INTO `t_payment_records` VALUES ('338', '17000003', '0', 'R150486349569881462', '30.00', '2', null, null, null, '1', '17000003', '2017-09-08 17:38:16', '17000003', '2017-09-08 17:38:16', '0');
INSERT INTO `t_payment_records` VALUES ('339', '17000003', '0', 'R150486426875726887', '68.00', '2', null, null, null, '1', '17000003', '2017-09-08 17:51:09', '17000003', '2017-09-08 17:51:09', '0');
INSERT INTO `t_payment_records` VALUES ('340', '17000003', '0', 'R150486449298685262', '30.00', '2', null, null, null, '1', '17000003', '2017-09-08 17:54:53', '17000003', '2017-09-08 17:54:53', '0');
INSERT INTO `t_payment_records` VALUES ('341', '17000003', '0', 'R150486501064642270', '30.00', '2', null, null, null, '1', '17000003', '2017-09-08 18:03:31', '17000003', '2017-09-08 18:03:31', '0');
INSERT INTO `t_payment_records` VALUES ('342', '17000003', '0', 'R150486509081579347', '518.00', '2', null, null, null, '1', '17000003', '2017-09-08 18:04:51', '17000003', '2017-09-08 18:04:51', '0');
INSERT INTO `t_payment_records` VALUES ('343', '17000002', '0', 'R150487173647434518', '30.00', '2', null, null, null, '1', '17000002', '2017-09-08 19:55:36', '17000002', '2017-09-08 19:55:36', '0');
INSERT INTO `t_payment_records` VALUES ('344', '17000002', '0', 'R150487176481831200', '30.00', '2', null, null, null, '1', '17000002', '2017-09-08 19:56:05', '17000002', '2017-09-08 19:56:05', '0');
INSERT INTO `t_payment_records` VALUES ('345', '17000002', '0', 'R150487180570729139', '30.00', '2', null, null, null, '1', '17000002', '2017-09-08 19:56:46', '17000002', '2017-09-08 19:56:46', '0');
INSERT INTO `t_payment_records` VALUES ('346', '17000007', '0', 'R150487390170750523', '30.00', '2', null, null, null, '1', '17000007', '2017-09-08 20:31:42', '17000007', '2017-09-08 20:31:42', '0');
INSERT INTO `t_payment_records` VALUES ('347', '17000001', '0', 'R150487627397411479', '1.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:11:14', '17000001', '2017-09-08 21:11:14', '0');
INSERT INTO `t_payment_records` VALUES ('348', '17000001', '0', 'R150487630374318079', '1.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:11:44', '17000001', '2017-09-08 21:11:44', '0');
INSERT INTO `t_payment_records` VALUES ('349', '17000001', '0', 'R150487633671495246', '1.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:12:17', '17000001', '2017-09-08 21:12:17', '0');
INSERT INTO `t_payment_records` VALUES ('350', '17000007', '0', 'R150487635145110002', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:12:31', '17000007', '2017-09-08 21:12:31', '0');
INSERT INTO `t_payment_records` VALUES ('351', '17000007', '0', 'R150487644395075684', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:14:04', '17000007', '2017-09-08 21:14:04', '0');
INSERT INTO `t_payment_records` VALUES ('352', '17000007', '0', 'R150487657088614307', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:16:11', '17000007', '2017-09-08 21:16:11', '0');
INSERT INTO `t_payment_records` VALUES ('353', '17000007', '0', 'R150487668349450544', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:18:04', '17000007', '2017-09-08 21:18:04', '0');
INSERT INTO `t_payment_records` VALUES ('354', '17000007', '0', 'R150487698030684858', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:23:00', '17000007', '2017-09-08 21:23:00', '0');
INSERT INTO `t_payment_records` VALUES ('355', '17000007', '0', 'R150487755191935841', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:32:32', '17000007', '2017-09-08 21:32:32', '0');
INSERT INTO `t_payment_records` VALUES ('356', '17000007', '0', 'R150487765718436731', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:34:17', '17000007', '2017-09-08 21:34:17', '0');
INSERT INTO `t_payment_records` VALUES ('357', '17000001', '0', 'R150487849553530922', '1.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:48:16', '17000001', '2017-09-08 21:48:16', '0');
INSERT INTO `t_payment_records` VALUES ('358', '17000001', '0', 'R150487854784366504', '10.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:49:08', '17000001', '2017-09-08 21:49:08', '0');
INSERT INTO `t_payment_records` VALUES ('359', '17000001', '0', 'R150487863288448472', '1.00', '1', null, null, null, '1', '17000001', '2017-09-08 21:50:33', '17000001', '2017-09-08 21:50:33', '0');
INSERT INTO `t_payment_records` VALUES ('360', '17000007', '0', 'R150487885027874949', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 21:54:10', '17000007', '2017-09-08 21:54:10', '0');
INSERT INTO `t_payment_records` VALUES ('361', '17000002', '0', 'R150487892199754989', '1.00', '1', null, null, null, '1', '17000002', '2017-09-08 21:55:22', '17000002', '2017-09-08 21:55:22', '0');
INSERT INTO `t_payment_records` VALUES ('362', '17000002', '0', 'R150487893743952905', '1.00', '1', null, null, null, '1', '17000002', '2017-09-08 21:55:37', '17000002', '2017-09-08 21:55:37', '0');
INSERT INTO `t_payment_records` VALUES ('363', '17000007', '0', 'R150487996913614908', '1.00', '1', null, null, null, '1', '17000007', '2017-09-08 22:12:49', '17000007', '2017-09-08 22:12:49', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `t_payments` VALUES ('84', '5', '0', '1.00', '1', null, '143', '0', '17000001', '2017-08-30 14:06:24', '17000001', '2017-08-30 14:06:24', '0');
INSERT INTO `t_payments` VALUES ('85', '5', '0', '1.00', '1', null, '144', '0', '17000001', '2017-08-30 14:06:27', '17000001', '2017-08-30 14:06:27', '0');
INSERT INTO `t_payments` VALUES ('86', '5', '0', '1.00', '1', null, '145', '0', '17000001', '2017-08-30 14:07:24', '17000001', '2017-08-30 14:07:24', '0');
INSERT INTO `t_payments` VALUES ('87', '5', '0', '1.00', '2', '1155390107135075084', '146', '1', '17000001', '2017-08-30 14:08:26', '17000001', '2017-08-30 14:08:26', '0');
INSERT INTO `t_payments` VALUES ('88', '5', '0', '10.00', '1', null, '147', '0', '17000002', '2017-08-31 12:59:30', '17000002', '2017-08-31 12:59:30', '0');
INSERT INTO `t_payments` VALUES ('89', '5', '0', '10.00', '1', null, '148', '0', '17000002', '2017-08-31 12:59:35', '17000002', '2017-08-31 12:59:35', '0');
INSERT INTO `t_payments` VALUES ('90', '5', '0', '10.00', '1', null, '149', '0', '17000002', '2017-08-31 12:59:49', '17000002', '2017-08-31 12:59:49', '0');
INSERT INTO `t_payments` VALUES ('91', '5', '0', '10.00', '1', null, '150', '0', '17000002', '2017-08-31 13:00:54', '17000002', '2017-08-31 13:00:54', '0');
INSERT INTO `t_payments` VALUES ('92', '5', '0', '10.00', '1', null, '151', '0', '17000002', '2017-08-31 13:01:16', '17000002', '2017-08-31 13:01:16', '0');
INSERT INTO `t_payments` VALUES ('93', '2', '0', '10.00', '1', null, '152', '1', '17000003', '2017-09-01 19:43:09', '17000003', '2017-09-01 19:43:09', '0');
INSERT INTO `t_payments` VALUES ('94', '5', '0', '10.00', '1', null, '153', '1', '17000003', '2017-09-01 19:43:22', '17000003', '2017-09-01 19:43:22', '0');
INSERT INTO `t_payments` VALUES ('95', '2', '0', '30.00', '1', null, '154', '1', '17000002', '2017-09-05 16:17:04', '17000002', '2017-09-05 16:17:04', '0');
INSERT INTO `t_payments` VALUES ('96', '5', '0', '10.00', '1', null, '155', '1', '17000002', '2017-09-05 16:17:40', '17000002', '2017-09-05 16:17:40', '0');
INSERT INTO `t_payments` VALUES ('97', '5', '0', '10.00', '1', null, '156', '1', '17000002', '2017-09-05 16:19:30', '17000002', '2017-09-05 16:19:30', '0');
INSERT INTO `t_payments` VALUES ('98', '5', '0', '10.00', '1', null, '157', '1', '17000002', '2017-09-05 16:25:23', '17000002', '2017-09-05 16:25:23', '0');
INSERT INTO `t_payments` VALUES ('99', '5', '0', '1000.00', '1', null, '158', '1', '17000002', '2017-09-05 16:28:28', '17000002', '2017-09-05 16:28:28', '0');
INSERT INTO `t_payments` VALUES ('100', '5', '0', '10.00', '1', null, '159', '1', '17000002', '2017-09-05 16:30:16', '17000002', '2017-09-05 16:30:16', '0');
INSERT INTO `t_payments` VALUES ('101', '5', '0', '10.00', '1', null, '160', '1', '17000002', '2017-09-05 16:30:54', '17000002', '2017-09-05 16:30:54', '0');
INSERT INTO `t_payments` VALUES ('102', '5', '0', '10.00', '1', null, '161', '1', '17000002', '2017-09-05 16:31:21', '17000002', '2017-09-05 16:31:21', '0');
INSERT INTO `t_payments` VALUES ('103', '5', '0', '10.00', '1', null, '162', '1', '17000002', '2017-09-05 16:32:15', '17000002', '2017-09-05 16:32:15', '0');
INSERT INTO `t_payments` VALUES ('104', '5', '0', '10.00', '1', null, '163', '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_payments` VALUES ('105', '5', '0', '10.00', '1', null, '164', '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_payments` VALUES ('106', '5', '0', '50.00', '1', null, '165', '1', '17000002', '2017-09-05 16:32:54', '17000002', '2017-09-05 16:32:54', '0');
INSERT INTO `t_payments` VALUES ('107', '5', '0', '50.00', '1', null, '166', '1', '17000002', '2017-09-05 16:35:17', '17000002', '2017-09-05 16:35:17', '0');
INSERT INTO `t_payments` VALUES ('108', '5', '0', '10.00', '1', null, '167', '1', '17000002', '2017-09-05 16:35:35', '17000002', '2017-09-05 16:35:35', '0');
INSERT INTO `t_payments` VALUES ('109', '5', '0', '10.00', '1', null, '168', '1', '17000002', '2017-09-05 16:37:29', '17000002', '2017-09-05 16:37:29', '0');
INSERT INTO `t_payments` VALUES ('110', '5', '0', '10.00', '1', null, '169', '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_payments` VALUES ('111', '5', '0', '10.00', '1', null, '170', '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_payments` VALUES ('112', '5', '0', '10.00', '1', null, '171', '1', '17000002', '2017-09-05 16:37:58', '17000002', '2017-09-05 16:37:58', '0');
INSERT INTO `t_payments` VALUES ('113', '5', '0', '10.00', '1', null, '172', '1', '17000002', '2017-09-05 16:38:52', '17000002', '2017-09-05 16:38:52', '0');
INSERT INTO `t_payments` VALUES ('114', '5', '0', '10.00', '1', null, '173', '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_payments` VALUES ('115', '5', '0', '10.00', '1', null, '174', '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_payments` VALUES ('116', '5', '0', '10.00', '1', null, '175', '1', '17000002', '2017-09-05 16:39:02', '17000002', '2017-09-05 16:39:02', '0');
INSERT INTO `t_payments` VALUES ('117', '5', '0', '10.00', '1', null, '176', '1', '17000002', '2017-09-05 16:43:33', '17000002', '2017-09-05 16:43:33', '0');
INSERT INTO `t_payments` VALUES ('118', '5', '0', '10.00', '1', null, '177', '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payments` VALUES ('119', '5', '0', '10.00', '1', null, '178', '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payments` VALUES ('120', '5', '0', '10.00', '1', null, '179', '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payments` VALUES ('121', '5', '0', '10.00', '1', null, '180', '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_payments` VALUES ('122', '5', '0', '10.00', '1', null, '181', '1', '17000002', '2017-09-05 16:44:32', '17000002', '2017-09-05 16:44:32', '0');
INSERT INTO `t_payments` VALUES ('123', '5', '0', '10.00', '1', null, '182', '1', '17000002', '2017-09-05 16:44:33', '17000002', '2017-09-05 16:44:33', '0');
INSERT INTO `t_payments` VALUES ('124', '5', '0', '10.00', '1', null, '183', '1', '17000002', '2017-09-05 16:44:57', '17000002', '2017-09-05 16:44:57', '0');
INSERT INTO `t_payments` VALUES ('125', '5', '0', '10.00', '1', null, '184', '1', '17000002', '2017-09-05 16:45:02', '17000002', '2017-09-05 16:45:02', '0');
INSERT INTO `t_payments` VALUES ('126', '5', '0', '50.00', '1', null, '185', '1', '17000002', '2017-09-05 16:51:20', '17000002', '2017-09-05 16:51:20', '0');
INSERT INTO `t_payments` VALUES ('127', '5', '0', '500.00', '1', null, '186', '1', '17000002', '2017-09-05 16:52:42', '17000002', '2017-09-05 16:52:42', '0');
INSERT INTO `t_payments` VALUES ('128', '5', '0', '10.00', '1', null, '187', '1', '17000002', '2017-09-05 16:54:56', '17000002', '2017-09-05 16:54:56', '0');
INSERT INTO `t_payments` VALUES ('129', '5', '0', '1000.00', '1', null, '188', '1', '17000002', '2017-09-05 16:56:17', '17000002', '2017-09-05 16:56:17', '0');
INSERT INTO `t_payments` VALUES ('130', '5', '0', '1000.00', '1', null, '189', '1', '17000002', '2017-09-05 16:56:18', '17000002', '2017-09-05 16:56:18', '0');
INSERT INTO `t_payments` VALUES ('131', '5', '0', '10.00', '1', null, '190', '1', '17000002', '2017-09-05 16:56:29', '17000002', '2017-09-05 16:56:29', '0');
INSERT INTO `t_payments` VALUES ('132', '5', '0', '10.00', '1', null, '191', '1', '17000002', '2017-09-05 16:56:33', '17000002', '2017-09-05 16:56:33', '0');
INSERT INTO `t_payments` VALUES ('133', '5', '0', '1000.00', '1', null, '192', '1', '17000002', '2017-09-05 17:02:11', '17000002', '2017-09-05 17:02:11', '0');
INSERT INTO `t_payments` VALUES ('134', '5', '0', '1000.00', '1', null, '193', '1', '17000002', '2017-09-05 17:02:43', '17000002', '2017-09-05 17:02:43', '0');
INSERT INTO `t_payments` VALUES ('135', '5', '0', '50.00', '1', null, '194', '1', '17000002', '2017-09-05 17:02:58', '17000002', '2017-09-05 17:02:58', '0');
INSERT INTO `t_payments` VALUES ('136', '5', '0', '1000.00', '1', null, '195', '1', '17000002', '2017-09-05 17:03:42', '17000002', '2017-09-05 17:03:42', '0');
INSERT INTO `t_payments` VALUES ('137', '2', '0', '1000.00', '1', null, '196', '1', '17000002', '2017-09-05 17:06:56', '17000002', '2017-09-05 17:06:56', '0');
INSERT INTO `t_payments` VALUES ('138', '5', '0', '500.00', '1', null, '197', '1', '17000002', '2017-09-05 17:13:03', '17000002', '2017-09-05 17:13:03', '0');
INSERT INTO `t_payments` VALUES ('139', '5', '0', '10.00', '1', null, '198', '1', '17000002', '2017-09-05 17:15:45', '17000002', '2017-09-05 17:15:45', '0');
INSERT INTO `t_payments` VALUES ('140', '5', '0', '1000.00', '1', null, '199', '1', '17000002', '2017-09-05 17:17:30', '17000002', '2017-09-05 17:17:30', '0');
INSERT INTO `t_payments` VALUES ('141', '2', '0', '1.00', '1', null, '200', '1', '17000002', '2017-09-05 17:21:49', '17000002', '2017-09-05 17:21:49', '0');
INSERT INTO `t_payments` VALUES ('142', '2', '0', '50.00', '1', null, '201', '1', '17000002', '2017-09-05 17:25:21', '17000002', '2017-09-05 17:25:21', '0');
INSERT INTO `t_payments` VALUES ('143', '5', '0', '50.00', '1', null, '202', '1', '17000002', '2017-09-05 17:36:17', '17000002', '2017-09-05 17:36:17', '0');
INSERT INTO `t_payments` VALUES ('144', '2', '0', '10.00', '1', null, '203', '1', '17000002', '2017-09-05 19:49:16', '17000002', '2017-09-05 19:49:16', '0');
INSERT INTO `t_payments` VALUES ('145', '5', '0', '50.00', '1', null, '204', '1', '17000002', '2017-09-05 19:57:57', '17000002', '2017-09-05 19:57:57', '0');
INSERT INTO `t_payments` VALUES ('146', '5', '0', '50.00', '1', null, '205', '1', '17000002', '2017-09-05 20:12:53', '17000002', '2017-09-05 20:12:53', '0');
INSERT INTO `t_payments` VALUES ('147', '5', '0', '50.00', '1', null, '206', '1', '17000002', '2017-09-05 20:35:17', '17000002', '2017-09-05 20:35:17', '0');
INSERT INTO `t_payments` VALUES ('148', '5', '0', '50.00', '1', null, '207', '1', '17000002', '2017-09-05 20:35:30', '17000002', '2017-09-05 20:35:30', '0');
INSERT INTO `t_payments` VALUES ('149', '5', '0', '50.00', '1', null, '208', '1', '17000002', '2017-09-05 20:35:37', '17000002', '2017-09-05 20:35:37', '0');
INSERT INTO `t_payments` VALUES ('150', '5', '0', '50.00', '1', null, '209', '1', '17000002', '2017-09-05 20:37:44', '17000002', '2017-09-05 20:37:44', '0');
INSERT INTO `t_payments` VALUES ('151', '2', '0', '50.00', '1', null, '210', '1', '17000002', '2017-09-05 20:37:49', '17000002', '2017-09-05 20:37:49', '0');
INSERT INTO `t_payments` VALUES ('152', '5', '0', '50.00', '1', null, '211', '1', '17000002', '2017-09-05 20:39:34', '17000002', '2017-09-05 20:39:34', '0');
INSERT INTO `t_payments` VALUES ('153', '5', '0', '50.00', '1', null, '212', '1', '17000002', '2017-09-05 20:40:46', '17000002', '2017-09-05 20:40:46', '0');
INSERT INTO `t_payments` VALUES ('154', '5', '0', '1000.00', '1', null, '213', '1', '17000002', '2017-09-05 20:40:54', '17000002', '2017-09-05 20:40:54', '0');
INSERT INTO `t_payments` VALUES ('155', '5', '0', '1.00', '1', null, '214', '1', '17000002', '2017-09-05 20:42:23', '17000002', '2017-09-05 20:42:23', '0');
INSERT INTO `t_payments` VALUES ('156', '5', '0', '50.00', '1', null, '215', '1', '17000002', '2017-09-05 20:43:30', '17000002', '2017-09-05 20:43:30', '0');
INSERT INTO `t_payments` VALUES ('157', '5', '0', '1.00', '1', null, '216', '1', '17000002', '2017-09-05 20:43:49', '17000002', '2017-09-05 20:43:49', '0');
INSERT INTO `t_payments` VALUES ('158', '5', '0', '1.00', '1', null, '217', '1', '17000002', '2017-09-05 20:43:54', '17000002', '2017-09-05 20:43:54', '0');
INSERT INTO `t_payments` VALUES ('159', '2', '0', '10.00', '1', null, '218', '1', '17000002', '2017-09-05 20:44:32', '17000002', '2017-09-05 20:44:32', '0');
INSERT INTO `t_payments` VALUES ('160', '2', '0', '10.00', '1', null, '219', '1', '17000002', '2017-09-05 20:46:47', '17000002', '2017-09-05 20:46:47', '0');
INSERT INTO `t_payments` VALUES ('161', '5', '0', '10.00', '1', null, '220', '1', '17000002', '2017-09-05 20:47:50', '17000002', '2017-09-05 20:47:50', '0');
INSERT INTO `t_payments` VALUES ('162', '5', '0', '50.00', '1', null, '221', '1', '17000002', '2017-09-05 20:48:55', '17000002', '2017-09-05 20:48:55', '0');
INSERT INTO `t_payments` VALUES ('163', '5', '0', '50.00', '1', null, '222', '1', '17000002', '2017-09-05 20:50:51', '17000002', '2017-09-05 20:50:51', '0');
INSERT INTO `t_payments` VALUES ('164', '5', '0', '1.00', '1', null, '223', '1', '17000002', '2017-09-05 21:16:23', '17000002', '2017-09-05 21:16:23', '0');
INSERT INTO `t_payments` VALUES ('165', '5', '0', '1.00', '1', null, '224', '1', '17000002', '2017-09-05 21:22:32', '17000002', '2017-09-05 21:22:32', '0');
INSERT INTO `t_payments` VALUES ('166', '5', '0', '1.00', '1', null, '225', '1', '17000002', '2017-09-05 21:31:57', '17000002', '2017-09-05 21:31:57', '0');
INSERT INTO `t_payments` VALUES ('167', '5', '0', '10.00', '1', null, '226', '1', '17000002', '2017-09-05 21:39:08', '17000002', '2017-09-05 21:39:08', '0');
INSERT INTO `t_payments` VALUES ('168', '5', '0', '10.00', '1', null, '227', '1', '17000002', '2017-09-05 21:39:38', '17000002', '2017-09-05 21:39:38', '0');
INSERT INTO `t_payments` VALUES ('169', '5', '0', '1.00', '1', null, '228', '1', '17000002', '2017-09-05 21:40:46', '17000002', '2017-09-05 21:40:46', '0');
INSERT INTO `t_payments` VALUES ('170', '5', '0', '10.00', '1', null, '229', '1', '17000002', '2017-09-05 21:43:06', '17000002', '2017-09-05 21:43:06', '0');
INSERT INTO `t_payments` VALUES ('171', '5', '0', '10.00', '1', null, '230', '1', '17000002', '2017-09-05 21:43:40', '17000002', '2017-09-05 21:43:40', '0');
INSERT INTO `t_payments` VALUES ('172', '2', '0', '10.00', '1', null, '231', '1', '17000002', '2017-09-05 21:43:45', '17000002', '2017-09-05 21:43:45', '0');
INSERT INTO `t_payments` VALUES ('173', '5', '0', '1.00', '1', null, '232', '1', '17000002', '2017-09-05 21:47:50', '17000002', '2017-09-05 21:47:50', '0');
INSERT INTO `t_payments` VALUES ('174', '5', '0', '1.00', '1', null, '233', '1', '17000002', '2017-09-05 21:53:43', '17000002', '2017-09-05 21:53:43', '0');
INSERT INTO `t_payments` VALUES ('175', '5', '0', '1.00', '1', null, '234', '1', '17000002', '2017-09-05 21:54:14', '17000002', '2017-09-05 21:54:14', '0');
INSERT INTO `t_payments` VALUES ('176', '5', '0', '10.00', '1', null, '235', '1', '17000002', '2017-09-05 21:55:22', '17000002', '2017-09-05 21:55:22', '0');
INSERT INTO `t_payments` VALUES ('177', '5', '0', '10.00', '1', null, '236', '1', '17000002', '2017-09-05 21:57:11', '17000002', '2017-09-05 21:57:11', '0');
INSERT INTO `t_payments` VALUES ('178', '5', '0', '10.00', '1', null, '237', '1', '17000002', '2017-09-05 21:57:40', '17000002', '2017-09-05 21:57:40', '0');
INSERT INTO `t_payments` VALUES ('179', '2', '0', '10.00', '1', null, '238', '1', '17000002', '2017-09-05 21:58:10', '17000002', '2017-09-05 21:58:10', '0');
INSERT INTO `t_payments` VALUES ('180', '1', '0', '10.00', '1', null, '239', '1', '17000002', '2017-09-05 21:58:20', '17000002', '2017-09-05 21:58:20', '0');
INSERT INTO `t_payments` VALUES ('181', '1', '0', '10.00', '1', null, '240', '1', '17000002', '2017-09-05 22:00:03', '17000002', '2017-09-05 22:00:03', '0');
INSERT INTO `t_payments` VALUES ('182', '2', '0', '1.00', '1', null, '241', '1', '17000002', '2017-09-05 22:00:36', '17000002', '2017-09-05 22:00:36', '0');
INSERT INTO `t_payments` VALUES ('183', '2', '0', '1.00', '1', null, '242', '1', '17000002', '2017-09-05 22:03:44', '17000002', '2017-09-05 22:03:44', '0');
INSERT INTO `t_payments` VALUES ('184', '2', '0', '1.00', '1', null, '243', '1', '17000002', '2017-09-05 22:04:33', '17000002', '2017-09-05 22:04:33', '0');
INSERT INTO `t_payments` VALUES ('185', '2', '0', '10.00', '1', null, '244', '1', '17000002', '2017-09-05 22:05:01', '17000002', '2017-09-05 22:05:01', '0');
INSERT INTO `t_payments` VALUES ('186', '5', '0', '1.00', '1', null, '245', '1', '17000002', '2017-09-05 22:05:38', '17000002', '2017-09-05 22:05:38', '0');
INSERT INTO `t_payments` VALUES ('187', '2', '0', '1.00', '1', null, '246', '1', '17000002', '2017-09-05 22:05:44', '17000002', '2017-09-05 22:05:44', '0');
INSERT INTO `t_payments` VALUES ('188', '5', '0', '10.00', '1', null, '247', '1', '17000002', '2017-09-05 22:19:40', '17000002', '2017-09-05 22:19:40', '0');
INSERT INTO `t_payments` VALUES ('189', '5', '0', '10.00', '1', null, '248', '1', '17000002', '2017-09-05 22:27:46', '17000002', '2017-09-05 22:27:46', '0');
INSERT INTO `t_payments` VALUES ('190', '5', '0', '10.00', '1', null, '249', '1', '17000002', '2017-09-05 22:29:35', '17000002', '2017-09-05 22:29:35', '0');
INSERT INTO `t_payments` VALUES ('191', '5', '0', '50.00', '1', null, '250', '1', '17000002', '2017-09-05 22:37:30', '17000002', '2017-09-05 22:37:30', '0');
INSERT INTO `t_payments` VALUES ('192', '5', '0', '50.00', '1', null, '251', '1', '17000002', '2017-09-05 22:38:20', '17000002', '2017-09-05 22:38:20', '0');
INSERT INTO `t_payments` VALUES ('193', '5', '0', '50.00', '1', null, '252', '1', '17000002', '2017-09-05 22:47:07', '17000002', '2017-09-05 22:47:07', '0');
INSERT INTO `t_payments` VALUES ('194', '5', '0', '50.00', '1', null, '253', '1', '17000002', '2017-09-05 22:58:59', '17000002', '2017-09-05 22:58:59', '0');
INSERT INTO `t_payments` VALUES ('195', '5', '0', '50.00', '1', null, '254', '1', '17000002', '2017-09-05 22:59:13', '17000002', '2017-09-05 22:59:13', '0');
INSERT INTO `t_payments` VALUES ('196', '5', '0', '50.00', '1', null, '255', '1', '17000002', '2017-09-06 01:00:42', '17000002', '2017-09-06 01:00:42', '0');
INSERT INTO `t_payments` VALUES ('197', '5', '0', '50.00', '1', null, '256', '1', '17000002', '2017-09-06 01:00:59', '17000002', '2017-09-06 01:00:59', '0');
INSERT INTO `t_payments` VALUES ('198', '5', '0', '50.00', '1', null, '257', '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_payments` VALUES ('199', '5', '0', '50.00', '1', null, '258', '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_payments` VALUES ('200', '5', '0', '50.00', '1', null, '259', '1', '17000002', '2017-09-06 01:01:04', '17000002', '2017-09-06 01:01:04', '0');
INSERT INTO `t_payments` VALUES ('201', '2', '0', '50.00', '1', null, '260', '1', '17000002', '2017-09-06 01:01:08', '17000002', '2017-09-06 01:01:08', '0');
INSERT INTO `t_payments` VALUES ('202', '2', '0', '50.00', '1', null, '261', '1', '17000002', '2017-09-06 01:01:40', '17000002', '2017-09-06 01:01:40', '0');
INSERT INTO `t_payments` VALUES ('203', '5', '0', '10.00', '1', null, '262', '1', '17000002', '2017-09-06 01:01:55', '17000002', '2017-09-06 01:01:55', '0');
INSERT INTO `t_payments` VALUES ('204', '5', '0', '10.00', '1', null, '263', '1', '17000002', '2017-09-06 01:01:56', '17000002', '2017-09-06 01:01:56', '0');
INSERT INTO `t_payments` VALUES ('205', '5', '0', '10.00', '1', null, '264', '1', '17000002', '2017-09-06 01:02:24', '17000002', '2017-09-06 01:02:24', '0');
INSERT INTO `t_payments` VALUES ('206', '5', '0', '10.00', '1', null, '265', '1', '17000002', '2017-09-06 01:02:53', '17000002', '2017-09-06 01:02:53', '0');
INSERT INTO `t_payments` VALUES ('207', '5', '0', '10.00', '1', null, '266', '1', '17000002', '2017-09-06 01:03:48', '17000002', '2017-09-06 01:03:48', '0');
INSERT INTO `t_payments` VALUES ('208', '5', '0', '10.00', '1', null, '267', '1', '17000002', '2017-09-06 01:04:43', '17000002', '2017-09-06 01:04:43', '0');
INSERT INTO `t_payments` VALUES ('209', '5', '0', '50.00', '1', null, '268', '1', '17000002', '2017-09-06 01:05:49', '17000002', '2017-09-06 01:05:49', '0');
INSERT INTO `t_payments` VALUES ('210', '5', '0', '50.00', '1', null, '269', '1', '17000002', '2017-09-06 01:06:01', '17000002', '2017-09-06 01:06:01', '0');
INSERT INTO `t_payments` VALUES ('211', '2', '0', '10.00', '1', null, '270', '1', '17000002', '2017-09-06 01:07:19', '17000002', '2017-09-06 01:07:19', '0');
INSERT INTO `t_payments` VALUES ('212', '2', '0', '10.00', '1', null, '271', '1', '17000002', '2017-09-06 01:07:21', '17000002', '2017-09-06 01:07:21', '0');
INSERT INTO `t_payments` VALUES ('213', '2', '0', '50.00', '1', null, '272', '1', '17000002', '2017-09-06 01:07:24', '17000002', '2017-09-06 01:07:24', '0');
INSERT INTO `t_payments` VALUES ('214', '5', '0', '10.00', '1', null, '273', '1', '17000002', '2017-09-06 01:07:36', '17000002', '2017-09-06 01:07:36', '0');
INSERT INTO `t_payments` VALUES ('215', '5', '0', '10.00', '1', null, '274', '1', '17000002', '2017-09-06 01:10:06', '17000002', '2017-09-06 01:10:06', '0');
INSERT INTO `t_payments` VALUES ('216', '5', '0', '10.00', '1', null, '275', '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_payments` VALUES ('217', '5', '0', '10.00', '1', null, '276', '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_payments` VALUES ('218', '5', '0', '10.00', '1', null, '277', '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_payments` VALUES ('219', '5', '0', '10.00', '1', null, '278', '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_payments` VALUES ('220', '5', '0', '10.00', '1', null, '279', '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_payments` VALUES ('221', '5', '0', '10.00', '1', null, '280', '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_payments` VALUES ('222', '5', '0', '10.00', '1', null, '281', '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_payments` VALUES ('223', '5', '0', '10.00', '1', null, '282', '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_payments` VALUES ('224', '5', '0', '10.00', '1', null, '283', '1', '17000002', '2017-09-06 01:10:12', '17000002', '2017-09-06 01:10:12', '0');
INSERT INTO `t_payments` VALUES ('225', '5', '0', '10.00', '1', null, '284', '1', '17000002', '2017-09-06 01:10:26', '17000002', '2017-09-06 01:10:26', '0');
INSERT INTO `t_payments` VALUES ('226', '5', '0', '10.00', '1', null, '285', '1', '17000002', '2017-09-06 01:27:20', '17000002', '2017-09-06 01:27:20', '0');
INSERT INTO `t_payments` VALUES ('227', '5', '0', '10.00', '1', null, '286', '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_payments` VALUES ('228', '5', '0', '10.00', '1', null, '287', '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_payments` VALUES ('229', '5', '0', '10.00', '1', null, '288', '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_payments` VALUES ('230', '5', '0', '10.00', '1', null, '289', '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_payments` VALUES ('231', '5', '0', '10.00', '1', null, '290', '1', '17000002', '2017-09-06 01:45:56', '17000002', '2017-09-06 01:45:56', '0');
INSERT INTO `t_payments` VALUES ('232', '5', '0', '10.00', '1', null, '291', '1', '17000002', '2017-09-06 01:45:57', '17000002', '2017-09-06 01:45:57', '0');
INSERT INTO `t_payments` VALUES ('233', '5', '0', '10.00', '1', null, '292', '1', '17000002', '2017-09-06 01:47:02', '17000002', '2017-09-06 01:47:02', '0');
INSERT INTO `t_payments` VALUES ('234', '5', '0', '10.00', '1', null, '293', '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payments` VALUES ('235', '5', '0', '10.00', '1', null, '294', '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payments` VALUES ('236', '5', '0', '10.00', '1', null, '295', '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payments` VALUES ('237', '5', '0', '10.00', '1', null, '296', '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_payments` VALUES ('238', '5', '0', '1.00', '1', null, '297', '1', '17000002', '2017-09-06 17:48:56', '17000002', '2017-09-06 17:48:56', '0');
INSERT INTO `t_payments` VALUES ('239', '5', '0', '1.00', '1', null, '298', '1', '17000002', '2017-09-06 17:49:08', '17000002', '2017-09-06 17:49:08', '0');
INSERT INTO `t_payments` VALUES ('240', '5', '0', '1.00', '1', null, '299', '1', '17000002', '2017-09-06 17:50:16', '17000002', '2017-09-06 17:50:16', '0');
INSERT INTO `t_payments` VALUES ('241', '5', '0', '1.00', '1', null, '300', '1', '17000002', '2017-09-06 17:51:15', '17000002', '2017-09-06 17:51:15', '0');
INSERT INTO `t_payments` VALUES ('242', '2', '0', '1.00', '1', null, '301', '1', '17000002', '2017-09-06 17:51:50', '17000002', '2017-09-06 17:51:50', '0');
INSERT INTO `t_payments` VALUES ('243', '5', '0', '1.00', '1', null, '302', '1', '17000002', '2017-09-06 17:52:31', '17000002', '2017-09-06 17:52:31', '0');
INSERT INTO `t_payments` VALUES ('244', '5', '0', '1.00', '1', null, '303', '1', '17000002', '2017-09-06 17:54:18', '17000002', '2017-09-06 17:54:18', '0');
INSERT INTO `t_payments` VALUES ('245', '1', '0', '1.00', '1', null, '304', '1', '17000002', '2017-09-06 17:54:55', '17000002', '2017-09-06 17:54:55', '0');
INSERT INTO `t_payments` VALUES ('246', '1', '0', '1.00', '1', null, '305', '1', '17000002', '2017-09-06 17:55:23', '17000002', '2017-09-06 17:55:23', '0');
INSERT INTO `t_payments` VALUES ('247', '1', '0', '1.00', '1', null, '306', '1', '17000002', '2017-09-06 17:55:45', '17000002', '2017-09-06 17:55:45', '0');
INSERT INTO `t_payments` VALUES ('248', '1', '0', '1.00', '1', null, '307', '1', '17000002', '2017-09-06 17:56:09', '17000002', '2017-09-06 17:56:09', '0');
INSERT INTO `t_payments` VALUES ('249', '1', '0', '1.00', '1', null, '308', '1', '17000002', '2017-09-06 17:56:27', '17000002', '2017-09-06 17:56:27', '0');
INSERT INTO `t_payments` VALUES ('250', '1', '0', '1.00', '1', null, '309', '1', '17000002', '2017-09-06 17:56:37', '17000002', '2017-09-06 17:56:37', '0');
INSERT INTO `t_payments` VALUES ('251', '1', '0', '1.00', '1', null, '310', '1', '17000002', '2017-09-06 17:57:09', '17000002', '2017-09-06 17:57:09', '0');
INSERT INTO `t_payments` VALUES ('252', '1', '0', '1.00', '1', null, '311', '1', '17000002', '2017-09-06 17:57:35', '17000002', '2017-09-06 17:57:35', '0');
INSERT INTO `t_payments` VALUES ('253', '5', '0', '1.00', '1', null, '312', '1', '17000002', '2017-09-06 18:06:34', '17000002', '2017-09-06 18:06:34', '0');
INSERT INTO `t_payments` VALUES ('254', '5', '0', '1.00', '1', null, '313', '1', '17000002', '2017-09-06 18:09:12', '17000002', '2017-09-06 18:09:12', '0');
INSERT INTO `t_payments` VALUES ('255', '1', '0', '1.00', '1', null, '314', '1', '17000002', '2017-09-06 18:10:23', '17000002', '2017-09-06 18:10:23', '0');
INSERT INTO `t_payments` VALUES ('256', '1', '0', '1.00', '1', null, '315', '1', '17000002', '2017-09-06 18:10:39', '17000002', '2017-09-06 18:10:39', '0');
INSERT INTO `t_payments` VALUES ('257', '5', '0', '1.00', '1', null, '316', '1', '17000002', '2017-09-06 18:11:01', '17000002', '2017-09-06 18:11:01', '0');
INSERT INTO `t_payments` VALUES ('258', '5', '0', '1.00', '1', null, '317', '1', '17000002', '2017-09-06 19:08:15', '17000002', '2017-09-06 19:08:15', '0');
INSERT INTO `t_payments` VALUES ('259', '1', '0', '1.00', '1', null, '318', '1', '17000002', '2017-09-06 19:08:32', '17000002', '2017-09-06 19:08:32', '0');
INSERT INTO `t_payments` VALUES ('260', '1', '0', '1.00', '1', null, '319', '1', '17000002', '2017-09-06 19:08:42', '17000002', '2017-09-06 19:08:42', '0');
INSERT INTO `t_payments` VALUES ('261', '5', '0', '1.00', '1', null, '320', '1', '17000002', '2017-09-06 19:23:41', '17000002', '2017-09-06 19:23:41', '0');
INSERT INTO `t_payments` VALUES ('262', '5', '0', '1.00', '1', null, '321', '1', '17000002', '2017-09-06 20:55:10', '17000002', '2017-09-06 20:55:10', '0');
INSERT INTO `t_payments` VALUES ('263', '5', '0', '1.00', '1', null, '322', '1', '17000002', '2017-09-06 20:55:52', '17000002', '2017-09-06 20:55:52', '0');
INSERT INTO `t_payments` VALUES ('264', '2', '0', '10.00', '1', null, '323', '1', '17000002', '2017-09-06 20:58:07', '17000002', '2017-09-06 20:58:07', '0');
INSERT INTO `t_payments` VALUES ('265', '1', '0', '10.00', '1', null, '324', '1', '17000002', '2017-09-06 21:01:36', '17000002', '2017-09-06 21:01:36', '0');
INSERT INTO `t_payments` VALUES ('266', '1', '0', '10.00', '1', null, '325', '1', '17000002', '2017-09-06 21:12:43', '17000002', '2017-09-06 21:12:43', '0');
INSERT INTO `t_payments` VALUES ('277', '8', '0', '30.00', '2', null, '336', '1', '17000003', '2017-09-08 17:07:18', '17000003', '2017-09-08 17:07:18', '0');
INSERT INTO `t_payments` VALUES ('278', '8', '0', '30.00', '2', null, '337', '1', '17000003', '2017-09-08 17:32:06', '17000003', '2017-09-08 17:32:06', '0');
INSERT INTO `t_payments` VALUES ('279', '8', '0', '30.00', '2', null, '338', '1', '17000003', '2017-09-08 17:38:16', '17000003', '2017-09-08 17:38:16', '0');
INSERT INTO `t_payments` VALUES ('280', '8', '0', '68.00', '2', null, '339', '1', '17000003', '2017-09-08 17:51:09', '17000003', '2017-09-08 17:51:09', '0');
INSERT INTO `t_payments` VALUES ('281', '8', '0', '30.00', '2', null, '340', '1', '17000003', '2017-09-08 17:54:53', '17000003', '2017-09-08 17:54:53', '0');
INSERT INTO `t_payments` VALUES ('282', '8', '0', '30.00', '2', null, '341', '1', '17000003', '2017-09-08 18:03:31', '17000003', '2017-09-08 18:03:31', '0');
INSERT INTO `t_payments` VALUES ('283', '8', '0', '518.00', '2', null, '342', '1', '17000003', '2017-09-08 18:04:51', '17000003', '2017-09-08 18:04:51', '0');
INSERT INTO `t_payments` VALUES ('284', '8', '0', '30.00', '2', null, '343', '1', '17000002', '2017-09-08 19:55:36', '17000002', '2017-09-08 19:55:36', '0');
INSERT INTO `t_payments` VALUES ('285', '8', '0', '30.00', '2', null, '344', '1', '17000002', '2017-09-08 19:56:05', '17000002', '2017-09-08 19:56:05', '0');
INSERT INTO `t_payments` VALUES ('286', '8', '0', '30.00', '2', null, '345', '1', '17000002', '2017-09-08 19:56:46', '17000002', '2017-09-08 19:56:46', '0');
INSERT INTO `t_payments` VALUES ('287', '8', '0', '30.00', '2', null, '346', '1', '17000007', '2017-09-08 20:31:42', '17000007', '2017-09-08 20:31:42', '0');
INSERT INTO `t_payments` VALUES ('288', '5', '0', '1.00', '1', null, '347', '1', '17000001', '2017-09-08 21:11:14', '17000001', '2017-09-08 21:11:14', '0');
INSERT INTO `t_payments` VALUES ('289', '2', '0', '1.00', '1', null, '348', '1', '17000001', '2017-09-08 21:11:44', '17000001', '2017-09-08 21:11:44', '0');
INSERT INTO `t_payments` VALUES ('290', '1', '0', '1.00', '1', null, '349', '1', '17000001', '2017-09-08 21:12:17', '17000001', '2017-09-08 21:12:17', '0');
INSERT INTO `t_payments` VALUES ('291', '2', '0', '1.00', '1', null, '350', '1', '17000007', '2017-09-08 21:12:31', '17000007', '2017-09-08 21:12:31', '0');
INSERT INTO `t_payments` VALUES ('292', '2', '0', '1.00', '2', '1156456987401440684', '351', '2', '17000007', '2017-09-08 21:14:04', '17000007', '2017-09-08 21:14:04', '0');
INSERT INTO `t_payments` VALUES ('293', '5', '0', '1.00', '1', null, '352', '1', '17000007', '2017-09-08 21:16:11', '17000007', '2017-09-08 21:16:11', '0');
INSERT INTO `t_payments` VALUES ('294', '2', '0', '1.00', '1', null, '353', '1', '17000007', '2017-09-08 21:18:04', '17000007', '2017-09-08 21:18:04', '0');
INSERT INTO `t_payments` VALUES ('295', '2', '0', '1.00', '1', null, '354', '1', '17000007', '2017-09-08 21:23:00', '17000007', '2017-09-08 21:23:00', '0');
INSERT INTO `t_payments` VALUES ('296', '2', '0', '1.00', '2', '1157152038755889645', '355', '2', '17000007', '2017-09-08 21:32:32', '17000007', '2017-09-08 21:32:32', '0');
INSERT INTO `t_payments` VALUES ('297', '1', '0', '1.00', '1', null, '356', '1', '17000007', '2017-09-08 21:34:17', '17000007', '2017-09-08 21:34:17', '0');
INSERT INTO `t_payments` VALUES ('298', '1', '0', '1.00', '1', null, '357', '1', '17000001', '2017-09-08 21:48:16', '17000001', '2017-09-08 21:48:16', '0');
INSERT INTO `t_payments` VALUES ('299', '1', '0', '10.00', '1', null, '358', '1', '17000001', '2017-09-08 21:49:08', '17000001', '2017-09-08 21:49:08', '0');
INSERT INTO `t_payments` VALUES ('300', '1', '0', '1.00', '1', null, '359', '1', '17000001', '2017-09-08 21:50:33', '17000001', '2017-09-08 21:50:33', '0');
INSERT INTO `t_payments` VALUES ('301', '1', '0', '1.00', '2', '1154180338574680654', '360', '2', '17000007', '2017-09-08 21:54:10', '17000007', '2017-09-08 21:54:10', '0');
INSERT INTO `t_payments` VALUES ('302', '5', '0', '1.00', '1', null, '361', '1', '17000002', '2017-09-08 21:55:22', '17000002', '2017-09-08 21:55:22', '0');
INSERT INTO `t_payments` VALUES ('303', '2', '0', '1.00', '1', null, '362', '1', '17000002', '2017-09-08 21:55:37', '17000002', '2017-09-08 21:55:37', '0');
INSERT INTO `t_payments` VALUES ('304', '1', '0', '1.00', '1', null, '363', '1', '17000007', '2017-09-08 22:12:49', '17000007', '2017-09-08 22:12:49', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';

-- ----------------------------
-- Records of t_recharges
-- ----------------------------
INSERT INTO `t_recharges` VALUES ('2', '17000004', 'R150374275630679326', '0', '1.00', null, '0', null, '0', '17000004', '2017-08-26 18:19:16', '17000004', '2017-08-26 18:19:16', '0');
INSERT INTO `t_recharges` VALUES ('3', '17000001', 'R150374279781876146', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-26 18:19:58', '17000001', '2017-08-26 18:19:58', '0');
INSERT INTO `t_recharges` VALUES ('4', '17000001', 'R150374280242128546', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-26 18:20:02', '17000001', '2017-08-26 18:20:02', '0');
INSERT INTO `t_recharges` VALUES ('5', '17000004', 'R150374284338567800', '0', '10.00', null, '0', null, '0', '17000004', '2017-08-26 18:20:43', '17000004', '2017-08-26 18:20:43', '0');
INSERT INTO `t_recharges` VALUES ('6', '17000004', 'R150374288150051025', '0', '1.00', null, '0', null, '0', '17000004', '2017-08-26 18:21:22', '17000004', '2017-08-26 18:21:22', '0');
INSERT INTO `t_recharges` VALUES ('7', '17000004', 'R150374292337726584', '0', '10.00', null, '0', null, '0', '17000004', '2017-08-26 18:22:03', '17000004', '2017-08-26 18:22:03', '0');
INSERT INTO `t_recharges` VALUES ('8', '17000002', 'R150388531491096769', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-28 09:55:15', '17000002', '2017-08-28 09:55:15', '0');
INSERT INTO `t_recharges` VALUES ('9', '17000001', 'R150389899596724656', '0', '50.00', null, '0', null, '0', '17000001', '2017-08-28 13:43:16', '17000001', '2017-08-28 13:43:16', '0');
INSERT INTO `t_recharges` VALUES ('10', '17000002', 'R150390379094153009', '0', '50.00', null, '0', null, '0', '17000002', '2017-08-28 15:03:11', '17000002', '2017-08-28 15:03:11', '0');
INSERT INTO `t_recharges` VALUES ('11', '17000002', 'R150390388905495843', '0', '50.00', null, '0', null, '0', '17000002', '2017-08-28 15:04:49', '17000002', '2017-08-28 15:04:49', '0');
INSERT INTO `t_recharges` VALUES ('12', '17000002', 'R150390410913042454', '0', '50.00', null, '0', null, '0', '17000002', '2017-08-28 15:08:29', '17000002', '2017-08-28 15:08:29', '0');
INSERT INTO `t_recharges` VALUES ('13', '17000002', 'R150391707450853073', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-28 18:44:35', '17000002', '2017-08-28 18:44:35', '0');
INSERT INTO `t_recharges` VALUES ('14', '17000002', 'R150391870369496478', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-28 19:11:44', '17000002', '2017-08-28 19:11:44', '0');
INSERT INTO `t_recharges` VALUES ('15', '17000003', 'R150391880873425990', '0', '10.00', null, '0', null, '0', '17000003', '2017-08-28 19:13:29', '17000003', '2017-08-28 19:13:29', '0');
INSERT INTO `t_recharges` VALUES ('16', '17000002', 'R150397158928177861', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-29 09:53:09', '17000002', '2017-08-29 09:53:09', '0');
INSERT INTO `t_recharges` VALUES ('17', '17000007', 'R150399060510734517', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('18', '17000007', 'R150399060511585594', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('19', '17000007', 'R150399060511862551', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('20', '17000007', 'R150399060512297556', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:10:05', '17000007', '2017-08-29 15:10:05', '0');
INSERT INTO `t_recharges` VALUES ('21', '17000007', 'R150399060978488218', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:10:10', '17000007', '2017-08-29 15:10:10', '0');
INSERT INTO `t_recharges` VALUES ('22', '17000007', 'R150399096029334015', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:16:00', '17000007', '2017-08-29 15:16:00', '0');
INSERT INTO `t_recharges` VALUES ('23', '17000007', 'R150399096077372887', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_recharges` VALUES ('24', '17000007', 'R150399096110864111', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:16:01', '17000007', '2017-08-29 15:16:01', '0');
INSERT INTO `t_recharges` VALUES ('25', '17000007', 'R150399097256945239', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:16:13', '17000007', '2017-08-29 15:16:13', '0');
INSERT INTO `t_recharges` VALUES ('26', '17000007', 'R150399098758968930', '0', '5000.00', null, '0', null, '0', '17000007', '2017-08-29 15:16:28', '17000007', '2017-08-29 15:16:28', '0');
INSERT INTO `t_recharges` VALUES ('27', '17000007', 'R150399550939786108', '0', '22.00', null, '0', null, '0', '17000007', '2017-08-29 16:31:49', '17000007', '2017-08-29 16:31:49', '0');
INSERT INTO `t_recharges` VALUES ('28', '17000007', 'R150399617605572302', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:42:56', '17000007', '2017-08-29 16:42:56', '0');
INSERT INTO `t_recharges` VALUES ('29', '17000007', 'R150399620525235004', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:43:25', '17000007', '2017-08-29 16:43:25', '0');
INSERT INTO `t_recharges` VALUES ('30', '17000007', 'R150399623197146763', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:43:52', '17000007', '2017-08-29 16:43:52', '0');
INSERT INTO `t_recharges` VALUES ('31', '17000007', 'R150399626590521873', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:44:26', '17000007', '2017-08-29 16:44:26', '0');
INSERT INTO `t_recharges` VALUES ('32', '17000007', 'R150399628643930949', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:44:46', '17000007', '2017-08-29 16:44:46', '0');
INSERT INTO `t_recharges` VALUES ('33', '17000007', 'R150399634962750838', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:45:50', '17000007', '2017-08-29 16:45:50', '0');
INSERT INTO `t_recharges` VALUES ('34', '17000007', 'R150399636993794867', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:46:10', '17000007', '2017-08-29 16:46:10', '0');
INSERT INTO `t_recharges` VALUES ('35', '17000007', 'R150399643120365663', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:47:11', '17000007', '2017-08-29 16:47:11', '0');
INSERT INTO `t_recharges` VALUES ('36', '17000007', 'R150399646947356783', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:47:49', '17000007', '2017-08-29 16:47:49', '0');
INSERT INTO `t_recharges` VALUES ('37', '17000007', 'R150399648742369190', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:48:07', '17000007', '2017-08-29 16:48:07', '0');
INSERT INTO `t_recharges` VALUES ('38', '17000007', 'R150399650681225986', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:48:27', '17000007', '2017-08-29 16:48:27', '0');
INSERT INTO `t_recharges` VALUES ('39', '17000007', 'R150399654630990557', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:49:06', '17000007', '2017-08-29 16:49:06', '0');
INSERT INTO `t_recharges` VALUES ('40', '17000007', 'R150399656718260661', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:49:27', '17000007', '2017-08-29 16:49:27', '0');
INSERT INTO `t_recharges` VALUES ('41', '17000001', 'R150399660698628836', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:50:07', '17000001', '2017-08-29 16:50:07', '0');
INSERT INTO `t_recharges` VALUES ('42', '17000007', 'R150399662206860377', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:50:22', '17000007', '2017-08-29 16:50:22', '0');
INSERT INTO `t_recharges` VALUES ('43', '17000002', 'R150399662709818608', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-29 16:50:27', '17000002', '2017-08-29 16:50:27', '0');
INSERT INTO `t_recharges` VALUES ('44', '17000001', 'R150399663610163282', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:50:36', '17000001', '2017-08-29 16:50:36', '0');
INSERT INTO `t_recharges` VALUES ('45', '17000007', 'R150399665376058066', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:50:54', '17000007', '2017-08-29 16:50:54', '0');
INSERT INTO `t_recharges` VALUES ('46', '17000001', 'R150399665441317664', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:50:54', '17000001', '2017-08-29 16:50:54', '0');
INSERT INTO `t_recharges` VALUES ('47', '17000001', 'R150399667895342060', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:51:19', '17000001', '2017-08-29 16:51:19', '0');
INSERT INTO `t_recharges` VALUES ('48', '17000007', 'R150399668356798260', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:51:24', '17000007', '2017-08-29 16:51:24', '0');
INSERT INTO `t_recharges` VALUES ('49', '17000002', 'R150399671839583774', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-29 16:51:58', '17000002', '2017-08-29 16:51:58', '0');
INSERT INTO `t_recharges` VALUES ('50', '17000001', 'R150399674528086289', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:52:25', '17000001', '2017-08-29 16:52:25', '0');
INSERT INTO `t_recharges` VALUES ('51', '17000001', 'R150399676426977273', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:52:44', '17000001', '2017-08-29 16:52:44', '0');
INSERT INTO `t_recharges` VALUES ('52', '17000001', 'R150399677068526697', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:52:51', '17000001', '2017-08-29 16:52:51', '0');
INSERT INTO `t_recharges` VALUES ('53', '17000001', 'R150399678206077635', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:53:02', '17000001', '2017-08-29 16:53:02', '0');
INSERT INTO `t_recharges` VALUES ('54', '17000007', 'R150399678537769887', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 16:53:05', '17000007', '2017-08-29 16:53:05', '0');
INSERT INTO `t_recharges` VALUES ('55', '17000002', 'R150399679750559884', '0', '1000.00', null, '0', null, '0', '17000002', '2017-08-29 16:53:18', '17000002', '2017-08-29 16:53:18', '0');
INSERT INTO `t_recharges` VALUES ('56', '17000001', 'R150399711079148113', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 16:58:31', '17000001', '2017-08-29 16:58:31', '0');
INSERT INTO `t_recharges` VALUES ('57', '17000001', 'R150399730675938242', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:01:47', '17000001', '2017-08-29 17:01:47', '0');
INSERT INTO `t_recharges` VALUES ('58', '17000001', 'R150399748473768850', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:04:45', '17000001', '2017-08-29 17:04:45', '0');
INSERT INTO `t_recharges` VALUES ('59', '17000001', 'R150399751968184468', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:05:20', '17000001', '2017-08-29 17:05:20', '0');
INSERT INTO `t_recharges` VALUES ('60', '17000001', 'R150399756619354002', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:06:06', '17000001', '2017-08-29 17:06:06', '0');
INSERT INTO `t_recharges` VALUES ('61', '17000005', 'R150399766906356543', '0', '10.00', null, '0', null, '0', '17000005', '2017-08-29 17:07:49', '17000005', '2017-08-29 17:07:49', '0');
INSERT INTO `t_recharges` VALUES ('62', '17000005', 'R150399772834824960', '0', '10.00', null, '0', null, '0', '17000005', '2017-08-29 17:08:48', '17000005', '2017-08-29 17:08:48', '0');
INSERT INTO `t_recharges` VALUES ('63', '17000007', 'R150399801483367380', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:13:35', '17000007', '2017-08-29 17:13:35', '0');
INSERT INTO `t_recharges` VALUES ('64', '17000005', 'R150399808842945875', '0', '10.00', null, '0', null, '0', '17000005', '2017-08-29 17:14:48', '17000005', '2017-08-29 17:14:48', '0');
INSERT INTO `t_recharges` VALUES ('65', '17000007', 'R150399809457410109', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:14:55', '17000007', '2017-08-29 17:14:55', '0');
INSERT INTO `t_recharges` VALUES ('66', '17000007', 'R150399815145769346', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:15:51', '17000007', '2017-08-29 17:15:51', '0');
INSERT INTO `t_recharges` VALUES ('67', '17000007', 'R150399822008031606', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:17:00', '17000007', '2017-08-29 17:17:00', '0');
INSERT INTO `t_recharges` VALUES ('68', '17000007', 'R150399825787447385', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:17:38', '17000007', '2017-08-29 17:17:38', '0');
INSERT INTO `t_recharges` VALUES ('69', '17000007', 'R150399830057951674', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:18:21', '17000007', '2017-08-29 17:18:21', '0');
INSERT INTO `t_recharges` VALUES ('70', '17000007', 'R150399833341181453', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:18:53', '17000007', '2017-08-29 17:18:53', '0');
INSERT INTO `t_recharges` VALUES ('71', '17000007', 'R150399835665926108', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:19:17', '17000007', '2017-08-29 17:19:17', '0');
INSERT INTO `t_recharges` VALUES ('72', '17000007', 'R150399837318614669', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:19:33', '17000007', '2017-08-29 17:19:33', '0');
INSERT INTO `t_recharges` VALUES ('73', '17000007', 'R150399839046476270', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:19:50', '17000007', '2017-08-29 17:19:50', '0');
INSERT INTO `t_recharges` VALUES ('74', '17000007', 'R150399853418685181', '0', '500.00', null, '0', null, '0', '17000007', '2017-08-29 17:22:14', '17000007', '2017-08-29 17:22:14', '0');
INSERT INTO `t_recharges` VALUES ('75', '17000007', 'R150399860887236259', '0', '500.00', null, '0', null, '0', '17000007', '2017-08-29 17:23:29', '17000007', '2017-08-29 17:23:29', '0');
INSERT INTO `t_recharges` VALUES ('76', '17000007', 'R150399938213455099', '0', '1000.00', null, '0', null, '0', '17000007', '2017-08-29 17:36:22', '17000007', '2017-08-29 17:36:22', '0');
INSERT INTO `t_recharges` VALUES ('77', '17000007', 'R150399941936078882', '0', '10.00', null, '0', null, '0', '17000007', '2017-08-29 17:36:59', '17000007', '2017-08-29 17:36:59', '0');
INSERT INTO `t_recharges` VALUES ('78', '17000001', 'R150399944414370725', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:37:24', '17000001', '2017-08-29 17:37:24', '0');
INSERT INTO `t_recharges` VALUES ('79', '17000001', 'R150399946707259002', '0', '10.00', null, '0', null, '0', '17000001', '2017-08-29 17:37:47', '17000001', '2017-08-29 17:37:47', '0');
INSERT INTO `t_recharges` VALUES ('80', '17000007', 'R150400149791621326', '0', '1.00', null, '0', null, '0', '17000007', '2017-08-29 18:11:38', '17000007', '2017-08-29 18:11:38', '0');
INSERT INTO `t_recharges` VALUES ('81', '17000007', 'R150400181264257854', '0', '1.00', null, '0', null, '0', '17000007', '2017-08-29 18:16:53', '17000007', '2017-08-29 18:16:53', '0');
INSERT INTO `t_recharges` VALUES ('82', '17000007', 'R150400194691267741', '0', '1.00', null, '0', null, '0', '17000007', '2017-08-29 18:19:07', '17000007', '2017-08-29 18:19:07', '0');
INSERT INTO `t_recharges` VALUES ('83', '17000002', 'R150401591896357635', '0', '1.00', null, '0', null, '0', '17000002', '2017-08-29 22:11:59', '17000002', '2017-08-29 22:11:59', '0');
INSERT INTO `t_recharges` VALUES ('84', '17000001', 'R150407318355373813', '0', '1.00', null, '0', null, '0', '17000001', '2017-08-30 14:06:24', '17000001', '2017-08-30 14:06:24', '0');
INSERT INTO `t_recharges` VALUES ('85', '17000001', 'R150407318701321506', '0', '1.00', null, '0', null, '0', '17000001', '2017-08-30 14:06:27', '17000001', '2017-08-30 14:06:27', '0');
INSERT INTO `t_recharges` VALUES ('86', '17000001', 'R150407324445273025', '0', '1.00', null, '0', null, '0', '17000001', '2017-08-30 14:07:24', '17000001', '2017-08-30 14:07:24', '0');
INSERT INTO `t_recharges` VALUES ('87', '17000001', 'R150407330550765201', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"146\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150407330550765201\",\"partner_id\":\"108674\",\"sign\":\"5d91ff471664f4b59d9510aa349bdddc\",\"trade_no\":\"1155390107135075084\"}', '0', null, '3', '17000001', '2017-08-30 14:47:43', '17000001', '2017-08-30 14:47:43', '0');
INSERT INTO `t_recharges` VALUES ('88', '17000002', 'R150415557010634556', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-31 12:59:30', '17000002', '2017-08-31 12:59:30', '0');
INSERT INTO `t_recharges` VALUES ('89', '17000002', 'R150415557544596656', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-31 12:59:35', '17000002', '2017-08-31 12:59:35', '0');
INSERT INTO `t_recharges` VALUES ('90', '17000002', 'R150415558891951587', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-31 12:59:49', '17000002', '2017-08-31 12:59:49', '0');
INSERT INTO `t_recharges` VALUES ('91', '17000002', 'R150415565426182555', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-31 13:00:54', '17000002', '2017-08-31 13:00:54', '0');
INSERT INTO `t_recharges` VALUES ('92', '17000002', 'R150415567572439886', '0', '10.00', null, '0', null, '0', '17000002', '2017-08-31 13:01:16', '17000002', '2017-08-31 13:01:16', '0');
INSERT INTO `t_recharges` VALUES ('93', '17000003', 'R150426618919486153', '0', '10.00', null, '0', null, '1', '17000003', '2017-09-01 19:43:09', '17000003', '2017-09-01 19:43:09', '0');
INSERT INTO `t_recharges` VALUES ('94', '17000003', 'R150426620193741171', '0', '10.00', null, '0', null, '1', '17000003', '2017-09-01 19:43:22', '17000003', '2017-09-01 19:43:22', '0');
INSERT INTO `t_recharges` VALUES ('95', '17000002', 'R150459942377870751', '0', '30.00', null, '0', null, '1', '17000002', '2017-09-05 16:17:04', '17000002', '2017-09-05 16:17:04', '0');
INSERT INTO `t_recharges` VALUES ('96', '17000002', 'R150459945953551109', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:17:40', '17000002', '2017-09-05 16:17:40', '0');
INSERT INTO `t_recharges` VALUES ('97', '17000002', 'R150459957003524269', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:19:30', '17000002', '2017-09-05 16:19:30', '0');
INSERT INTO `t_recharges` VALUES ('98', '17000002', 'R150459992311058387', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:25:23', '17000002', '2017-09-05 16:25:23', '0');
INSERT INTO `t_recharges` VALUES ('99', '17000002', 'R150460010812656025', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 16:28:28', '17000002', '2017-09-05 16:28:28', '0');
INSERT INTO `t_recharges` VALUES ('100', '17000002', 'R150460021640413572', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:30:16', '17000002', '2017-09-05 16:30:16', '0');
INSERT INTO `t_recharges` VALUES ('101', '17000002', 'R150460025437717796', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:30:54', '17000002', '2017-09-05 16:30:54', '0');
INSERT INTO `t_recharges` VALUES ('102', '17000002', 'R150460028093788170', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:31:21', '17000002', '2017-09-05 16:31:21', '0');
INSERT INTO `t_recharges` VALUES ('103', '17000002', 'R150460033538420738', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:32:15', '17000002', '2017-09-05 16:32:15', '0');
INSERT INTO `t_recharges` VALUES ('104', '17000002', 'R150460033752325761', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_recharges` VALUES ('105', '17000002', 'R150460033799647011', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:32:18', '17000002', '2017-09-05 16:32:18', '0');
INSERT INTO `t_recharges` VALUES ('106', '17000002', 'R150460037392322089', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 16:32:54', '17000002', '2017-09-05 16:32:54', '0');
INSERT INTO `t_recharges` VALUES ('107', '17000002', 'R150460051681562701', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 16:35:17', '17000002', '2017-09-05 16:35:17', '0');
INSERT INTO `t_recharges` VALUES ('108', '17000002', 'R150460053498329950', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:35:35', '17000002', '2017-09-05 16:35:35', '0');
INSERT INTO `t_recharges` VALUES ('109', '17000002', 'R150460064898661837', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:37:29', '17000002', '2017-09-05 16:37:29', '0');
INSERT INTO `t_recharges` VALUES ('110', '17000002', 'R150460065472217906', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_recharges` VALUES ('111', '17000002', 'R150460065488526942', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:37:35', '17000002', '2017-09-05 16:37:35', '0');
INSERT INTO `t_recharges` VALUES ('112', '17000002', 'R150460067761038791', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:37:58', '17000002', '2017-09-05 16:37:58', '0');
INSERT INTO `t_recharges` VALUES ('113', '17000002', 'R150460073214426285', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:38:52', '17000002', '2017-09-05 16:38:52', '0');
INSERT INTO `t_recharges` VALUES ('114', '17000002', 'R150460073294520038', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_recharges` VALUES ('115', '17000002', 'R150460073316232700', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:38:53', '17000002', '2017-09-05 16:38:53', '0');
INSERT INTO `t_recharges` VALUES ('116', '17000002', 'R150460074223070559', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:39:02', '17000002', '2017-09-05 16:39:02', '0');
INSERT INTO `t_recharges` VALUES ('117', '17000002', 'R150460101266484137', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:43:33', '17000002', '2017-09-05 16:43:33', '0');
INSERT INTO `t_recharges` VALUES ('118', '17000002', 'R150460107085236490', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_recharges` VALUES ('119', '17000002', 'R150460107106183582', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_recharges` VALUES ('120', '17000002', 'R150460107122511936', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_recharges` VALUES ('121', '17000002', 'R150460107140193255', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:31', '17000002', '2017-09-05 16:44:31', '0');
INSERT INTO `t_recharges` VALUES ('122', '17000002', 'R150460107156939536', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:32', '17000002', '2017-09-05 16:44:32', '0');
INSERT INTO `t_recharges` VALUES ('123', '17000002', 'R150460107321155489', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:33', '17000002', '2017-09-05 16:44:33', '0');
INSERT INTO `t_recharges` VALUES ('124', '17000002', 'R150460109720651730', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:44:57', '17000002', '2017-09-05 16:44:57', '0');
INSERT INTO `t_recharges` VALUES ('125', '17000002', 'R150460110238933109', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:45:02', '17000002', '2017-09-05 16:45:02', '0');
INSERT INTO `t_recharges` VALUES ('126', '17000002', 'R150460147996260674', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 16:51:20', '17000002', '2017-09-05 16:51:20', '0');
INSERT INTO `t_recharges` VALUES ('127', '17000002', 'R150460156158260175', '0', '500.00', null, '0', null, '1', '17000002', '2017-09-05 16:52:42', '17000002', '2017-09-05 16:52:42', '0');
INSERT INTO `t_recharges` VALUES ('128', '17000002', 'R150460169594536315', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:54:56', '17000002', '2017-09-05 16:54:56', '0');
INSERT INTO `t_recharges` VALUES ('129', '17000002', 'R150460177738154457', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 16:56:17', '17000002', '2017-09-05 16:56:17', '0');
INSERT INTO `t_recharges` VALUES ('130', '17000002', 'R150460177777255129', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 16:56:18', '17000002', '2017-09-05 16:56:18', '0');
INSERT INTO `t_recharges` VALUES ('131', '17000002', 'R150460178916051656', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:56:29', '17000002', '2017-09-05 16:56:29', '0');
INSERT INTO `t_recharges` VALUES ('132', '17000002', 'R150460179330816727', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 16:56:33', '17000002', '2017-09-05 16:56:33', '0');
INSERT INTO `t_recharges` VALUES ('133', '17000002', 'R150460213116255205', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 17:02:11', '17000002', '2017-09-05 17:02:11', '0');
INSERT INTO `t_recharges` VALUES ('134', '17000002', 'R150460216332765538', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 17:02:43', '17000002', '2017-09-05 17:02:43', '0');
INSERT INTO `t_recharges` VALUES ('135', '17000002', 'R150460217761159362', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 17:02:58', '17000002', '2017-09-05 17:02:58', '0');
INSERT INTO `t_recharges` VALUES ('136', '17000002', 'R150460222164545184', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 17:03:42', '17000002', '2017-09-05 17:03:42', '0');
INSERT INTO `t_recharges` VALUES ('137', '17000002', 'R150460241609623496', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 17:06:56', '17000002', '2017-09-05 17:06:56', '0');
INSERT INTO `t_recharges` VALUES ('138', '17000002', 'R150460278303744002', '0', '500.00', null, '0', null, '1', '17000002', '2017-09-05 17:13:03', '17000002', '2017-09-05 17:13:03', '0');
INSERT INTO `t_recharges` VALUES ('139', '17000002', 'R150460294497933844', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 17:15:45', '17000002', '2017-09-05 17:15:45', '0');
INSERT INTO `t_recharges` VALUES ('140', '17000002', 'R150460304974188412', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 17:17:30', '17000002', '2017-09-05 17:17:30', '0');
INSERT INTO `t_recharges` VALUES ('141', '17000002', 'R150460330857835719', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 17:21:49', '17000002', '2017-09-05 17:21:49', '0');
INSERT INTO `t_recharges` VALUES ('142', '17000002', 'R150460352132043020', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 17:25:21', '17000002', '2017-09-05 17:25:21', '0');
INSERT INTO `t_recharges` VALUES ('143', '17000002', 'R150460417720055340', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 17:36:17', '17000002', '2017-09-05 17:36:17', '0');
INSERT INTO `t_recharges` VALUES ('144', '17000002', 'R150461215563811015', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 19:49:16', '17000002', '2017-09-05 19:49:16', '0');
INSERT INTO `t_recharges` VALUES ('145', '17000002', 'R150461267731257575', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 19:57:57', '17000002', '2017-09-05 19:57:57', '0');
INSERT INTO `t_recharges` VALUES ('146', '17000002', 'R150461357307193115', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:12:53', '17000002', '2017-09-05 20:12:53', '0');
INSERT INTO `t_recharges` VALUES ('147', '17000002', 'R150461491657179950', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:35:17', '17000002', '2017-09-05 20:35:17', '0');
INSERT INTO `t_recharges` VALUES ('148', '17000002', 'R150461493040635194', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:35:30', '17000002', '2017-09-05 20:35:30', '0');
INSERT INTO `t_recharges` VALUES ('149', '17000002', 'R150461493695181556', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:35:37', '17000002', '2017-09-05 20:35:37', '0');
INSERT INTO `t_recharges` VALUES ('150', '17000002', 'R150461506386786260', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:37:44', '17000002', '2017-09-05 20:37:44', '0');
INSERT INTO `t_recharges` VALUES ('151', '17000002', 'R150461506923489056', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:37:49', '17000002', '2017-09-05 20:37:49', '0');
INSERT INTO `t_recharges` VALUES ('152', '17000002', 'R150461517424420157', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:39:34', '17000002', '2017-09-05 20:39:34', '0');
INSERT INTO `t_recharges` VALUES ('153', '17000002', 'R150461524572942174', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:40:46', '17000002', '2017-09-05 20:40:46', '0');
INSERT INTO `t_recharges` VALUES ('154', '17000002', 'R150461525367283245', '0', '1000.00', null, '0', null, '1', '17000002', '2017-09-05 20:40:54', '17000002', '2017-09-05 20:40:54', '0');
INSERT INTO `t_recharges` VALUES ('155', '17000002', 'R150461534348062528', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 20:42:23', '17000002', '2017-09-05 20:42:23', '0');
INSERT INTO `t_recharges` VALUES ('156', '17000002', 'R150461540960037091', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:43:30', '17000002', '2017-09-05 20:43:30', '0');
INSERT INTO `t_recharges` VALUES ('157', '17000002', 'R150461542863952421', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 20:43:49', '17000002', '2017-09-05 20:43:49', '0');
INSERT INTO `t_recharges` VALUES ('158', '17000002', 'R150461543372529835', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 20:43:54', '17000002', '2017-09-05 20:43:54', '0');
INSERT INTO `t_recharges` VALUES ('159', '17000002', 'R150461547171887650', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 20:44:32', '17000002', '2017-09-05 20:44:32', '0');
INSERT INTO `t_recharges` VALUES ('160', '17000002', 'R150461560712746082', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 20:46:47', '17000002', '2017-09-05 20:46:47', '0');
INSERT INTO `t_recharges` VALUES ('161', '17000002', 'R150461566987475828', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 20:47:50', '17000002', '2017-09-05 20:47:50', '0');
INSERT INTO `t_recharges` VALUES ('162', '17000002', 'R150461573546286224', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:48:55', '17000002', '2017-09-05 20:48:55', '0');
INSERT INTO `t_recharges` VALUES ('163', '17000002', 'R150461585058820448', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 20:50:51', '17000002', '2017-09-05 20:50:51', '0');
INSERT INTO `t_recharges` VALUES ('164', '17000002', 'R150461738339619295', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:16:23', '17000002', '2017-09-05 21:16:23', '0');
INSERT INTO `t_recharges` VALUES ('165', '17000002', 'R150461775153119394', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:22:32', '17000002', '2017-09-05 21:22:32', '0');
INSERT INTO `t_recharges` VALUES ('166', '17000002', 'R150461831675824378', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:31:57', '17000002', '2017-09-05 21:31:57', '0');
INSERT INTO `t_recharges` VALUES ('167', '17000002', 'R150461874757483596', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:39:08', '17000002', '2017-09-05 21:39:08', '0');
INSERT INTO `t_recharges` VALUES ('168', '17000002', 'R150461877823254141', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:39:38', '17000002', '2017-09-05 21:39:38', '0');
INSERT INTO `t_recharges` VALUES ('169', '17000002', 'R150461884557327556', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:40:46', '17000002', '2017-09-05 21:40:46', '0');
INSERT INTO `t_recharges` VALUES ('170', '17000002', 'R150461898609879467', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:43:06', '17000002', '2017-09-05 21:43:06', '0');
INSERT INTO `t_recharges` VALUES ('171', '17000002', 'R150461902004343910', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:43:40', '17000002', '2017-09-05 21:43:40', '0');
INSERT INTO `t_recharges` VALUES ('172', '17000002', 'R150461902515984320', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:43:45', '17000002', '2017-09-05 21:43:45', '0');
INSERT INTO `t_recharges` VALUES ('173', '17000002', 'R150461927029373972', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:47:50', '17000002', '2017-09-05 21:47:50', '0');
INSERT INTO `t_recharges` VALUES ('174', '17000002', 'R150461962316843438', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:53:43', '17000002', '2017-09-05 21:53:43', '0');
INSERT INTO `t_recharges` VALUES ('175', '17000002', 'R150461965385339518', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 21:54:14', '17000002', '2017-09-05 21:54:14', '0');
INSERT INTO `t_recharges` VALUES ('176', '17000002', 'R150461972221761319', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:55:22', '17000002', '2017-09-05 21:55:22', '0');
INSERT INTO `t_recharges` VALUES ('177', '17000002', 'R150461983132775008', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:57:11', '17000002', '2017-09-05 21:57:11', '0');
INSERT INTO `t_recharges` VALUES ('178', '17000002', 'R150461985994843995', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:57:40', '17000002', '2017-09-05 21:57:40', '0');
INSERT INTO `t_recharges` VALUES ('179', '17000002', 'R150461988997543047', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:58:10', '17000002', '2017-09-05 21:58:10', '0');
INSERT INTO `t_recharges` VALUES ('180', '17000002', 'R150461990042882452', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 21:58:20', '17000002', '2017-09-05 21:58:20', '0');
INSERT INTO `t_recharges` VALUES ('181', '17000002', 'R150462000310063873', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 22:00:03', '17000002', '2017-09-05 22:00:03', '0');
INSERT INTO `t_recharges` VALUES ('182', '17000002', 'R150462003572570613', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 22:00:36', '17000002', '2017-09-05 22:00:36', '0');
INSERT INTO `t_recharges` VALUES ('183', '17000002', 'R150462022394288431', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 22:03:44', '17000002', '2017-09-05 22:03:44', '0');
INSERT INTO `t_recharges` VALUES ('184', '17000002', 'R150462027295582935', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 22:04:33', '17000002', '2017-09-05 22:04:33', '0');
INSERT INTO `t_recharges` VALUES ('185', '17000002', 'R150462030125167179', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 22:05:01', '17000002', '2017-09-05 22:05:01', '0');
INSERT INTO `t_recharges` VALUES ('186', '17000002', 'R150462033803144948', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 22:05:38', '17000002', '2017-09-05 22:05:38', '0');
INSERT INTO `t_recharges` VALUES ('187', '17000002', 'R150462034353334755', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-05 22:05:44', '17000002', '2017-09-05 22:05:44', '0');
INSERT INTO `t_recharges` VALUES ('188', '17000002', 'R150462117963122460', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 22:19:40', '17000002', '2017-09-05 22:19:40', '0');
INSERT INTO `t_recharges` VALUES ('189', '17000002', 'R150462166618616195', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 22:27:46', '17000002', '2017-09-05 22:27:46', '0');
INSERT INTO `t_recharges` VALUES ('190', '17000002', 'R150462177509991291', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-05 22:29:35', '17000002', '2017-09-05 22:29:35', '0');
INSERT INTO `t_recharges` VALUES ('191', '17000002', 'R150462225003289003', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 22:37:30', '17000002', '2017-09-05 22:37:30', '0');
INSERT INTO `t_recharges` VALUES ('192', '17000002', 'R150462230026473798', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 22:38:20', '17000002', '2017-09-05 22:38:20', '0');
INSERT INTO `t_recharges` VALUES ('193', '17000002', 'R150462282666328459', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 22:47:07', '17000002', '2017-09-05 22:47:07', '0');
INSERT INTO `t_recharges` VALUES ('194', '17000002', 'R150462353859762359', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 22:58:59', '17000002', '2017-09-05 22:58:59', '0');
INSERT INTO `t_recharges` VALUES ('195', '17000002', 'R150462355298850551', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-05 22:59:13', '17000002', '2017-09-05 22:59:13', '0');
INSERT INTO `t_recharges` VALUES ('196', '17000002', 'R150463084234644376', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:00:42', '17000002', '2017-09-06 01:00:42', '0');
INSERT INTO `t_recharges` VALUES ('197', '17000002', 'R150463085870328271', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:00:59', '17000002', '2017-09-06 01:00:59', '0');
INSERT INTO `t_recharges` VALUES ('198', '17000002', 'R150463086074731164', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_recharges` VALUES ('199', '17000002', 'R150463086141856391', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_recharges` VALUES ('200', '17000002', 'R150463086394581755', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:04', '17000002', '2017-09-06 01:01:04', '0');
INSERT INTO `t_recharges` VALUES ('201', '17000002', 'R150463086748256536', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:07', '17000002', '2017-09-06 01:01:07', '0');
INSERT INTO `t_recharges` VALUES ('202', '17000002', 'R150463089988276706', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:40', '17000002', '2017-09-06 01:01:40', '0');
INSERT INTO `t_recharges` VALUES ('203', '17000002', 'R150463091547086276', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:55', '17000002', '2017-09-06 01:01:55', '0');
INSERT INTO `t_recharges` VALUES ('204', '17000002', 'R150463091632210465', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:01:56', '17000002', '2017-09-06 01:01:56', '0');
INSERT INTO `t_recharges` VALUES ('205', '17000002', 'R150463094439021382', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:02:24', '17000002', '2017-09-06 01:02:24', '0');
INSERT INTO `t_recharges` VALUES ('206', '17000002', 'R150463097293059788', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:02:53', '17000002', '2017-09-06 01:02:53', '0');
INSERT INTO `t_recharges` VALUES ('207', '17000002', 'R150463102797061230', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:03:48', '17000002', '2017-09-06 01:03:48', '0');
INSERT INTO `t_recharges` VALUES ('208', '17000002', 'R150463108300960727', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:04:43', '17000002', '2017-09-06 01:04:43', '0');
INSERT INTO `t_recharges` VALUES ('209', '17000002', 'R150463114851451050', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:05:49', '17000002', '2017-09-06 01:05:49', '0');
INSERT INTO `t_recharges` VALUES ('210', '17000002', 'R150463116067115389', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:06:01', '17000002', '2017-09-06 01:06:01', '0');
INSERT INTO `t_recharges` VALUES ('211', '17000002', 'R150463123858227228', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:07:19', '17000002', '2017-09-06 01:07:19', '0');
INSERT INTO `t_recharges` VALUES ('212', '17000002', 'R150463124115039295', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:07:21', '17000002', '2017-09-06 01:07:21', '0');
INSERT INTO `t_recharges` VALUES ('213', '17000002', 'R150463124389339650', '0', '50.00', null, '0', null, '1', '17000002', '2017-09-06 01:07:24', '17000002', '2017-09-06 01:07:24', '0');
INSERT INTO `t_recharges` VALUES ('214', '17000002', 'R150463125645189716', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:07:36', '17000002', '2017-09-06 01:07:36', '0');
INSERT INTO `t_recharges` VALUES ('215', '17000002', 'R150463140622818211', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:06', '17000002', '2017-09-06 01:10:06', '0');
INSERT INTO `t_recharges` VALUES ('216', '17000002', 'R150463140759018821', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_recharges` VALUES ('217', '17000002', 'R150463140814244560', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_recharges` VALUES ('218', '17000002', 'R150463140875033309', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_recharges` VALUES ('219', '17000002', 'R150463140930529071', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_recharges` VALUES ('220', '17000002', 'R150463140980574968', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_recharges` VALUES ('221', '17000002', 'R150463141029421478', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_recharges` VALUES ('222', '17000002', 'R150463141081456384', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_recharges` VALUES ('223', '17000002', 'R150463141133129767', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_recharges` VALUES ('224', '17000002', 'R150463141185889827', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:12', '17000002', '2017-09-06 01:10:12', '0');
INSERT INTO `t_recharges` VALUES ('225', '17000002', 'R150463142580429432', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:10:26', '17000002', '2017-09-06 01:10:26', '0');
INSERT INTO `t_recharges` VALUES ('226', '17000002', 'R150463244007568988', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:27:20', '17000002', '2017-09-06 01:27:20', '0');
INSERT INTO `t_recharges` VALUES ('227', '17000002', 'R150463244056696288', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_recharges` VALUES ('228', '17000002', 'R150463244097226087', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_recharges` VALUES ('229', '17000002', 'R150463244164263424', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_recharges` VALUES ('230', '17000002', 'R150463244213866455', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_recharges` VALUES ('231', '17000002', 'R150463355587082858', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:45:56', '17000002', '2017-09-06 01:45:56', '0');
INSERT INTO `t_recharges` VALUES ('232', '17000002', 'R150463355659948920', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:45:57', '17000002', '2017-09-06 01:45:57', '0');
INSERT INTO `t_recharges` VALUES ('233', '17000002', 'R150463362183486796', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:47:02', '17000002', '2017-09-06 01:47:02', '0');
INSERT INTO `t_recharges` VALUES ('234', '17000002', 'R150463362254770188', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_recharges` VALUES ('235', '17000002', 'R150463362276452436', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_recharges` VALUES ('236', '17000002', 'R150463362294651521', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_recharges` VALUES ('237', '17000002', 'R150463362310858898', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_recharges` VALUES ('238', '17000002', 'R150469133566826196', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:48:56', '17000002', '2017-09-06 17:48:56', '0');
INSERT INTO `t_recharges` VALUES ('239', '17000002', 'R150469134848355455', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:49:08', '17000002', '2017-09-06 17:49:08', '0');
INSERT INTO `t_recharges` VALUES ('240', '17000002', 'R150469141602038957', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:50:16', '17000002', '2017-09-06 17:50:16', '0');
INSERT INTO `t_recharges` VALUES ('241', '17000002', 'R150469147452746549', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:51:15', '17000002', '2017-09-06 17:51:15', '0');
INSERT INTO `t_recharges` VALUES ('242', '17000002', 'R150469150991542917', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:51:50', '17000002', '2017-09-06 17:51:50', '0');
INSERT INTO `t_recharges` VALUES ('243', '17000002', 'R150469155130333207', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:52:31', '17000002', '2017-09-06 17:52:31', '0');
INSERT INTO `t_recharges` VALUES ('244', '17000002', 'R150469165796011724', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:54:18', '17000002', '2017-09-06 17:54:18', '0');
INSERT INTO `t_recharges` VALUES ('245', '17000002', 'R150469169468917073', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:54:55', '17000002', '2017-09-06 17:54:55', '0');
INSERT INTO `t_recharges` VALUES ('246', '17000002', 'R150469172275210554', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:55:23', '17000002', '2017-09-06 17:55:23', '0');
INSERT INTO `t_recharges` VALUES ('247', '17000002', 'R150469174516981803', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:55:45', '17000002', '2017-09-06 17:55:45', '0');
INSERT INTO `t_recharges` VALUES ('248', '17000002', 'R150469176888963495', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:56:09', '17000002', '2017-09-06 17:56:09', '0');
INSERT INTO `t_recharges` VALUES ('249', '17000002', 'R150469178662015748', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:56:27', '17000002', '2017-09-06 17:56:27', '0');
INSERT INTO `t_recharges` VALUES ('250', '17000002', 'R150469179666733650', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:56:37', '17000002', '2017-09-06 17:56:37', '0');
INSERT INTO `t_recharges` VALUES ('251', '17000002', 'R150469182886319323', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:57:09', '17000002', '2017-09-06 17:57:09', '0');
INSERT INTO `t_recharges` VALUES ('252', '17000002', 'R150469185493025707', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 17:57:35', '17000002', '2017-09-06 17:57:35', '0');
INSERT INTO `t_recharges` VALUES ('253', '17000002', 'R150469239354615236', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 18:06:34', '17000002', '2017-09-06 18:06:34', '0');
INSERT INTO `t_recharges` VALUES ('254', '17000002', 'R150469255182899028', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 18:09:12', '17000002', '2017-09-06 18:09:12', '0');
INSERT INTO `t_recharges` VALUES ('255', '17000002', 'R150469262343060471', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 18:10:23', '17000002', '2017-09-06 18:10:23', '0');
INSERT INTO `t_recharges` VALUES ('256', '17000002', 'R150469263946223156', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 18:10:39', '17000002', '2017-09-06 18:10:39', '0');
INSERT INTO `t_recharges` VALUES ('257', '17000002', 'R150469266123211858', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 18:11:01', '17000002', '2017-09-06 18:11:01', '0');
INSERT INTO `t_recharges` VALUES ('258', '17000002', 'R150469609518833754', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 19:08:15', '17000002', '2017-09-06 19:08:15', '0');
INSERT INTO `t_recharges` VALUES ('259', '17000002', 'R150469611183896195', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 19:08:32', '17000002', '2017-09-06 19:08:32', '0');
INSERT INTO `t_recharges` VALUES ('260', '17000002', 'R150469612224243874', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 19:08:42', '17000002', '2017-09-06 19:08:42', '0');
INSERT INTO `t_recharges` VALUES ('261', '17000002', 'R150469702096733872', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 19:23:41', '17000002', '2017-09-06 19:23:41', '0');
INSERT INTO `t_recharges` VALUES ('262', '17000002', 'R150470251029190204', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 20:55:10', '17000002', '2017-09-06 20:55:10', '0');
INSERT INTO `t_recharges` VALUES ('263', '17000002', 'R150470255215487950', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-06 20:55:52', '17000002', '2017-09-06 20:55:52', '0');
INSERT INTO `t_recharges` VALUES ('264', '17000002', 'R150470268725942218', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 20:58:07', '17000002', '2017-09-06 20:58:07', '0');
INSERT INTO `t_recharges` VALUES ('265', '17000002', 'R150470289635171826', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 21:01:36', '17000002', '2017-09-06 21:01:36', '0');
INSERT INTO `t_recharges` VALUES ('266', '17000002', 'R150470356296257427', '0', '10.00', null, '0', null, '1', '17000002', '2017-09-06 21:12:43', '17000002', '2017-09-06 21:12:43', '0');
INSERT INTO `t_recharges` VALUES ('277', '17000003', 'R150486163784756063', '1', '30.00', null, '0', null, '1', '17000003', '2017-09-08 17:07:18', '17000003', '2017-09-08 17:07:18', '0');
INSERT INTO `t_recharges` VALUES ('278', '17000003', 'R150486312628189270', '1', '30.00', null, '0', null, '1', '17000003', '2017-09-08 17:32:06', '17000003', '2017-09-08 17:32:06', '0');
INSERT INTO `t_recharges` VALUES ('279', '17000003', 'R150486349569881462', '1', '30.00', null, '0', null, '1', '17000003', '2017-09-08 17:38:16', '17000003', '2017-09-08 17:38:16', '0');
INSERT INTO `t_recharges` VALUES ('280', '17000003', 'R150486426875726887', '1', '68.00', null, '0', null, '1', '17000003', '2017-09-08 17:51:09', '17000003', '2017-09-08 17:51:09', '0');
INSERT INTO `t_recharges` VALUES ('281', '17000003', 'R150486449298685262', '1', '30.00', null, '0', null, '1', '17000003', '2017-09-08 17:54:53', '17000003', '2017-09-08 17:54:53', '0');
INSERT INTO `t_recharges` VALUES ('282', '17000003', 'R150486501064642270', '1', '30.00', null, '0', null, '1', '17000003', '2017-09-08 18:03:31', '17000003', '2017-09-08 18:03:31', '0');
INSERT INTO `t_recharges` VALUES ('283', '17000003', 'R150486509081579347', '1', '518.00', null, '0', null, '1', '17000003', '2017-09-08 18:04:51', '17000003', '2017-09-08 18:04:51', '0');
INSERT INTO `t_recharges` VALUES ('284', '17000002', 'R150487173647434518', '1', '30.00', null, '0', null, '1', '17000002', '2017-09-08 19:55:36', '17000002', '2017-09-08 19:55:36', '0');
INSERT INTO `t_recharges` VALUES ('285', '17000002', 'R150487176481831200', '1', '30.00', null, '0', null, '1', '17000002', '2017-09-08 19:56:05', '17000002', '2017-09-08 19:56:05', '0');
INSERT INTO `t_recharges` VALUES ('286', '17000002', 'R150487180570729139', '1', '30.00', null, '0', null, '1', '17000002', '2017-09-08 19:56:46', '17000002', '2017-09-08 19:56:46', '0');
INSERT INTO `t_recharges` VALUES ('287', '17000007', 'R150487390170750523', '1', '30.00', null, '0', null, '1', '17000007', '2017-09-08 20:31:42', '17000007', '2017-09-08 20:31:42', '0');
INSERT INTO `t_recharges` VALUES ('288', '17000001', 'R150487627397411479', '0', '1.00', null, '0', null, '1', '17000001', '2017-09-08 21:11:14', '17000001', '2017-09-08 21:11:14', '0');
INSERT INTO `t_recharges` VALUES ('289', '17000001', 'R150487630374318079', '0', '1.00', null, '0', null, '1', '17000001', '2017-09-08 21:11:44', '17000001', '2017-09-08 21:11:44', '0');
INSERT INTO `t_recharges` VALUES ('290', '17000001', 'R150487633671495246', '0', '1.00', null, '0', null, '1', '17000001', '2017-09-08 21:12:17', '17000001', '2017-09-08 21:12:17', '0');
INSERT INTO `t_recharges` VALUES ('291', '17000007', 'R150487635145110002', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 21:12:31', '17000007', '2017-09-08 21:12:31', '0');
INSERT INTO `t_recharges` VALUES ('292', '17000007', 'R150487644395075684', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"351\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150487644395075684\",\"partner_id\":\"108674\",\"sign\":\"3f85bb2509f4200d12c6e96c66d906ab\",\"trade_no\":\"1156456987401440684\"}', '0', null, '2', '17000007', '2017-09-08 21:14:04', '17000007', '2017-09-08 21:14:04', '0');
INSERT INTO `t_recharges` VALUES ('293', '17000007', 'R150487657088614307', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 21:16:11', '17000007', '2017-09-08 21:16:11', '0');
INSERT INTO `t_recharges` VALUES ('294', '17000007', 'R150487668349450544', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 21:18:03', '17000007', '2017-09-08 21:18:03', '0');
INSERT INTO `t_recharges` VALUES ('295', '17000007', 'R150487698030684858', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 21:23:00', '17000007', '2017-09-08 21:23:00', '0');
INSERT INTO `t_recharges` VALUES ('296', '17000007', 'R150487755191935841', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"355\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150487755191935841\",\"partner_id\":\"108674\",\"sign\":\"798dd1c7fe244dac65e610380132c2e6\",\"trade_no\":\"1157152038755889645\"}', '0', null, '2', '17000007', '2017-09-08 21:32:32', '17000007', '2017-09-08 21:32:32', '0');
INSERT INTO `t_recharges` VALUES ('297', '17000007', 'R150487765718436731', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 21:34:17', '17000007', '2017-09-08 21:34:17', '0');
INSERT INTO `t_recharges` VALUES ('298', '17000001', 'R150487849553530922', '0', '1.00', null, '0', null, '1', '17000001', '2017-09-08 21:48:16', '17000001', '2017-09-08 21:48:16', '0');
INSERT INTO `t_recharges` VALUES ('299', '17000001', 'R150487854784366504', '0', '10.00', null, '0', null, '1', '17000001', '2017-09-08 21:49:08', '17000001', '2017-09-08 21:49:08', '0');
INSERT INTO `t_recharges` VALUES ('300', '17000001', 'R150487863288448472', '0', '1.00', null, '0', null, '1', '17000001', '2017-09-08 21:50:33', '17000001', '2017-09-08 21:50:33', '0');
INSERT INTO `t_recharges` VALUES ('301', '17000007', 'R150487885027874949', '1', '1.00', '{\"amount\":\"1.0000\",\"attach\":\"360\",\"code\":\"00\",\"message\":\"Pay Success\",\"order_no\":\"R150487885027874949\",\"partner_id\":\"108674\",\"sign\":\"4db8f56a7d5be53d1c75dca2f7fdcdb4\",\"trade_no\":\"1154180338574680654\"}', '0', null, '2', '17000007', '2017-09-08 21:54:10', '17000007', '2017-09-08 21:54:10', '0');
INSERT INTO `t_recharges` VALUES ('302', '17000002', 'R150487892199754989', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-08 21:55:22', '17000002', '2017-09-08 21:55:22', '0');
INSERT INTO `t_recharges` VALUES ('303', '17000002', 'R150487893743952905', '0', '1.00', null, '0', null, '1', '17000002', '2017-09-08 21:55:37', '17000002', '2017-09-08 21:55:37', '0');
INSERT INTO `t_recharges` VALUES ('304', '17000007', 'R150487996913614908', '0', '1.00', null, '0', null, '1', '17000007', '2017-09-08 22:12:49', '17000007', '2017-09-08 22:12:49', '0');
INSERT INTO `t_recharges` VALUES ('305', '17000001', 'R150659122373378997', '1', '100.00', '测试', '0', null, '1', '1', '2017-09-28 17:33:44', '1', '2017-09-28 17:33:44', '0');
INSERT INTO `t_recharges` VALUES ('306', '17000001', 'R150659133797996075', '1', '100.00', '测试', '0', null, '1', '1', '2017-09-28 17:35:38', '1', '2017-09-28 17:35:38', '0');
INSERT INTO `t_recharges` VALUES ('307', '17000001', 'R150659148475481486', '1', '90.00', '测试', '0', null, '1', '1', '2017-09-28 17:38:05', '1', '2017-09-28 17:38:05', '0');
INSERT INTO `t_recharges` VALUES ('308', '17000001', 'R150659319559076277', '1', '11.00', '测试', '0', null, '1', '1', '2017-09-28 18:06:36', '1', '2017-09-28 18:06:36', '0');
INSERT INTO `t_recharges` VALUES ('309', '17000001', 'R150665786893796729', '1', '101.00', '测试', '0', null, '1', '1', '2017-09-29 12:04:29', '1', '2017-09-29 12:04:29', '0');
INSERT INTO `t_recharges` VALUES ('310', '17000001', 'R150666302761560229', '1', '120.00', '测试充值', '0', null, '1', '1', '2017-09-29 13:30:28', '1', '2017-09-29 13:30:28', '0');
INSERT INTO `t_recharges` VALUES ('311', '17000001', 'R150676314947856715', '1', '111.00', '测试金额', '0', null, '1', '1', '2017-09-30 17:19:09', '1', '2017-09-30 17:19:09', '0');
INSERT INTO `t_recharges` VALUES ('312', '17000001', 'R150752074327839455', '1', '111.00', '测试充值admin', '0', null, '1', '1', '2017-10-09 11:45:43', '1', '2017-10-09 11:45:43', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('1', '1', '1', '0', '6.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '1', '2017-09-04 10:32:04', '1', '2017-09-04 10:32:04', '0');
INSERT INTO `t_user_account` VALUES ('3', '17000001', '1', '0', '0.00', '0.00', '-1.00', '0.00', '0.00', '0.00', '154', '17000001', '2017-10-12 16:42:03', '4', '2017-10-12 16:42:12', '0');
INSERT INTO `t_user_account` VALUES ('6', '17000002', '1', '0', '41.00', '100.00', '0.00', '0.00', '0.00', '0.00', '266', '17000002', '2017-09-05 20:05:00', '17000002', '2017-09-08 21:55:37', '0');
INSERT INTO `t_user_account` VALUES ('7', '17000009', '1', '0', '6.00', '2.00', '0.00', '0.00', '0.00', '0.00', '2', '17000009', '2017-09-04 10:32:08', '17000009', '2017-09-04 10:32:08', '0');
INSERT INTO `t_user_account` VALUES ('8', '17000003', '1', '0', '736.00', '736.00', '0.00', '0.00', '0.00', '0.00', '77', '17000003', '2017-09-08 15:27:53', '17000003', '2017-09-08 18:04:51', '0');
INSERT INTO `t_user_account` VALUES ('19', '17000007', '1', '0', '36.00', '33.00', '0.00', '0.00', '0.00', '0.00', '145', '17000007', '2017-09-08 20:08:38', '17000007', '2017-09-08 22:12:49', '0');
INSERT INTO `t_user_account` VALUES ('20', '17000012', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000012', '2017-09-27 11:20:21', '17000012', '2017-09-27 11:20:21', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户交易明细';

-- ----------------------------
-- Records of t_user_account_detail
-- ----------------------------
INSERT INTO `t_user_account_detail` VALUES ('10', '3', '17000001', 'R150407330550765201', '-1', '0.00', null, '1.00', '50', '0', '', '1', '0', '17000001', '2017-10-12 16:26:58', '1', '2017-10-12 16:26:58', '0');
INSERT INTO `t_user_account_detail` VALUES ('11', '3', '17000001', 'R150407330550765201', '-1', '0.00', null, '2.00', '50', '0', '', '2', '0', '17000001', '2017-10-12 16:46:21', '4', '2017-10-12 16:46:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('12', '3', '17000001', 'R150407330550765201', '-1', '1.00', null, '2.00', '50', '1', '测试不通过', '1', '0', '17000001', '2017-10-12 16:42:29', '4', '2017-10-12 16:42:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('13', '3', '17000001', 'R150407330550765201', '-1', '1.00', null, '2.00', '50', '0', '', '1', '0', '17000001', '2017-10-12 16:26:59', '4', '2017-10-12 16:26:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('14', '3', '17000001', 'R150407330550765201', '-1', '0.00', null, '2.00', '50', '0', '', '1', '0', '17000001', '2017-10-12 16:27:00', '4', '2017-10-12 16:27:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('15', '3', '17000001', 'R150407330550765201', '-1', '0.00', null, '3.00', '50', '1', '测试不通过', '1', '0', '17000001', '2017-10-12 16:42:19', '4', '2017-10-12 16:42:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('20', '3', '17000001', 'R150424242620597557', '1', '10.00', '4', '11.00', '10', '2', '测试金额测试充值10块', '1', '1', '17000001', '2017-09-04 19:40:42', '1', '2017-09-04 19:40:42', '0');
INSERT INTO `t_user_account_detail` VALUES ('23', '6', '17000002', 'R150424941331079226', '1', '10.00', '4', '10.00', '10', '2', '测试', '1', '1', '17000002', '2017-09-04 19:40:43', '1', '2017-09-04 19:40:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('24', '3', '17000001', 'R150425020769560470', '1', '11.00', '4', '22.00', '10', '2', '测试', '1', '1', '17000001', '2017-09-04 19:40:43', '1', '2017-09-04 19:40:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('25', '7', '17000009', 'R150425664342852646', '1', '1.00', '4', '1.00', '10', '2', '测试', '1', '1', '17000009', '2017-09-04 19:40:43', '1', '2017-09-04 19:40:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('26', '7', '17000009', 'R150425809274127437', '1', '2.00', '4', '3.00', '10', '2', '2', '1', '1', '17000009', '2017-09-04 19:40:44', '1', '2017-09-04 19:40:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('27', '3', '17000001', 'R150427831130913473', '1', '1.00', '4', '2.00', '10', '2', '2313233', '1', '1', '17000001', '2017-09-04 19:40:44', '17000001', '2017-09-04 19:40:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('28', '3', '17000001', 'W150450675145482207', '-1', '1.00', '4', '9.00', '50', '1', '财务审核不通过', '2', '1', '17000001', '2017-09-30 17:28:45', '17000022', '2017-09-30 17:28:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('29', '6', '17000002', 'R150461267731257575', '1', '50.00', '4', '6.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 19:57:57', '17000002', '2017-09-05 19:57:57', '0');
INSERT INTO `t_user_account_detail` VALUES ('30', '6', '17000002', 'R150461357307193115', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:12:53', '17000002', '2017-09-05 20:12:53', '0');
INSERT INTO `t_user_account_detail` VALUES ('31', '6', '17000002', 'R150461491657179950', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:35:17', '17000002', '2017-09-05 20:35:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('32', '6', '17000002', 'R150461493040635194', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:35:30', '17000002', '2017-09-05 20:35:30', '0');
INSERT INTO `t_user_account_detail` VALUES ('33', '6', '17000002', 'R150461493695181556', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:35:37', '17000002', '2017-09-05 20:35:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('34', '6', '17000002', 'R150461506386786260', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:37:44', '17000002', '2017-09-05 20:37:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('35', '6', '17000002', 'R150461506923489056', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:37:49', '17000002', '2017-09-05 20:37:49', '0');
INSERT INTO `t_user_account_detail` VALUES ('36', '6', '17000002', 'R150461517424420157', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:39:34', '17000002', '2017-09-05 20:39:34', '0');
INSERT INTO `t_user_account_detail` VALUES ('37', '6', '17000002', 'R150461524572942174', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:40:46', '17000002', '2017-09-05 20:40:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('38', '6', '17000002', 'R150461525367283245', '1', '1000.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:40:54', '17000002', '2017-09-05 20:40:54', '0');
INSERT INTO `t_user_account_detail` VALUES ('39', '6', '17000002', 'R150461534348062528', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:42:23', '17000002', '2017-09-05 20:42:23', '0');
INSERT INTO `t_user_account_detail` VALUES ('40', '6', '17000002', 'R150461540960037091', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:43:30', '17000002', '2017-09-05 20:43:30', '0');
INSERT INTO `t_user_account_detail` VALUES ('41', '6', '17000002', 'R150461542863952421', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:43:49', '17000002', '2017-09-05 20:43:49', '0');
INSERT INTO `t_user_account_detail` VALUES ('42', '6', '17000002', 'R150461543372529835', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:43:54', '17000002', '2017-09-05 20:43:54', '0');
INSERT INTO `t_user_account_detail` VALUES ('43', '6', '17000002', 'R150461547171887650', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:44:32', '17000002', '2017-09-05 20:44:32', '0');
INSERT INTO `t_user_account_detail` VALUES ('44', '6', '17000002', 'R150461560712746082', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:46:47', '17000002', '2017-09-05 20:46:47', '0');
INSERT INTO `t_user_account_detail` VALUES ('45', '6', '17000002', 'R150461566987475828', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:47:50', '17000002', '2017-09-05 20:47:50', '0');
INSERT INTO `t_user_account_detail` VALUES ('46', '6', '17000002', 'R150461573546286224', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:48:55', '17000002', '2017-09-05 20:48:55', '0');
INSERT INTO `t_user_account_detail` VALUES ('47', '6', '17000002', 'R150461585058820448', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 20:50:51', '17000002', '2017-09-05 20:50:51', '0');
INSERT INTO `t_user_account_detail` VALUES ('48', '6', '17000002', 'R150461738339619295', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:16:23', '17000002', '2017-09-05 21:16:23', '0');
INSERT INTO `t_user_account_detail` VALUES ('49', '6', '17000002', 'R150461775153119394', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:22:32', '17000002', '2017-09-05 21:22:32', '0');
INSERT INTO `t_user_account_detail` VALUES ('50', '6', '17000002', 'R150461831675824378', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:31:57', '17000002', '2017-09-05 21:31:57', '0');
INSERT INTO `t_user_account_detail` VALUES ('51', '6', '17000002', 'R150461874757483596', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:39:08', '17000002', '2017-09-05 21:39:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('52', '6', '17000002', 'R150461877823254141', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:39:38', '17000002', '2017-09-05 21:39:38', '0');
INSERT INTO `t_user_account_detail` VALUES ('53', '6', '17000002', 'R150461884557327556', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:40:46', '17000002', '2017-09-05 21:40:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('54', '6', '17000002', 'R150461898609879467', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:43:06', '17000002', '2017-09-05 21:43:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('55', '6', '17000002', 'R150461902004343910', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:43:40', '17000002', '2017-09-05 21:43:40', '0');
INSERT INTO `t_user_account_detail` VALUES ('56', '6', '17000002', 'R150461902515984320', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:43:45', '17000002', '2017-09-05 21:43:45', '0');
INSERT INTO `t_user_account_detail` VALUES ('57', '6', '17000002', 'R150461927029373972', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:47:50', '17000002', '2017-09-05 21:47:50', '0');
INSERT INTO `t_user_account_detail` VALUES ('58', '6', '17000002', 'R150461962316843438', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:53:43', '17000002', '2017-09-05 21:53:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('59', '6', '17000002', 'R150461965385339518', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:54:14', '17000002', '2017-09-05 21:54:14', '0');
INSERT INTO `t_user_account_detail` VALUES ('60', '6', '17000002', 'R150461972221761319', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:55:22', '17000002', '2017-09-05 21:55:22', '0');
INSERT INTO `t_user_account_detail` VALUES ('61', '6', '17000002', 'R150461983132775008', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:57:11', '17000002', '2017-09-05 21:57:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('62', '6', '17000002', 'R150461985994843995', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:57:40', '17000002', '2017-09-05 21:57:40', '0');
INSERT INTO `t_user_account_detail` VALUES ('63', '6', '17000002', 'R150461988997543047', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:58:10', '17000002', '2017-09-05 21:58:10', '0');
INSERT INTO `t_user_account_detail` VALUES ('64', '6', '17000002', 'R150461990042882452', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 21:58:20', '17000002', '2017-09-05 21:58:20', '0');
INSERT INTO `t_user_account_detail` VALUES ('65', '6', '17000002', 'R150462000310063873', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:00:03', '17000002', '2017-09-05 22:00:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('66', '6', '17000002', 'R150462003572570613', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:00:36', '17000002', '2017-09-05 22:00:36', '0');
INSERT INTO `t_user_account_detail` VALUES ('67', '6', '17000002', 'R150462022394288431', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:03:44', '17000002', '2017-09-05 22:03:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('68', '6', '17000002', 'R150462027295582935', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:04:33', '17000002', '2017-09-05 22:04:33', '0');
INSERT INTO `t_user_account_detail` VALUES ('69', '6', '17000002', 'R150462030125167179', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:05:01', '17000002', '2017-09-05 22:05:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('70', '6', '17000002', 'R150462033803144948', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:05:38', '17000002', '2017-09-05 22:05:38', '0');
INSERT INTO `t_user_account_detail` VALUES ('71', '6', '17000002', 'R150462034353334755', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:05:44', '17000002', '2017-09-05 22:05:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('72', '6', '17000002', 'R150462117963122460', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:19:40', '17000002', '2017-09-05 22:19:40', '0');
INSERT INTO `t_user_account_detail` VALUES ('73', '6', '17000002', 'R150462166618616195', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:27:46', '17000002', '2017-09-05 22:27:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('74', '6', '17000002', 'R150462177509991291', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:29:35', '17000002', '2017-09-05 22:29:35', '0');
INSERT INTO `t_user_account_detail` VALUES ('75', '6', '17000002', 'R150462225003289003', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:37:30', '17000002', '2017-09-05 22:37:30', '0');
INSERT INTO `t_user_account_detail` VALUES ('76', '6', '17000002', 'R150462230026473798', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:38:20', '17000002', '2017-09-05 22:38:20', '0');
INSERT INTO `t_user_account_detail` VALUES ('77', '6', '17000002', 'R150462282666328459', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:47:07', '17000002', '2017-09-05 22:47:07', '0');
INSERT INTO `t_user_account_detail` VALUES ('78', '6', '17000002', 'R150462353859762359', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:58:59', '17000002', '2017-09-05 22:58:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('79', '6', '17000002', 'R150462355298850551', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-05 22:59:13', '17000002', '2017-09-05 22:59:13', '0');
INSERT INTO `t_user_account_detail` VALUES ('80', '6', '17000002', 'R150463084234644376', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:00:42', '17000002', '2017-09-06 01:00:42', '0');
INSERT INTO `t_user_account_detail` VALUES ('81', '6', '17000002', 'R150463085870328271', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:00:59', '17000002', '2017-09-06 01:00:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('82', '6', '17000002', 'R150463086074731164', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('83', '6', '17000002', 'R150463086141856391', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:01', '17000002', '2017-09-06 01:01:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('84', '6', '17000002', 'R150463086394581755', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:04', '17000002', '2017-09-06 01:01:04', '0');
INSERT INTO `t_user_account_detail` VALUES ('85', '6', '17000002', 'R150463086748256536', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:08', '17000002', '2017-09-06 01:01:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('86', '6', '17000002', 'R150463089988276706', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:40', '17000002', '2017-09-06 01:01:40', '0');
INSERT INTO `t_user_account_detail` VALUES ('87', '6', '17000002', 'R150463091547086276', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:55', '17000002', '2017-09-06 01:01:55', '0');
INSERT INTO `t_user_account_detail` VALUES ('88', '6', '17000002', 'R150463091632210465', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:01:56', '17000002', '2017-09-06 01:01:56', '0');
INSERT INTO `t_user_account_detail` VALUES ('89', '6', '17000002', 'R150463094439021382', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:02:24', '17000002', '2017-09-06 01:02:24', '0');
INSERT INTO `t_user_account_detail` VALUES ('90', '6', '17000002', 'R150463097293059788', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:02:53', '17000002', '2017-09-06 01:02:53', '0');
INSERT INTO `t_user_account_detail` VALUES ('91', '6', '17000002', 'R150463102797061230', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:03:48', '17000002', '2017-09-06 01:03:48', '0');
INSERT INTO `t_user_account_detail` VALUES ('92', '6', '17000002', 'R150463108300960727', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:04:43', '17000002', '2017-09-06 01:04:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('93', '6', '17000002', 'R150463114851451050', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:05:49', '17000002', '2017-09-06 01:05:49', '0');
INSERT INTO `t_user_account_detail` VALUES ('94', '6', '17000002', 'R150463116067115389', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:06:01', '17000002', '2017-09-06 01:06:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('95', '6', '17000002', 'R150463123858227228', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:07:19', '17000002', '2017-09-06 01:07:19', '0');
INSERT INTO `t_user_account_detail` VALUES ('96', '6', '17000002', 'R150463124115039295', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:07:21', '17000002', '2017-09-06 01:07:21', '0');
INSERT INTO `t_user_account_detail` VALUES ('97', '6', '17000002', 'R150463124389339650', '1', '50.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:07:24', '17000002', '2017-09-06 01:07:24', '0');
INSERT INTO `t_user_account_detail` VALUES ('98', '6', '17000002', 'R150463125645189716', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:07:36', '17000002', '2017-09-06 01:07:36', '0');
INSERT INTO `t_user_account_detail` VALUES ('99', '6', '17000002', 'R150463140622818211', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:06', '17000002', '2017-09-06 01:10:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('100', '6', '17000002', 'R150463140759018821', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('101', '6', '17000002', 'R150463140814244560', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:08', '17000002', '2017-09-06 01:10:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('102', '6', '17000002', 'R150463140875033309', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('103', '6', '17000002', 'R150463140930529071', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:09', '17000002', '2017-09-06 01:10:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('104', '6', '17000002', 'R150463140980574968', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_user_account_detail` VALUES ('105', '6', '17000002', 'R150463141029421478', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:10', '17000002', '2017-09-06 01:10:10', '0');
INSERT INTO `t_user_account_detail` VALUES ('106', '6', '17000002', 'R150463141081456384', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('107', '6', '17000002', 'R150463141133129767', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:11', '17000002', '2017-09-06 01:10:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('108', '6', '17000002', 'R150463141185889827', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:12', '17000002', '2017-09-06 01:10:12', '0');
INSERT INTO `t_user_account_detail` VALUES ('109', '6', '17000002', 'R150463142580429432', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:10:26', '17000002', '2017-09-06 01:10:26', '0');
INSERT INTO `t_user_account_detail` VALUES ('110', '6', '17000002', 'R150463244007568988', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:27:20', '17000002', '2017-09-06 01:27:20', '0');
INSERT INTO `t_user_account_detail` VALUES ('111', '6', '17000002', 'R150463244056696288', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_user_account_detail` VALUES ('112', '6', '17000002', 'R150463244097226087', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:27:21', '17000002', '2017-09-06 01:27:21', '0');
INSERT INTO `t_user_account_detail` VALUES ('113', '6', '17000002', 'R150463244164263424', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_user_account_detail` VALUES ('114', '6', '17000002', 'R150463244213866455', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:27:22', '17000002', '2017-09-06 01:27:22', '0');
INSERT INTO `t_user_account_detail` VALUES ('115', '6', '17000002', 'R150463355587082858', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:45:56', '17000002', '2017-09-06 01:45:56', '0');
INSERT INTO `t_user_account_detail` VALUES ('116', '6', '17000002', 'R150463355659948920', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:45:57', '17000002', '2017-09-06 01:45:57', '0');
INSERT INTO `t_user_account_detail` VALUES ('117', '6', '17000002', 'R150463362183486796', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:47:02', '17000002', '2017-09-06 01:47:02', '0');
INSERT INTO `t_user_account_detail` VALUES ('118', '6', '17000002', 'R150463362254770188', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('119', '6', '17000002', 'R150463362276452436', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('120', '6', '17000002', 'R150463362294651521', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('121', '6', '17000002', 'R150463362310858898', '1', '10.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 01:47:03', '17000002', '2017-09-06 01:47:03', '0');
INSERT INTO `t_user_account_detail` VALUES ('122', '6', '17000002', 'R150469133566826196', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:48:56', '17000002', '2017-09-06 17:48:56', '0');
INSERT INTO `t_user_account_detail` VALUES ('123', '6', '17000002', 'R150469134848355455', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:49:08', '17000002', '2017-09-06 17:49:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('124', '6', '17000002', 'R150469141602038957', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:50:16', '17000002', '2017-09-06 17:50:16', '0');
INSERT INTO `t_user_account_detail` VALUES ('125', '6', '17000002', 'R150469147452746549', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:51:15', '17000002', '2017-09-06 17:51:15', '0');
INSERT INTO `t_user_account_detail` VALUES ('126', '6', '17000002', 'R150469150991542917', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:51:50', '17000002', '2017-09-06 17:51:50', '0');
INSERT INTO `t_user_account_detail` VALUES ('127', '6', '17000002', 'R150469155130333207', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:52:31', '17000002', '2017-09-06 17:52:31', '0');
INSERT INTO `t_user_account_detail` VALUES ('128', '6', '17000002', 'R150469165796011724', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:54:18', '17000002', '2017-09-06 17:54:18', '0');
INSERT INTO `t_user_account_detail` VALUES ('129', '6', '17000002', 'R150469169468917073', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:54:55', '17000002', '2017-09-06 17:54:55', '0');
INSERT INTO `t_user_account_detail` VALUES ('130', '6', '17000002', 'R150469172275210554', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:55:23', '17000002', '2017-09-06 17:55:23', '0');
INSERT INTO `t_user_account_detail` VALUES ('131', '6', '17000002', 'R150469174516981803', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:55:45', '17000002', '2017-09-06 17:55:45', '0');
INSERT INTO `t_user_account_detail` VALUES ('132', '6', '17000002', 'R150469176888963495', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:56:09', '17000002', '2017-09-06 17:56:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('133', '6', '17000002', 'R150469178662015748', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:56:27', '17000002', '2017-09-06 17:56:27', '0');
INSERT INTO `t_user_account_detail` VALUES ('134', '6', '17000002', 'R150469179666733650', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:56:37', '17000002', '2017-09-06 17:56:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('135', '6', '17000002', 'R150469182886319323', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:57:09', '17000002', '2017-09-06 17:57:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('136', '6', '17000002', 'R150469185493025707', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 17:57:35', '17000002', '2017-09-06 17:57:35', '0');
INSERT INTO `t_user_account_detail` VALUES ('137', '6', '17000002', 'R150469239354615236', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 18:06:34', '17000002', '2017-09-06 18:06:34', '0');
INSERT INTO `t_user_account_detail` VALUES ('138', '6', '17000002', 'R150469255182899028', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 18:09:12', '17000002', '2017-09-06 18:09:12', '0');
INSERT INTO `t_user_account_detail` VALUES ('139', '6', '17000002', 'R150469262343060471', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 18:10:23', '17000002', '2017-09-06 18:10:23', '0');
INSERT INTO `t_user_account_detail` VALUES ('140', '6', '17000002', 'R150469263946223156', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 18:10:39', '17000002', '2017-09-06 18:10:39', '0');
INSERT INTO `t_user_account_detail` VALUES ('141', '6', '17000002', 'R150469266123211858', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 18:11:01', '17000002', '2017-09-06 18:11:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('142', '6', '17000002', 'R150469609518833754', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 19:08:15', '17000002', '2017-09-06 19:08:15', '0');
INSERT INTO `t_user_account_detail` VALUES ('143', '6', '17000002', 'R150469611183896195', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 19:08:32', '17000002', '2017-09-06 19:08:32', '0');
INSERT INTO `t_user_account_detail` VALUES ('144', '6', '17000002', 'R150469612224243874', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 19:08:42', '17000002', '2017-09-06 19:08:42', '0');
INSERT INTO `t_user_account_detail` VALUES ('145', '6', '17000002', 'R150469702096733872', '1', '1.00', '4', '12.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-06 19:23:41', '17000002', '2017-09-06 19:23:41', '0');
INSERT INTO `t_user_account_detail` VALUES ('156', '8', '17000003', 'R150486163784756063', '1', '30.00', '4', '30.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 17:07:18', '17000003', '2017-09-08 17:07:18', '0');
INSERT INTO `t_user_account_detail` VALUES ('157', '8', '17000003', 'R150486312628189270', '1', '30.00', '4', '60.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 17:32:06', '17000003', '2017-09-08 17:32:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('158', '8', '17000003', 'R150486349569881462', '1', '30.00', '4', '90.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 17:38:16', '17000003', '2017-09-08 17:38:16', '0');
INSERT INTO `t_user_account_detail` VALUES ('159', '8', '17000003', 'R150486426875726887', '1', '68.00', '4', '158.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 17:51:09', '17000003', '2017-09-08 17:51:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('160', '8', '17000003', 'R150486449298685262', '1', '30.00', '4', '188.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 17:54:53', '17000003', '2017-09-08 17:54:53', '0');
INSERT INTO `t_user_account_detail` VALUES ('161', '8', '17000003', 'R150486501064642270', '1', '30.00', '4', '218.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 18:03:31', '17000003', '2017-09-08 18:03:31', '0');
INSERT INTO `t_user_account_detail` VALUES ('162', '8', '17000003', 'R150486509081579347', '1', '518.00', '4', '736.00', '10', '2', '玩家充值', null, '1', '17000003', '2017-09-08 18:04:51', '17000003', '2017-09-08 18:04:51', '0');
INSERT INTO `t_user_account_detail` VALUES ('163', '6', '17000002', 'R150487173647434518', '1', '30.00', '4', '42.00', '10', '2', '玩家充值', null, '1', '17000002', '2017-09-08 19:55:37', '17000002', '2017-09-08 19:55:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('164', '6', '17000002', 'R150487176481831200', '1', '30.00', '4', '72.00', '10', '2', '玩家充值', null, '1', '17000002', '2017-09-08 19:56:05', '17000002', '2017-09-08 19:56:05', '0');
INSERT INTO `t_user_account_detail` VALUES ('165', '6', '17000002', 'R150487180570729139', '1', '30.00', '4', '102.00', '10', '2', '玩家充值', null, '1', '17000002', '2017-09-08 19:56:46', '17000002', '2017-09-08 19:56:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('166', '19', '17000007', 'R150487390170750523', '1', '30.00', '4', '33.00', '10', '2', '玩家充值', null, '1', '17000007', '2017-09-08 20:31:42', '17000007', '2017-09-08 20:31:42', '0');
INSERT INTO `t_user_account_detail` VALUES ('167', '3', '17000001', 'R150487627397411479', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:11:14', '17000001', '2017-09-08 21:11:14', '0');
INSERT INTO `t_user_account_detail` VALUES ('168', '3', '17000001', 'R150487630374318079', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:11:44', '17000001', '2017-09-08 21:11:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('169', '3', '17000001', 'R150487633671495246', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:12:17', '17000001', '2017-09-08 21:12:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('170', '19', '17000007', 'R150487635145110002', '1', '1.00', '4', '33.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:12:31', '17000007', '2017-09-08 21:12:31', '0');
INSERT INTO `t_user_account_detail` VALUES ('171', '19', '17000007', 'R150487644395075684', '1', '1.00', '4', '33.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:14:04', '17000007', '2017-09-08 21:14:04', '0');
INSERT INTO `t_user_account_detail` VALUES ('172', '19', '17000007', 'R150487657088614307', '1', '1.00', '4', '33.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:16:11', '17000007', '2017-09-08 21:16:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('173', '19', '17000007', 'R150487668349450544', '1', '1.00', '4', '33.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:18:04', '17000007', '2017-09-08 21:18:04', '0');
INSERT INTO `t_user_account_detail` VALUES ('174', '19', '17000007', 'R150487698030684858', '1', '1.00', '4', '33.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:23:00', '17000007', '2017-09-08 21:23:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('175', '19', '17000007', 'R150487755191935841', '1', '1.00', '4', '34.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:32:32', '17000007', '2017-09-08 21:32:32', '0');
INSERT INTO `t_user_account_detail` VALUES ('176', '19', '17000007', 'R150487765718436731', '1', '1.00', '4', '35.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 21:34:17', '17000007', '2017-09-08 21:34:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('177', '3', '17000001', 'R150487849553530922', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:48:16', '17000001', '2017-09-08 21:48:16', '0');
INSERT INTO `t_user_account_detail` VALUES ('178', '3', '17000001', 'R150487854784366504', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:49:08', '17000001', '2017-09-08 21:49:08', '0');
INSERT INTO `t_user_account_detail` VALUES ('179', '3', '17000001', 'R150487863288448472', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000001', '2017-09-08 21:50:33', '17000001', '2017-09-08 21:50:33', '0');
INSERT INTO `t_user_account_detail` VALUES ('180', '19', '17000007', 'R150487885027874949', '1', '1.00', '4', '35.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-25 16:07:44', '17000007', '2017-09-25 16:07:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('181', '6', '17000002', 'R150487892199754989', '1', '1.00', '4', '102.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-08 21:55:22', '17000002', '2017-09-08 21:55:22', '0');
INSERT INTO `t_user_account_detail` VALUES ('182', '6', '17000002', 'R150487893743952905', '1', '1.00', '4', '102.00', '10', '5', '玩家充值', null, '1', '17000002', '2017-09-08 21:55:37', '17000002', '2017-09-08 21:55:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('183', '19', '17000007', 'R150487996913614908', '1', '1.00', '4', '36.00', '10', '5', '玩家充值', null, '1', '17000007', '2017-09-08 22:12:49', '17000007', '2017-09-08 22:12:49', '0');
INSERT INTO `t_user_account_detail` VALUES ('184', '3', '17000001', 'R150659122373378997', '1', '100.00', '4', '110.00', '11', '2', '测试', null, '1', '17000001', '2017-09-28 17:33:44', '17000001', '2017-09-28 17:33:44', '0');
INSERT INTO `t_user_account_detail` VALUES ('185', '3', '17000001', 'R150659133797996075', '1', '100.00', '4', '210.00', '11', '2', '测试', null, '1', '17000001', '2017-09-28 17:35:38', '17000001', '2017-09-28 17:35:38', '0');
INSERT INTO `t_user_account_detail` VALUES ('186', '3', '17000001', 'R150659148475481486', '1', '90.00', '4', '300.00', '11', '2', '测试', null, '1', '17000001', '2017-09-28 17:38:05', '17000001', '2017-09-28 17:38:05', '0');
INSERT INTO `t_user_account_detail` VALUES ('187', '3', '17000001', 'R150659319559076277', '1', '11.00', '4', '311.00', '11', '2', '测试', null, '1', '17000001', '2017-09-28 18:06:36', '17000001', '2017-09-28 18:06:36', '0');
INSERT INTO `t_user_account_detail` VALUES ('188', '3', '17000001', 'R150665786893796729', '1', '101.00', '4', '107.00', '11', '2', '测试', null, '1', '17000001', '2017-09-29 12:04:29', '17000001', '2017-09-29 12:04:29', '0');
INSERT INTO `t_user_account_detail` VALUES ('189', '3', '17000001', 'R150666302761560229', '1', '120.00', '4', '227.00', '11', '2', '测试充值', null, '1', '17000001', '2017-09-29 13:30:28', '17000001', '2017-09-29 13:30:28', '0');
INSERT INTO `t_user_account_detail` VALUES ('190', '3', '17000001', 'R150676314947856715', '1', '111.00', '4', '400.00', '11', '2', '测试金额', null, '1', '17000001', '2017-09-30 17:19:09', '17000001', '2017-09-30 17:19:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('191', '3', '17000001', 'R150752074327839455', '1', '111.00', '4', '511.00', '11', '2', '测试充值admin', null, '1', '17000001', '2017-10-09 11:45:43', '17000001', '2017-10-09 11:45:43', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户绑定卡片';

-- ----------------------------
-- Records of t_user_cards
-- ----------------------------
INSERT INTO `t_user_cards` VALUES ('1', '17000001', '12adsfsd12', '城西支行分行', '21', '0', '0', '2017-09-28 21:40:15', '1', '2017-09-28 21:40:15', '0', 'Damon 风柔');
INSERT INTO `t_user_cards` VALUES ('2', '17000004', '52121212321324324325', '杭州分行', '3', '0', '0', '0000-00-00 00:00:00', '0', null, '0', '阳光测试');
INSERT INTO `t_user_cards` VALUES ('4', '17000007', '332533623365332', '交通银行杭州分行中山支行', '25', '0', '0', '0000-00-00 00:00:00', '0', null, '0', '吴胡子');
INSERT INTO `t_user_cards` VALUES ('5', '17000005', '62284866688866', '城西支行', '18', '0', '0', '0000-00-00 00:00:00', '0', null, '0', 'Damon');
INSERT INTO `t_user_cards` VALUES ('6', '17000002', '62170071566363', '杭州分行中山支行', '1', '1', '1', '2017-08-31 20:41:00', '1', '2017-08-31 20:41:00', '0', '小魏');
INSERT INTO `t_user_cards` VALUES ('7', '17000003', '622848035220211112', '拱墅区支行', '21', '1', '1', '2017-09-01 19:38:52', '1', '2017-09-01 19:38:52', '0', '11111');

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
) ENGINE=InnoDB AUTO_INCREMENT=17000031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '15260282340', '2', '0', '1', '1', 'http://img.jsqq.net/uploads/allimg/150111/1_150111080328_19.jpg', '2017-10-10 20:32:15', '0', null, null, null, '5', '1', '2017-09-28 12:09:34', '1', '2017-09-28 12:09:34', '0', null, '2');
INSERT INTO `t_users` VALUES ('3', 'KF001', 'e10adc3949ba59abbe56e057f20f883e', '客服001', '15260282340', '2', '0', '3', '3', null, '2017-09-28 12:09:32', '0', '1', '3', null, '1', '1', '2017-09-28 12:09:32', '1', '2017-09-28 12:09:32', '0', null, '1977704195');
INSERT INTO `t_users` VALUES ('4', 'KF002', 'e10adc3949ba59abbe56e057f20f883e', '客服003', '15260282340', '2', '0', '3', '4', null, '2017-10-10 12:02:58', '0', '2', '4', null, '1', '1', '2017-10-10 12:02:58', '1', '2017-10-10 12:02:58', '0', null, '1977704192');
INSERT INTO `t_users` VALUES ('5', 'agdress', 'e10adc3949ba59abbe56e057f20f883e', '星河娱乐', '15901794296', '2', '0', '5', '5', null, '2017-09-25 11:16:09', '0', '1', null, null, '1', '1', '2017-09-25 11:16:09', null, '2017-09-25 11:16:09', '0', null, null);
INSERT INTO `t_users` VALUES ('6', 'agdress1', '81dc9bdb52d04dc20036dbd8313ed055', '我自己a', '15260282340', '2', '0', '5', '6', null, '2017-09-25 11:16:12', '0', '2', null, null, '3', '1', '2017-09-25 11:16:12', null, '2017-09-25 11:16:12', '0', null, null);
INSERT INTO `t_users` VALUES ('17000001', '15901794296', '423350', '阳光大佬2', '15901794296', '-1', '1', '0', '4', '2017090809061430402302.jpeg', '2017-09-30 17:01:18', '0', '1', '20361890', 'n', '6', '0', '2017-09-30 17:01:18', '1', '2017-09-30 17:01:18', '0', 'gogogo3', '9');
INSERT INTO `t_users` VALUES ('17000002', '18550473963', '242700', 'Damon 风', '18550473963', '-1', '1', '0', '4', '', '2017-09-30 12:08:18', '0', '1', '20533559', 'n', '14', '0', '2017-09-01 22:51:25', '17000002', '2017-09-30 12:08:18', '0', '17000002_9c0333b4-35cd-40a5-9e58-d55989788c1d', '11');
INSERT INTO `t_users` VALUES ('17000003', '18058159956', '646398', '18058159956', '18058159956', '-1', '1', '0', '4', null, '2017-09-06 23:04:44', '0', '1', '20575939', 'n', '1', '0', '2017-09-01 19:38:52', '17000003', '2017-09-06 23:04:44', '0', '17000003_a5eace0e-0280-439a-a159-d60ef6aaf602', '10');
INSERT INTO `t_users` VALUES ('17000004', '18321755892', '210281', '18321755892', '18321755892', '-1', '1', '0', null, null, '2017-08-26 18:13:56', '0', '1', '20695319', 'n', '0', '0', '2017-08-26 17:48:20', '17000004', '2017-08-26 18:13:56', '0', 'XH002589217000004', null);
INSERT INTO `t_users` VALUES ('17000005', '18050473963', '464782', '18050473963', '18050473963', '-1', '1', '0', '3', null, '2017-08-29 14:13:09', '0', '1', '20819946', 'n', '1', '0', '2017-08-29 14:13:09', '0', '2017-08-29 14:13:09', '0', 'XH002396317000005', null);
INSERT INTO `t_users` VALUES ('17000007', '18668223750', '584576', '胡子侠', '18668223750', '-1', '1', '0', '4', '2017090809063752608318.jpeg', '2017-09-08 22:12:12', '0', '1', '20820787', 'n', '9', '0', '2017-08-31 21:55:59', '17000007', '2017-09-08 22:12:12', '0', 'XH002375017000007', null);
INSERT INTO `t_users` VALUES ('17000008', 'LOOK1', 'e10adc3949ba59abbe56e057f20f883e', '我自己-赖', null, '2', '0', '7', null, null, '2017-09-01 17:11:00', '0', null, null, null, '1', '1', '2017-09-01 17:11:00', null, '2017-09-01 17:11:00', '0', null, '971083603');
INSERT INTO `t_users` VALUES ('17000009', '18550473933', '150189', '18550473933', '18550473933', '-1', '1', '0', '4', null, '2017-08-30 16:08:12', '0', '1', '20907618', 'n', '1', '0', '2017-08-30 16:08:12', '0', '2017-08-30 16:08:12', '0', 'XH002393317000009', null);
INSERT INTO `t_users` VALUES ('17000010', '15355046527', '391783', '15355046527', '15355046527', '-1', '1', '0', '4', null, '2017-09-01 19:40:34', '0', '1', '21075954', 'n', '1', '1', '2017-09-01 19:36:42', '17000010', '2017-09-01 19:40:34', '0', 'XH002652717000010', null);
INSERT INTO `t_users` VALUES ('17000012', '17767077763', '793841', '17767077763', '17767077763', '-1', '1', '0', '3', null, '2017-09-06 16:29:31', '0', '1', '21850971', 'n', '1', '1', '2017-09-06 16:29:30', '0', '2017-09-06 16:29:31', '0', 'XH002776317000012', null);
INSERT INTO `t_users` VALUES ('17000013', 'AV123456', 'e10adc3949ba59abbe56e057f20f883e', 'AV123456', null, '2', '0', '1', null, null, '2017-09-21 10:09:32', '0', null, null, null, '1', '1', '2017-09-21 10:09:32', null, '2017-09-21 10:09:32', '0', null, null);
INSERT INTO `t_users` VALUES ('17000015', 'root', 'e10adc3949ba59abbe56e057f20f883e', 'root', '15260282341', '2', '0', '2', null, null, '2017-09-21 13:57:58', '0', null, null, null, '1', '1', '2017-09-21 13:57:58', null, '2017-09-21 13:57:58', '0', null, null);
INSERT INTO `t_users` VALUES ('17000022', 'CW001', 'e10adc3949ba59abbe56e057f20f883e', '财务', '15260282340', '2', '0', '4', null, null, '2017-09-28 14:52:41', '0', '4', null, null, '1', '1', '2017-09-28 14:52:41', null, '2017-09-28 14:52:41', '0', null, null);
INSERT INTO `t_users` VALUES ('17000023', 'agdresstest1', 'e10adc3949ba59abbe56e057f20f883e', '代理商测试1', '15260282342', '2', '0', '5', null, null, '2017-09-28 20:42:25', '0', '5', null, null, '1', '1', '2017-09-28 20:42:25', null, '2017-09-28 20:42:25', '0', null, null);
INSERT INTO `t_users` VALUES ('17000024', 'agdresstest22', 'e10adc3949ba59abbe56e057f20f883e', '代理商测试', '15260282340', '2', '0', '5', null, null, null, '0', '6', null, null, '1', '1', '0000-00-00 00:00:00', null, null, '0', null, null);
INSERT INTO `t_users` VALUES ('17000030', '15260282340', '473753', '15260282340', '15260282340', '-1', '1', null, '3', null, '2017-10-10 15:16:46', '0', '1', '24635209', 'n', '1', '1', '2017-10-10 15:16:02', '17000030', '2017-10-10 15:16:46', '0', 'XH002234017000030', null);
