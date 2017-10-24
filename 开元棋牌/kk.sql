/*
Navicat MySQL Data Transfer

Source Server         : api——product
Source Server Version : 50637
Source Host           : 58.64.197.100:3306
Source Database       : kk

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-10-24 11:24:04
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
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片地址',
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of m_items
-- ----------------------------
INSERT INTO `m_items` VALUES ('1', 'R10', '10.png', '充10元', '0', '10.00', null, null, '1', '1', '2017-10-23 19:57:42', '1', '2017-10-23 19:57:42', '0');
INSERT INTO `m_items` VALUES ('2', 'R50', '50.png', '充50元', '0', '50.00', null, null, '1', '1', '2017-10-23 11:31:25', '1', '2017-10-23 11:31:25', '0');
INSERT INTO `m_items` VALUES ('3', 'R100', '100.png', '充100元', '0', '100.00', null, null, '1', '1', '2017-10-23 11:31:24', '1', '2017-10-23 11:31:24', '0');
INSERT INTO `m_items` VALUES ('4', 'R500', '500.png', '充500元', '0', '500.00', null, null, '1', '1', '2017-10-23 11:31:24', '1', '2017-10-23 11:31:24', '0');
INSERT INTO `m_items` VALUES ('11', 'R1000', '1000.png', '充1000', '0', '1000.00', null, null, '1', '1', '2017-10-23 11:31:24', null, '2017-10-23 11:31:24', '0');
INSERT INTO `m_items` VALUES ('12', 'R2000', '2000.png', '充2000', '0', '2000.00', null, null, '1', '1', '2017-10-23 11:31:23', null, '2017-10-23 11:31:23', '0');
INSERT INTO `m_items` VALUES ('14', 'R5000', '5000.png', '充5000', '0', '5000.00', null, null, '1', '1', '2017-10-23 11:31:23', null, '2017-10-23 11:31:23', '0');
INSERT INTO `m_items` VALUES ('15', 'kaiyuan1', '1.png', '充值1元', '0', '1.00', null, null, '1', '1', '2017-10-23 11:31:22', null, '2017-10-23 11:31:22', '0');
INSERT INTO `m_items` VALUES ('16', 'kaiyuan6', '6.png', '充值6元', '1', '6.00', null, null, '1', '1', '2017-10-23 11:31:29', null, '2017-10-23 11:31:29', '0');
INSERT INTO `m_items` VALUES ('17', 'kaiyuan30', '30.png', '充值30元', '1', '30.00', null, null, '1', '1', '2017-10-23 11:31:29', null, '2017-10-23 11:31:29', '0');
INSERT INTO `m_items` VALUES ('18', 'kaiyuan60', '60.png', '充值60元', '1', '60.00', null, null, '1', '1', '2017-10-23 11:31:30', null, '2017-10-23 11:31:30', '0');
INSERT INTO `m_items` VALUES ('19', 'kaiyuan128', '128.png', '充值128元', '1', '128.00', null, null, '1', '1', '2017-10-23 11:31:30', null, '2017-10-23 11:31:30', '0');
INSERT INTO `m_items` VALUES ('20', 'kaiyuan328', '328.png', '充值328元', '1', '328.00', null, null, '1', '1', '2017-10-23 11:31:30', null, '2017-10-23 11:31:30', '0');
INSERT INTO `m_items` VALUES ('21', 'kaiyuan648', '648.png', '充值648元', '1', '648.00', null, null, '1', '1', '2017-10-23 11:31:31', null, '2017-10-23 11:31:31', '0');

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
-- Table structure for `sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `data_kind` int(11) NOT NULL DEFAULT '0' COMMENT '数据分类（0：APP版本号，1：预留，2：预留，3：预留）',
  `data_value` varchar(50) DEFAULT NULL COMMENT '数据值',
  `str_col1` varchar(255) DEFAULT NULL COMMENT '预留字段（实际意思可根据不同的类型自行配置）',
  `str_col2` varchar(255) DEFAULT NULL COMMENT '预留字段（实际意思可根据不同的类型自行配置）',
  `int_col1` int(255) DEFAULT NULL,
  `int_col2` int(255) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '有效期开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '有效期结束时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `version_no` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '0', '100', null, null, '100', '1', null, null, 'int_col1代码APP版本号，int_col2代表是否需要内购', null, '1', '2017-09-30 17:32:45', '1', '2017-10-23 14:13:03', '0');
INSERT INTO `sys_config` VALUES ('4', '0', '110', null, null, '110', '0', '2017-10-23 14:13:06', null, null, null, '0', '2017-10-23 14:13:06', null, '2017-10-23 14:13:13', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

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
INSERT INTO `t_audit_logs` VALUES ('56', '304', '1', '1', 'ces', '1', '1', '2017-10-24 10:25:14', '1', '2017-10-24 10:25:14', '0');
INSERT INTO `t_audit_logs` VALUES ('57', '308', '1', '1', 'ceshi', '1', '1', '2017-10-24 10:26:37', '1', '2017-10-24 10:26:37', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('14', '10', 'fa fa-users text-aqua', '295', '1', '17000054', '2017-10-23 20:33:12', null, '2017-10-23 20:33:12', '0');
INSERT INTO `t_message` VALUES ('15', '10', 'fa fa-users text-aqua', '301', '1', '17000089', '2017-10-23 20:33:14', null, '2017-10-23 20:33:14', '0');
INSERT INTO `t_message` VALUES ('16', '10', 'fa fa-users text-aqua', '303', '1', '17000054', '2017-10-23 21:09:07', null, '2017-10-23 21:09:07', '0');
INSERT INTO `t_message` VALUES ('17', '50', 'fa fa-user text-red', '304', '1', '17000060', '2017-10-24 10:18:15', '17000060', '2017-10-24 10:18:15', '0');
INSERT INTO `t_message` VALUES ('18', '50', 'fa fa-user text-red', '308', '1', '17000060', '2017-10-24 10:24:54', '17000060', '2017-10-24 10:24:54', '0');
INSERT INTO `t_message` VALUES ('19', '10', 'fa fa-users text-aqua', '309', '1', '1', '2017-10-24 10:28:16', null, '2017-10-24 10:28:16', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_content
-- ----------------------------
INSERT INTO `t_message_content` VALUES ('40', '295', '1', '1', '小魏6 发起了一笔充值，金额：1.0，订单编号：R150876007220424204。', '0', '1', '17000054', '2017-10-23 20:33:12', null, '2017-10-23 20:33:12', '0');
INSERT INTO `t_message_content` VALUES ('41', '301', '1', '1', '11111111 发起了一笔充值，金额：1.0，订单编号：R150876111862581762。', '0', '1', '17000089', '2017-10-23 20:33:14', null, '2017-10-23 20:33:14', '0');
INSERT INTO `t_message_content` VALUES ('42', '303', '1', '1', '小魏6 发起了一笔充值，金额：1.0，订单编号：R150876408351749332。', '0', '1', '17000054', '2017-10-23 21:09:07', null, '2017-10-23 21:09:07', '0');
INSERT INTO `t_message_content` VALUES ('43', '304', '1', null, '你有一笔新的提现审核，编号：W150881149461462248。', '1', '2', '17000060', '2017-10-24 10:18:15', '1', '2017-10-24 10:25:14', '0');
INSERT INTO `t_message_content` VALUES ('44', '304', null, '1', 'huhuhu 发起了一笔大额提现申请，金额：100.0，订单编号：W150881149461462248。', '0', '1', '17000060', '2017-10-24 10:18:15', '17000060', '2017-10-24 10:18:15', '0');
INSERT INTO `t_message_content` VALUES ('45', '308', '1', null, '你有一笔新的提现审核，编号：W150881189427117233。', '1', '2', '17000060', '2017-10-24 10:24:54', '1', '2017-10-24 10:26:38', '0');
INSERT INTO `t_message_content` VALUES ('46', '308', null, '1', 'huhuhu 发起了一笔大额提现申请，金额：101.0，订单编号：W150881189427117233。', '0', '1', '17000060', '2017-10-24 10:24:54', '17000060', '2017-10-24 10:24:54', '0');
INSERT INTO `t_message_content` VALUES ('47', '309', '1', '1', 'huhuhu ]充值了1.0元，订单编号：R150881209521060016。', '0', '1', '1', '2017-10-24 10:28:16', null, '2017-10-24 10:28:16', '0');

-- ----------------------------
-- Table structure for `t_pay_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_type`;
CREATE TABLE `t_pay_type` (
  `pay_type` int(11) NOT NULL,
  `pay_name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '支付名称',
  `pay_alias` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '别名',
  `icon` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `is_recommend` int(11) DEFAULT '0',
  `sort` int(11) DEFAULT NULL,
  `version_no` bigint(20) NOT NULL DEFAULT '1' COMMENT '数据版本号 用于锁处理(存时间戳)',
  `create_by` bigint(20) NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '记录是否已删除',
  PRIMARY KEY (`pay_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_pay_type
-- ----------------------------
INSERT INTO `t_pay_type` VALUES ('1', '网银支付', null, null, '0', '99', '1', '1', '2017-10-23 16:26:25', null, '2017-10-23 16:26:25', '1');
INSERT INTO `t_pay_type` VALUES ('2', '微信扫码支付', 'WEIXIN', 'icon_wechatpay.png', '0', '2', '1', '1', '2017-10-23 16:26:21', null, '2017-10-23 16:26:21', '0');
INSERT INTO `t_pay_type` VALUES ('3', '支付宝扫码支付', 'ALIPAY', 'icon_alipay.png', '0', '99', '1', '1', '2017-10-23 16:26:26', null, '2017-10-23 16:26:26', '1');
INSERT INTO `t_pay_type` VALUES ('5', '支付宝支付', 'ALIPAYWAP', 'icon_alipay.png', '0', '3', '1', '1', '2017-10-23 20:54:32', null, '2017-10-23 20:54:32', '0');
INSERT INTO `t_pay_type` VALUES ('6', 'QQ扫描支付', 'QQ', 'icon_qqpay.png', '0', '99', '1', '1', '2017-10-23 16:26:27', null, '2017-10-23 16:26:27', '1');
INSERT INTO `t_pay_type` VALUES ('7', 'QQ钱包支付', 'QQWAP', 'icon_qqpay.png', '1', '1', '1', '1', '2017-10-23 16:26:20', null, '2017-10-23 16:26:20', '0');
INSERT INTO `t_pay_type` VALUES ('8', '苹果支付', null, null, '0', '99', '1', '1', '2017-10-23 16:26:28', null, '2017-10-23 16:26:28', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=467 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payment_records
-- ----------------------------
INSERT INTO `t_payment_records` VALUES ('428', '17000060', '0', 'R150839449906226793', '50.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:28:19', '17000060', '2017-10-19 14:28:19', '0');
INSERT INTO `t_payment_records` VALUES ('429', '17000060', '0', 'R150839453051653387', '100.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:28:51', '17000060', '2017-10-19 14:28:51', '0');
INSERT INTO `t_payment_records` VALUES ('430', '17000060', '0', 'R150839453904380620', '100.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:28:59', '17000060', '2017-10-19 14:28:59', '0');
INSERT INTO `t_payment_records` VALUES ('431', '17000060', '0', 'R150839455237563347', '500.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:29:12', '17000060', '2017-10-19 14:29:12', '0');
INSERT INTO `t_payment_records` VALUES ('432', '17000060', '0', 'R150839455725739260', '50.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:29:17', '17000060', '2017-10-19 14:29:17', '0');
INSERT INTO `t_payment_records` VALUES ('433', '17000060', '0', 'R150839456064011512', '50.00', '1', null, null, null, '1', '17000060', '2017-10-19 14:29:21', '17000060', '2017-10-19 14:29:21', '0');
INSERT INTO `t_payment_records` VALUES ('434', '17000059', '0', 'R150841557576945664', '100.00', '1', null, null, null, '1', '17000059', '2017-10-19 20:19:36', '17000059', '2017-10-19 20:19:36', '0');
INSERT INTO `t_payment_records` VALUES ('435', '17000081', '0', 'R150849105433044381', '50.00', '1', null, null, null, '1', '17000081', '2017-10-20 17:17:34', '17000081', '2017-10-20 17:17:34', '0');
INSERT INTO `t_payment_records` VALUES ('436', '17000081', '0', 'R150849106473045831', '50.00', '1', null, null, null, '1', '17000081', '2017-10-20 17:17:45', '17000081', '2017-10-20 17:17:45', '0');
INSERT INTO `t_payment_records` VALUES ('437', '17000081', '0', 'R150849108102878578', '50.00', '1', null, null, null, '1', '17000081', '2017-10-20 17:18:01', '17000081', '2017-10-20 17:18:01', '0');
INSERT INTO `t_payment_records` VALUES ('438', '17000059', '0', 'R150873871458816012', '1.00', '1', null, null, null, '1', '17000059', '2017-10-23 14:05:15', '17000059', '2017-10-23 14:05:15', '0');
INSERT INTO `t_payment_records` VALUES ('439', '17000059', '0', 'R150873871825917739', '1.00', '1', null, null, null, '1', '17000059', '2017-10-23 14:05:18', '17000059', '2017-10-23 14:05:18', '0');
INSERT INTO `t_payment_records` VALUES ('440', '17000059', '0', 'R150873871974873214', '1.00', '1', null, null, null, '1', '17000059', '2017-10-23 14:05:20', '17000059', '2017-10-23 14:05:20', '0');
INSERT INTO `t_payment_records` VALUES ('441', '17000060', '0', 'R150875589765944522', '1.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:51:38', '17000060', '2017-10-23 18:51:38', '0');
INSERT INTO `t_payment_records` VALUES ('442', '17000060', '0', 'R150875592027559400', '1.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:52:00', '17000060', '2017-10-23 18:52:00', '0');
INSERT INTO `t_payment_records` VALUES ('443', '17000060', '0', 'R150875592570639972', '1.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:52:06', '17000060', '2017-10-23 18:52:06', '0');
INSERT INTO `t_payment_records` VALUES ('444', '17000060', '0', 'R150875593372684086', '50.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:52:14', '17000060', '2017-10-23 18:52:14', '0');
INSERT INTO `t_payment_records` VALUES ('445', '17000060', '0', 'R150875593704049896', '1.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:52:17', '17000060', '2017-10-23 18:52:17', '0');
INSERT INTO `t_payment_records` VALUES ('446', '17000060', '0', 'R150875594112847113', '100.00', '1', null, null, null, '1', '17000060', '2017-10-23 18:52:21', '17000060', '2017-10-23 18:52:21', '0');
INSERT INTO `t_payment_records` VALUES ('447', '17000054', '0', 'R150875989471162089', '1.00', '1', null, null, null, '1', '17000054', '2017-10-23 19:58:15', '17000054', '2017-10-23 19:58:15', '0');
INSERT INTO `t_payment_records` VALUES ('448', '17000069', '0', 'R150875991181553423', '10.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:58:32', '17000069', '2017-10-23 19:58:32', '0');
INSERT INTO `t_payment_records` VALUES ('449', '17000069', '0', 'R150875992348591682', '1.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:58:43', '17000069', '2017-10-23 19:58:43', '0');
INSERT INTO `t_payment_records` VALUES ('450', '17000069', '0', 'R150875993011477725', '1.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:58:50', '17000069', '2017-10-23 19:58:50', '0');
INSERT INTO `t_payment_records` VALUES ('451', '17000069', '0', 'R150875993858973748', '1.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:58:59', '17000069', '2017-10-23 19:58:59', '0');
INSERT INTO `t_payment_records` VALUES ('452', '17000069', '0', 'R150875994992413104', '1.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:59:10', '17000069', '2017-10-23 19:59:10', '0');
INSERT INTO `t_payment_records` VALUES ('453', '17000069', '0', 'R150875995676848261', '50.00', '1', null, null, null, '1', '17000069', '2017-10-23 19:59:17', '17000069', '2017-10-23 19:59:17', '0');
INSERT INTO `t_payment_records` VALUES ('454', '17000054', '0', 'R150875999960437467', '1.00', '1', null, null, null, '1', '17000054', '2017-10-23 20:00:00', '17000054', '2017-10-23 20:00:00', '0');
INSERT INTO `t_payment_records` VALUES ('455', '17000054', '0', 'R150876007220424204', '1.00', '1', null, null, null, '1', '17000054', '2017-10-23 20:01:12', '17000054', '2017-10-23 20:01:12', '0');
INSERT INTO `t_payment_records` VALUES ('456', '17000065', '0', 'R150876043859043959', '10.00', '1', null, null, null, '1', '17000065', '2017-10-23 20:07:19', '17000065', '2017-10-23 20:07:19', '0');
INSERT INTO `t_payment_records` VALUES ('457', '17000065', '0', 'R150876048920735851', '10.00', '1', null, null, null, '1', '17000065', '2017-10-23 20:08:09', '17000065', '2017-10-23 20:08:09', '0');
INSERT INTO `t_payment_records` VALUES ('458', '17000065', '0', 'R150876052770133351', '10.00', '1', null, null, null, '1', '17000065', '2017-10-23 20:08:48', '17000065', '2017-10-23 20:08:48', '0');
INSERT INTO `t_payment_records` VALUES ('459', '17000065', '0', 'R150876055575047710', '10.00', '1', null, null, null, '1', '17000065', '2017-10-23 20:09:16', '17000065', '2017-10-23 20:09:16', '0');
INSERT INTO `t_payment_records` VALUES ('460', '17000089', '0', 'R150876110614969728', '1.00', '1', null, null, null, '1', '17000089', '2017-10-23 20:18:26', '17000089', '2017-10-23 20:18:26', '0');
INSERT INTO `t_payment_records` VALUES ('461', '17000089', '0', 'R150876111862581762', '1.00', '1', null, null, null, '1', '17000089', '2017-10-23 20:18:39', '17000089', '2017-10-23 20:18:39', '0');
INSERT INTO `t_payment_records` VALUES ('462', '17000089', '0', 'R150876120052513683', '10.00', '1', null, null, null, '1', '17000089', '2017-10-23 20:20:01', '17000089', '2017-10-23 20:20:01', '0');
INSERT INTO `t_payment_records` VALUES ('463', '17000054', '0', 'R150876408351749332', '1.00', '1', null, null, null, '1', '17000054', '2017-10-23 21:08:04', '17000054', '2017-10-23 21:08:04', '0');
INSERT INTO `t_payment_records` VALUES ('464', '17000060', '0', 'R150881162918610341', '1.00', '1', null, null, null, '1', '17000060', '2017-10-24 10:20:29', '17000060', '2017-10-24 10:20:29', '0');
INSERT INTO `t_payment_records` VALUES ('465', '17000060', '0', 'R150881163666892793', '10.00', '1', null, null, null, '1', '17000060', '2017-10-24 10:20:37', '17000060', '2017-10-24 10:20:37', '0');
INSERT INTO `t_payment_records` VALUES ('466', '17000060', '0', 'R150881164550887740', '100.00', '1', null, null, null, '1', '17000060', '2017-10-24 10:20:46', '17000060', '2017-10-24 10:20:46', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of t_payments
-- ----------------------------
INSERT INTO `t_payments` VALUES ('369', '7', '0', '50.00', '1', null, '428', '1', '17000060', '2017-10-19 14:28:19', '17000060', '2017-10-19 14:28:19', '0');
INSERT INTO `t_payments` VALUES ('370', '7', '0', '100.00', '1', null, '429', '1', '17000060', '2017-10-19 14:28:51', '17000060', '2017-10-19 14:28:51', '0');
INSERT INTO `t_payments` VALUES ('371', '2', '0', '100.00', '1', null, '430', '1', '17000060', '2017-10-19 14:28:59', '17000060', '2017-10-19 14:28:59', '0');
INSERT INTO `t_payments` VALUES ('372', '2', '0', '500.00', '1', null, '431', '1', '17000060', '2017-10-19 14:29:12', '17000060', '2017-10-19 14:29:12', '0');
INSERT INTO `t_payments` VALUES ('373', '2', '0', '50.00', '1', null, '432', '1', '17000060', '2017-10-19 14:29:17', '17000060', '2017-10-19 14:29:17', '0');
INSERT INTO `t_payments` VALUES ('374', '7', '0', '50.00', '1', null, '433', '1', '17000060', '2017-10-19 14:29:21', '17000060', '2017-10-19 14:29:21', '0');
INSERT INTO `t_payments` VALUES ('375', '2', '0', '100.00', '1', null, '434', '1', '17000059', '2017-10-19 20:19:36', '17000059', '2017-10-19 20:19:36', '0');
INSERT INTO `t_payments` VALUES ('376', '7', '0', '50.00', '1', null, '435', '1', '17000081', '2017-10-20 17:17:34', '17000081', '2017-10-20 17:17:34', '0');
INSERT INTO `t_payments` VALUES ('377', '2', '0', '50.00', '1', null, '436', '1', '17000081', '2017-10-20 17:17:45', '17000081', '2017-10-20 17:17:45', '0');
INSERT INTO `t_payments` VALUES ('378', '5', '0', '50.00', '1', null, '437', '1', '17000081', '2017-10-20 17:18:01', '17000081', '2017-10-20 17:18:01', '0');
INSERT INTO `t_payments` VALUES ('379', '5', '0', '1.00', '1', null, '438', '1', '17000059', '2017-10-23 14:05:15', '17000059', '2017-10-23 14:05:15', '0');
INSERT INTO `t_payments` VALUES ('380', '7', '0', '1.00', '1', null, '439', '1', '17000059', '2017-10-23 14:05:18', '17000059', '2017-10-23 14:05:18', '0');
INSERT INTO `t_payments` VALUES ('381', '2', '0', '1.00', '1', null, '440', '1', '17000059', '2017-10-23 14:05:20', '17000059', '2017-10-23 14:05:20', '0');
INSERT INTO `t_payments` VALUES ('382', '7', '0', '1.00', '1', null, '441', '1', '17000060', '2017-10-23 18:51:38', '17000060', '2017-10-23 18:51:38', '0');
INSERT INTO `t_payments` VALUES ('383', '2', '0', '1.00', '1', null, '442', '1', '17000060', '2017-10-23 18:52:00', '17000060', '2017-10-23 18:52:00', '0');
INSERT INTO `t_payments` VALUES ('384', '2', '0', '1.00', '1', null, '443', '1', '17000060', '2017-10-23 18:52:06', '17000060', '2017-10-23 18:52:06', '0');
INSERT INTO `t_payments` VALUES ('385', '2', '0', '50.00', '1', null, '444', '1', '17000060', '2017-10-23 18:52:14', '17000060', '2017-10-23 18:52:14', '0');
INSERT INTO `t_payments` VALUES ('386', '2', '0', '1.00', '1', null, '445', '1', '17000060', '2017-10-23 18:52:17', '17000060', '2017-10-23 18:52:17', '0');
INSERT INTO `t_payments` VALUES ('387', '5', '0', '100.00', '1', null, '446', '1', '17000060', '2017-10-23 18:52:21', '17000060', '2017-10-23 18:52:21', '0');
INSERT INTO `t_payments` VALUES ('388', '2', '0', '1.00', '1', null, '447', '1', '17000054', '2017-10-23 19:58:15', '17000054', '2017-10-23 19:58:15', '0');
INSERT INTO `t_payments` VALUES ('389', '2', '0', '10.00', '1', null, '448', '1', '17000069', '2017-10-23 19:58:32', '17000069', '2017-10-23 19:58:32', '0');
INSERT INTO `t_payments` VALUES ('390', '2', '0', '1.00', '1', null, '449', '1', '17000069', '2017-10-23 19:58:43', '17000069', '2017-10-23 19:58:43', '0');
INSERT INTO `t_payments` VALUES ('391', '2', '0', '1.00', '1', null, '450', '1', '17000069', '2017-10-23 19:58:50', '17000069', '2017-10-23 19:58:50', '0');
INSERT INTO `t_payments` VALUES ('392', '2', '0', '1.00', '1', null, '451', '1', '17000069', '2017-10-23 19:58:59', '17000069', '2017-10-23 19:58:59', '0');
INSERT INTO `t_payments` VALUES ('393', '2', '0', '1.00', '1', null, '452', '1', '17000069', '2017-10-23 19:59:10', '17000069', '2017-10-23 19:59:10', '0');
INSERT INTO `t_payments` VALUES ('394', '5', '0', '50.00', '1', null, '453', '1', '17000069', '2017-10-23 19:59:17', '17000069', '2017-10-23 19:59:17', '0');
INSERT INTO `t_payments` VALUES ('395', '5', '0', '1.00', '1', null, '454', '1', '17000054', '2017-10-23 20:00:00', '17000054', '2017-10-23 20:00:00', '0');
INSERT INTO `t_payments` VALUES ('396', '2', '0', '1.00', '2', 'RX1710232002875227917', '455', '2', '17000054', '2017-10-23 20:01:12', '17000054', '2017-10-23 20:33:11', '0');
INSERT INTO `t_payments` VALUES ('397', '2', '0', '10.00', '1', null, '456', '1', '17000065', '2017-10-23 20:07:19', '17000065', '2017-10-23 20:07:19', '0');
INSERT INTO `t_payments` VALUES ('398', '2', '0', '10.00', '1', null, '457', '1', '17000065', '2017-10-23 20:08:09', '17000065', '2017-10-23 20:08:09', '0');
INSERT INTO `t_payments` VALUES ('399', '2', '0', '10.00', '1', null, '458', '1', '17000065', '2017-10-23 20:08:48', '17000065', '2017-10-23 20:08:48', '0');
INSERT INTO `t_payments` VALUES ('400', '2', '0', '10.00', '1', null, '459', '1', '17000065', '2017-10-23 20:09:16', '17000065', '2017-10-23 20:09:16', '0');
INSERT INTO `t_payments` VALUES ('401', '2', '0', '1.00', '1', null, '460', '1', '17000089', '2017-10-23 20:18:26', '17000089', '2017-10-23 20:18:26', '0');
INSERT INTO `t_payments` VALUES ('402', '2', '0', '1.00', '2', 'RX1710232019333232570', '461', '2', '17000089', '2017-10-23 20:18:39', '17000089', '2017-10-23 20:33:13', '0');
INSERT INTO `t_payments` VALUES ('403', '7', '0', '10.00', '1', null, '462', '1', '17000089', '2017-10-23 20:20:01', '17000089', '2017-10-23 20:20:01', '0');
INSERT INTO `t_payments` VALUES ('404', '2', '0', '1.00', '2', 'RX1710232109114246265', '463', '2', '17000054', '2017-10-23 21:08:04', '17000054', '2017-10-23 21:09:07', '0');
INSERT INTO `t_payments` VALUES ('405', '2', '0', '1.00', '1', null, '464', '1', '17000060', '2017-10-24 10:20:29', '17000060', '2017-10-24 10:20:29', '0');
INSERT INTO `t_payments` VALUES ('406', '2', '0', '10.00', '1', null, '465', '1', '17000060', '2017-10-24 10:20:37', '17000060', '2017-10-24 10:20:37', '0');
INSERT INTO `t_payments` VALUES ('407', '2', '0', '100.00', '1', null, '466', '1', '17000060', '2017-10-24 10:20:46', '17000060', '2017-10-24 10:20:46', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';

-- ----------------------------
-- Records of t_recharges
-- ----------------------------
INSERT INTO `t_recharges` VALUES ('377', '17000060', 'R150839449906226793', '0', '50.00', null, '0', null, '1', '17000060', '2017-10-19 14:28:19', '17000060', '2017-10-19 14:28:19', '0');
INSERT INTO `t_recharges` VALUES ('378', '17000060', 'R150839453051653387', '0', '100.00', null, '0', null, '1', '17000060', '2017-10-19 14:28:51', '17000060', '2017-10-19 14:28:51', '0');
INSERT INTO `t_recharges` VALUES ('379', '17000060', 'R150839453904380620', '0', '100.00', null, '0', null, '1', '17000060', '2017-10-19 14:28:59', '17000060', '2017-10-19 14:28:59', '0');
INSERT INTO `t_recharges` VALUES ('380', '17000060', 'R150839455237563347', '0', '500.00', null, '0', null, '1', '17000060', '2017-10-19 14:29:12', '17000060', '2017-10-19 14:29:12', '0');
INSERT INTO `t_recharges` VALUES ('381', '17000060', 'R150839455725739260', '0', '50.00', null, '0', null, '1', '17000060', '2017-10-19 14:29:17', '17000060', '2017-10-19 14:29:17', '0');
INSERT INTO `t_recharges` VALUES ('382', '17000060', 'R150839456064011512', '0', '50.00', null, '0', null, '1', '17000060', '2017-10-19 14:29:21', '17000060', '2017-10-19 14:29:21', '0');
INSERT INTO `t_recharges` VALUES ('383', '17000059', 'R150841557576945664', '0', '100.00', null, '0', null, '1', '17000059', '2017-10-19 20:19:36', '17000059', '2017-10-19 20:19:36', '0');
INSERT INTO `t_recharges` VALUES ('384', '17000056', 'R150849081322844735', '1', '500.00', '系统上线测试用', '0', null, '1', '1', '2017-10-20 17:13:33', '1', '2017-10-20 17:13:33', '0');
INSERT INTO `t_recharges` VALUES ('385', '17000060', 'R150849099011044734', '1', '500.00', '系统上线测试用', '0', null, '1', '1', '2017-10-20 17:16:30', '1', '2017-10-20 17:16:30', '0');
INSERT INTO `t_recharges` VALUES ('386', '17000081', 'R150849105433044381', '0', '50.00', null, '0', null, '1', '17000081', '2017-10-20 17:17:34', '17000081', '2017-10-20 17:17:34', '0');
INSERT INTO `t_recharges` VALUES ('387', '17000081', 'R150849106473045831', '0', '50.00', null, '0', null, '1', '17000081', '2017-10-20 17:17:45', '17000081', '2017-10-20 17:17:45', '0');
INSERT INTO `t_recharges` VALUES ('388', '17000081', 'R150849108102878578', '0', '50.00', null, '0', null, '1', '17000081', '2017-10-20 17:18:01', '17000081', '2017-10-20 17:18:01', '0');
INSERT INTO `t_recharges` VALUES ('389', '17000059', 'R150873871458816012', '0', '1.00', null, '0', null, '1', '17000059', '2017-10-23 14:05:15', '17000059', '2017-10-23 14:05:15', '0');
INSERT INTO `t_recharges` VALUES ('390', '17000059', 'R150873871825917739', '0', '1.00', null, '0', null, '1', '17000059', '2017-10-23 14:05:18', '17000059', '2017-10-23 14:05:18', '0');
INSERT INTO `t_recharges` VALUES ('391', '17000059', 'R150873871974873214', '0', '1.00', null, '0', null, '1', '17000059', '2017-10-23 14:05:20', '17000059', '2017-10-23 14:05:20', '0');
INSERT INTO `t_recharges` VALUES ('392', '17000060', 'R150875589765944522', '0', '1.00', null, '0', null, '1', '17000060', '2017-10-23 18:51:38', '17000060', '2017-10-23 18:51:38', '0');
INSERT INTO `t_recharges` VALUES ('393', '17000060', 'R150875592027559400', '0', '1.00', null, '0', null, '1', '17000060', '2017-10-23 18:52:00', '17000060', '2017-10-23 18:52:00', '0');
INSERT INTO `t_recharges` VALUES ('394', '17000060', 'R150875592570639972', '0', '1.00', null, '0', null, '1', '17000060', '2017-10-23 18:52:06', '17000060', '2017-10-23 18:52:06', '0');
INSERT INTO `t_recharges` VALUES ('395', '17000060', 'R150875593372684086', '0', '50.00', null, '0', null, '1', '17000060', '2017-10-23 18:52:14', '17000060', '2017-10-23 18:52:14', '0');
INSERT INTO `t_recharges` VALUES ('396', '17000060', 'R150875593704049896', '0', '1.00', null, '0', null, '1', '17000060', '2017-10-23 18:52:17', '17000060', '2017-10-23 18:52:17', '0');
INSERT INTO `t_recharges` VALUES ('397', '17000060', 'R150875594112847113', '0', '100.00', null, '0', null, '1', '17000060', '2017-10-23 18:52:21', '17000060', '2017-10-23 18:52:21', '0');
INSERT INTO `t_recharges` VALUES ('398', '17000054', 'R150875989471162089', '0', '1.00', null, '0', null, '1', '17000054', '2017-10-23 19:58:15', '17000054', '2017-10-23 19:58:15', '0');
INSERT INTO `t_recharges` VALUES ('399', '17000069', 'R150875991181553423', '0', '10.00', null, '0', null, '1', '17000069', '2017-10-23 19:58:32', '17000069', '2017-10-23 19:58:32', '0');
INSERT INTO `t_recharges` VALUES ('400', '17000069', 'R150875992348591682', '0', '1.00', null, '0', null, '1', '17000069', '2017-10-23 19:58:43', '17000069', '2017-10-23 19:58:43', '0');
INSERT INTO `t_recharges` VALUES ('401', '17000069', 'R150875993011477725', '0', '1.00', null, '0', null, '1', '17000069', '2017-10-23 19:58:50', '17000069', '2017-10-23 19:58:50', '0');
INSERT INTO `t_recharges` VALUES ('402', '17000069', 'R150875993858973748', '0', '1.00', null, '0', null, '1', '17000069', '2017-10-23 19:58:59', '17000069', '2017-10-23 19:58:59', '0');
INSERT INTO `t_recharges` VALUES ('403', '17000069', 'R150875994992413104', '0', '1.00', null, '0', null, '1', '17000069', '2017-10-23 19:59:10', '17000069', '2017-10-23 19:59:10', '0');
INSERT INTO `t_recharges` VALUES ('404', '17000069', 'R150875995676848261', '0', '50.00', null, '0', null, '1', '17000069', '2017-10-23 19:59:17', '17000069', '2017-10-23 19:59:17', '0');
INSERT INTO `t_recharges` VALUES ('405', '17000054', 'R150875999960437467', '0', '1.00', null, '0', null, '1', '17000054', '2017-10-23 20:00:00', '17000054', '2017-10-23 20:00:00', '0');
INSERT INTO `t_recharges` VALUES ('406', '17000054', 'R150876007220424204', '1', '1.00', '{\"attach\":\"455\",\"ordernumber\":\"R150876007220424204\",\"orderstatus\":\"1\",\"partner\":\"21044\",\"paymoney\":\"1.000\",\"sign\":\"81ad046694cddc75406a8f9afdd80f40\",\"sysnumber\":\"RX1710232002875227917\"}', '0', null, '2', '17000054', '2017-10-23 20:01:12', '17000054', '2017-10-23 20:33:11', '0');
INSERT INTO `t_recharges` VALUES ('407', '17000065', 'R150876043859043959', '0', '10.00', null, '0', null, '1', '17000065', '2017-10-23 20:07:19', '17000065', '2017-10-23 20:07:19', '0');
INSERT INTO `t_recharges` VALUES ('408', '17000065', 'R150876048920735851', '0', '10.00', null, '0', null, '1', '17000065', '2017-10-23 20:08:09', '17000065', '2017-10-23 20:08:09', '0');
INSERT INTO `t_recharges` VALUES ('409', '17000065', 'R150876052770133351', '0', '10.00', null, '0', null, '1', '17000065', '2017-10-23 20:08:48', '17000065', '2017-10-23 20:08:48', '0');
INSERT INTO `t_recharges` VALUES ('410', '17000065', 'R150876055575047710', '0', '10.00', null, '0', null, '1', '17000065', '2017-10-23 20:09:16', '17000065', '2017-10-23 20:09:16', '0');
INSERT INTO `t_recharges` VALUES ('411', '17000089', 'R150876110614969728', '0', '1.00', null, '0', null, '1', '17000089', '2017-10-23 20:18:26', '17000089', '2017-10-23 20:18:26', '0');
INSERT INTO `t_recharges` VALUES ('412', '17000089', 'R150876111862581762', '1', '1.00', '{\"attach\":\"461\",\"ordernumber\":\"R150876111862581762\",\"orderstatus\":\"1\",\"partner\":\"21044\",\"paymoney\":\"1.000\",\"sign\":\"2a7126794b9997c99ef77281cb5bf8dd\",\"sysnumber\":\"RX1710232019333232570\"}', '0', null, '2', '17000089', '2017-10-23 20:18:39', '17000089', '2017-10-23 20:33:13', '0');
INSERT INTO `t_recharges` VALUES ('413', '17000089', 'R150876120052513683', '0', '10.00', null, '0', null, '1', '17000089', '2017-10-23 20:20:01', '17000089', '2017-10-23 20:20:01', '0');
INSERT INTO `t_recharges` VALUES ('414', '17000054', 'R150876408351749332', '1', '1.00', '{\"attach\":\"463\",\"ordernumber\":\"R150876408351749332\",\"orderstatus\":\"1\",\"partner\":\"21044\",\"paymoney\":\"1.000\",\"sign\":\"918cefce6d007a5681526320b47fcd5c\",\"sysnumber\":\"RX1710232109114246265\"}', '0', null, '2', '17000054', '2017-10-23 21:08:04', '17000054', '2017-10-23 21:09:07', '0');
INSERT INTO `t_recharges` VALUES ('415', '17000060', 'R150881162918610341', '0', '1.00', null, '0', null, '1', '17000060', '2017-10-24 10:20:29', '17000060', '2017-10-24 10:20:29', '0');
INSERT INTO `t_recharges` VALUES ('416', '17000060', 'R150881163666892793', '0', '10.00', null, '0', null, '1', '17000060', '2017-10-24 10:20:37', '17000060', '2017-10-24 10:20:37', '0');
INSERT INTO `t_recharges` VALUES ('417', '17000060', 'R150881164550887740', '0', '100.00', null, '0', null, '1', '17000060', '2017-10-24 10:20:46', '17000060', '2017-10-24 10:20:46', '0');
INSERT INTO `t_recharges` VALUES ('418', '17000060', 'R150881209521060016', '1', '1.00', '', '0', null, '1', '1', '2017-10-24 10:28:15', '1', '2017-10-24 10:28:15', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户';

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('30', '17000054', '1', '0', '2.00', '2.00', '0.00', '0.00', '0.00', '0.00', '23', '17000054', '2017-10-19 12:15:22', '17000054', '2017-10-23 21:09:07', '0');
INSERT INTO `t_user_account` VALUES ('31', '17000056', '1', '0', '453.30', '500.00', '0.00', '0.00', '0.00', '0.00', '65', '17000056', '2017-10-19 13:59:54', '17000056', '2017-10-20 17:13:33', '0');
INSERT INTO `t_user_account` VALUES ('33', '17000059', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '40', '17000059', '2017-10-19 14:10:05', '17000059', '2017-10-23 14:05:20', '0');
INSERT INTO `t_user_account` VALUES ('34', '17000060', '1', '0', '169.98', '501.00', '0.00', '0.00', '0.00', '0.00', '140', '17000060', '2017-10-19 14:28:19', '17000060', '2017-10-24 10:28:15', '0');
INSERT INTO `t_user_account` VALUES ('35', '17000061', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000061', '2017-10-19 15:49:15', '17000061', '2017-10-19 15:49:15', '0');
INSERT INTO `t_user_account` VALUES ('36', '17000062', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000062', '2017-10-19 15:57:11', '17000062', '2017-10-19 15:57:11', '0');
INSERT INTO `t_user_account` VALUES ('37', '17000063', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9', '17000063', '2017-10-19 16:04:47', '17000063', '2017-10-19 16:04:47', '0');
INSERT INTO `t_user_account` VALUES ('38', '17000065', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '54', '17000065', '2017-10-19 16:24:24', '17000065', '2017-10-23 20:09:16', '0');
INSERT INTO `t_user_account` VALUES ('39', '17000068', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000068', '2017-10-20 16:46:50', '17000068', '2017-10-20 16:46:50', '0');
INSERT INTO `t_user_account` VALUES ('40', '17000069', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '60', '17000069', '2017-10-20 16:47:36', '17000069', '2017-10-23 19:59:17', '0');
INSERT INTO `t_user_account` VALUES ('41', '17000070', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000070', '2017-10-20 16:52:14', '17000070', '2017-10-20 16:52:14', '0');
INSERT INTO `t_user_account` VALUES ('42', '17000071', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000071', '2017-10-20 16:55:59', '17000071', '2017-10-20 16:55:59', '0');
INSERT INTO `t_user_account` VALUES ('43', '17000072', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000072', '2017-10-20 16:56:11', '17000072', '2017-10-20 16:56:11', '0');
INSERT INTO `t_user_account` VALUES ('44', '17000073', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000073', '2017-10-20 16:56:15', '17000073', '2017-10-20 16:56:15', '0');
INSERT INTO `t_user_account` VALUES ('45', '17000074', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000074', '2017-10-20 17:02:16', '17000074', '2017-10-20 17:02:16', '0');
INSERT INTO `t_user_account` VALUES ('46', '17000075', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000075', '2017-10-20 17:02:31', '17000075', '2017-10-20 17:02:31', '0');
INSERT INTO `t_user_account` VALUES ('47', '17000077', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000077', '2017-10-20 17:03:50', '17000077', '2017-10-20 17:03:50', '0');
INSERT INTO `t_user_account` VALUES ('48', '17000078', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '5', '17000078', '2017-10-20 17:04:57', '17000078', '2017-10-20 17:04:57', '0');
INSERT INTO `t_user_account` VALUES ('49', '17000079', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000079', '2017-10-20 17:10:55', '17000079', '2017-10-20 17:10:55', '0');
INSERT INTO `t_user_account` VALUES ('50', '17000080', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000080', '2017-10-20 17:11:26', '17000080', '2017-10-20 17:11:26', '0');
INSERT INTO `t_user_account` VALUES ('51', '17000081', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '19', '17000081', '2017-10-20 17:17:13', '17000081', '2017-10-20 17:18:01', '0');
INSERT INTO `t_user_account` VALUES ('52', '17000082', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000082', '2017-10-20 17:20:49', '17000082', '2017-10-20 17:20:49', '0');
INSERT INTO `t_user_account` VALUES ('53', '17000083', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '18', '17000083', '2017-10-20 17:23:40', '17000083', '2017-10-20 17:23:40', '0');
INSERT INTO `t_user_account` VALUES ('54', '17000084', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000084', '2017-10-20 17:27:05', '17000084', '2017-10-20 17:27:05', '0');
INSERT INTO `t_user_account` VALUES ('55', '17000085', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '30', '17000085', '2017-10-20 17:28:07', '17000085', '2017-10-20 17:28:07', '0');
INSERT INTO `t_user_account` VALUES ('56', '17000086', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000086', '2017-10-20 17:29:21', '17000086', '2017-10-20 17:29:21', '0');
INSERT INTO `t_user_account` VALUES ('57', '17000087', '1', '0', '400.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000087', '2017-10-20 17:33:49', '17000087', '2017-10-20 17:33:49', '0');
INSERT INTO `t_user_account` VALUES ('58', '17000088', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000088', '2017-10-20 17:39:31', '17000088', '2017-10-20 17:39:31', '0');
INSERT INTO `t_user_account` VALUES ('59', '17000089', '1', '0', '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '48', '17000089', '2017-10-20 17:40:59', '17000089', '2017-10-23 20:33:13', '0');
INSERT INTO `t_user_account` VALUES ('60', '17000090', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000090', '2017-10-20 17:59:53', '17000090', '2017-10-20 17:59:53', '0');
INSERT INTO `t_user_account` VALUES ('61', '17000091', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '94', '17000091', '2017-10-20 18:11:15', '17000091', '2017-10-20 18:11:15', '0');
INSERT INTO `t_user_account` VALUES ('62', '17000092', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000092', '2017-10-20 18:59:12', '17000092', '2017-10-20 18:59:12', '0');
INSERT INTO `t_user_account` VALUES ('63', '17000093', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '5', '17000093', '2017-10-20 19:18:54', '17000093', '2017-10-20 19:18:54', '0');
INSERT INTO `t_user_account` VALUES ('64', '17000095', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000095', '2017-10-23 15:17:18', '17000095', '2017-10-23 15:17:18', '0');
INSERT INTO `t_user_account` VALUES ('65', '17000096', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000096', '2017-10-23 15:19:20', '17000096', '2017-10-23 15:19:20', '0');
INSERT INTO `t_user_account` VALUES ('66', '17000098', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000098', '2017-10-23 15:26:00', '17000098', '2017-10-23 15:26:00', '0');
INSERT INTO `t_user_account` VALUES ('67', '17000099', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000099', '2017-10-23 15:31:46', '17000099', '2017-10-23 15:31:46', '0');
INSERT INTO `t_user_account` VALUES ('68', '17000100', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000100', '2017-10-23 15:31:49', '17000100', '2017-10-23 15:31:49', '0');
INSERT INTO `t_user_account` VALUES ('69', '17000101', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000101', '2017-10-23 15:50:23', '17000101', '2017-10-23 15:50:23', '0');
INSERT INTO `t_user_account` VALUES ('70', '17000101', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000101', '2017-10-23 15:50:24', '17000101', '2017-10-23 15:50:24', '0');
INSERT INTO `t_user_account` VALUES ('71', '17000102', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000102', '2017-10-23 16:00:20', '17000102', '2017-10-23 16:00:20', '0');
INSERT INTO `t_user_account` VALUES ('72', '17000103', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000103', '2017-10-23 16:07:15', '17000103', '2017-10-23 16:07:15', '0');
INSERT INTO `t_user_account` VALUES ('73', '17000104', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000104', '2017-10-23 16:09:14', '17000104', '2017-10-23 16:09:14', '0');
INSERT INTO `t_user_account` VALUES ('74', '17000105', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000105', '2017-10-23 17:22:26', '17000105', '2017-10-23 17:22:26', '0');
INSERT INTO `t_user_account` VALUES ('75', '17000106', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '14', '17000106', '2017-10-23 17:25:53', '17000106', '2017-10-23 17:25:53', '0');
INSERT INTO `t_user_account` VALUES ('76', '17000107', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000107', '2017-10-23 17:28:15', '17000107', '2017-10-23 17:28:15', '0');
INSERT INTO `t_user_account` VALUES ('77', '17000108', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000108', '2017-10-23 17:37:37', '17000108', '2017-10-23 17:37:37', '0');
INSERT INTO `t_user_account` VALUES ('78', '17000109', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000109', '2017-10-23 17:59:53', '17000109', '2017-10-23 17:59:53', '0');
INSERT INTO `t_user_account` VALUES ('79', '17000110', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000110', '2017-10-23 18:01:24', '17000110', '2017-10-23 18:01:24', '0');
INSERT INTO `t_user_account` VALUES ('80', '17000111', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12', '17000111', '2017-10-23 18:45:16', '17000111', '2017-10-23 18:45:16', '0');
INSERT INTO `t_user_account` VALUES ('81', '17000112', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000112', '2017-10-23 18:49:01', '17000112', '2017-10-23 18:49:01', '0');
INSERT INTO `t_user_account` VALUES ('82', '17000114', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '49', '17000114', '2017-10-23 18:57:15', '17000114', '2017-10-23 18:57:15', '0');
INSERT INTO `t_user_account` VALUES ('83', '17000115', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000115', '2017-10-23 19:03:52', '17000115', '2017-10-23 19:03:52', '0');
INSERT INTO `t_user_account` VALUES ('84', '17000116', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000116', '2017-10-23 19:10:54', '17000116', '2017-10-23 19:10:54', '0');
INSERT INTO `t_user_account` VALUES ('85', '17000117', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000117', '2017-10-23 19:12:28', '17000117', '2017-10-23 19:12:28', '0');
INSERT INTO `t_user_account` VALUES ('86', '17000118', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000118', '2017-10-23 19:13:24', '17000118', '2017-10-23 19:13:24', '0');
INSERT INTO `t_user_account` VALUES ('87', '17000131', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12', '17000131', '2017-10-23 19:17:42', '17000131', '2017-10-23 19:17:42', '0');
INSERT INTO `t_user_account` VALUES ('88', '17000132', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000132', '2017-10-23 19:28:54', '17000132', '2017-10-23 19:28:54', '0');
INSERT INTO `t_user_account` VALUES ('89', '17000133', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '19', '17000133', '2017-10-23 19:41:20', '17000133', '2017-10-23 19:41:20', '0');
INSERT INTO `t_user_account` VALUES ('90', '17000134', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000134', '2017-10-23 19:42:21', '17000134', '2017-10-23 19:42:21', '0');
INSERT INTO `t_user_account` VALUES ('91', '17000135', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000135', '2017-10-23 19:43:14', '17000135', '2017-10-23 19:43:14', '0');
INSERT INTO `t_user_account` VALUES ('92', '17000136', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '7', '17000136', '2017-10-23 19:43:55', '17000136', '2017-10-23 19:43:55', '0');
INSERT INTO `t_user_account` VALUES ('93', '17000137', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000137', '2017-10-23 19:46:30', '17000137', '2017-10-23 19:46:30', '0');
INSERT INTO `t_user_account` VALUES ('94', '17000138', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000138', '2017-10-23 19:50:28', '17000138', '2017-10-23 19:50:28', '0');
INSERT INTO `t_user_account` VALUES ('95', '17000139', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000139', '2017-10-23 19:52:04', '17000139', '2017-10-23 19:52:04', '0');
INSERT INTO `t_user_account` VALUES ('96', '17000140', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000140', '2017-10-23 19:53:32', '17000140', '2017-10-23 19:53:32', '0');
INSERT INTO `t_user_account` VALUES ('97', '17000141', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000141', '2017-10-23 19:54:45', '17000141', '2017-10-23 19:54:45', '0');
INSERT INTO `t_user_account` VALUES ('98', '17000142', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000142', '2017-10-23 20:09:44', '17000142', '2017-10-23 20:09:44', '0');
INSERT INTO `t_user_account` VALUES ('99', '17000143', '1', '0', '583.12', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000143', '2017-10-23 20:41:31', '17000143', '2017-10-23 20:41:31', '0');
INSERT INTO `t_user_account` VALUES ('100', '17000144', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000144', '2017-10-23 21:07:33', '17000144', '2017-10-23 21:07:33', '0');
INSERT INTO `t_user_account` VALUES ('101', '17000145', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9', '17000145', '2017-10-23 21:24:30', '17000145', '2017-10-23 21:24:30', '0');
INSERT INTO `t_user_account` VALUES ('102', '17000146', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000146', '2017-10-23 21:26:00', '17000146', '2017-10-23 21:26:00', '0');
INSERT INTO `t_user_account` VALUES ('103', '17000147', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000147', '2017-10-23 21:39:22', '17000147', '2017-10-23 21:39:22', '0');
INSERT INTO `t_user_account` VALUES ('104', '17000148', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '17000148', '2017-10-23 21:41:08', '17000148', '2017-10-23 21:41:08', '0');
INSERT INTO `t_user_account` VALUES ('105', '17000149', '1', '0', '940.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '17000149', '2017-10-23 21:44:00', '17000149', '2017-10-23 21:44:00', '0');
INSERT INTO `t_user_account` VALUES ('106', '17000150', '1', '0', '999.00', '0.00', '0.00', '0.00', '0.00', '0.00', '7', '17000150', '2017-10-23 21:44:17', '17000150', '2017-10-23 21:44:17', '0');
INSERT INTO `t_user_account` VALUES ('107', '17000151', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '17000151', '2017-10-23 21:45:48', '17000151', '2017-10-23 21:45:48', '0');
INSERT INTO `t_user_account` VALUES ('108', '17000152', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '17000152', '2017-10-23 21:46:03', '17000152', '2017-10-23 21:46:03', '0');
INSERT INTO `t_user_account` VALUES ('109', '17000153', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '10', '17000153', '2017-10-24 09:53:26', '17000153', '2017-10-24 09:53:26', '0');
INSERT INTO `t_user_account` VALUES ('110', '17000154', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12', '17000154', '2017-10-24 09:54:35', '17000154', '2017-10-24 09:54:35', '0');
INSERT INTO `t_user_account` VALUES ('111', '17000155', '1', '0', '1000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000155', '2017-10-24 10:24:42', '17000155', '2017-10-24 10:24:42', '0');
INSERT INTO `t_user_account` VALUES ('112', '17000156', '1', '0', '14.00', '0.00', '0.00', '0.00', '0.00', '0.00', '11', '17000156', '2017-10-24 10:54:15', '17000156', '2017-10-24 10:54:15', '0');
INSERT INTO `t_user_account` VALUES ('113', '17000157', '1', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '17000157', '2017-10-24 10:59:36', '17000157', '2017-10-24 10:59:36', '0');
INSERT INTO `t_user_account` VALUES ('114', '17000158', '1', '0', '500.00', '0.00', '0.00', '0.00', '0.00', '0.00', '13', '17000158', '2017-10-24 11:05:21', '17000158', '2017-10-24 11:05:21', '0');
INSERT INTO `t_user_account` VALUES ('115', '17000159', '1', '0', '25.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '17000159', '2017-10-24 11:14:58', '17000159', '2017-10-24 11:14:58', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户交易明细';

-- ----------------------------
-- Records of t_user_account_detail
-- ----------------------------
INSERT INTO `t_user_account_detail` VALUES ('266', '34', '17000060', '1017620171019022819', 'R150839449906226793', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:28:19', '17000060', '2017-10-19 14:28:19', '0');
INSERT INTO `t_user_account_detail` VALUES ('267', '34', '17000060', '1017620171019022850', 'R150839453051653387', '1', '100.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:28:51', '17000060', '2017-10-19 14:28:51', '0');
INSERT INTO `t_user_account_detail` VALUES ('268', '34', '17000060', '1017620171019022859', 'R150839453904380620', '1', '100.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:28:59', '17000060', '2017-10-19 14:28:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('269', '34', '17000060', '1017620171019022912', 'R150839455237563347', '1', '500.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:29:12', '17000060', '2017-10-19 14:29:12', '0');
INSERT INTO `t_user_account_detail` VALUES ('270', '34', '17000060', '1017620171019022917', 'R150839455725739260', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:29:17', '17000060', '2017-10-19 14:29:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('271', '34', '17000060', '1017620171019022920', 'R150839456064011512', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-19 14:29:21', '17000060', '2017-10-19 14:29:21', '0');
INSERT INTO `t_user_account_detail` VALUES ('272', '33', '17000059', '1017620171019081935', 'R150841557576945664', '1', '100.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000059', '2017-10-19 20:19:36', '17000059', '2017-10-19 20:19:36', '0');
INSERT INTO `t_user_account_detail` VALUES ('273', '31', '17000056', '1017620171020051333', 'R150849081322844735', '1', '500.00', '4', '500.00', '11', '2', '系统上线测试用', null, '1', '17000056', '2017-10-20 17:13:33', '17000056', '2017-10-20 17:13:33', '0');
INSERT INTO `t_user_account_detail` VALUES ('274', '34', '17000060', '1017620171020051630', 'R150849099011044734', '1', '500.00', '4', '500.00', '11', '2', '系统上线测试用', null, '1', '17000060', '2017-10-20 17:16:30', '17000060', '2017-10-20 17:16:30', '0');
INSERT INTO `t_user_account_detail` VALUES ('275', '51', '17000081', '1017620171020051734', 'R150849105433044381', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000081', '2017-10-20 17:17:34', '17000081', '2017-10-20 17:17:34', '0');
INSERT INTO `t_user_account_detail` VALUES ('276', '51', '17000081', '1017620171020051744', 'R150849106473045831', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000081', '2017-10-20 17:17:45', '17000081', '2017-10-20 17:17:45', '0');
INSERT INTO `t_user_account_detail` VALUES ('277', '51', '17000081', '1017620171020051801', 'R150849108102878578', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000081', '2017-10-20 17:18:01', '17000081', '2017-10-20 17:18:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('278', '33', '17000059', '1017620171023020514', 'R150873871458816012', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000059', '2017-10-23 14:05:15', '17000059', '2017-10-23 14:05:15', '0');
INSERT INTO `t_user_account_detail` VALUES ('279', '33', '17000059', '1017620171023020518', 'R150873871825917739', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000059', '2017-10-23 14:05:18', '17000059', '2017-10-23 14:05:18', '0');
INSERT INTO `t_user_account_detail` VALUES ('280', '33', '17000059', '1017620171023020519', 'R150873871974873214', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000059', '2017-10-23 14:05:20', '17000059', '2017-10-23 14:05:20', '0');
INSERT INTO `t_user_account_detail` VALUES ('281', '34', '17000060', '1017620171023065137', 'R150875589765944522', '1', '1.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:51:38', '17000060', '2017-10-23 18:51:38', '0');
INSERT INTO `t_user_account_detail` VALUES ('282', '34', '17000060', '1017620171023065200', 'R150875592027559400', '1', '1.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:52:00', '17000060', '2017-10-23 18:52:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('283', '34', '17000060', '1017620171023065205', 'R150875592570639972', '1', '1.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:52:06', '17000060', '2017-10-23 18:52:06', '0');
INSERT INTO `t_user_account_detail` VALUES ('284', '34', '17000060', '1017620171023065213', 'R150875593372684086', '1', '50.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:52:14', '17000060', '2017-10-23 18:52:14', '0');
INSERT INTO `t_user_account_detail` VALUES ('285', '34', '17000060', '1017620171023065217', 'R150875593704049896', '1', '1.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:52:17', '17000060', '2017-10-23 18:52:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('286', '34', '17000060', '1017620171023065221', 'R150875594112847113', '1', '100.00', '4', '140.50', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-23 18:52:21', '17000060', '2017-10-23 18:52:21', '0');
INSERT INTO `t_user_account_detail` VALUES ('287', '30', '17000054', '1017620171023075814', 'R150875989471162089', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000054', '2017-10-23 19:58:15', '17000054', '2017-10-23 19:58:15', '0');
INSERT INTO `t_user_account_detail` VALUES ('288', '40', '17000069', '1017620171023075831', 'R150875991181553423', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:58:32', '17000069', '2017-10-23 19:58:32', '0');
INSERT INTO `t_user_account_detail` VALUES ('289', '40', '17000069', '1017620171023075843', 'R150875992348591682', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:58:43', '17000069', '2017-10-23 19:58:43', '0');
INSERT INTO `t_user_account_detail` VALUES ('290', '40', '17000069', '1017620171023075850', 'R150875993011477725', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:58:50', '17000069', '2017-10-23 19:58:50', '0');
INSERT INTO `t_user_account_detail` VALUES ('291', '40', '17000069', '1017620171023075858', 'R150875993858973748', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:58:59', '17000069', '2017-10-23 19:58:59', '0');
INSERT INTO `t_user_account_detail` VALUES ('292', '40', '17000069', '1017620171023075909', 'R150875994992413104', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:59:10', '17000069', '2017-10-23 19:59:10', '0');
INSERT INTO `t_user_account_detail` VALUES ('293', '40', '17000069', '1017620171023075916', 'R150875995676848261', '1', '50.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000069', '2017-10-23 19:59:17', '17000069', '2017-10-23 19:59:17', '0');
INSERT INTO `t_user_account_detail` VALUES ('294', '30', '17000054', '1017620171023075959', 'R150875999960437467', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000054', '2017-10-23 20:00:00', '17000054', '2017-10-23 20:00:00', '0');
INSERT INTO `t_user_account_detail` VALUES ('295', '30', '17000054', '1017620171023083311', 'R150876007220424204', '1', '1.00', '4', '1.00', '10', '2', '玩家充值', null, '2', '17000054', '2017-10-23 20:01:12', '17000054', '2017-10-23 20:33:11', '0');
INSERT INTO `t_user_account_detail` VALUES ('296', '38', '17000065', '1017620171023080718', 'R150876043859043959', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000065', '2017-10-23 20:07:19', '17000065', '2017-10-23 20:07:19', '0');
INSERT INTO `t_user_account_detail` VALUES ('297', '38', '17000065', '1017620171023080809', 'R150876048920735851', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000065', '2017-10-23 20:08:09', '17000065', '2017-10-23 20:08:09', '0');
INSERT INTO `t_user_account_detail` VALUES ('298', '38', '17000065', '1017620171023080847', 'R150876052770133351', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000065', '2017-10-23 20:08:48', '17000065', '2017-10-23 20:08:48', '0');
INSERT INTO `t_user_account_detail` VALUES ('299', '38', '17000065', '1017620171023080915', 'R150876055575047710', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000065', '2017-10-23 20:09:16', '17000065', '2017-10-23 20:09:16', '0');
INSERT INTO `t_user_account_detail` VALUES ('300', '59', '17000089', '1017620171023081826', 'R150876110614969728', '1', '1.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000089', '2017-10-23 20:18:26', '17000089', '2017-10-23 20:18:26', '0');
INSERT INTO `t_user_account_detail` VALUES ('301', '59', '17000089', '1017620171023083313', 'R150876111862581762', '1', '1.00', '4', '1.00', '10', '2', '玩家充值', null, '2', '17000089', '2017-10-23 20:18:39', '17000089', '2017-10-23 20:33:14', '0');
INSERT INTO `t_user_account_detail` VALUES ('302', '59', '17000089', '1017620171023082000', 'R150876120052513683', '1', '10.00', '4', '0.00', '10', '5', '玩家充值', null, '1', '17000089', '2017-10-23 20:20:01', '17000089', '2017-10-23 20:20:01', '0');
INSERT INTO `t_user_account_detail` VALUES ('303', '30', '17000054', '1017620171023090907', 'R150876408351749332', '1', '1.00', '4', '2.00', '10', '2', '玩家充值', null, '2', '17000054', '2017-10-23 21:08:04', '17000054', '2017-10-23 21:09:07', '0');
INSERT INTO `t_user_account_detail` VALUES ('304', '34', '17000060', '1017620171024101814,1017620171024102513', 'W150881149461462248', '-1', '100.00', '4', '68.98', '50', '1', 'ces', '1', '1', '17000060', '2017-10-24 10:24:06', '1', '2017-10-24 10:25:13', '0');
INSERT INTO `t_user_account_detail` VALUES ('305', '34', '17000060', '1017620171024102029', 'R150881162918610341', '1', '1.00', '4', '68.98', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-24 10:20:29', '17000060', '2017-10-24 10:20:29', '0');
INSERT INTO `t_user_account_detail` VALUES ('306', '34', '17000060', '1017620171024102036', 'R150881163666892793', '1', '10.00', '4', '68.98', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-24 10:20:37', '17000060', '2017-10-24 10:20:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('307', '34', '17000060', '1017620171024102045', 'R150881164550887740', '1', '100.00', '4', '68.98', '10', '5', '玩家充值', null, '1', '17000060', '2017-10-24 10:20:46', '17000060', '2017-10-24 10:20:46', '0');
INSERT INTO `t_user_account_detail` VALUES ('308', '34', '17000060', '1017620171024102454,1017620171024102637', 'W150881189427117233', '-1', '101.00', '4', '67.98', '50', '1', 'ceshi', '1', '1', '17000060', '2017-10-24 10:25:30', '1', '2017-10-24 10:26:37', '0');
INSERT INTO `t_user_account_detail` VALUES ('309', '34', '17000060', '1017620171024102815', 'R150881209521060016', '1', '1.00', '4', '169.98', '11', '2', '', null, '1', '17000060', '2017-10-24 10:28:15', '17000060', '2017-10-24 10:28:15', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户绑定卡片';

-- ----------------------------
-- Records of t_user_cards
-- ----------------------------
INSERT INTO `t_user_cards` VALUES ('15', '17000069', '6623223487653212', '光大银行', '16', '1', '1', '0000-00-00 00:00:00', null, null, '0', '李小璐');
INSERT INTO `t_user_cards` VALUES ('16', '17000060', '6228480352202673112', '农业银行', '1', '1', '1', '0000-00-00 00:00:00', null, null, '0', '一一一');

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
  `ky_account` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开云棋盘账号',
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
) ENGINE=InnoDB AUTO_INCREMENT=17000160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '15260282340', '2', '0', '1', '1', 'http://img.jsqq.net/uploads/allimg/150111/1_150111080328_19.jpg', '2017-09-28 12:09:34', '0', null, null, null, '2', '3', '1', '2017-09-28 12:09:34', '1', '2017-09-28 12:09:34', '0', null, null, null);
INSERT INTO `t_users` VALUES ('4', 'KF001', 'e10adc3949ba59abbe56e057f20f883e', '客服', '15260282340', '2', '0', '3', '1', null, '2017-10-20 18:30:37', '0', null, null, null, '203707655', '1', '1', '2017-10-20 18:30:37', null, '2017-10-20 18:30:37', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000054', '15260282340', 'cc77051c307acbdb13f7adca62766fc1', '小魏6', '15260282340', '-1', '1', null, '4', null, '2017-10-23 21:28:42', '0', null, '小魏6', 'http://www.ky508.com:89/game/index.html?account=10176_小魏6&token=eyJkYXRhIjoiMTAxNzZf5bCP6a2PNiIsImNyZWF0ZWQiOjE1MDg3NjUzODAsImV4cCI6NjB9.SpDxjcChMWmutkjjhklLDuBFbxbMJCLOO7bgwAZDL34=&lang=undefined&gameId=0', null, '6', '1', '2017-10-19 14:08:23', '17000054', '2017-10-23 21:28:42', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000056', '15901794296', 'd51d51722e9803db473f5ee86bb8fb25', '一米阳光', '15901794296', '-1', '1', null, '4', null, '2017-10-23 21:12:22', '0', null, '一米阳光', 'http://www.ky508.com:89/game/index.html?account=10176_一米阳光&token=eyJkYXRhIjoiMTAxNzZf5LiA57Gz6Ziz5YWJIiwiY3JlYXRlZCI6MTUwODc2NDQwMCwiZXhwIjo2MH0=.8beAVtJRkDQss6ZF0n9wde42cyHXdZDnUVsZjg96jQU=&lang=undefined&gameId=0', null, '10', '1', '2017-10-20 17:15:18', '17000056', '2017-10-23 21:12:22', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000059', '游客_15260282340', null, '游客_15260282340', null, '-1', '2', null, '4', null, '2017-10-19 14:09:56', '0', null, '游客_15260282340', null, null, '1', '1', '2017-10-19 14:09:56', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000060', '17767077763', '55d2e62bbf05620dc7dcdea390a0420f', 'huhuhu', '17767077763', '-1', '1', null, '4', null, '2017-10-23 18:48:59', '0', null, 'huhuhu', 'http://www.ky508.com:89/game/index.html?account=10176_huhuhu&token=eyJkYXRhIjoiMTAxNzZfaHVodWh1IiwiY3JlYXRlZCI6MTUwODc1NTc5NywiZXhwIjo2MH0=.MmltYHJFEdgwX6YkReJppmdYCEz+tRh5IZ9zJ9mHbdQ=&lang=undefined&gameId=0', null, '11', '1', '2017-10-23 15:51:43', '17000060', '2017-10-23 18:48:59', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000061', '游客_TNhUzOlDrzqPt5fw', null, '游客_TNhUzOlDrzqPt5fw', null, '-1', '2', null, '4', null, '2017-10-19 15:47:21', '0', null, '游客_TNhUzOlDrzqPt5fw', null, null, '1', '1', '2017-10-19 15:47:21', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000062', '游客_fr5tWq5371LI1Z1q', null, '游客_fr5tWq5371LI1Z1q', null, '-1', '2', null, '4', null, '2017-10-19 15:56:15', '0', null, '游客_fr5tWq5371LI1Z1q', null, null, '1', '1', '2017-10-19 15:56:15', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000063', '游客_1NPcecNb78ZOCMRr', null, '游客_1NPcecNb78ZOCMRr', null, '-1', '2', null, '4', null, '2017-10-19 16:04:15', '0', null, '游客_1NPcecNb78ZOCMRr', null, null, '1', '1', '2017-10-19 16:04:15', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000065', '13295353220', 'cc77051c307acbdb13f7adca62766fc1', 'mtf', '13295353220', '-1', '1', null, '4', null, '2017-10-24 10:26:42', '0', null, 'mtf', 'http://www.ky508.com:89/game/index.html?account=10176_mtf&token=eyJkYXRhIjoiMTAxNzZfbXRmIiwiY3JlYXRlZCI6MTUwODgxMTk5MCwiZXhwIjo2MH0=.ROhhZLdElWoAUgUTiuqFRaEdbKANnjZQYzryxxW6Hk4=&lang=undefined&gameId=0', null, '14', '1', '2017-10-19 16:23:55', '17000065', '2017-10-24 10:26:42', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000068', '游客_z4fsFpbXK5GUwoFu', null, '游客_z4fsFpbXK5GUwoFu', null, '-1', '2', null, '4', null, '2017-10-20 16:46:28', '0', null, '游客_z4fsFpbXK5GUwoFu', null, null, '1', '1', '2017-10-20 16:46:28', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000069', '13330908360', 'cc77051c307acbdb13f7adca62766fc1', '爱丝寂寞人', '13330908360', '-1', '1', null, '4', null, '2017-10-23 19:48:30', '0', null, '爱丝寂寞人', 'http://www.ky508.com:89/game/index.html?account=10176_爱丝寂寞人&token=eyJkYXRhIjoiMTAxNzZf54ix5Lid5a+C5a+e5Lq6IiwiY3JlYXRlZCI6MTUwODc1OTM2OCwiZXhwIjo2MH0=.avQzvasHuB5hM9fsZV6oPTdnQCodQOyJynXzPI7LM2g=&lang=undefined&gameId=0', null, '6', '1', '2017-10-20 16:47:11', '17000069', '2017-10-23 19:48:30', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000070', '游客_vX6AN1JvPc93tbqA', null, '游客_vX6AN1JvPc93tbqA', null, '-1', '2', null, '4', null, '2017-10-20 16:52:14', '0', null, '游客_vX6AN1JvPc93tbqA', null, null, '1', '1', '2017-10-20 16:52:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000071', '游客_EaIVWfVtQnfh2jtY', null, '游客_EaIVWfVtQnfh2jtY', null, '-1', '2', null, '4', null, '2017-10-20 16:55:58', '0', null, '游客_EaIVWfVtQnfh2jtY', null, null, '1', '1', '2017-10-20 16:55:58', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000072', '游客_tIJO7ykAlDjRoaUi', null, '游客_tIJO7ykAlDjRoaUi', null, '-1', '2', null, '4', null, '2017-10-20 16:56:11', '0', null, '游客_tIJO7ykAlDjRoaUi', null, null, '1', '1', '2017-10-20 16:56:11', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000073', '游客_juDLbJ2ke6FVzlIX', null, '游客_juDLbJ2ke6FVzlIX', null, '-1', '2', null, '4', null, '2017-10-20 16:56:14', '0', null, '游客_juDLbJ2ke6FVzlIX', null, null, '1', '1', '2017-10-20 16:56:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000074', '游客_wFX5I14tjPcIo7SV', null, '游客_wFX5I14tjPcIo7SV', null, '-1', '2', null, '4', null, '2017-10-20 17:02:16', '0', null, '游客_wFX5I14tjPcIo7SV', null, null, '1', '1', '2017-10-20 17:02:16', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000075', '游客_cpaBuVYz0yUH0AIW', null, '游客_cpaBuVYz0yUH0AIW', null, '-1', '2', null, '4', null, '2017-10-20 17:02:30', '0', null, '游客_cpaBuVYz0yUH0AIW', null, null, '1', '1', '2017-10-20 17:02:30', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000076', '游客_JhI8BukUYrMvkyzw', null, '游客_JhI8BukUYrMvkyzw', null, '-1', '2', null, '4', null, '2017-10-20 17:03:39', '0', null, '游客_JhI8BukUYrMvkyzw', null, null, '1', '1', '2017-10-20 17:03:39', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000077', '游客_3YN1S8No6LmbTfSj', null, '游客_3YN1S8No6LmbTfSj', null, '-1', '2', null, '4', null, '2017-10-20 17:03:50', '0', null, '游客_3YN1S8No6LmbTfSj', null, null, '1', '1', '2017-10-20 17:03:50', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000078', '游客_lwRkQJBmMON9dMJ0', null, '游客_lwRkQJBmMON9dMJ0', null, '-1', '2', null, '4', null, '2017-10-20 17:04:57', '0', null, '游客_lwRkQJBmMON9dMJ0', null, null, '1', '1', '2017-10-20 17:04:57', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000079', '游客_DPXmSDrJsW1PbRN2', null, '游客_DPXmSDrJsW1PbRN2', null, '-1', '2', null, '4', null, '2017-10-20 17:10:54', '0', null, '游客_DPXmSDrJsW1PbRN2', null, null, '1', '1', '2017-10-20 17:10:54', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000080', '游客_o564iX5VtCHCVLV8', null, '游客_o564iX5VtCHCVLV8', null, '-1', '2', null, '4', null, '2017-10-20 17:11:26', '0', null, '游客_o564iX5VtCHCVLV8', null, null, '1', '1', '2017-10-20 17:11:26', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000081', '13276720611', 'cc77051c307acbdb13f7adca62766fc1', 'DJ发酒疯', '13276720611', '-1', '1', null, '4', null, '2017-10-20 17:16:36', '0', null, 'DJ发酒疯', 'http://www.ky508.com:89/game/index.html?account=10176_DJ发酒疯&token=eyJkYXRhIjoiMTAxNzZfRErlj5HphZLnlq8iLCJjcmVhdGVkIjoxNTA4NDkxMDI5LCJleHAiOjYwfQ==.Wzjl4XWPhTo/sLE6GcI6e60q6LeXpw3ZvDChNv4oLQ0=&lang=undefined&gameId=0', null, '2', '1', '2017-10-20 17:16:36', null, '2017-10-20 17:29:05', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000082', '游客_avIOsfyruNmWqFmc', null, '游客_avIOsfyruNmWqFmc', null, '-1', '2', null, '4', null, '2017-10-20 17:20:49', '0', null, '游客_avIOsfyruNmWqFmc', null, null, '1', '1', '2017-10-20 17:20:49', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000083', '游客_wYfpuYRHf8gsLFpL', null, '游客_wYfpuYRHf8gsLFpL', null, '-1', '2', null, '4', null, '2017-10-20 17:23:39', '0', null, '游客_wYfpuYRHf8gsLFpL', null, null, '1', '1', '2017-10-20 17:23:39', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000085', '游客_0z3HraZhehQmBSON', null, '游客_0z3HraZhehQmBSON', null, '-1', '2', null, '4', null, '2017-10-20 17:28:07', '0', null, '游客_0z3HraZhehQmBSON', null, null, '1', '1', '2017-10-20 17:28:07', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000086', '游客_T1CT4ydjwZxhGpr1', null, '游客_T1CT4ydjwZxhGpr1', null, '-1', '2', null, '4', null, '2017-10-20 17:29:20', '0', null, '游客_T1CT4ydjwZxhGpr1', null, null, '1', '1', '2017-10-20 17:29:20', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000087', '游客_jNT7AGlrpo304XVE', null, '游客_jNT7AGlrpo304XVE', null, '-1', '2', null, '4', null, '2017-10-20 17:33:49', '0', null, '游客_jNT7AGlrpo304XVE', null, null, '1', '1', '2017-10-20 17:33:49', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000088', '游客_vlJEhEPLGCGMySY0', null, '游客_vlJEhEPLGCGMySY0', null, '-1', '2', null, '4', null, '2017-10-20 17:39:31', '0', null, '游客_vlJEhEPLGCGMySY0', null, null, '1', '1', '2017-10-20 17:39:31', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000089', '18357100901', 'af2f6f86bf6c7f97fe4d0929bc3de98a', '11111111', '18357100901', '-1', '1', null, '4', null, '2017-10-24 10:31:10', '0', null, '11111111', 'http://www.ky508.com:89/game/index.html?account=10176_11111111&token=eyJkYXRhIjoiMTAxNzZfMTExMTExMTEiLCJjcmVhdGVkIjoxNTA4ODEyMjU4LCJleHAiOjYwfQ==.nuCmAe+usTvCsxiMlD2C7rIo+yLhRHaXfZAt4lZrZGg=&lang=undefined&gameId=0', null, '10', '1', '2017-10-20 17:40:58', '17000089', '2017-10-24 10:31:10', '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000090', '游客_vjb3oUTeYlioQssR', null, '游客_vjb3oUTeYlioQssR', null, '-1', '2', null, '4', null, '2017-10-20 17:59:52', '0', null, '游客_vjb3oUTeYlioQssR', null, null, '1', '1', '2017-10-20 17:59:52', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000091', '游客_azQ93iPRh5oIi1dO', null, '游客_azQ93iPRh5oIi1dO', null, '-1', '2', null, '4', null, '2017-10-20 18:11:14', '0', null, '游客_azQ93iPRh5oIi1dO', null, null, '1', '1', '2017-10-20 18:11:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000092', '游客_jYuThGgwMCxiBoVP', null, '游客_jYuThGgwMCxiBoVP', null, '-1', '2', null, '4', null, '2017-10-20 18:59:12', '0', null, '游客_jYuThGgwMCxiBoVP', null, null, '1', '1', '2017-10-20 18:59:12', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000093', '游客_gwJgKUvM2jAoFfgg', null, '游客_gwJgKUvM2jAoFfgg', null, '-1', '2', null, '4', null, '2017-10-20 19:18:53', '0', null, '游客_gwJgKUvM2jAoFfgg', null, null, '1', '1', '2017-10-20 19:18:53', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000094', '游客_uAOCjBxLMunUoPAm', null, '游客_uAOCjBxLMunUoPAm', null, '-1', '2', null, '4', null, '2017-10-23 15:13:15', '0', null, '游客_uAOCjBxLMunUoPAm', null, null, '1', '1', '2017-10-23 15:13:15', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000095', '游客_t2p5wyXjCXvqe7gk', null, '游客_t2p5wyXjCXvqe7gk', null, '-1', '2', null, '4', null, '2017-10-23 15:17:18', '0', null, '游客_t2p5wyXjCXvqe7gk', null, null, '1', '1', '2017-10-23 15:17:18', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000096', '游客_plKYrF8P92PaBaNE', null, '游客_plKYrF8P92PaBaNE', null, '-1', '2', null, '4', null, '2017-10-23 15:19:20', '0', null, '游客_plKYrF8P92PaBaNE', null, null, '1', '1', '2017-10-23 15:19:20', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000097', '游客_Wwz6XqT4RPV4NWX8', null, '游客_Wwz6XqT4RPV4NWX8', null, '-1', '2', null, '4', null, '2017-10-23 15:22:52', '0', null, '游客_Wwz6XqT4RPV4NWX8', null, null, '1', '1', '2017-10-23 15:22:52', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000098', '游客_3bgpNN25WGpzHB3l', null, '游客_3bgpNN25WGpzHB3l', null, '-1', '2', null, '4', null, '2017-10-23 15:26:00', '0', null, '游客_3bgpNN25WGpzHB3l', null, null, '1', '1', '2017-10-23 15:26:00', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000099', '游客_Zw4v84ppT73PgUWz', null, '游客_Zw4v84ppT73PgUWz', null, '-1', '2', null, '4', null, '2017-10-23 15:31:46', '0', null, '游客_Zw4v84ppT73PgUWz', null, null, '1', '1', '2017-10-23 15:31:46', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000100', '游客_A3BCJmqbI03ZJKPW', null, '游客_A3BCJmqbI03ZJKPW', null, '-1', '2', null, '4', null, '2017-10-23 15:31:48', '0', null, '游客_A3BCJmqbI03ZJKPW', null, null, '1', '1', '2017-10-23 15:31:48', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000101', '游客_mEzmExW9nLDxIY75', null, '游客_mEzmExW9nLDxIY75', null, '-1', '2', null, '4', null, '2017-10-23 15:50:23', '0', null, '游客_mEzmExW9nLDxIY75', null, null, '1', '1', '2017-10-23 15:50:23', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000102', '游客_mrAoetLAK48uRYze', null, '游客_mrAoetLAK48uRYze', null, '-1', '2', null, '4', null, '2017-10-23 16:00:20', '0', null, '游客_mrAoetLAK48uRYze', null, null, '1', '1', '2017-10-23 16:00:20', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000103', '游客_1iskQT5VD0Bqdooi', null, '游客_1iskQT5VD0Bqdooi', null, '-1', '2', null, '4', null, '2017-10-23 16:07:14', '0', null, '游客_1iskQT5VD0Bqdooi', null, null, '1', '1', '2017-10-23 16:07:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000104', '游客_r2mszD1Zv6ITHtmL', null, '游客_r2mszD1Zv6ITHtmL', null, '-1', '2', null, '4', null, '2017-10-23 16:09:14', '0', null, '游客_r2mszD1Zv6ITHtmL', null, null, '1', '1', '2017-10-23 16:09:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000105', '游客_EzZB6SPxy9FeU4Qd', null, '游客_EzZB6SPxy9FeU4Qd', null, '-1', '2', null, '4', null, '2017-10-23 17:22:24', '0', null, '游客_EzZB6SPxy9FeU4Qd', null, null, '1', '1', '2017-10-23 17:22:24', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000106', '游客_pGdUpAr4jYkW0jao', null, '游客_pGdUpAr4jYkW0jao', null, '-1', '2', null, '4', null, '2017-10-23 17:25:53', '0', null, '游客_pGdUpAr4jYkW0jao', null, null, '1', '1', '2017-10-23 17:25:53', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000107', '游客_Ye9ltOeTJAC8cKMB', null, '游客_Ye9ltOeTJAC8cKMB', null, '-1', '2', null, '4', null, '2017-10-23 17:28:14', '0', null, '游客_Ye9ltOeTJAC8cKMB', null, null, '1', '1', '2017-10-23 17:28:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000108', '游客_tXsDV81VsSdjkIJ5', null, '游客_tXsDV81VsSdjkIJ5', null, '-1', '2', null, '4', null, '2017-10-23 17:37:36', '0', null, '游客_tXsDV81VsSdjkIJ5', null, null, '1', '1', '2017-10-23 17:37:36', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000109', '游客_OCELRyWfAaA5tcWu', null, '游客_OCELRyWfAaA5tcWu', null, '-1', '2', null, '4', null, '2017-10-23 17:59:53', '0', null, '游客_OCELRyWfAaA5tcWu', null, null, '1', '1', '2017-10-23 17:59:53', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000110', '游客_CL3Kryo5iZgysRsU', null, '游客_CL3Kryo5iZgysRsU', null, '-1', '2', null, '4', null, '2017-10-23 18:01:24', '0', null, '游客_CL3Kryo5iZgysRsU', null, null, '1', '1', '2017-10-23 18:01:24', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000111', '游客_nH3JqAsxAo9MPprm', null, '游客_nH3JqAsxAo9MPprm', null, '-1', '2', null, '4', null, '2017-10-23 18:45:15', '0', null, '游客_nH3JqAsxAo9MPprm', null, null, '1', '1', '2017-10-23 18:45:15', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000112', '游客_viU4JgvZeZu8VW1S', null, '游客_viU4JgvZeZu8VW1S', null, '-1', '2', null, '4', null, '2017-10-23 18:49:00', '0', null, '游客_viU4JgvZeZu8VW1S', null, null, '1', '1', '2017-10-23 18:49:00', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000113', '游客_jzDtyhtOuKX7SRZ5', null, '游客_jzDtyhtOuKX7SRZ5', null, '-1', '2', null, '4', null, '2017-10-23 18:51:43', '0', null, '游客_jzDtyhtOuKX7SRZ5', null, null, '1', '1', '2017-10-23 18:51:43', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000114', '游客_mh8O65KLWZSSIc8F', null, '游客_mh8O65KLWZSSIc8F', null, '-1', '2', null, '4', null, '2017-10-23 18:57:14', '0', null, '游客_mh8O65KLWZSSIc8F', null, null, '1', '1', '2017-10-23 18:57:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000115', '游客_EgM1iEh2VsuBCZHi', null, '游客_EgM1iEh2VsuBCZHi', null, '-1', '2', null, '4', null, '2017-10-23 19:03:52', '0', null, '游客_EgM1iEh2VsuBCZHi', null, null, '1', '1', '2017-10-23 19:03:52', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000116', '游客_7A6IQEELyeZaofmr', null, '游客_7A6IQEELyeZaofmr', null, '-1', '2', null, '4', null, '2017-10-23 19:10:53', '0', null, '游客_7A6IQEELyeZaofmr', null, null, '1', '1', '2017-10-23 19:10:53', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000117', '游客_vl0PC3w5Okfsc3mR', null, '游客_vl0PC3w5Okfsc3mR', null, '-1', '2', null, '4', null, '2017-10-23 19:12:28', '0', null, '游客_vl0PC3w5Okfsc3mR', null, null, '1', '1', '2017-10-23 19:12:28', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000118', '游客_XDUr9NmP0vf5tAHX', null, '游客_XDUr9NmP0vf5tAHX', null, '-1', '2', null, '4', null, '2017-10-23 19:13:24', '0', null, '游客_XDUr9NmP0vf5tAHX', null, null, '1', '1', '2017-10-23 19:13:24', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000131', '游客_HLnSRdq8E6aNM79E', null, '游客_HLnSRdq8E6aNM79E', null, '-1', '2', null, '4', null, '2017-10-23 19:17:42', '0', null, '游客_HLnSRdq8E6aNM79E', null, null, '1', '1', '2017-10-23 19:17:42', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000132', '游客_PtwHWpHMHG5dq7OM', null, '游客_PtwHWpHMHG5dq7OM', null, '-1', '2', null, '4', null, '2017-10-23 19:28:54', '0', null, '游客_PtwHWpHMHG5dq7OM', null, null, '1', '1', '2017-10-23 19:28:54', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000133', '游客_vdQ6Eif4sOgcF46g', null, '游客_vdQ6Eif4sOgcF46g', null, '-1', '2', null, '4', null, '2017-10-23 19:41:20', '0', null, '游客_vdQ6Eif4sOgcF46g', null, null, '1', '1', '2017-10-23 19:41:20', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000134', '游客_ifmKBqibZzpnqdmo', null, '游客_ifmKBqibZzpnqdmo', null, '-1', '2', null, '4', null, '2017-10-23 19:42:21', '0', null, '游客_ifmKBqibZzpnqdmo', null, null, '1', '1', '2017-10-23 19:42:21', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000135', '游客_BBTBPJP1Bw5zMLOw', null, '游客_BBTBPJP1Bw5zMLOw', null, '-1', '2', null, '4', null, '2017-10-23 19:43:14', '0', null, '游客_BBTBPJP1Bw5zMLOw', null, null, '1', '1', '2017-10-23 19:43:14', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000136', '游客_3QyqC5wJQMsGodn8', null, '游客_3QyqC5wJQMsGodn8', null, '-1', '2', null, '4', null, '2017-10-23 19:43:55', '0', null, '游客_3QyqC5wJQMsGodn8', null, null, '1', '1', '2017-10-23 19:43:55', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000137', '游客_X9ds1AkgYQlbuwbo', null, '游客_X9ds1AkgYQlbuwbo', null, '-1', '2', null, '4', null, '2017-10-23 19:46:30', '0', null, '游客_X9ds1AkgYQlbuwbo', null, null, '1', '1', '2017-10-23 19:46:30', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000138', '游客_aZIe6BBcsnCmamwn', null, '游客_aZIe6BBcsnCmamwn', null, '-1', '2', null, '4', null, '2017-10-23 19:50:28', '0', null, '游客_aZIe6BBcsnCmamwn', null, null, '1', '1', '2017-10-23 19:50:28', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000139', '游客_DIPQXsRCEkffZufj', null, '游客_DIPQXsRCEkffZufj', null, '-1', '2', null, '4', null, '2017-10-23 19:52:04', '0', null, '游客_DIPQXsRCEkffZufj', null, null, '1', '1', '2017-10-23 19:52:04', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000140', '游客_iOja1ey7V4jGlYsG', null, '游客_iOja1ey7V4jGlYsG', null, '-1', '2', null, '4', null, '2017-10-23 19:53:32', '0', null, '游客_iOja1ey7V4jGlYsG', null, null, '1', '1', '2017-10-23 19:53:32', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000141', '游客_9gxRUw7e4M2h8VsT', null, '游客_9gxRUw7e4M2h8VsT', null, '-1', '2', null, '4', null, '2017-10-23 19:54:45', '0', null, '游客_9gxRUw7e4M2h8VsT', null, null, '1', '1', '2017-10-23 19:54:45', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000142', '游客_sh7qiV4mCckMmFlr', null, '游客_sh7qiV4mCckMmFlr', null, '-1', '2', null, '4', null, '2017-10-23 20:09:42', '0', null, '游客_sh7qiV4mCckMmFlr', null, null, '1', '1', '2017-10-23 20:09:42', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000143', '游客_w4MdUvCnxgiJ1A7p', null, '游客_w4MdUvCnxgiJ1A7p', null, '-1', '2', null, '4', null, '2017-10-23 20:41:28', '0', null, '游客_w4MdUvCnxgiJ1A7p', null, null, '1', '1', '2017-10-23 20:41:28', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000144', '游客_EAuMW6JZ4r3akFNw', null, '游客_EAuMW6JZ4r3akFNw', null, '-1', '2', null, '4', null, '2017-10-23 21:07:33', '0', null, '游客_EAuMW6JZ4r3akFNw', null, null, '1', '1', '2017-10-23 21:07:33', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000145', '游客_ikhHuf35axYTieCg', null, '游客_ikhHuf35axYTieCg', null, '-1', '2', null, '4', null, '2017-10-23 21:24:30', '0', null, '游客_ikhHuf35axYTieCg', null, null, '1', '1', '2017-10-23 21:24:30', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000146', '游客_mCV7M9Vg2w4GQJBy', null, '游客_mCV7M9Vg2w4GQJBy', null, '-1', '2', null, '4', null, '2017-10-23 21:26:00', '0', null, '游客_mCV7M9Vg2w4GQJBy', null, null, '1', '1', '2017-10-23 21:26:00', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000147', '游客_0ocxyaEWJzMEWbKk', null, '游客_0ocxyaEWJzMEWbKk', null, '-1', '2', null, '4', null, '2017-10-23 21:39:20', '0', null, '游客_0ocxyaEWJzMEWbKk', null, null, '1', '1', '2017-10-23 21:39:20', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000148', '游客_wXsGi27kuK6SGyCF', null, '游客_wXsGi27kuK6SGyCF', null, '-1', '2', null, '4', null, '2017-10-23 21:41:08', '0', null, '游客_wXsGi27kuK6SGyCF', null, null, '1', '1', '2017-10-23 21:41:08', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000149', '游客_mdP29LNRDNQtEXYi', null, '游客_mdP29LNRDNQtEXYi', null, '-1', '2', null, '4', null, '2017-10-23 21:43:58', '0', null, '游客_mdP29LNRDNQtEXYi', null, null, '1', '1', '2017-10-23 21:43:58', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000150', '游客_FcsF19pKSO7IGdkT', null, '游客_FcsF19pKSO7IGdkT', null, '-1', '2', null, '4', null, '2017-10-23 21:44:16', '0', null, '游客_FcsF19pKSO7IGdkT', null, null, '1', '1', '2017-10-23 21:44:16', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000151', '游客_7xnL5CLOQYvJ3NZo', null, '游客_7xnL5CLOQYvJ3NZo', null, '-1', '2', null, '4', null, '2017-10-23 21:45:48', '0', null, '游客_7xnL5CLOQYvJ3NZo', null, null, '1', '1', '2017-10-23 21:45:48', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000152', '游客_aFxHK2uI0rddY2Qt', null, '游客_aFxHK2uI0rddY2Qt', null, '-1', '2', null, '4', null, '2017-10-23 21:46:02', '0', null, '游客_aFxHK2uI0rddY2Qt', null, null, '1', '1', '2017-10-23 21:46:02', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000153', '游客_dycJnEaa06O2p3Nt', null, '游客_dycJnEaa06O2p3Nt', null, '-1', '2', null, '4', null, '2017-10-24 09:53:26', '0', null, '游客_dycJnEaa06O2p3Nt', null, null, '1', '1', '2017-10-24 09:53:26', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000154', '游客_TwU9JOWDs8qY37dR', null, '游客_TwU9JOWDs8qY37dR', null, '-1', '2', null, '4', null, '2017-10-24 09:54:35', '0', null, '游客_TwU9JOWDs8qY37dR', null, null, '1', '1', '2017-10-24 09:54:35', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000155', '游客_3NedOMtuT3o57VjH', null, '游客_3NedOMtuT3o57VjH', null, '-1', '2', null, '4', null, '2017-10-24 10:24:40', '0', null, '游客_3NedOMtuT3o57VjH', null, null, '1', '1', '2017-10-24 10:24:40', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000156', '游客_utctV9jMJ2uUHaY6', null, '游客_utctV9jMJ2uUHaY6', null, '-1', '2', null, '4', null, '2017-10-24 10:54:13', '0', null, '游客_utctV9jMJ2uUHaY6', null, null, '1', '1', '2017-10-24 10:54:13', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000157', '游客_MKO1UGOoEw97DozV', null, '游客_MKO1UGOoEw97DozV', null, '-1', '2', null, '4', null, '2017-10-24 10:59:35', '0', null, '游客_MKO1UGOoEw97DozV', null, null, '1', '1', '2017-10-24 10:59:35', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000158', '游客_ztrCYgbbctH8ufrt', null, '游客_ztrCYgbbctH8ufrt', null, '-1', '2', null, '4', null, '2017-10-24 11:05:19', '0', null, '游客_ztrCYgbbctH8ufrt', null, null, '1', '1', '2017-10-24 11:05:19', null, null, '0', null, null, null);
INSERT INTO `t_users` VALUES ('17000159', '游客_XI16XxHOfIDGwdx3', null, '游客_XI16XxHOfIDGwdx3', null, '-1', '2', null, '4', null, '2017-10-24 11:14:56', '0', null, '游客_XI16XxHOfIDGwdx3', null, null, '1', '1', '2017-10-24 11:14:56', null, null, '0', null, null, null);
