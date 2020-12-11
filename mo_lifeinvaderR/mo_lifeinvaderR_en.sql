INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick', 'USB Stick (empty)', '-1', '0', '1', '0');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick_data', 'USB Stick (with Data)', '-1', '0', '1', '0');
	
INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'TwentyFourSeven', 'usbstick', '20');

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'LTDgasoline', 'usbstick', '25');