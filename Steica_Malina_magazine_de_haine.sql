CREATE TABLE locatie (
  id_locatie INT,
  tara VARCHAR(15) NOT NULL,
  oras VARCHAR(20)  NOT NULL,
  strada VARCHAR(50) NOT NULL,
  numar INT
);
ALTER TABLE locatie ADD PRIMARY KEY (id_locatie);

CREATE TABLE Magazin (
  id_magazin VARCHAR(15) PRIMARY KEY,
  id_locatie INT
);
ALTER TABLE magazin ADD FOREIGN KEY (id_locatie) REFERENCES locatie (id_locatie);

CREATE TABLE angajat (
  id_angajat INT PRIMARY KEY,
  id_magazin VARCHAR(15),
  mail VARCHAR(50),
  telefon VARCHAR(15),
  nume VARCHAR(25) NOT NULL
);
ALTER TABLE angajat ADD FOREIGN KEY (id_magazin) REFERENCES magazin(id_magazin);
ALTER TABLE angajat ADD CONSTRAINT mail_ang UNIQUE (mail);
ALTER TABLE angajat ADD CONSTRAINT telefon_ang UNIQUE (telefon);

CREATE TABLE contract (
  id_contract INT PRIMARY KEY,
  id_angajat INT,
  data_angajarii DATE NOT NULL,
  functie VARCHAR(255),
  salariu NUMBER(8,2), 
  CONSTRAINT ang_salariu_min CHECK (salariu > 0)
);
ALTER TABLE contract
ADD FOREIGN KEY (id_angajat) REFERENCES angajat(id_angajat);

CREATE TABLE distribuitor (
    id_distr VARCHAR(15) PRIMARY KEY,
    mail VARCHAR(50),
    telefon VARCHAR(15)
);
ALTER TABLE distribuitor ADD CONSTRAINT mail_distr UNIQUE (mail);
ALTER TABLE distribuitor ADD CONSTRAINT telefon_distr UNIQUE (telefon);

CREATE TABLE aprov_magazin (
    id_magazin VARCHAR(15),
    id_distr VARCHAR(15),
    constraint id_aprov primary key(id_magazin, id_distr),
    constraint fk_aprov_mag
    foreign key(id_magazin) references magazin(id_magazin)
    on delete cascade,
    constraint fk_aprov_distr
    foreign key(id_distr) references distribuitor(id_distr)
    on delete cascade
);
CREATE TABLE produs (
  id_produs VARCHAR(15) PRIMARY KEY,
  pret NUMBER(6,2) CHECK (pret > 0)
);

CREATE TABLE stoc_magazin (
  id_magazin VARCHAR(15),
  id_produs VARCHAR(15),
  constraint id_stoc primary key(id_magazin, id_produs),
  constraint fk_stoc_magazin
  foreign key(id_magazin) references magazin(id_magazin)
  on delete cascade, 
  constraint fk_stoc_produs 
  foreign key(id_produs) references produs(id_produs)
  on delete cascade
);
CREATE TABLE comanda (
  id_comanda INT PRIMARY KEY,
  id_client INT,
  valoare_totala NUMBER(6,2) CHECK (valoare_totala >= 0)
);
CREATE TABLE detalii_comanda (
  id_comanda INT,
  id_produs VARCHAR(15),
  nr_buc INT,
  constraint id_detalii primary key(id_comanda, id_produs),
  constraint fk_det_com
  foreign key(id_comanda) references comanda(id_comanda)
  on delete cascade, 
  constraint fk_det_prod
  foreign key(id_produs) references produs(id_produs)
  on delete cascade
);
CREATE TABLE client (
  id_client INT PRIMARY KEY,
  nume VARCHAR(25),
  mail VARCHAR(50),
  telefon VARCHAR(15)
);
ALTER TABLE client ADD CONSTRAINT mail_client UNIQUE (mail);
ALTER TABLE client ADD CONSTRAINT telefon_client UNIQUE (telefon);

INSERT INTO locatie VALUES 
(1,'Romania', 'Bucuresti','Calea Vitan',59);
INSERT INTO locatie VALUES 
(2,'Romania', 'Oradea','Str. Nufarului',30);
INSERT INTO locatie VALUES 
(3,'Romania', 'Cluj-Napoca','Str. Avram Iancu',492);
INSERT INTO locatie VALUES 
(4,'Italia', 'Roma','Della Spiga',103);
INSERT INTO locatie VALUES 
(5,'Germania', 'Berlin','Augsburg',51);

INSERT INTO magazin VALUES 
('NewFashion',1);
INSERT INTO magazin VALUES 
('TrendyVibes',2);
INSERT INTO magazin VALUES 
('RevolutionAge',3);
INSERT INTO magazin VALUES 
('Memoir',4);
INSERT INTO magazin VALUES 
('HouseOfGucci',5);

INSERT INTO angajat VALUES 
(1,'NewFashion','bogdanoctavian@email.com','0742750707', 'Bogdan Octavian');
INSERT INTO angajat VALUES 
(2,'NewFashion','bicuaida@email.com','0722480283', 'Bicu Aida');
INSERT INTO angajat VALUES 
(3,'TrendyVibes','lascudan@email.com','0249415901', 'Lascu Dan');
INSERT INTO angajat VALUES 
(4,'TrendyVibes','mihaigeorge@email.com','0769658750', 'Mihai George');
INSERT INTO angajat VALUES 
(5,'RevolutionAge','papaandreea@email.com','0727944931', 'Popa Andreea');
INSERT INTO angajat VALUES 
(6,'RevolutionAge','teodoroemil@email.com','0261840554 ', 'Teodoro Emil');
INSERT INTO angajat VALUES 
(7,'Memoir','francescobasso@email.com','+390600004917', 'Francesco Basso');
INSERT INTO angajat VALUES 
(8,'Memoir','giovannicontadino@email.com','+390649159995', 'Giovanni Contadino');
INSERT INTO angajat VALUES 
(9,'HouseOfGucci','hahndagmar@email.com','05445544137 ','Hahn Dagmar');

