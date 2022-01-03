--ONLY NEED ONE OF THEM!
--OPTION 1 IF YOU HAVE A LIMIT SYSTEM ON YOUR SERVER
﻿INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick', 'USB Stick (empty)', '-1', '0', '1', '0');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick_data', 'USB Stick (with Data)', '-1', '0', '1', '0');
	
INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'TwentyFourSeven', 'usbstick', '20');

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'LTDgasoline', 'usbstick', '25');
	
--OPTION 2 IF YOU HAVE A WEIGHT SYSTEM ON YOUR SERVER
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
    ('usbstick', 'USB Stick (empty)', '0', '0', '1');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
    ('usbstick_data', 'USB Stick (with Data)', '0', '0', '1');
    
INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
    (NULL, 'TwentyFourSeven', 'usbstick', '20');

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
    (NULL, 'LTDgasoline', 'usbstick', '25');
