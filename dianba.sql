/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : dianba

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 27/11/2024 15:26:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply`  (
  `applyId` int NOT NULL AUTO_INCREMENT,
  `chargeId` int NOT NULL,
  `applyTime` datetime NULL DEFAULT NULL,
  `applyStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applicant` int NOT NULL,
  PRIMARY KEY (`applyId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES (1, 35, '2024-08-23 06:05:50', '未通过', 9);
INSERT INTO `apply` VALUES (2, 36, '2024-08-23 06:05:50', '未通过', 9);
INSERT INTO `apply` VALUES (3, 37, '2024-08-23 06:06:27', '已完成', 9);
INSERT INTO `apply` VALUES (4, 38, '2024-08-23 06:06:27', '审批中', 9);
INSERT INTO `apply` VALUES (5, 35, '2024-08-24 01:34:19', '已完成', 10);
INSERT INTO `apply` VALUES (6, 39, '2024-08-24 01:34:19', '已完成', 10);
INSERT INTO `apply` VALUES (7, 32, '2024-08-24 03:04:42', '已完成', 22);
INSERT INTO `apply` VALUES (8, 43, '2024-08-24 06:10:11', '已完成', 22);
INSERT INTO `apply` VALUES (9, 44, '2024-08-24 06:10:11', '未通过', 22);
INSERT INTO `apply` VALUES (10, 40, '2024-08-24 08:20:45', '已完成', 21);
INSERT INTO `apply` VALUES (11, 41, '2024-08-24 08:20:45', '已完成', 21);
INSERT INTO `apply` VALUES (12, 44, '2024-08-24 08:51:20', '已完成', 23);
INSERT INTO `apply` VALUES (13, 45, '2024-08-24 08:51:20', '未通过', 23);
INSERT INTO `apply` VALUES (14, 43, '2024-08-25 06:39:50', '已完成', 24);
INSERT INTO `apply` VALUES (15, 45, '2024-08-25 06:39:50', '已完成', 24);
INSERT INTO `apply` VALUES (16, 42, '2024-08-25 07:16:46', '已完成', 25);
INSERT INTO `apply` VALUES (17, 46, '2024-08-25 07:16:46', '已完成', 25);
INSERT INTO `apply` VALUES (18, 48, '2024-08-25 07:16:46', '已完成', 25);
INSERT INTO `apply` VALUES (19, 47, '2024-08-25 07:16:46', '未通过', 25);
INSERT INTO `apply` VALUES (20, 47, '2024-08-25 11:35:45', '审批中', 2);
INSERT INTO `apply` VALUES (21, 49, '2024-08-25 11:35:45', '审批中', 2);
INSERT INTO `apply` VALUES (22, 33, '2024-08-25 11:35:45', '审批中', 2);
INSERT INTO `apply` VALUES (23, 50, '2024-08-29 14:11:33', '审批中', 10);