INSERT INTO contract VALUES 
(1,1,'01-Apr-2022','Manager',4000);
INSERT INTO contract VALUES 
(2,2,'06-Apr-2022','Agent de vanzari',3000);
INSERT INTO contract VALUES 
(3,3,'10-May-2022','Manager',3500);
INSERT INTO contract VALUES 
(4,4,'16-May-2022','Agent de vanzari',2500);
INSERT INTO contract VALUES 
(5,5,'11-Jan-2021','Manager',3800);
INSERT INTO contract VALUES 
(6,6,'15-Jan-2021','Agent de vanzari',2850);
INSERT INTO contract VALUES 
(7,7,'15-Aug-2021','Manager',7000);
INSERT INTO contract VALUES 
(8,8,'15-Aug-2021','Agent de vanzari',4000);
INSERT INTO contract VALUES 
(9,9,'20-Aug-2021','Manager',7000);
INSERT INTO contract VALUES 
(10,9,'24-Aug-2021','Agent de vanzari',4000);

INSERT INTO distribuitor VALUES 
('Fashion Place','fshplc@email.com','+5492954684076');
INSERT INTO distribuitor VALUES 
('Nelmarc','nelmarc@email.com','+244959150383');
INSERT INTO distribuitor VALUES 
('JA Shop','jashop@email.com','+40702085192');

INSERT INTO aprov_magazin VALUES 
('NewFashion','Fashion Place');
INSERT INTO aprov_magazin VALUES 
('TrendyVibes','Fashion Place');
INSERT INTO aprov_magazin VALUES 
('RevolutionAge','Fashion Place');
INSERT INTO aprov_magazin VALUES 
('Memoir','Nelmarc');
INSERT INTO aprov_magazin VALUES 
('HouseOfGucci','JA Shop');

INSERT INTO produs VALUES 
('Bluza',54.99);
INSERT INTO produs VALUES 
('Rochie',159.99);
INSERT INTO produs VALUES 
('Pantaloni',84.99);
INSERT INTO produs VALUES 
('Geaca',254.99);
INSERT INTO produs VALUES 
('Fusta',64.99);


INSERT INTO stoc_magazin VALUES
('NewFashion','Bluza');
INSERT INTO stoc_magazin VALUES
('NewFashion','Rochie');
INSERT INTO stoc_magazin VALUES
('NewFashion','Pantaloni');
INSERT INTO stoc_magazin VALUES
('NewFashion','Geaca');
INSERT INTO stoc_magazin VALUES
('NewFashion','Fusta');

INSERT INTO stoc_magazin VALUES
('TrendyVibes','Bluza');
INSERT INTO stoc_magazin VALUES
('TrendyVibes','Rochie');
INSERT INTO stoc_magazin VALUES
('TrendyVibes','Pantaloni');
INSERT INTO stoc_magazin VALUES
('TrendyVibes','Fusta');

INSERT INTO stoc_magazin VALUES
('RevolutionAge','Rochie');
INSERT INTO stoc_magazin VALUES
('RevolutionAge','Fusta');

INSERT INTO stoc_magazin VALUES
('Memoir','Rochie');

INSERT INTO stoc_magazin VALUES
('HouseOfGucci','Bluza');
INSERT INTO stoc_magazin VALUES
('HouseOfGucci','Rochie');
INSERT INTO stoc_magazin VALUES
('HouseOfGucci','Pantaloni');
INSERT INTO stoc_magazin VALUES
('HouseOfGucci','Geaca');
INSERT INTO stoc_magazin VALUES
('HouseOfGucci','Fusta');

INSERT INTO client VALUES
(1,'Popescu Andrei','popescuandrei@email.com','0702078753');
INSERT INTO client VALUES
(2,'Radu Otilia','raduotilia@email.com','0702070553');
INSERT INTO client VALUES
(3,'Georgia Vasilica','georgianavasilica@email.com','0703497033');
INSERT INTO client VALUES
(4,'Rusu Dragos','rusudragos@email.com','0702015005');

INSERT INTO comanda VALUES
(1,1,0);
INSERT INTO comanda VALUES
(2,2,0);
INSERT INTO comanda VALUES
(3,3,0);
INSERT INTO comanda VALUES
(4,3,0);
INSERT INTO comanda VALUES
(5,4,0);

INSERT INTO detalii_comanda VALUES
(1,'Bluza',2);
INSERT INTO detalii_comanda VALUES
(1,'Pantaloni',1);
INSERT INTO detalii_comanda VALUES
(2,'Geaca',1);
INSERT INTO detalii_comanda VALUES
(2,'Rochie',1);
INSERT INTO detalii_comanda VALUES
(3,'Fusta',3);
INSERT INTO detalii_comanda VALUES
(3,'Bluza',2);
INSERT INTO detalii_comanda VALUES
(4,'Pantaloni',2);
INSERT INTO detalii_comanda VALUES
(5,'Rochie',2);

UPDATE comanda
SET valoare_totala = (SELECT SUM(nr_buc*pret)
                      FROM detalii_comanda 
                      JOIN produs ON detalii_comanda.id_produs = produs.id_produs
                      WHERE id_comanda = comanda.id_comanda);