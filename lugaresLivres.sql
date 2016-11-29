USE EuroTrain;

DELIMITER $$
CREATE PROCEDURE procedureLugaresLivres (IN Data DATE,IN Hora TIME(0),IN cidPartida VARCHAR(32), IN cidChegada VARCHAR(32))
BEGIN
	SELECT L.Nr AS Lugar, L.Classe AS Classe, L.Carruagem AS Carruagem  FROM Viagem 
    	INNER JOIN Cidade AS CP 
    	ON CP.ID_Cidade = Viagem.Cidade_Partida
    		INNER JOIN Cidade AS CC
    		ON CC.ID_Cidade = Viagem.Cidade_Chegada
    			INNER JOIN Lugar AS L 
    			ON L.Comboio = Viagem.Comboio
    			WHERE Viagem.Hora_Partida = Hora AND CP.Nome = cidPartida AND CC.Nome = cidChegada
					  AND L.Nr NOT IN (SELECT Lugar.Nr FROM Lugar 
								   INNER JOIN Reserva ON Lugar.Nr = Reserva.Lugar
								   INNER JOIN Viagem ON Reserva.Viagem = Viagem.ID_Viagem
                                   INNER JOIN Cidade AS CPP ON CPP.ID_Cidade = Viagem.Cidade_Partida
								   INNER JOIN Cidade AS CCC ON CCC.ID_Cidade = Viagem.Cidade_Chegada
								   WHERE Reserva.Data = Data AND Viagem.Hora_Partida = Hora AND Reserva.Comboio = Lugar.Comboio
											AND CPP.Nome = cidPartida AND CCC.Nome = cidChegada );
END $$

SET @data = '2016-12-26';
SET @hora = '10:00:00';
SET @CidPartida = 'Braga';
SET @CidChegada = 'Porto';
CALL procedureLugaresLivres(@data,@hora,@CidPartida,@CidChegada);

DROP PROCEDURE procedureLugaresLivres;
