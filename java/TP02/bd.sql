CREATE DATABASE tp2;
USE tp2;

CREATE TABLE `imovel` (
  `cd` int(11) NOT NULL AUTO_INCREMENT,
  `endereco` varchar(255) DEFAULT NULL,
  `quartos` int(11) DEFAULT NULL,
  `metros` int(11) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  PRIMARY KEY (`cd`)
) 