-- ----------------------------
-- Table structure for charge
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge`  (
  `chargeId` int NOT NULL AUTO_INCREMENT,
  `chargeName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `launch` tinyint(1) NOT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `zhuangTai` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `maintenanceTime` datetime NOT NULL,
  `owningId` int NULL DEFAULT NULL,
  `cost` int NULL DEFAULT NULL,
  `powerConsumption` int NULL DEFAULT NULL,
  PRIMARY KEY (`chargeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of charge
-- ----------------------------
INSERT INTO `charge` VALUES (8, 'Cindy Allen', 1, '0H6zF7zehM', '正常', '2003-01-17 11:47:18', 2, 2000, 2);
INSERT INTO `charge` VALUES (9, 'Shimada Itsuki', 1, 'yI1DXxstPp', '正常', '2014-11-08 17:55:28', 2, 2000, 222);
INSERT INTO `charge` VALUES (10, 'Tse Suk Yee', 1, 'HG4jw1HYRR', '正常', '2010-10-04 21:32:01', 2, 2000, 224);
INSERT INTO `charge` VALUES (11, 'Lam On Kay', 1, 'Kbturxkvpi', '异常', '2011-12-14 05:44:54', 2, 2000, 100);
INSERT INTO `charge` VALUES (12, 'Louis Holmes', 1, 'YjmKG4toey', '正常', '2005-10-02 15:39:32', 2, 2000, 120);
INSERT INTO `charge` VALUES (13, 'Lu Zhiyuan', 1, 'EbxGDRB05V', '正常', '2015-03-28 08:08:24', 2, 2000, 120);
INSERT INTO `charge` VALUES (14, 'Miyazaki Yuito', 0, 'UFkK2gxwV4', '正常', '2007-10-07 09:14:39', 2, 2000, 100);
INSERT INTO `charge` VALUES (15, 'Lai Chung Yin', 0, 'Ge3U3zCcPL', '正常', '2011-12-22 06:15:35', 2, 2000, 10000);
INSERT INTO `charge` VALUES (16, 'Sasaki Mio', 0, 'VeyVTWilSZ', '正常', '2006-06-05 17:03:08', 2, 2000, 0);
INSERT INTO `charge` VALUES (17, 'Xu Lan', 1, 'IipPJtC6OY', '正常', '2021-09-14 12:01:47', 2, 2000, 0);
INSERT INTO `charge` VALUES (18, 'Yan Lu', 1, '9WuR2vf815', '正常', '2013-06-23 01:24:53', 5, 2000, NULL);
INSERT INTO `charge` VALUES (19, 'Miu On Kay', 0, 'b9zBfXg7sq', '正常', '2002-01-06 13:01:40', 3, 2000, NULL);
INSERT INTO `charge` VALUES (20, 'Wong Tak Wah', 1, '9r8LqIreMy', '正常', '2000-03-16 23:12:16', 5, 2000, NULL);
INSERT INTO `charge` VALUES (21, 'Deng Jiehong', 0, 'Z8yj0HXBLB', '正常', '2023-11-04 03:11:12', 5, 2000, NULL);
INSERT INTO `charge` VALUES (22, 'Hsuan Ting Fung', 0, 'Lj3FZX6dOD', '异常', '2003-10-10 09:08:47', 3, 2000, NULL);
INSERT INTO `charge` VALUES (23, 'Jeffrey Watson', 1, 'MV9A1Sw564', '异常', '2019-06-01 11:49:41', 5, 2000, NULL);
INSERT INTO `charge` VALUES (24, 'Elaine Gordon', 1, 'hdLUmmBB6u', '正常', '2007-10-11 15:34:42', 2, 2000, NULL);
INSERT INTO `charge` VALUES (25, 'Han Xiaoming', 0, 'BxQNxeQbAr', '正常', '2009-05-28 09:16:49', 4, 2000, NULL);
INSERT INTO `charge` VALUES (26, 'Ota Sara', 1, 'znXgMEbfMm', '正常', '2002-01-07 22:15:11', 4, 2000, NULL);
INSERT INTO `charge` VALUES (27, 'Murata Akina', 0, 'jWX0Efdd0s', '异常', '2018-07-09 12:09:38', 3, 2000, NULL);
INSERT INTO `charge` VALUES (28, 'Zhao Jialun', 1, 'hSlRbAf9kD', '正常', '2018-08-04 15:51:54', 2, 2000, NULL);
INSERT INTO `charge` VALUES (29, 'Chang Yunxi', 0, 'Op7mjqwgcT', '异常', '2011-06-18 22:48:43', 6, 2000, NULL);
INSERT INTO `charge` VALUES (30, 'Clifford Stevens', 1, 'iVaXQyCYq8', '正常', '2006-11-22 19:35:46', 3, 2000, NULL);
INSERT INTO `charge` VALUES (31, 'Jiang Jiehong', 1, 'PCfmbnS4QT', '正常', '2009-07-03 11:36:36', 2, 2000, NULL);
INSERT INTO `charge` VALUES (33, '多对', 0, '多对多', '正常', '2024-08-13 16:00:00', 1, 2000, NULL);
INSERT INTO `charge` VALUES (35, '测试1', 1, '宜昌', '正常', '2024-08-23 02:59:52', 10, 2000, NULL);
INSERT INTO `charge` VALUES (36, '测试2', 1, '宜昌2', '正常', '2024-08-23 02:59:52', 1, 2000, NULL);
INSERT INTO `charge` VALUES (37, '测试3', 1, '宜昌3', '正常', '2024-08-23 02:59:52', 9, 2000, NULL);
INSERT INTO `charge` VALUES (38, '测试4', 1, '宜昌4', '正常', '2024-08-23 02:59:52', 1, 2000, NULL);
INSERT INTO `charge` VALUES (39, '测试5', 1, '宜昌5', '正常', '2024-08-16 06:15:02', 10, 2000, NULL);
INSERT INTO `charge` VALUES (40, '测试6', 1, '宜昌6', '正常', '2024-08-23 08:45:20', 21, 2000, NULL);
INSERT INTO `charge` VALUES (41, 'dd', 1, 'ddd', '正常', '2024-08-07 16:00:00', 21, 2000, 0);
INSERT INTO `charge` VALUES (42, '测试7', 1, '宜昌', '正常', '2024-08-24 03:07:01', 25, 2000, 0);
INSERT INTO `charge` VALUES (43, '电霸1', 1, '宜昌', '正常', '2024-08-24 06:08:34', 24, 2000, 0);
INSERT INTO `charge` VALUES (44, '电霸2', 1, '宜昌', '正常', '2024-08-24 06:08:34', 23, 2000, 0);
INSERT INTO `charge` VALUES (45, '电霸3', 1, '宜昌', '正常', '2024-08-24 06:08:34', 24, 2000, 0);
INSERT INTO `charge` VALUES (46, '电霸4', 1, 'xi陵', '正常', '2024-08-24 16:00:00', 25, 2000, 0);
INSERT INTO `charge` VALUES (47, '电霸5', 1, 'sd', '正常', '2024-08-24 16:00:00', 1, 2000, 0);
INSERT INTO `charge` VALUES (48, '电霸6', 1, '三大', '正常', '2024-08-24 16:00:00', 25, 2000, 0);
INSERT INTO `charge` VALUES (49, '电霸7', 1, '宜昌', '正常', '2024-08-24 16:00:00', 1, 2000, 0);
INSERT INTO `charge` VALUES (50, '电霸8', 1, 'kk', '正常', '2024-08-24 16:00:00', 1, 2000, 0);
INSERT INTO `charge` VALUES (51, '电霸9', 1, 'tt', '正常', '2024-08-24 16:00:00', 0, 2000, 0);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `feedId` int NOT NULL AUTO_INCREMENT,
  `feedBack` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `feedTime` datetime NULL DEFAULT NULL,
  `done` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`feedId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, 'Raspbzrry elite', '2013-05-13 06:20:42', '已处理');
