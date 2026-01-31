 CREATE TABLE dbo.vozilo
(
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    marka NVARCHAR(15) NOT NULL,
    model NVARCHAR(25) NOT NULL,
    godina INT NOT NULL,
    cijena_dan FLOAT NOT NULL,
    status TINYINT NOT NULL
);
GO

-- Create klijent
CREATE TABLE dbo.klijent
(
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ime NVARCHAR(45) NOT NULL,
    prezime NVARCHAR(45) NOT NULL,
    telefon NVARCHAR(15) NOT NULL,
    br_dokumenta INT NOT NULL
);
GO

-- Create rezervacija (FKs to vozilo and klijent)
CREATE TABLE dbo.rezervacija
(
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    vozilo_id INT NOT NULL,
    klijent_id INT NOT NULL,
    datum_kreiranja DATE NOT NULL,
    datum_od DATE NOT NULL,
    datum_do DATE NOT NULL,
    ukupna_cijena FLOAT NOT NULL,
    CONSTRAINT FK_rezervacija_vozilo FOREIGN KEY (vozilo_id) REFERENCES dbo.vozilo(id),
    CONSTRAINT FK_rezervacija_klijent FOREIGN KEY (klijent_id) REFERENCES dbo.klijent(id)
);
GO

-- ===========================
-- INSERT VOZILA 
-- ===========================
    SET IDENTITY_INSERT dbo.vozilo ON;

    INSERT INTO dbo.vozilo (id, marka, model, godina, cijena_dan, status) VALUES
    (1, N'Volkswagen', N'Golf', 2018, 45.50, 1),
    (2, N'Toyota', N'Corolla', 2020, 50.00, 1),
    (3, N'BMW', N'320i', 2019, 70.00, 1),
    (4, N'Audi', N'A4', 2021, 75.00, 1),
    (5, N'Mercedes', N'C200', 2017, 65.00, 0),
    (6, N'Ford', N'Focus', 2016, 40.00, 1),
    (7, N'Opel', N'Astra', 2019, 48.00, 1),
    (8, N'Nissan', N'Qashqai', 2020, 60.00, 1),
    (9, N'Peugeot', N'308', 2018, 42.50, 0),
    (10, N'Renault', N'Megane', 2021, 55.00, 1);

    SET IDENTITY_INSERT dbo.vozilo OFF;
GO

-- ===========================
-- INSERT KLIJENATA 
-- ===========================
    SET IDENTITY_INSERT dbo.klijent ON;

    INSERT INTO dbo.klijent (id, ime, prezime, telefon, br_dokumenta) VALUES
    (1, N'Amir', N'Hadzić', '061123456', 12345678),
    (2, N'Selma', N'Jahić', '062234567', 23456789),
    (3, N'Adnan', N'Čengić', '063345678', 34567890),
    (4, N'Lejla', N'Begović', '060456789', 45678901),
    (5, N'Denis', N'Mujić', '061567890', 56789012),
    (6, N'Emir', N'Alispahić', '062678901', 67890123),
    (7, N'Nina', N'Šarić', '063789012', 78901234),
    (8, N'Haris', N'Kovačević', '060890123', 89012345),
    (9, N'Aida', N'Ćatić', '061901234', 90123456),
    (10, N'Mirza', N'Hadžiahmetović', '062012345', 11234567);

    SET IDENTITY_INSERT dbo.klijent OFF;

    -- reseed identity to max(id)

GO

-- ===========================
-- INSERT REZERVACIJA 
-- ===========================
    INSERT INTO dbo.rezervacija (vozilo_id, klijent_id, datum_kreiranja, datum_od, datum_do, ukupna_cijena) VALUES
    (1, 1, '2026-01-01', '2026-01-05', '2026-01-10', 455.00),
    (2, 2, '2026-01-02', '2026-01-07', '2026-01-12', 250.00),
    (3, 3, '2026-01-03', '2026-01-10', '2026-01-15', 350.00),
    (4, 4, '2026-01-04', '2026-01-12', '2026-01-18', 450.00),
    (5, 5, '2026-01-05', '2026-01-15', '2026-01-20', 325.00),
    (6, 6, '2026-01-06', '2026-01-18', '2026-01-22', 160.00),
    (7, 7, '2026-01-07', '2026-01-20', '2026-01-25', 240.00),
    (8, 8, '2026-01-08', '2026-01-25', '2026-01-30', 300.00),
    (9, 9, '2026-01-09', '2026-01-28', '2026-02-02', 212.50),
    (10, 10, '2026-01-10', '2026-01-30', '2026-02-05', 385.00);
GO