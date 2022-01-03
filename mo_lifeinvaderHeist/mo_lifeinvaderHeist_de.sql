--DU BRAUCHST NUR EINE DER BEIDEN OPTIONEN
--OPTION 1 WENN DU EIN LIMIT-SYSTEM AUF DEINEM SERVER HAST
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick', 'USB Stick (leer)', '-1', '0', '1', '0');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	('usbstick_data', 'USB Stick (mit Daten)', '-1', '0', '1', '0');
	
INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'TwentyFourSeven', 'usbstick', '20');

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'LTDgasoline', 'usbstick', '25');
	
--OPTION 2 WENN DU EIN GEWICHTS-SYSTEM AUF DEINEM SERVER HAST
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('usbstick', 'USB Stick (leer)', '0', '0', '1');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('usbstick_data', 'USB Stick (mit Daten)', '0', '0', '1');
	
INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'TwentyFourSeven', 'usbstick', '20');

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES 
	(NULL, 'LTDgasoline', 'usbstick', '25');