INSERT INTO `feedback` VALUES (2, 'Sprawberry elite', '2024-05-18 13:46:15', '已处理');
INSERT INTO `feedback` VALUES (3, 'pluots pro', '2000-03-08 19:34:28', '已处理');
INSERT INTO `feedback` VALUES (4, 'nrape', '2021-09-16 14:39:10', '已处理');
INSERT INTO `feedback` VALUES (5, 'Pluots se', '2017-10-02 01:37:50', '未处理');
INSERT INTO `feedback` VALUES (6, 'frape', '2005-04-17 21:58:58', '已处理');
INSERT INTO `feedback` VALUES (7, 'xOrange', '2006-11-12 22:09:20', '未处理');
INSERT INTO `feedback` VALUES (8, 'Strawberry', '2007-10-05 18:53:32', '已处理');
INSERT INTO `feedback` VALUES (9, 'Mbngo plus', '2005-10-27 03:26:07', '未处理');
INSERT INTO `feedback` VALUES (10, 'xRambutan', '2003-01-10 22:29:04', '未处理');
INSERT INTO `feedback` VALUES (11, 'Mango', '2006-02-24 11:20:20', '已处理');
INSERT INTO `feedback` VALUES (12, '测试7坏了', NULL, '未完成');
INSERT INTO `feedback` VALUES (13, '测试9有问题', '2024-08-23 03:26:40', '未完成');
INSERT INTO `feedback` VALUES (14, '设备坏了', '2024-08-24 06:12:45', '已处理');
INSERT INTO `feedback` VALUES (15, '充电桩11异常', '2024-08-23 16:00:00', '未完成');
INSERT INTO `feedback` VALUES (16, '充电桩44号出现故障', '2024-08-24 08:53:18', '未完成');
INSERT INTO `feedback` VALUES (17, '充电桩42报修', '2024-08-24 16:00:00', '已处理');

