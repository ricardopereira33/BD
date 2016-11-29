USE EuroTrain;

DELIMITER $$
CREATE PROCEDURE procedureReservasViagem (IN Data DATE,IN Hora TIME(0),IN CidadePartida VARCHAR(32), IN CidadeChegada VARCHAR(32))
BEGIN
	SELECT Cliente.Nome, Reserva.Lugar, Reserva.Preço FROM Viagem 
    INNER JOIN Cidade AS CP 
    ON CP.ID_Cidade = Viagem.Cidade_Partida
		INNER JOIN Cidade AS CC 
        ON CC.ID_Cidade = Viagem.Cidade_Chegada
			INNER JOIN Reserva 
            ON Reserva.Viagem = Viagem.ID_Viagem
				INNER JOIN Cliente 
                ON CLiente.ID_Cliente = Reserva.Cliente
    WHERE CP.Nome = CidadePartida AND CC.Nome = CidadeChegada AND Reserva.Data = Data AND Viagem.Hora_Partida = Hora
    ORDER BY Cliente.Nome ASC;
END $$

SET @data = '2016-12-26';
SET @hora = '11:30:00';
SET @cidadePartida = 'Porto';
SET @cidadeChegada = 'Lisboa';
CALL procedureReservasViagem(@data, @hora, @cidadePartida, @cidadeChegada);

DROP PROCEDURE procedureReservasViagem;

