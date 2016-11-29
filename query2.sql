USE EuroTrain;

SELECT Cliente.Nome AS Nome, Reserva.Preço AS Preço FROM Reserva
INNER JOIN Cliente ON Cliente.ID_Cliente = Reserva.Cliente
ORDER BY Preço DESC;