-- ----------------------------
-- Table structure for keeplist
-- ----------------------------
DROP TABLE IF EXISTS `keeplist`;
CREATE TABLE `keeplist`  (
  `keepId` int NOT NULL AUTO_INCREMENT,
  `chargeId` int NOT NULL,
  `pchargeId` int NOT NULL,
  `keepTime` datetime NOT NULL,
  `faultDescription` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `done` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`keepId`) USING BTREE,
  INDEX `负责人id`(`pchargeId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of keeplist
-- ----------------------------
INSERT INTO `keeplist` VALUES (5, 1, 2, '2011-02-28 01:11:04', 'Pluyts core', '完成');
INSERT INTO `keeplist` VALUES (6, 2, 4, '2002-06-23 04:32:24', 'iGrape', '完成');
INSERT INTO `keeplist` VALUES (7, 3, 1, '2023-06-10 02:43:33', 'Grape', '未完成');
INSERT INTO `keeplist` VALUES (8, 4, 3, '2013-10-23 02:43:55', 'Cherry', '未完成');
INSERT INTO `keeplist` VALUES (9, 5, 3, '2005-06-28 09:01:07', 'ultra-Mango', '完成');
INSERT INTO `keeplist` VALUES (10, 6, 1, '2013-07-15 23:32:06', 'Orange plus', '完成');
INSERT INTO `keeplist` VALUES (11, 7, 1, '2012-11-20 22:33:41', 'iRagpberry', '完成');
INSERT INTO `keeplist` VALUES (12, 8, 2, '2022-12-09 05:40:13', 'hherry pro', '未完成');
INSERT INTO `keeplist` VALUES (13, 9, 3, '2016-01-05 12:57:02', 'Strawberry', '完成');
INSERT INTO `keeplist` VALUES (14, 10, 4, '2018-09-25 06:25:47', 'Mango', '完成');
INSERT INTO `keeplist` VALUES (15, 11, 1, '2000-09-28 01:09:57', 'omni-Rambutan', '未完成');
INSERT INTO `keeplist` VALUES (16, 12, 2, '2002-10-17 17:57:05', 'Raspberry', '完成');
INSERT INTO `keeplist` VALUES (17, 13, 4, '2004-07-20 03:35:41', 'Strawberzy', '完成');
INSERT INTO `keeplist` VALUES (18, 14, 3, '2006-09-24 20:43:33', 'ultra-Mango', '完成');
INSERT INTO `keeplist` VALUES (19, 15, 2, '2021-03-14 22:36:05', 'Grape', '未完成');
INSERT INTO `keeplist` VALUES (20, 16, 2, '2006-12-06 06:57:54', 'Grame', '完成');
INSERT INTO `keeplist` VALUES (21, 17, 2, '2012-06-18 11:43:13', 'Orlnge', '未完成');
INSERT INTO `keeplist` VALUES (22, 18, 4, '2018-06-03 18:09:48', 'Orahge', '完成');
INSERT INTO `keeplist` VALUES (23, 19, 2, '2001-07-08 07:02:55', 'Cherry', '完成');
INSERT INTO `keeplist` VALUES (24, 20, 1, '2004-04-30 04:56:38', 'eango', '未完成');
INSERT INTO `keeplist` VALUES (25, 1, 2, '2024-08-07 16:00:00', '你猜', '');
INSERT INTO `keeplist` VALUES (26, 1, 2, '2024-08-08 16:00:00', '真的吗', '');
INSERT INTO `keeplist` VALUES (27, 1, 1, '2024-08-06 16:00:00', '哈哈', '完成');
INSERT INTO `keeplist` VALUES (28, 1, 11, '2024-08-15 16:00:00', '哎', '未完成');
INSERT INTO `keeplist` VALUES (29, 9, 2, '2024-08-04 16:00:00', '', '完成');
INSERT INTO `keeplist` VALUES (30, 44, 2, '2024-07-31 16:00:00', '', '未完成');
INSERT INTO `keeplist` VALUES (31, 42, 2, '2024-08-24 16:00:00', '', '未完成');

-- ----------------------------
-- Table structure for pinformation
-- ----------------------------
DROP TABLE IF EXISTS `pinformation`;
CREATE TABLE `pinformation`  (
  `userId` int NOT NULL,
  `information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pinformation
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleId` int NOT NULL,
  `roleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`roleId` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (3, '管理员');
INSERT INTO `role` VALUES (1, '普通用户');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `roleId` int NULL DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE,
  INDEX `用户类别id`(`roleId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'apply', '123', '16843592456', 1);
INSERT INTO `users` VALUES (2, 'li', '123', '12341111111', 3);
INSERT INTO `users` VALUES (9, 'ff', '123', '123451111111', 1);
INSERT INTO `users` VALUES (10, '丁风', '123', '13562846924', 3);
INSERT INTO `users` VALUES (11, 'cc', '123', '15374581111', 1);
INSERT INTO `users` VALUES (21, 'zx', '123', '13378589632', 3);
INSERT INTO `users` VALUES (24, 'zx2', '123', '19371393320', 1);
INSERT INTO `users` VALUES (25, 'zx3', '123', '19371393320', 1);

SET FOREIGN_KEY_CHECKS = 1;
