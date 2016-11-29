USE EuroTrain;

CREATE USER 'admin'@'localhost';
SET PASSWORD FOR 'admin'@'localhost' = PASSWORD('admin');

GRANT ALL ON EuroTrain.* TO 'admin'@'localhost';

CREATE USER 'gestor'@'localhost';
SET PASSWORD FOR 'gestor'@'localhost' = PASSWORD('gestor');

GRANT SELECT (ID_Cliente, Nome, Username, Email, Telemóvel, Cidade) 
	ON EuroTrain.Cliente TO 'gestor'@'localhost';
GRANT SELECT ON EuroTrain.Reserva TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.Viagem TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.Comboio TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.Lugar TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.Cidade TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.País TO 'gestor'@'localhost';


CREATE USER 'cliente'@'localhost';
SET PASSWORD FOR 'cliente'@'localhost' = PASSWORD('cliente');

GRANT INSERT ON EuroTrain.Cliente TO 'cliente'@'localhost';
GRANT SELECT, INSERT, UPDATE ON EuroTrain.Reserva TO 'cliente'@'localhost';
GRANT SELECT ON EuroTrain.Viagem TO 'cliente'@'localhost';
GRANT SELECT ON EuroTrain.Comboio TO 'cliente'@'localhost';
GRANT SELECT ON EuroTrain.Lugar TO 'cliente'@'localhost';
GRANT SELECT ON EuroTrain.Cidade TO 'cliente'@'localhost';
GRANT SELECT ON EuroTrain.País TO 'cliente'@'localhost';
