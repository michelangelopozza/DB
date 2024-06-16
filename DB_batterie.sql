CREATE DATABASE IF NOT EXISTS batterie;

USE batterie;

CREATE TABLE IF NOT EXISTS CasaAutomobilistica (
    nomeCasa VARCHAR(255) PRIMARY KEY,
    nomeCEO VARCHAR(255),
    cognomeCEO VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS BMS (
    cod VARCHAR(255) PRIMARY KEY,
    BUS VARCHAR(255),
    CU VARCHAR(255),
    scheda VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Batteria (
    produttore VARCHAR(255),
    modello VARCHAR(255),
    BMSCod VARCHAR(255) NOT NULL,
    C_3 DECIMAL(10),
    Z_in DECIMAL(10),
    V DECIMAL(10),
    Qn DECIMAL(10),
    PRIMARY KEY (produttore, modello),
    FOREIGN KEY (BMSCod) REFERENCES BMS (Cod)
);

CREATE TABLE IF NOT EXISTS MacchinaElettrica (
    modello VARCHAR(255),
    anno INT(4),
    casa VARCHAR(255),
    nCelle INT(4) NOT NULL,
    prezzo DECIMAL(10),
    prodBatteria VARCHAR(255) NOT NULL,
    modelloBatteria VARCHAR(255) NOT NULL,
    PRIMARY KEY (modello, anno, casa),
    FOREIGN KEY (casa) REFERENCES CasaAutomobilistica (nomeCasa),
    FOREIGN KEY (prodBatteria, modelloBatteria) REFERENCES Batteria (produttore, modello)
);

CREATE TABLE IF NOT EXISTS Algoritmo (
    nome VARCHAR(255) PRIMARY KEY,
    stima VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Operatore (
    id INT(10),
    nome VARCHAR(255),
    cognome VARCHAR(255),
    azienda VARCHAR(255),
    PRIMARY KEY (id, azienda)
);

CREATE TABLE IF NOT EXISTS CameraClimatica (
    produttore VARCHAR(255),
    modello VARCHAR(255),
    T_min DECIMAL,
    T_max DECIMAL,
    PRIMARY KEY (produttore, modello)
);

CREATE TABLE IF NOT EXISTS Laboratorio (
    id INT (10) PRIMARY KEY,
    sede VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Interfaccia (
    nomeAlgoritmo VARCHAR(255),
    BMSCod VARCHAR(255),
    PRIMARY KEY (nomeAlgoritmo, BMSCod),
    FOREIGN KEY (nomeAlgoritmo) REFERENCES Algoritmo(nome),
    FOREIGN KEY (BMSCod) REFERENCES BMS(cod)
);

CREATE TABLE IF NOT EXISTS Strumentazione (
    idLaboratorio INT,
    produttoreCamera VARCHAR(255),
    modelloCamera VARCHAR(255),
    PRIMARY KEY (idLaboratorio, produttoreCamera, modelloCamera),
    FOREIGN KEY (idLaboratorio) REFERENCES Laboratorio(id),
    FOREIGN KEY (produttoreCamera, modelloCamera) REFERENCES CameraClimatica(produttore, modello)
);

CREATE TABLE IF NOT EXISTS DiagnosticTest (
    cod VARCHAR(255) PRIMARY KEY ,
    prodBatteria VARCHAR(255) NOT NULL,
    modelloBatteria VARCHAR(255) NOT NULL,
    stato VARCHAR(255) DEFAULT 'in corso',
    nome VARCHAR(255),
    dataInizio DATE,
    dataFine DATE,
    prodCamera VARCHAR(255),
    modelloCamera VARCHAR(255),
    idOperatore INT(10) NOT NULL,
    aziendaOperatore VARCHAR(255) NOT NULL,
    CONSTRAINT CHECK (stato IN ('in corso', 'terminato')),
    CONSTRAINT CHECK (nome IN ('HPPC', 'Capacity Test', 'EIS', 'GITT', 'Driving Cycle')),
    FOREIGN KEY (prodCamera, modelloCamera) REFERENCES CameraClimatica(produttore, modello),
    FOREIGN KEY (idOperatore, aziendaOperatore) REFERENCES Operatore (id, azienda),
    FOREIGN KEY (prodBatteria, modelloBatteria) REFERENCES Batteria(produttore, modello)
);

CREATE TABLE IF NOT EXISTS Performance (
    cod VARCHAR(255) PRIMARY KEY,
    Q DECIMAL,
    P DECIMAL,
    Z_in DECIMAL,
    FOREIGN KEY (cod) REFERENCES DiagnosticTest(cod)
);

USE batterie;

-- Inserire dati nella tabella CasaAutomobilistica
INSERT INTO CasaAutomobilistica (nomeCasa, nomeCEO, cognomeCEO) VALUES
('Tesla', 'Elon', 'Musk'),
('Nissan', 'Makoto', 'Uchida'),
('BMW', 'Oliver', 'Zipse'),
('Audi', 'Markus', 'Duesmann'),
('Toyota', 'Akio', 'Toyoda');

-- Inserire dati nella tabella BMS
INSERT INTO BMS (cod, BUS, CU, scheda) VALUES
('BMS001', 'CAN', 'CU001', 'SchedaA'),
('BMS002', 'LIN', 'CU002', 'SchedaB'),
('BMS003', 'CAN', 'CU003', 'SchedaC'),
('BMS004', 'LIN', 'CU004', 'SchedaD'),
('BMS005', 'CAN', 'CU005', 'SchedaE');

-- Inserire dati nella tabella Batteria
INSERT INTO Batteria (produttore, modello, BMSCod, C_3, Z_in, V, Qn) VALUES
('Panasonic', 'BAT001', 'BMS001', 3.0, 0.005, 3.7, 100),
('LG', 'BAT002', 'BMS002', 3.0, 0.006, 3.7, 110),
('Samsung', 'BAT003', 'BMS003', 3.0, 0.007, 3.7, 120),
('Sony', 'BAT004', 'BMS004', 3.0, 0.008, 3.7, 130),
('CATL', 'BAT005', 'BMS005', 3.0, 0.009, 3.7, 140);

-- Inserire dati nella tabella MacchinaElettrica
INSERT INTO MacchinaElettrica (modello, anno, casa, nCelle, prezzo, prodBatteria, modelloBatteria) VALUES
('Model S', 2022, 'Tesla', 7000, 79999.99, 'Panasonic', 'BAT001'),
('Leaf', 2021, 'Nissan', 5000, 34999.99, 'LG', 'BAT002'),
('i3', 2020, 'BMW', 4000, 42999.99, 'Samsung', 'BAT003'),
('e-tron', 2021, 'Audi', 6000, 65999.99, 'Sony', 'BAT004'),
('Prius', 2022, 'Toyota', 4500, 29999.99, 'CATL', 'BAT005');

-- Inserire dati nella tabella Algoritmo
INSERT INTO Algoritmo (nome, stima) VALUES
('AlgoritmoA', 'StimaA'),
('AlgoritmoB', 'StimaB'),
('AlgoritmoC', 'StimaC'),
('AlgoritmoD', 'StimaD'),
('AlgoritmoE', 'StimaE');

-- Inserire dati nella tabella Operatore
INSERT INTO Operatore (id, nome, cognome, azienda) VALUES
(1, 'John', 'Doe', 'OperTech'),
(2, 'Jane', 'Smith', 'DiagCorp'),
(3, 'Alice', 'Johnson', 'TestLab'),
(4, 'Bob', 'Williams', 'EcoTest'),
(5, 'Charlie', 'Brown', 'BatteryCheck');

-- Inserire dati nella tabella CameraClimatica
INSERT INTO CameraClimatica (produttore, modello, T_min, T_max) VALUES
('ClimaCorp', 'CC001', -20, 60),
('EnviroTech', 'ET002', -30, 70),
('ThermoSys', 'TS003', -25, 65),
('ClimaCorp', 'CC004', -15, 50),
('EnviroTech', 'ET005', -35, 75);

-- Inserire dati nella tabella Laboratorio
INSERT INTO Laboratorio (id, sede) VALUES
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Los Angeles'),
(4, 'Chicago'),
(5, 'Houston');

-- Inserire dati nella tabella Interfaccia
INSERT INTO Interfaccia (nomeAlgoritmo, BMSCod) VALUES
('AlgoritmoA', 'BMS001'),
('AlgoritmoB', 'BMS002'),
('AlgoritmoC', 'BMS003'),
('AlgoritmoD', 'BMS004'),
('AlgoritmoE', 'BMS005');

-- Inserire dati nella tabella Strumentazione
INSERT INTO Strumentazione (idLaboratorio, produttoreCamera, modelloCamera) VALUES
(1, 'ClimaCorp', 'CC001'),
(2, 'EnviroTech', 'ET002'),
(3, 'ThermoSys', 'TS003'),
(4, 'ClimaCorp', 'CC004'),
(5, 'EnviroTech', 'ET005');

-- Inserire dati nella tabella DiagnosticTest
INSERT INTO DiagnosticTest (cod, prodBatteria, modelloBatteria, stato, nome, dataInizio, dataFine, prodCamera, modelloCamera, idOperatore, aziendaOperatore) VALUES
('DT001', 'Panasonic', 'BAT001', 'in corso', 'HPPC', '2024-01-01', '2024-01-05', 'ClimaCorp', 'CC001', 1, 'OperTech'),
('DT002', 'LG', 'BAT002', 'in corso', 'Capacity Test', '2024-01-06', '2024-01-10', 'EnviroTech', 'ET002', 2, 'DiagCorp'),
('DT003', 'Samsung', 'BAT003', 'in corso', 'EIS', '2024-01-11', '2024-01-15', 'ThermoSys', 'TS003', 3, 'TestLab'),
('DT004', 'Sony', 'BAT004', 'in corso', 'Driving Cycle', '2024-01-16', '2024-01-20', 'ClimaCorp', 'CC004', 4, 'EcoTest'),
('DT005', 'CATL', 'BAT005', 'in corso', 'HPPC', '2024-01-21', '2024-01-25', 'EnviroTech', 'ET005', 5, 'BatteryCheck');

-- Popola la tabella Performance
INSERT INTO Performance (cod, Q, P, Z_in) VALUES
('DT001', 4800, 300, 0.011),
('DT002', 4300, 280, 0.021),
('DT003', 4500, 290, 0.016),
('DT004', 5000, 310, 0.013),
('DT005', 4700, 295, 0.019);

DELIMITER $$
CREATE TRIGGER aggiornaStato
AFTER INSERT ON Performance
FOR EACH ROW
BEGIN
    DECLARE testState VARCHAR(255);

    SELECT stato INTO testState
    FROM DiagnosticTest
    WHERE cod = NEW.cod;

    IF testState = 'in corso' THEN
        UPDATE DiagnosticTest
        SET stato = 'terminato'
        WHERE cod = NEW.cod;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER controlloStatoTest
AFTER INSERT ON Performance
FOR EACH ROW
BEGIN
    DECLARE test_id VARCHAR(255);

    SELECT cod INTO test_id
    FROM DiagnosticTest
    WHERE cod = NEW.cod AND stato = 'in corso';
    UPDATE DiagnosticTest
    SET stato = 'terminato'
    WHERE cod = test_id;
END$$

DELIMITER ;


DELIMITER $$
CREATE TRIGGER verificaDisponibilitaBatteria
BEFORE INSERT ON DiagnosticTest
FOR EACH ROW
BEGIN
    DECLARE batteryExists INT;
    DECLARE batteryInUse INT;

    SELECT COUNT(*) INTO batteryExists
    FROM Batteria
    WHERE modello = NEW.modelloBatteria AND produttore = NEW.prodBatteria;

    IF batteryExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: La batteria specificata non esiste';
    END IF;

    SELECT COUNT(*) INTO batteryInUse
    FROM DiagnosticTest
    WHERE prodBatteria = NEW.prodBatteria
      AND modelloBatteria = NEW.modelloBatteria
      AND stato = 'in corso';

    IF batteryInUse > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: La batteria è già impegnata in un altro test "in corso"';
    END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE confrontoValoriBatteria (
    IN produttoreBatteria VARCHAR(255),
    IN modelloBatteria VARCHAR(255)
)
BEGIN
    DECLARE testCod VARCHAR(255);
    DECLARE testQ DECIMAL(10, 2);
    DECLARE testZ_in DECIMAL(10, 2);
    DECLARE testV DECIMAL(10, 2);
    DECLARE batteriaQn DECIMAL(10, 2);
    DECLARE batteriaZ_in DECIMAL(10, 2);
    DECLARE batteriaV DECIMAL(10, 2);

    -- Cerca i dati della batteria
    SELECT b.Qn, b.Z_in, b.V
    INTO batteriaQn, batteriaZ_in, batteriaV
    FROM Batteria b
    WHERE b.produttore = produttoreBatteria AND b.modello = modelloBatteria;

    -- Cerca l'ultimo test per la batteria data
    SELECT dt.cod
    INTO testCod
    FROM DiagnosticTest dt
    WHERE dt.prodBatteria = produttoreBatteria AND dt.modelloBatteria = modelloBatteria
    ORDER BY dt.dataFine DESC
    LIMIT 1;

    -- Se non esiste nessun test, segnalare un errore
    IF testCod IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nessun test trovato per la batteria specificata';
    END IF;

    -- Cerca i dati della performance per il test trovato
    SELECT p.Q, p.Z_in
    INTO testQ, testZ_in
    FROM Performance p
    WHERE p.cod = testCod;

    -- Restituire i risultati
    SELECT testQ AS 'Capacità registrata', testZ_in AS 'Impedenza registrata', batteriaV AS 'Tensione registrata', batteriaQn AS 'Capacità nominale', batteriaZ_in AS 'Impedenza nominale', batteriaV AS 'Tensione nominale';
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE operatoriLiberi()
BEGIN
    -- Seleziona operatori liberi
    SELECT o.id, o.nome, o.cognome
    FROM Operatore o
    WHERE NOT EXISTS (
        SELECT 1
        FROM DiagnosticTest dt
        WHERE dt.idOperatore = o.id AND dt.aziendaOperatore = o.azienda AND dt.stato = 'in corso'
    );
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE camereClimaticheInUso()
BEGIN
    SELECT DISTINCT produttore, modello
    FROM CameraClimatica
    WHERE (produttore, modello) IN (
        SELECT prodCamera, modelloCamera
        FROM DiagnosticTest
        WHERE stato = 'in corso'
    );
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE numeroAutoProdottePerAnno(
    IN anno INT(4)
)
BEGIN
    SELECT ca.nomeCasa AS CasaAutomobilistica, COUNT(me.modello) AS NumeroAutoProdotte
    FROM CasaAutomobilistica ca
    LEFT JOIN MacchinaElettrica me ON ca.nomeCasa = me.casa AND me.anno = anno
    GROUP BY ca.nomeCasa;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE numeroTestPerOperatore()
BEGIN
    SELECT o.id AS ID, o.nome AS NomeOperatore, o.cognome AS CognomeOperatore, COUNT(dt.cod) AS NumeroTestEseguiti
    FROM Operatore o
    LEFT JOIN DiagnosticTest dt ON o.id = dt.idOperatore
    GROUP BY o.id, o.nome, o.cognome;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE interfacciaBMS(
    IN bmsCod VARCHAR(255)
)
BEGIN
    SELECT i.nomeAlgoritmo
    FROM Interfaccia i
    WHERE i.BMSCod = bmsCod;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE visualizzaStrumentazioneLaboratorio(
    IN labId INT
)
BEGIN
    SELECT s.idLaboratorio, s.produttoreCamera, s.modelloCamera
    FROM Strumentazione s
    WHERE s.idLaboratorio = labId;
END$$

DELIMITER ;





