USE EuroTrain;

SELECT Cliente.Username, COUNT(*) AS Número FROM Reserva
	INNER JOIN Cliente 
    ON Cliente.ID_Cliente = Reserva.Cliente
GROUP BY Cliente.Username
ORDER BY Número DESC;