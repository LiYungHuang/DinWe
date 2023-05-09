-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-05-09 05:09:12
-- 伺服器版本： 10.4.27-MariaDB
-- PHP 版本： 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `dinwe`
--

DELIMITER $$
--
-- 程序
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getbusinessHours` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants_operating_time WHERE resturant_id = rid;
    if isExist > 1 THEN
    	SELECT @myCount:=@myCount+1 AS id,
			CASE
    			WHEN weekday = 1 THEN "一"
    			WHEN weekday = 2 THEN "二"
				WHEN weekday = 3 THEN "三"
                WHEN weekday = 4 THEN "四"
                WHEN weekday = 5 THEN "五"
                WHEN weekday = 6 THEN "六"
                WHEN weekday = 7 THEN "日"
    			ELSE weekday
			END as weekday,
            CASE
    			WHEN isOpen IS NULL THEN 1
    			ELSE isOpen
			END as isOpen,
            CASE
    			WHEN opentime IS NULL THEN TIME_FORMAT("11:30", "%H:%i")
    			ELSE TIME_FORMAT(opentime, "%H:%i")
			END as opentime,
            CASE
    			WHEN closetime IS NULL THEN TIME_FORMAT("21:00", "%H:%i")
    			ELSE TIME_FORMAT(closetime, "%H:%i")
			END as closetime, 
            CASE
    			WHEN break_optime IS NULL THEN TIME_FORMAT("15:00", "%H:%i")
    			ELSE TIME_FORMAT(break_optime, "%H:%i")
			END as breaktimeOP,
            CASE
    			WHEN break_edtime IS NULL THEN TIME_FORMAT("17:30", "%H:%i")
    			ELSE TIME_FORMAT(break_edtime, "%H:%i")
			END as breaktimeED
                from resturants_operating_time WHERE resturant_id = rid;
    else
        SELECT 'The resturant does not set Operating Time.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDBdate` ()   begin
	SET @today = now();
	SELECT DATE_FORMAT(@today, "%Y-%m-%d") as today;
    -- SELECT TIME_FORMAT(@today, "%H:%i") as today;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantActivity` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    DECLARE notState4 int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturant_activities WHERE resturant_id = rid;
    SELECT count(*) into notState4 from resturant_activities WHERE resturant_id = rid AND prostate <> 4;
    
    if isExist > 0 THEN
   	 if notState4 > 0 THEN
    	SELECT @myCount:=@myCount+1 AS activity_id,
        	   id AS DB_id,
        	   resturant_id,
 			   title,
       		   editdate,
       		   releasedate,
       		   start_date AS startdate,
      		   end_date AS enddate,
      		   img,
               img_name,
               content,
               prostate
 			   from resturant_activities WHERE resturant_id = rid AND prostate <> 4
               ORDER BY releasedate DESC;
      ELSE
      	SELECT null as message;
      end if;
    else
        SELECT 'This resturant is not exist.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantComment` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
	DECLARE isState4 int DEFAULT 0;

	SELECT count(*) into isExist from orders WHERE resturant_id = rid;
    SELECT count(*) into isState4 from orders WHERE resturant_id = rid AND order_state = 4;
    
    if isExist > 0 THEN
    	if isState4 >0 THEN
    		SELECT order_id, order_date as orderdate, order_stars as star, order_comment as comments
 			from orders WHERE resturant_id = rid AND order_state = 4
            ORDER BY orderdate DESC;
        ELSE
        	SELECT null as message;
    	end if;
    else
        SELECT null as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantFacilities` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, 
            	   "玩具區" AS name,
        		   toy AS isChecked
            from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "溜滑梯" AS name,
        		   slide AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "球池" AS name,
        		   ballpit AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "沙坑" AS name,
        		   sandpit AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "農場" AS name,
        		   farm AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "草地" AS name,
        		   lawn AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "動物" AS name,
        		   animal AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "魚池" AS name,
        		   fishpond AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "生態池" AS name,
        		   ecopond AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "戲水池" AS name,
        		   paddingpool AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "家家酒" AS name,
        		   home AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "電玩設施" AS name,
        		   videogame AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "兒童書區" AS name,
        		   childrenbook AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "課程體驗" AS name,
        		   course AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "滿月活動" AS name,
        		   fullmoon AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "收涎活動" AS name,
        		   saliva AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "抓周活動" AS name,
        		   oneyear AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "性別派對" AS name,
        		   sexparty AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "慶生派對" AS name,
        		   birthday AS isChecked
 			from resturant_facilities WHERE resturant_id = rid;
            
    else
        SELECT 'http://fail.php.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantFoodCulture` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, 
            	   "素食" AS name,
        		   vegetarian AS isChecked
            from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "純素食" AS name,
        		   vegan AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "清真菜" AS name,
        		   muslin AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "無麩質" AS name,
        		   glutenfree AS isChecked
 			from resturant_facilities WHERE resturant_id = rid;
            
    else
        SELECT 'http://fail.php.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantImg` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    DECLARE item mediumblob DEFAULT '';
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, resturant_image_names.image1 as name,
        		resturants.resturant_image1 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.image2 as name,
        		resturants.resturant_image2 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.image3 as name,
        		resturants.resturant_image3 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.image4 as name,
        		resturants.resturant_image4 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.image5 as name,
        		resturants.resturant_image5 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid;
    else
        SELECT 'The resturant does not set Image.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantInfo` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    	SELECT resturant_id,
 			   resturant_account,
       		   resturant_name,
       		   resturant_uninum,
       		   resturant_phone,
      		   resturant_address,
      		   resturant_email,
               resturant_intro,
               resturant_ifram,
               resturant_state,
               DATE_FORMAT(editdate, "%Y/%m/%d") as editdate,
               TIME_FORMAT(edittime, "%H:%i") as edittime
 			   from resturants WHERE resturant_id = rid;
