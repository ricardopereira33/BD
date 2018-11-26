-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 2016/2017
--
-- Caso de Estudo: "Euro-Train"
-- Povoamento parcial da base de dados.
-- Grupo XX

-- Base de dados de trabalho
USE EuroTrain;

-- Povoamento da tabela "País"
INSERT INTO País (ID_País, Nome)
    VALUES
        (1, 'Portugal'),
        (2, 'Espanha'),
        (3, 'França'),
        (4, 'Alemanha'),
        (5, 'Luxemburgo');
-- SELECT * FROM País;

-- Povoamento da tabela "Cidade"
INSERT INTO Cidade (ID_Cidade, País , Nome)
    VALUES
        (1,1, 'Braga'),
        (2,1, 'Porto'),
        (3,1, 'Lisboa'),
        (4,2, 'Madrid'),
        (5,2, 'Barcelona'),
        (6,3, 'Paris'),
        (7,4, 'Munique'),
        (8,5, 'Luxemburgo');
-- SELECT * FROM Cidade

-- Povoamento da tabela "Cliente"
INSERT INTO Cliente (ID_Cliente, Nome, Username, Password, Email, Telemóvel, Cidade)
    VALUES
        (1, 'José', 'jose33', 'RPd234','ri@mail.com', 943213968, 1),
        (2, 'Ana', 'ana22', 'dfssw21', 'ana@mail.com', 973267943, 3),
        (3, 'Patrick', 'patrick11', 'wqer31', 'pat@mail.com', 953138527 , 8),
        (4, 'Joana', 'ju213', 'dfs123', 'ju@mail.com', 973351234, 1),
        (5, 'Müller', 'muller23', 'gfa456', 'muller@mail.com', 958643231 , 7);
-- SELECT * FROM Cliente

-- Povoamento da tabela "Comboio"
INSERT INTO Comboio (ID_Comboio, Tipo, Descrição, Capacidade)
    VALUES
        (1, 'Alfa', 'O Alfa permite-lhe viajar com todo o conforto e segurança, de norte a sul do país,
                    e oferece-lhe o ambiente ideal para trabalhar ou descontrair durante a viagem.
                    Para além de serviços específicos para as classes Conforto e Turística,
                    pode desfrutar ainda de cafetaria, minibar, refeições, Wi-Fi gratuito e WC.',0),
        (2, 'Internacional', 'O Internacional permite-lhe viajar com todo o conforto e segurança, para um destino da europa,
                              e oferece-lhe o ambiente ideal para trabalhar ou descontrair durante a viagem.
                              Para além de serviços específicos para as classes Conforto e Turística,
                              pode desfrutar ainda de cafetaria, minibar, refeições, Wi-Fi gratuito e WC.
                              As cadeiras estão adaptadas a longas viagens.',0);
-- SELECT * FROM Comboio

DELIMITER $$
CREATE TRIGGER ActCapacidadeInc
    AFTER INSERT ON Lugar
    FOR EACH ROW
BEGIN
    UPDATE Comboio
        SET Capacidade = Capacidade + 1
        WHERE ID_Comboio = NEW.Comboio;
END $$

DELIMITER $$
CREATE TRIGGER ActCapacidadeDec
    AFTER DELETE ON Lugar
    FOR EACH ROW
BEGIN
    UPDATE Comboio
        SET Capacidade = Capacidade - 1
        WHERE ID_Comboio = OLD.Comboio;
END $$

-- Povoamento da tabela "Lugar"
INSERT INTO Lugar (Comboio, Nr, Classe, Carruagem)
    VALUES
        (1,1, 'Turística',1),
        (1,2, 'Turística',1),
        (1,3, 'Turística',1),
        (1,4, 'Turística',1),
        (1,5, 'Turística',1),
        (1,6, 'Turística',2),
        (1,7, 'Turística',2),
        (1,8, 'Turística',2),
        (1,9, 'Turística',2),
        (1,10, 'Conforto',3),
        (1,11, 'Conforto',3),
        (1,12, 'Conforto',3),
        (2,1, 'Turística',1),
        (2,2, 'Turística',1),
        (2,3, 'Turística',1),
        (2,4, 'Turística',1),
        (2,5, 'Turística',1),
        (2,6, 'Turística',2),
        (2,7, 'Turística',2),
        (2,8, 'Turística',2),
        (2,9, 'Turística',2),
        (2,10, 'Conforto',3),
        (2,11, 'Conforto',3),
        (2,12, 'Conforto',3);
-- SELECT * FROM Lugar

-- Povoamento da tabela "Viagem"
INSERT INTO Viagem (ID_Viagem, Comboio, Cidade_Partida, Cidade_Chegada, Hora_Partida, Hora_Chegada, Duração)
    VALUES
        (1,1, 1, 2 , '10:00:00', '11:20:00','1:20:00'),
        (2,1, 2, 3 , '11:30:00', '15:00:00','3:30:00'),
        (3,1, 3, 2 , '15:30:00', '19:00:00','3:30:00'),
        (4,1, 2, 1 , '19:20:00', '20:40:00','1:20:00'),
        (5,2, 1, 4 , '10:00:00', '14:00:00','4:00:00'),
        (6,2, 4, 1 , '14:30:00', '18:30:00','4:00:00');
-- SELECT * FROM Viagem

-- Povoamento da tabela "Reserva"
INSERT INTO Reserva (ID_Reserva, Data, Comboio, Lugar, Código, Preço, Cliente, Viagem)
    VALUES
        (1,'2016-12-26', 1, 10,'74ytrefg', 18.90, 1,1),
        (2,'2016-12-26', 1, 11, 'hw567i4w', 18.90, 2,1),
        (3,'2016-12-26', 1, 3, '47k6twyj', 14.90, 3,1),
        (4,'2016-12-26', 1, 7, '74ytfeww', 17.90, 1,2),
        (5,'2016-12-26', 1, 8, '423eei4w', 17.90, 2,2),
        (6,'2016-12-27', 1, 7, 'grvr4s21', 14.90, 3,4),
        (7,'2016-12-27', 2, 7, 'fvfqgwef', 33.90, 5,6),
        (8,'2016-12-28', 1, 3, 'fwfqqwrj', 17.90, 2,3),
        (9,'2016-12-30', 2, 10, 'it8745ur', 39.90, 4,5),
        (10,'2016-12-30', 2, 12, 'vbfq3341', 39.90, 5,5);

-- SELECT * FROM Reserva


