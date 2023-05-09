-----

-- 更改照片型態 Blob -> Mediumblob

-----

ALTER TABLE
    `resturants` CHANGE `resturant_image1` `resturant_image1` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_image2` `resturant_image2` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_image3` `resturant_image3` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_image4` `resturant_image4` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_image5` `resturant_image5` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_menu1` `resturant_menu1` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_menu2` `resturant_menu2` MEDIUMBLOB NULL DEFAULT NULL,
    CHANGE `resturant_menu3` `resturant_menu3` MEDIUMBLOB NULL DEFAULT NULL;


ALTER TABLE
    `resturant_activities` CHANGE `img` `img` MEDIUMBLOB NULL DEFAULT NULL;

ALTER TABLE
    `members` CHANGE `member_image` `member_image` MEDIUMBLOB NULL DEFAULT NULL;