--      SELECT * from resturants WHERE resturant_id = rid;
    else
        SELECT 'This resturant is not exist.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantMenu` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    DECLARE item mediumblob DEFAULT '';
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, resturant_image_names.menu1 as name,
        		resturants.resturant_menu1 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.menu2 as name,
        		resturants.resturant_menu2 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid
            union all
            SELECT @myCount:=@myCount+1 AS id, resturant_image_names.menu3 as name,
        		resturants.resturant_menu3 AS item
            from resturants, resturant_image_names
            WHERE resturants.resturant_id = rid AND resturant_image_names.resturant_id = rid;
    else
        SELECT 'The resturant does not set Image.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantOrders` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from orders WHERE resturant_id = rid;
    
    if isExist > 0 THEN
    	SELECT @myCount:=@myCount+1 AS id,
        	   order_id AS DB_order_id,
        	   resturant_id,
 			   order_who AS name,
       		   order_phone AS tel,
       		   order_date AS orderdate,
       		   order_time AS ordertime,
      		   order_adult AS adult,
               CASE
    				WHEN order_child IS NULL THEN 0
    				ELSE order_child
			   END AS child,
               CASE
    				WHEN order_chair IS NULL THEN 0
    				ELSE order_chair
			   END AS chair,
               CASE
    				WHEN order_tableware IS NULL THEN 0
    				ELSE order_tableware
			   END AS tableware,  
               CASE
    				WHEN order_notes IS NULL THEN ""
    				ELSE order_notes
			   END AS notes,
               order_state AS orderstate
 			   from orders WHERE resturant_id = rid
               ORDER BY orderdate DESC, ordertime;
    else
        SELECT null as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantPandAvg` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;

	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT resturants.resturant_id,
               resturants.resturant_max as people,
               resturants.resturant_averageconsum as averagesum,
               DATE_FORMAT(resturant_facilities.editdate, "%Y/%m/%d") as editdate,
               TIME_FORMAT(resturant_facilities.edittime, "%H:%i") as edittime
 			from resturants, resturant_facilities WHERE resturants.resturant_id = rid AND resturant_facilities.resturant_id = rid;
    else
        SELECT 'http://fail.php.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantPayments` (IN `rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, 
            	   "現金支付" AS name,
        		   cash AS isChecked
            from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "VISA" AS name,
        		   visa AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "信用卡" AS name,
        		   creditcard AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "街口支付" AS name,
        		   streetpay AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "悠遊付" AS name,
        		   easycard AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "LINE Pay" AS name,
        		   linepay AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "Apple Pay" AS name,
        		   applepay AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "Google Pay" AS name,
        		   googlepay AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "台灣 Pay" AS name,
        		   taiwanpay AS isChecked
 			from resturant_facilities WHERE resturant_id = rid;
            
    else
        SELECT 'http://fail.php.' as message;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getResturantServices` (`rid` INT)   begin
    DECLARE isExist int DEFAULT 0;
    
    SET @myCount = 0;
	SELECT count(*) into isExist from resturants WHERE resturant_id = rid;
    if isExist = 1 THEN
    		SELECT @myCount:=@myCount+1 AS id, 
            	   "供應酒精飲品" AS name,
        		   alcohol AS isChecked
            from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "免費無線網路" AS name,
        		   wifi AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "座充插座" AS name,
        		   socket AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "禁菸餐廳" AS name,
        		   smoking AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "兒童座椅" AS name,
        		   childseat AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "兒童餐具" AS name,
        		   childware AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "哺乳室" AS name,
        		   nursingroom AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "尿布台" AS name,
        		   diaper AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "免費嬰兒車租借" AS name,
        		   stroller AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "國民旅遊卡" AS name,
        		   touristcard AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "專車接送" AS name,
        		   shuttle AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "汽車專區" AS name,
        		   car AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "機車專區" AS name,
        		   scotter AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "停車場折抵優惠" AS name,
        		   parkdiscount AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "場地租借" AS name,
        		   venuerental AS isChecked
 			from resturant_facilities WHERE resturant_id = rid
            union ALL
            SELECT @myCount:=@myCount+1 AS id, 
            	   "無障礙設施" AS name,
        		   barrierfree AS isChecked
 			from resturant_facilities WHERE resturant_id = rid;
            
    else
        SELECT 'http://fail.php.' as message;
    end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 `emails`
--

CREATE TABLE `emails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `token_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `members`
--

CREATE TABLE `members` (
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `member_account` varchar(20) NOT NULL,
  `member_password` varchar(100) NOT NULL,
  `member_email` varchar(100) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `member_birthday` date DEFAULT NULL,
  `member_cellphone` varchar(10) DEFAULT NULL,
  `member_image` mediumblob DEFAULT NULL,
  `member_state` int(11) NOT NULL DEFAULT 1,
  `member_token` varchar(100) DEFAULT NULL,
  `member_giveup` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `members`
--

INSERT INTO `members` (`member_id`, `member_account`, `member_password`, `member_email`, `member_name`, `member_birthday`, `member_cellphone`, `member_image`, `member_state`, `member_token`, `member_giveup`) VALUES
(1, '0903621823', '$2y$10$juMgl2RZA31JASKXfy21VeAnMyin1gdM/UWDvFCeG5A7BHuAdRrMK', '0903621823@gmail.com', '郭紀伸', '1994-10-26', '0903621823', NULL, 9, NULL, 0),
(2, '0962681267', '$2y$10$LS6Onegsf7fhyJU7hOhBAOLwPewj.bjhQebmAHK0buF5DMA8Dqy9e', '0962681267@gmail.com', '賴姿吟', '1990-12-09', '0962681267', NULL, 1, NULL, 0),
(3, '0941232464', '$2y$10$zEcTuNXnxzC3r.YdJLVzi.vWTVYpL0EDohpZZwVNFzFRA1eZPHDTa', '0941232464@gmail.com', '林文彬', '1998-02-28', '0941232464', NULL, 1, NULL, 0),
(4, '0997599583', '$2y$10$PQY4c3aYRJU59spnasOEQO9PgLKyNX14UG5q99jK8RPZJuGkgF5fK', '0997599583@gmail.com', '林淑娟', '1980-05-24', '0997599583', NULL, 1, NULL, 0),
(5, '0908725532', '$2y$10$uLHos9l.0J8gU986yveLPeU6iVivLEENtKHwt/bgvoWe/4i3UmbvC', '0908725532@gmail.com', '陳和憲', '1998-09-13', '0908725532', NULL, 1, NULL, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `member_likes`
--

CREATE TABLE `member_likes` (
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `member_tags`
--

CREATE TABLE `member_tags` (
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `tag_name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `member_tag_resturants`
--

CREATE TABLE `member_tag_resturants` (
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2023_04_21_015347_create_resturants_table', 1),
(3, '2023_04_21_015502_create_resturant_operating_times_table', 1),
(4, '2023_04_21_015533_create_resturant_facilities_table', 1),
(5, '2023_04_21_021410_create_members_table', 1),
(6, '2023_04_21_021418_create_member_likes_table', 1),
(7, '2023_04_21_021424_create_member_tags_table', 1),
(8, '2023_04_21_021432_create_member_tag_resturants_table', 1),
(9, '2023_04_21_023326_create_orders_table', 1),
(10, '2023_04_21_054841_create_resturant_activities_table', 1),
(11, '2023_04_21_143309_create_emails_table', 1),
(12, '2023_04_23_122255_create_resturant_image_names_table', 1),
(13, '2023_04_27_153954_create_news_table', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `news`
--

CREATE TABLE `news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `resturant_name` varchar(50) NOT NULL,
  `image` blob NOT NULL,
  `title` varchar(50) NOT NULL,
  `subtitle` varchar(50) NOT NULL,
  `text` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `order_who` varchar(20) NOT NULL,
  `order_phone` varchar(10) NOT NULL,
  `order_date` date NOT NULL,
  `order_time` time NOT NULL,
  `order_adult` int(11) NOT NULL,
  `order_child` int(11) DEFAULT NULL,
  `order_chair` int(11) DEFAULT NULL,
  `order_tableware` int(11) DEFAULT NULL,
  `order_stars` int(11) DEFAULT NULL,
  `order_notes` text DEFAULT NULL,
  `order_state` tinyint(4) NOT NULL DEFAULT 1,
  `order_comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `orders`
--

INSERT INTO `orders` (`order_id`, `member_id`, `resturant_id`, `order_who`, `order_phone`, `order_date`, `order_time`, `order_adult`, `order_child`, `order_chair`, `order_tableware`, `order_stars`, `order_notes`, `order_state`, `order_comment`) VALUES
(1, 1, 10, '郭紀伸', '0903621823', '2023-04-03', '10:00:00', 4, 2, 2, 2, 5, '我家小孩比較吵，希望可以安排包廂', 4, '昨天在這邊舉辦了寶寶的週歲生日和抓周活動，感到非常滿意！ 從前期的聯繫，到後續的佈置及餐點安排，還有現場的服務跟抓周老師都非常到位，可圈可點！ 大人小孩都吃的滿足、玩得盡興，也滿足到媽媽想要給寶寶一個難得的回憶跟紀念的心❤️ CP值非常高👍 未來有要在辦小朋友的趴踢也有可能再在這裡舉辦'),
(2, 1, 10, '郭紀伸', '0903621823', '2023-03-03', '11:00:00', 4, 2, 2, 2, 1, '希望入座前消毒', 4, '很適合辦小朋友慶生會 感謝服務人員幫我們拯救了受傷嚴重的蛋糕 重新擺設，讓活動圓滿結束😄😄 餐點也蠻好吃的非常棒的親子餐廳👍'),
(3, 2, 10, '賴姿吟', '0962681267', '2023-04-15', '12:00:00', 6, 4, 4, 4, 3, '冷氣不要太強', 4, '桌上附贈有尿布、紙圍兜…等，若需要其他用餐、清潔的東西也能索取，真的很貼心 餐點出餐速度很快，1915廣播最後點餐時間 餐點味道不錯，很快就能吃完 學齡前的親子餐廳，即使小孩吶喊也不會有異樣眼光，完全是天堂'),
(4, 2, 10, '賴姿吟', '0962681267', '2023-04-30', '13:00:00', 6, 4, 4, 4, 2, NULL, 4, '朋友家人在此辦周歲抓周宴，服務及餐點都很到位，一次最少得十人份，所以用不完的可以帶走。 盼望小小孩能平安順利長大，結束時也很多親子在樓下同樂了。 器具是媽媽額外租借的，品質優良，價格實惠。有電梯可以方便家人移動及搬下樓'),
(6, 1, 10, '林文彬', '0941232464', '2023-04-05', '14:00:00', 8, 6, 2, 2, 5, '食物不要有青椒', 4, '第一次光臨順便過來用餐、疫情問題座位有點少、建議先預約避免等候、餐點都算不錯主要很適合小孩吃飯、一樓遊戲區空間不大，有機會在光臨用餐'),
(7, 3, 10, '林文彬', '0941232464', '2023-05-02', '11:30:00', 8, 6, 2, 2, 4, '對花生過敏', 4, '遊戲空間開放寬闊，有區分不同年齡層，各入口處都有服務人員看著，對小朋友態度也很親切。雖然還是會有5.6歲的跑進幼幼區玩，不過基本秩序仍維持得不錯。 水池那邊就比較雞肋，小孩一下就沒興趣了，其它都玩得不亦樂乎，連室外沙坑都待了半小時有。自己覺得繩籠最讓我驚豔，也沒想到小孩已經這麼厲害都敢爬了。 食物也不錯吃喔，食材搭配滿健康的，雖然整體消費高但一行四人都開心。'),
(8, 3, 10, '郭紀伸', '0903621823', '2023-05-02', '12:00:00', 10, 8, 3, 3, 3, '食材務必新鮮', 4, '親子餐廳安全及衛生的環境這邊都有，總共兩層樓，假日僅採預約制，可包場，老闆娘非常有愛以及好聊，建議也可平日多多帶孩子來玩，孩子開心，家長也放鬆！'),
(9, 4, 10, '林淑娟', '0997599583', '2023-05-02', '12:00:00', 4, 2, 2, 2, 2, '座位希望靠窗', 4, '我是下午消費的客人，整個規劃的很棒，老闆很認真，老闆娘更是親切，而且場地很乾淨，真的是耐心細心用心的一家店，如果有六顆星我會按六顆，廁所也有良好的設施，下次有機會還會再去'),
(10, 4, 10, '陳和憲', '0908725532', '2023-05-03', '17:30:00', 3, 3, 3, 2, 1, '座位希望靠窗', 4, '一樓免費入場，玩小遊戲需要費用，可以跟櫃檯買套票，真心覺得很不錯，因為每個遊戲都有機會換到娃娃，價格很可以。也另外有花藝之類的課程。 全部都有專人在旁邊引導，我們年紀太小，服務人員也很有耐心引導和等待我們～真是太感謝了～ 一樓還有餐廳可以用餐，大人可以吃咖啡廳的義大利麵，嬰兒還是要自己準備食物，沒有中式的粥或清淡的食物～ 遠道而來，特地買門票二樓的故事館走走，但小孩太小，不然他裡面有一區互動式的釣魚教學，還有專人講解，感覺很專業，可以學習到新知識。淺淺聽到餌的方式和使用方法，還有甩竿體驗。覺得大概中班大班可以玩的更盡興。二樓最後還有DIY區域～'),
(11, 4, 10, '賴姿吟', '0962681267', '2023-05-02', '19:00:00', 1, 1, 1, 1, 4, '可能會遲到', 4, '店員十分親切。也會注意媽媽帶的小孩是哪一位。如果有媽媽在找小孩也都第一時間觀察出來。非常細心。外面等待區沙坑讓小孩玩的不想走。裡面遊戲區很大。小孩進入要收180清潔費。必須一個大人陪同。第一次用餐店員會詳細介紹服務非常好。裡面球池大人必需穿著襪子才能入場。也有廚房玩具跟釣魚區。小型盪鞦韆。餐點滿好吃價格是360-280都有。小孩餐點是269有貝殼麵或是南瓜飯也可以選擇。以服務來說算是不錯用餐環境。大樹是爸媽帶小孩的好去處❤️'),
(12, 3, 10, '林文彬', '0941232464', '2023-05-15', '11:30:00', 2, 1, 1, 1, NULL, NULL, 1, NULL),
(13, 4, 10, '林淑娟', '0997599583', '2023-05-16', '17:00:00', 2, 1, 1, 1, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Resturant', 10, 'API TOKEN', '1ea3b90c3d8a49a97b5021de0a24fa2578cb9e17a6bcb41d771ddb01b590aae1', '[\"*\"]', NULL, NULL, '2023-05-09 03:06:27', '2023-05-09 03:06:27');

-- --------------------------------------------------------

--
-- 資料表結構 `resturants`
--

CREATE TABLE `resturants` (
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `resturant_name` varchar(50) NOT NULL,
  `resturant_address` varchar(50) NOT NULL,
  `resturant_uninum` varchar(8) DEFAULT NULL,
  `resturant_phone` varchar(10) DEFAULT NULL,
  `resturant_email` varchar(50) DEFAULT NULL,
  `resturant_image1` mediumblob DEFAULT NULL,
  `resturant_image2` mediumblob DEFAULT NULL,
  `resturant_image3` mediumblob DEFAULT NULL,
  `resturant_image4` mediumblob DEFAULT NULL,
  `resturant_image5` mediumblob DEFAULT NULL,
  `resturant_menu1` mediumblob DEFAULT NULL,
  `resturant_menu2` mediumblob DEFAULT NULL,
  `resturant_menu3` mediumblob DEFAULT NULL,
  `resturant_intro` longtext DEFAULT NULL,
  `resturant_state` int(11) NOT NULL DEFAULT 1,
  `resturant_averageconsum` int(11) DEFAULT NULL,
  `resturant_ifram` varchar(600) DEFAULT NULL,
  `resturant_max` int(11) DEFAULT NULL,
  `resturant_account` varchar(20) DEFAULT NULL,
  `resturant_password` varchar(100) DEFAULT NULL,
  `editdate` date DEFAULT NULL,
  `edittime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `resturants`
--

INSERT INTO `resturants` (`resturant_id`, `resturant_name`, `resturant_address`, `resturant_uninum`, `resturant_phone`, `resturant_email`, `resturant_image1`, `resturant_image2`, `resturant_image3`, `resturant_image4`, `resturant_image5`, `resturant_menu1`, `resturant_menu2`, `resturant_menu3`, `resturant_intro`, `resturant_state`, `resturant_averageconsum`, `resturant_ifram`, `resturant_max`, `resturant_account`, `resturant_password`, `editdate`, `edittime`) VALUES
(1, '威爾森的農場', '台中市豐原區豐勢路二段535巷122弄23號', NULL, '0425132063', '0425132063@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '大樹', 2, 500, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.3300616879415!2d120.68301151534523!3d24.160154678915234!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34693d61a5364761%3A0x86249dcf46d88e04!2z5aSn5qi55YWI55Sf6Kaq5a2Q6aSQ5buz!5e0!3m2!1szh-TW!2stw!4v1682580707170!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', 45, 'bigtree0427', '$2y$10$hpOtb8DNu0YsrA/j6EGbUuFRC3aDx9UD50e7gPXQtZDUN9ZeE4BvS', '2023-05-05', '14:39:35'),
(2, '大家書房', '台中市大雅區信義路汝鎏公園', NULL, '0422564879', '0422564879@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3638.205726998994!2d120.62004047596814!3d24.23458237001499!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3469169dd38a3cfb%3A0x657fb26cb2132755!2z5aSn5a625pu45oi_!5e0!3m2!1szh-TW!2stw!4v1682821930675!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0422564879', '$2y$10$VCt3wOEaJm8AeVbYZbwwU.9V64XEPqlpxs2jxtxlbDrutD25DakbS', NULL, NULL),
(3, '小島3.5度', '台中市北屯區經貿三路二段82號', NULL, '0424257070', '0424257070@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3639.5132042845767!2d120.65762557596706!3d24.18879937180368!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34691636073b0629%3A0xae4329eb8f949713!2z5bCP5bO2My415bqmLUlzbGFuZCBBdXJvcmEg5Y-w5Lit5YaS6Zqq6aSoIOKWkCDlj6Tnpq7mipPlkagv5rS75YuV5YyF5aC0L-aFtueUn-a0vuWwjS_opqrlrZDlj4vlloQv6LyV6aOf57Ch6aSQL-e-qeWkp-WIqem6tS_kuIvljYjojLbilpA!5e0!3m2!1szh-TW!2stw!4v1682822007610!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0424257070', '$2y$10$O/bXfcRX1MS3ps7Ee8w5kOIoCDhJLcsasDVGWk2NO4V/ERzkgdSwy', NULL, NULL),
(4, '小樂圓 Oden Good', '台中市西區精誠七街17號', NULL, '0423232888', '0423232888@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.489504761792!2d120.65481747596621!3d24.15455977313924!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34693d9a532cc227%3A0x774385e72fbe82ff!2z5bCP5qiC5ZyTIE9kZW4gR29vZA!5e0!3m2!1szh-TW!2stw!4v1682822072712!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0423232888', '$2y$10$iNTRIiCGOfdRxdxOBCgnOuk6rbu1dQFIQCulsdd88ky7deDE0.9ya', NULL, NULL),
(5, '山豬別館', '台中市豐原區南陽路59巷22-13號', NULL, '0425120019', '0425120019@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3638.1198256830958!2d120.72875257596812!3d24.23758746989761!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346919f61ab3355b%3A0x82a48c4ffd67c506!2z5bGx6LGs5Yil6aSo!5e0!3m2!1szh-TW!2stw!4v1682822318525!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0425120019', '$2y$10$0xfFgEWvXP/3jfkqrnx2OO2MDvdtt7ILKJi.ZcD5ORBMDZYOxY4Vq', NULL, NULL),
(6, '公老坪Dream kitchen', '台中市豐原區水源路坪頂巷12號', NULL, '0928340008', '0928340008@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3637.4147031672014!2d120.75847457596858!3d24.262241668933022!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34691bb270cdb169%3A0x42b6eebe7a7aac8c!2z5YWs6ICB5Z2qRHJlYW0ga2l0Y2hlbg!5e0!3m2!1szh-TW!2stw!4v1682822358591!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0928340008', '$2y$10$BubZgki41bA7bn88Ie.S0er5Sc5bJ./OqxgLa7G5kuYyJLKdCoPCu', NULL, NULL),
(7, '北屯丹水滾鍋物風生水起', '台中市北屯區景賢路126號', NULL, '0424350699', '0424350699@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.137560751551!2d120.72388697596651!3d24.166907972657757!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346919a000decc19%3A0x617c424c89425c9d!2z5YyX5bGv5Li55rC05ru-6Y2L54mp6aKo55Sf5rC06LW3!5e0!3m2!1szh-TW!2stw!4v1682822386278!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0424350699', '$2y$10$BnUGUlf7u1zBZNktrXwax.LzDVtmv0oKJjxJq/kTGKNqpU6rfJTGW', NULL, NULL),
(8, '赤腳丫生態農莊', '台中市大雅區雅潭路三段500號', NULL, '0425690735', '0425690735@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3638.738505353538!2d120.66801257596751!3d24.215936270743725!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3469170f8da1afbd%3A0x80fb0d4dc007b225!2z6LWk6IWz5Lir55Sf5oWL6L6y6I6K!5e0!3m2!1szh-TW!2stw!4v1682822412288!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0425690735', '$2y$10$tnS5qk3OeRE0FDdvwQDk3eHBcekw8RE1YNjXu6dWNDhD6Faq5blsW', NULL, NULL),
(9, '咱們小時候', '台中市北屯區祥順一街45號', NULL, '0424392106', '0424392106@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.2773359567204!2d120.72791207596642!3d24.162004572848957!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346919fbfab3fd41%3A0xca974f51716a1f78!2z5ZKx5YCR5bCP5pmC5YCZLeimquWtkOmkkOW7sw!5e0!3m2!1szh-TW!2stw!4v1682822476796!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '0424392106', '$2y$10$OJTDcNXTOebA.jh2lvg.hujHGiU4DBgGqJuxP2Kcq5GL9khUGQtNu', NULL, NULL),
(10, '大樹先生親子餐廳', '台中市北區崇德路一段212號', '54668162', '0422352253', '0422352253@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '一個以孩子為主角的空間球池的專家-大樹先生 專屬的大樹專用球，除了有CE認證，您也可以看到上面有大樹的Logo。 夢幻、瘋狂、嗨翻，都是球池區的代名詞，它具有無法阻擋的吸引力，是小朋友的最愛。 在球海波浪中盡情翻滾跳躍，在爬坡、索橋、廊道、滑梯、球池的循環中，小孩不知不覺的學會了平衡、律動、及肢體協調，藉由短距接觸，建立禮讓的人際規則。 球池內有多少顆球？30,000顆以上！稍偏軟的球體設計可有效吸收撞擊能量，可促進小孩的柔和觸感。透明及不透明雙球混搭，輔以投射燈光，顯現一種閃亮跳躍的特殊氛圍，當小孩池中躍起，池球隨之舞向上空，夢幻極了。\n\n在0~24個月專區內，我們提供了小小寶貝專屬的爬行軟墊和迷你球池等專為2歲以下幼兒設計的設施。各式的爬行軟墊提供寶貝們身體運動，動作計畫的刺激，可以活化身體肌肉彈性與張力。 透過爬行，走路，上下階梯與滑動，增進幼齡孩子的身體動作能力。舉例來說，學步的孩子透過走在斜坡上，可以強化步行的穩定度。另外特製的軟墊和折疊墊，可以提供幼齡的孩子從事前翻，測滾等體能動作，促進身體協調與平衡能力。 另外不同動物造型組合，激發孩子們的想像與創意空間。叢林的平衡板組合則可以讓孩子在爬，走，搖擺的身體運動中，尋找平衡並促進身體控制。\n\n明亮的雙層餐廳，附設許多遊戲區，供應親子友善料理。', 2, 400, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3640.3303240679575!2d120.6826253759664!3d24.16014547292146!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34693d61a5364761%3A0x86249dcf46d88e04!2z5aSn5qi55YWI55Sf6Kaq5a2Q6aSQ5buz!5e0!3m2!1szh-TW!2stw!4v1683258016816!5m2!1szh-TW!2stw\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', 40, '0422352253', '$2y$10$EivbzXnmpaKls2vg/POXX.unITKR9pyIm3lOfc7gBDlZ8l7DmY.ri', '2023-05-05', '14:38:43');

-- --------------------------------------------------------

--
-- 資料表結構 `resturants_operating_time`
--

CREATE TABLE `resturants_operating_time` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `weekday` int(11) NOT NULL,
  `isOpen` int(11) DEFAULT NULL,
  `opentime` time DEFAULT NULL,
  `closetime` time DEFAULT NULL,
  `break_optime` time DEFAULT NULL,
  `break_edtime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `resturants_operating_time`
--

INSERT INTO `resturants_operating_time` (`id`, `resturant_id`, `weekday`, `isOpen`, `opentime`, `closetime`, `break_optime`, `break_edtime`) VALUES
(1, 1, 1, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(2, 1, 2, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(3, 1, 3, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(4, 1, 4, 0, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(5, 1, 5, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(6, 1, 6, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(7, 1, 7, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(9, 2, 2, NULL, NULL, NULL, NULL, NULL),
(10, 2, 3, NULL, NULL, NULL, NULL, NULL),
(11, 2, 4, NULL, NULL, NULL, NULL, NULL),
(12, 2, 5, NULL, NULL, NULL, NULL, NULL),
(13, 2, 6, NULL, NULL, NULL, NULL, NULL),
(14, 2, 7, NULL, NULL, NULL, NULL, NULL),
(15, 3, 1, NULL, NULL, NULL, NULL, NULL),
(16, 3, 2, NULL, NULL, NULL, NULL, NULL),
(17, 3, 3, NULL, NULL, NULL, NULL, NULL),
(18, 3, 4, NULL, NULL, NULL, NULL, NULL),
(19, 3, 5, NULL, NULL, NULL, NULL, NULL),
(20, 3, 6, NULL, NULL, NULL, NULL, NULL),
(21, 3, 7, NULL, NULL, NULL, NULL, NULL),
(22, 4, 1, NULL, NULL, NULL, NULL, NULL),
(23, 4, 2, NULL, NULL, NULL, NULL, NULL),
(24, 4, 3, NULL, NULL, NULL, NULL, NULL),
(25, 4, 4, NULL, NULL, NULL, NULL, NULL),
(26, 4, 5, NULL, NULL, NULL, NULL, NULL),
(27, 4, 6, NULL, NULL, NULL, NULL, NULL),
(28, 4, 7, NULL, NULL, NULL, NULL, NULL),
(29, 5, 1, NULL, NULL, NULL, NULL, NULL),
(30, 5, 2, NULL, NULL, NULL, NULL, NULL),
(31, 5, 3, NULL, NULL, NULL, NULL, NULL),
(32, 5, 4, NULL, NULL, NULL, NULL, NULL),
(33, 5, 5, NULL, NULL, NULL, NULL, NULL),
(34, 5, 6, NULL, NULL, NULL, NULL, NULL),
(35, 5, 7, NULL, NULL, NULL, NULL, NULL),
(36, 6, 1, NULL, NULL, NULL, NULL, NULL),
(37, 6, 2, NULL, NULL, NULL, NULL, NULL),
(38, 6, 3, NULL, NULL, NULL, NULL, NULL),
(39, 6, 4, NULL, NULL, NULL, NULL, NULL),
(40, 6, 5, NULL, NULL, NULL, NULL, NULL),
(41, 6, 6, NULL, NULL, NULL, NULL, NULL),
(42, 6, 7, NULL, NULL, NULL, NULL, NULL),
(43, 7, 1, NULL, NULL, NULL, NULL, NULL),
(44, 7, 2, NULL, NULL, NULL, NULL, NULL),
(45, 7, 3, NULL, NULL, NULL, NULL, NULL),
(46, 7, 4, NULL, NULL, NULL, NULL, NULL),
(47, 7, 5, NULL, NULL, NULL, NULL, NULL),
(48, 7, 6, NULL, NULL, NULL, NULL, NULL),
(49, 7, 7, NULL, NULL, NULL, NULL, NULL),
(50, 8, 1, NULL, NULL, NULL, NULL, NULL),
(51, 8, 2, NULL, NULL, NULL, NULL, NULL),
(52, 8, 3, NULL, NULL, NULL, NULL, NULL),
(53, 8, 4, NULL, NULL, NULL, NULL, NULL),
(54, 8, 5, NULL, NULL, NULL, NULL, NULL),
(55, 8, 6, NULL, NULL, NULL, NULL, NULL),
(56, 8, 7, NULL, NULL, NULL, NULL, NULL),
(57, 9, 1, NULL, NULL, NULL, NULL, NULL),
(58, 9, 2, NULL, NULL, NULL, NULL, NULL),
(59, 9, 3, NULL, NULL, NULL, NULL, NULL),
(60, 9, 4, NULL, NULL, NULL, NULL, NULL),
(61, 9, 5, NULL, NULL, NULL, NULL, NULL),
(62, 9, 6, NULL, NULL, NULL, NULL, NULL),
(63, 9, 7, NULL, NULL, NULL, NULL, NULL),
(64, 10, 1, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(65, 10, 2, 0, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(66, 10, 3, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(67, 10, 4, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(68, 10, 5, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(69, 10, 6, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00'),
(70, 10, 7, 1, '11:30:00', '21:00:00', '15:00:00', '17:30:00');

-- --------------------------------------------------------

--
-- 資料表結構 `resturant_activities`
--

CREATE TABLE `resturant_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `img` mediumblob DEFAULT NULL,
  `img_name` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `editdate` date DEFAULT NULL,
  `releasedate` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `prostate` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `resturant_facilities`
--

CREATE TABLE `resturant_facilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `cash` tinyint(4) NOT NULL DEFAULT 0,
  `visa` tinyint(4) NOT NULL DEFAULT 0,
  `creditcard` tinyint(4) NOT NULL DEFAULT 0,
  `streetpay` tinyint(4) NOT NULL DEFAULT 0,
  `easycard` tinyint(4) NOT NULL DEFAULT 0,
  `linepay` tinyint(4) NOT NULL DEFAULT 0,
  `applepay` tinyint(4) NOT NULL DEFAULT 0,
  `googlepay` tinyint(4) NOT NULL DEFAULT 0,
  `taiwanpay` tinyint(4) NOT NULL DEFAULT 0,
  `alcohol` tinyint(4) NOT NULL DEFAULT 0,
  `wifi` tinyint(4) NOT NULL DEFAULT 0,
  `socket` tinyint(4) NOT NULL DEFAULT 0,
  `smoking` tinyint(4) NOT NULL DEFAULT 0,
  `childseat` tinyint(4) NOT NULL DEFAULT 0,
  `childware` tinyint(4) NOT NULL DEFAULT 0,
  `nursingroom` tinyint(4) NOT NULL DEFAULT 0,
  `diaper` tinyint(4) NOT NULL DEFAULT 0,
  `stroller` tinyint(4) NOT NULL DEFAULT 0,
  `touristcard` tinyint(4) NOT NULL DEFAULT 0,
  `shuttle` tinyint(4) NOT NULL DEFAULT 0,
  `car` tinyint(4) NOT NULL DEFAULT 0,
  `scotter` tinyint(4) NOT NULL DEFAULT 0,
  `parkdiscount` tinyint(4) NOT NULL DEFAULT 0,
  `venuerental` tinyint(4) NOT NULL DEFAULT 0,
  `barrierfree` tinyint(4) NOT NULL DEFAULT 0,
  `toy` tinyint(4) NOT NULL DEFAULT 0,
  `slide` tinyint(4) NOT NULL DEFAULT 0,
  `ballpit` tinyint(4) NOT NULL DEFAULT 0,
  `sandpit` tinyint(4) NOT NULL DEFAULT 0,
  `farm` tinyint(4) NOT NULL DEFAULT 0,
  `lawn` tinyint(4) NOT NULL DEFAULT 0,
  `animal` tinyint(4) NOT NULL DEFAULT 0,
  `fishpond` tinyint(4) NOT NULL DEFAULT 0,
  `ecopond` tinyint(4) NOT NULL DEFAULT 0,
  `paddingpool` tinyint(4) NOT NULL DEFAULT 0,
  `home` tinyint(4) NOT NULL DEFAULT 0,
  `videogame` tinyint(4) NOT NULL DEFAULT 0,
  `childrenbook` tinyint(4) NOT NULL DEFAULT 0,
  `course` tinyint(4) NOT NULL DEFAULT 0,
  `fullmoon` tinyint(4) NOT NULL DEFAULT 0,
  `saliva` tinyint(4) NOT NULL DEFAULT 0,
  `oneyear` tinyint(4) NOT NULL DEFAULT 0,
  `sexparty` tinyint(4) NOT NULL DEFAULT 0,
  `birthday` tinyint(4) NOT NULL DEFAULT 0,
  `vegetarian` tinyint(4) NOT NULL DEFAULT 0,
  `vegan` tinyint(4) NOT NULL DEFAULT 0,
  `muslin` tinyint(4) NOT NULL DEFAULT 0,
  `glutenfree` tinyint(4) NOT NULL DEFAULT 0,
  `editdate` date DEFAULT NULL,
  `edittime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `resturant_facilities`
--

INSERT INTO `resturant_facilities` (`id`, `resturant_id`, `cash`, `visa`, `creditcard`, `streetpay`, `easycard`, `linepay`, `applepay`, `googlepay`, `taiwanpay`, `alcohol`, `wifi`, `socket`, `smoking`, `childseat`, `childware`, `nursingroom`, `diaper`, `stroller`, `touristcard`, `shuttle`, `car`, `scotter`, `parkdiscount`, `venuerental`, `barrierfree`, `toy`, `slide`, `ballpit`, `sandpit`, `farm`, `lawn`, `animal`, `fishpond`, `ecopond`, `paddingpool`, `home`, `videogame`, `childrenbook`, `course`, `fullmoon`, `saliva`, `oneyear`, `sexparty`, `birthday`, `vegetarian`, `vegan`, `muslin`, `glutenfree`, `editdate`, `edittime`) VALUES
(1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, '2023-04-28', '11:42:44'),
(2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
(10, 10, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, '2023-05-05', '14:28:22');

-- --------------------------------------------------------

--
-- 資料表結構 `resturant_image_names`
--

CREATE TABLE `resturant_image_names` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resturant_id` bigint(20) UNSIGNED NOT NULL,
  `image1` varchar(50) DEFAULT NULL,
  `image2` varchar(50) DEFAULT NULL,
  `image3` varchar(50) DEFAULT NULL,
  `image4` varchar(50) DEFAULT NULL,
  `image5` varchar(50) DEFAULT NULL,
  `menu1` varchar(50) DEFAULT NULL,
  `menu2` varchar(50) DEFAULT NULL,
  `menu3` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `resturant_image_names`
--

INSERT INTO `resturant_image_names` (`id`, `resturant_id`, `image1`, `image2`, `image3`, `image4`, `image5`, `menu1`, `menu2`, `menu3`) VALUES
(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- 資料表索引 `member_likes`
--
ALTER TABLE `member_likes`
  ADD PRIMARY KEY (`member_id`,`resturant_id`),
  ADD KEY `member_likes_resturant_id_foreign` (`resturant_id`);

--
-- 資料表索引 `member_tags`
--
ALTER TABLE `member_tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD KEY `member_tags_member_id_foreign` (`member_id`);

--
-- 資料表索引 `member_tag_resturants`
--
ALTER TABLE `member_tag_resturants`
  ADD PRIMARY KEY (`tag_id`,`resturant_id`),
  ADD KEY `member_tag_resturants_resturant_id_foreign` (`resturant_id`);

--
-- 資料表索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_resturant_id_foreign` (`resturant_id`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `orders_member_id_foreign` (`member_id`),
  ADD KEY `orders_resturant_id_foreign` (`resturant_id`);

--
-- 資料表索引 `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- 資料表索引 `resturants`
--
ALTER TABLE `resturants`
  ADD PRIMARY KEY (`resturant_id`);

--
-- 資料表索引 `resturants_operating_time`
--
ALTER TABLE `resturants_operating_time`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resturants_operating_time_resturant_id_foreign` (`resturant_id`);

--
-- 資料表索引 `resturant_activities`
--
ALTER TABLE `resturant_activities`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `resturant_facilities`
--
ALTER TABLE `resturant_facilities`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `resturant_image_names`
--
ALTER TABLE `resturant_image_names`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `emails`
--
ALTER TABLE `emails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `members`
--
ALTER TABLE `members`
  MODIFY `member_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `member_tags`
--
ALTER TABLE `member_tags`
  MODIFY `tag_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `resturants`
--
ALTER TABLE `resturants`
  MODIFY `resturant_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `resturants_operating_time`
--
ALTER TABLE `resturants_operating_time`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `resturant_activities`
--
ALTER TABLE `resturant_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `resturant_facilities`
--
ALTER TABLE `resturant_facilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `resturant_image_names`
--
ALTER TABLE `resturant_image_names`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `member_likes`
--
ALTER TABLE `member_likes`
  ADD CONSTRAINT `member_likes_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `member_likes_resturant_id_foreign` FOREIGN KEY (`resturant_id`) REFERENCES `resturants` (`resturant_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `member_tags`
--
ALTER TABLE `member_tags`
  ADD CONSTRAINT `member_tags_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `member_tag_resturants`
--
ALTER TABLE `member_tag_resturants`
  ADD CONSTRAINT `member_tag_resturants_resturant_id_foreign` FOREIGN KEY (`resturant_id`) REFERENCES `resturants` (`resturant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `member_tag_resturants_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `member_tags` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_resturant_id_foreign` FOREIGN KEY (`resturant_id`) REFERENCES `resturants` (`resturant_id`);

--
-- 資料表的限制式 `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `orders_resturant_id_foreign` FOREIGN KEY (`resturant_id`) REFERENCES `resturants` (`resturant_id`);

--
-- 資料表的限制式 `resturants_operating_time`
--
ALTER TABLE `resturants_operating_time`
  ADD CONSTRAINT `resturants_operating_time_resturant_id_foreign` FOREIGN KEY (`resturant_id`) REFERENCES `resturants` (`resturant_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
