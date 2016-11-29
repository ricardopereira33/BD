USE EuroTrain;

SELECT Comboio.ID_Comboio AS Comboio, CP.Nome AS Partida, CC.Nome AS Chegada, Viagem.Duração FROM Viagem 
	INNER JOIN Comboio 
    ON Comboio.ID_Comboio = Viagem.Comboio
		INNER JOIN Cidade AS CP 
        ON CP.ID_Cidade = Viagem.Cidade_Partida
			INNER JOIN Cidade AS CC 
            ON CC.ID_Cidade = Viagem.Cidade_Chegada;
            
            
        
