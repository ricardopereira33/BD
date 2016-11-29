USE EuroTrain;

DELIMITER $$
CREATE PROCEDURE procedureLugaresOcupados (IN inputData DATE,IN inputHora TIME(0))
BEGIN
	SELECT Lugar.Comboio,Lugar.Nr, Lugar.Classe, Lugar.Carruagem FROM Lugar
	INNER JOIN Reserva ON Lugar.Nr = Reserva.Lugar
    INNER JOIN Viagem ON Reserva.Viagem = Viagem.ID_Viagem
	WHERE Reserva.Data = inputData AND Viagem.Hora_Partida = inputHora AND Viagem.Cidade_Partida = 1 AND Viagem.Cidade_Chegada= 2 AND Reserva.Comboio = Lugar.Comboio;
END $$

SET @data = '2016-12-26';
SET @hora = '10:00:00';
CALL procedureLugaresOcupados(@data,@hora);

DROP PROCEDURE procedureLugaresOcupados;

