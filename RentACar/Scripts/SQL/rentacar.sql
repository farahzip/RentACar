 USE rentacardb;


    -- Create vozilo
    CREATE TABLE dbo.vozilo
    (
        id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        marka NVARCHAR(15) NOT NULL,
        model NVARCHAR(25) NOT NULL,
        godina INT NOT NULL,
        cijena_dan FLOAT NOT NULL,
        status TINYINT NOT NULL
    );

    -- Create klijent
    CREATE TABLE dbo.klijent
    (
        id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ime NVARCHAR(45) NOT NULL,
        prezime NVARCHAR(45) NOT NULL,
        telefon NVARCHAR(15) NOT NULL,
        br_dokumenta INT NOT NULL
    );

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