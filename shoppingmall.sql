/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : shoppingmall

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 09/01/2025 13:37:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '29653289f9fc69756d2bc255bcfa585c59c6950e', '/uploads/avatars/67762bd1a9f93.jpg', 'HelloKitty', 'explem12345@outlook.com');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `CartID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '用户ID',
  `ProductID` int(11) NOT NULL COMMENT '商品ID',
  `Quantity` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`CartID`) USING BTREE,
  INDEX `UserID`(`UserID`) USING BTREE,
  INDEX `ProductID`(`ProductID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, 12345, 2, 1);
INSERT INTO `cart` VALUES (2, 12345, 7, 1);
INSERT INTO `cart` VALUES (3, 12345, 5, 1);
INSERT INTO `cart` VALUES (4, 12345, 1, 1);
INSERT INTO `cart` VALUES (5, 12345, 1, 1);
INSERT INTO `cart` VALUES (6, 12345, 2, 1);
INSERT INTO `cart` VALUES (7, 12345, 2, 1);
INSERT INTO `cart` VALUES (8, 12345, 3, 1);
INSERT INTO `cart` VALUES (9, 1, 1, 1);
INSERT INTO `cart` VALUES (10, 1, 3, 1);
INSERT INTO `cart` VALUES (11, 1, 2, 1);
INSERT INTO `cart` VALUES (12, 1, 2, 1);
INSERT INTO `cart` VALUES (13, 1, 7, 1);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cate_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`CategoryID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '水果', 'fruit');
INSERT INTO `categories` VALUES (2, '男装', 'boyclothes');
INSERT INTO `categories` VALUES (3, '女装', 'girlclothes');
INSERT INTO `categories` VALUES (4, '饮料', 'drink');
INSERT INTO `categories` VALUES (5, '内衣', 'inclothes');
INSERT INTO `categories` VALUES (6, '美妆', 'meizhuang');
INSERT INTO `categories` VALUES (7, '情趣', 'sex');
INSERT INTO `categories` VALUES (8, '电子产品', 'dianzi');
INSERT INTO `categories` VALUES (9, '家电', 'homedian');
INSERT INTO `categories` VALUES (10, '运动', 'sport');
INSERT INTO `categories` VALUES (11, '厨具', 'kitchen');

-- ----------------------------
-- Table structure for orderdetails
-- ----------------------------
DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails`  (
  `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`OrderDetailID`) USING BTREE,
  INDEX `OrderID`(`OrderID`) USING BTREE,
  INDEX `ProductID`(`ProductID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of orderdetails
-- ----------------------------
INSERT INTO `orderdetails` VALUES (1, 1, 1, 1, 1);
INSERT INTO `orderdetails` VALUES (2, 2, 5, 1, 1);
INSERT INTO `orderdetails` VALUES (3, 3, 1, 1, 1);
INSERT INTO `orderdetails` VALUES (4, 4, 6, 1, 1);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `OrderID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NULL DEFAULT NULL,
  `OrderDate` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `TotalAmount` decimal(10, 2) NOT NULL,
  `OrderStatus` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`) USING BTREE,
  INDEX `UserID`(`UserID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, '2025-01-02 21:07:52', 30.00, '未发货');
INSERT INTO `orders` VALUES (2, 1, '2025-01-06 20:39:05', 18.00, '已发货');
INSERT INTO `orders` VALUES (3, 1, '2025-01-09 13:18:20', 30.00, '未发货');
INSERT INTO `orders` VALUES (4, 1, '2025-01-09 13:19:41', 18.00, '未发货');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `ProductID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `Price` decimal(10, 2) NOT NULL,
  `Stock` int(11) NOT NULL,
  `CategoryID` int(11) NULL DEFAULT NULL,
  `Image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ProductID`) USING BTREE,
  INDEX `CategoryID`(`CategoryID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '草莓', '好吃美味20个x1盒', 30.00, 3000000, 1, '/uploads/avatars/67762bd1a9f93.jpg', '已发布');
INSERT INTO `products` VALUES (2, '草莓', '好吃美味20个x1盒', 30.00, 3000000, 1, '/uploads/avatars/67762bd1a9f93.jpg', '已发布');
INSERT INTO `products` VALUES (3, '草莓', '好吃美味20个x1盒', 30.00, 3000000, 1, '/uploads/avatars/67762bd1a9f93.jpg', '已发布');
INSERT INTO `products` VALUES (4, '草莓', '好吃美味20个x1盒', 30.00, 3000000, 1, '/uploads/avatars/67762bd1a9f93.jpg', '已发布');
INSERT INTO `products` VALUES (5, '可口可乐', '10x1箱', 18.00, 30000000, 4, '/uploads/avatars/677b94fad1db1.jpg', '已发布');
INSERT INTO `products` VALUES (6, '可口可乐', '10x1箱', 18.00, 30000000, 4, '/uploads/avatars/677b94fce225a.jpg', '已发布');
INSERT INTO `products` VALUES (7, '猕猴桃', '清仓大甩卖', 5.00, 234142, 1, '/uploads/avatars/677ba090f116f.png', '已发布');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '账号',
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `Phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `Address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '29653289f9fc69756d2bc255bcfa585c59c6950e', 'root666@qq.com', '19485736205', '汕头市西胪镇', '/uploads/avatars/67762bd1a9f93.jpg', 'hello');
INSERT INTO `user` VALUES (2, 'zzl666', '66b90ea53459edee415b83fd0b5221eeb89bef40', 'zzl666@qq.com', '16525342780', NULL, '/uploads/avatars/67762bd1a9f93.jpg', NULL);

SET FOREIGN_KEY_CHECKS = 1;
