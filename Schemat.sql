USE master
GO

--DROP DATABASE Siec_Wypozyczalni
--GO

CREATE DATABASE Siec_Wypozyczalni
GO

USE Siec_Wypozyczalni
GO

CREATE TABLE Samochody(
	Samochód_ID INT IDENTITY(1,1) PRIMARY KEY,
	Marka VARCHAR(10),
	Model VARCHAR(10),
	Typ VARCHAR(10),
	Rok_Produkcji INT,
	Pojemnoœæ_silnika INT,
	Przebieg DECIMAL(6,0),
	Dostêpnoœæ VARCHAR(3),
	Cena_dzien MONEY,
	Cena_km MONEY,
	CONSTRAINT Samochody_Dostêpnoœæ_Check CHECK(
	Dostêpnoœæ LIKE 'TAK' OR 
	Dostêpnoœæ LIKE 'NIE'
	)
)
GO

CREATE TABLE Regiony(
	Region_ID INT IDENTITY(1,1) PRIMARY KEY,
	Nazwa VARCHAR(25),
	Kraj VARCHAR(20)
)
GO

CREATE TABLE Adresy(
	Adres_ID INT IDENTITY(1,1) PRIMARY KEY,
	Region_ID INT, 
	Miasto VARCHAR(30),
	Nr_poczt VARCHAR(12),
	Ulica VARCHAR(30),
	Nr_Budynku INT,
	Nr_Lokalu INT,
	CONSTRAINT Adresy_Region_FK FOREIGN KEY(Region_ID) REFERENCES Regiony(Region_ID)
)
GO

CREATE TABLE Stanowiska(
	Stanowisko_ID INT IDENTITY(1,1) PRIMARY KEY,
	Nazwa VARCHAR(20),
	Pensja_min INT,
	Pensja_max INT
)
GO

CREATE TABLE Siedziby(
	Siedziba_ID INT IDENTITY(1,1) PRIMARY KEY,
	Adres_ID INT,
	CONSTRAINT Siedziby_Adres_FK FOREIGN KEY (Adres_ID) REFERENCES Adresy(Adres_ID)
)
GO

CREATE TABLE Pracownicy(
	Pracownik_ID VARCHAR(15) PRIMARY KEY,
	Adres_ID INT,
	Stanowisko_ID INT,
	Siedziba_ID INT,
	Imiê VARCHAR(30),
	Nazwisko VARCHAR(30),
	Pesel VARCHAR(11),
	Telefon VARCHAR(9),
	Pensja INT,
	Data_zatr DATE,
	CONSTRAINT Pracownicy_Adres_FK FOREIGN KEY (Adres_ID) REFERENCES Adresy(Adres_ID),
	CONSTRAINT Pracownicy_Stanowiska_FK FOREIGN KEY (Stanowisko_ID) REFERENCES Stanowiska(Stanowisko_ID),
	CONSTRAINT Pracownicy_Siedziba_FK FOREIGN KEY (Siedziba_ID) REFERENCES Siedziby(Siedziba_ID),
	CONSTRAINT Pracownicy_Pesel_Check CHECK(
	SUBSTRING(Pesel,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,9,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,10,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,11,1) BETWEEN '0' AND '9'),
	CONSTRAINT Pracownicy_Telefon_Check CHECK(
	SUBSTRING(Telefon,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,9,1) BETWEEN '0' AND '9')
)
GO

CREATE TABLE Historia_Pracownicy(
	Pracownik_ID VARCHAR(15) PRIMARY KEY,
	Adres_ID INT,
	Stanowisko_ID INT,
	Siedziba_ID INT,
	Imiê VARCHAR(30),
	Nazwisko VARCHAR(30),
	Pesel VARCHAR(11),
	Telefon VARCHAR(9),
	data_zatr DATE,
	data_zwol DATE,
	CONSTRAINT Hist_Pracownicy_Adres_FK FOREIGN KEY (Adres_ID) REFERENCES Adresy(Adres_ID),
	CONSTRAINT Hist_Pracownicy_Stanowisko_FK FOREIGN KEY (Stanowisko_ID) REFERENCES Stanowiska(Stanowisko_ID),
	CONSTRAINT Hist_Pracownicy_Siedziba_FK FOREIGN KEY (Siedziba_ID) REFERENCES Siedziby(Siedziba_ID),
	CONSTRAINT Hist_Pracownicy_Pesel_Check CHECK(
	SUBSTRING(Pesel,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,9,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,10,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,11,1) BETWEEN '0' AND '9'),
	CONSTRAINT Hist_Pracownicy_Telefon_Check CHECK(
	SUBSTRING(Telefon,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,9,1) BETWEEN '0' AND '9')
)
GO

CREATE TABLE Klienci(
	Klient_ID INT IDENTITY(1,1) PRIMARY KEY,
	Adres_ID INT,
	Imiê VARCHAR(30),
	Nazwisko VARCHAR(30),
	Pesel VARCHAR(11),
	Telefon VARCHAR(9),
	CONSTRAINT Klienci_Adres_FK FOREIGN KEY (Adres_ID) REFERENCES Adresy(Adres_ID),
	CONSTRAINT Klienci_Pesel_Check CHECK(
	SUBSTRING(Pesel,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,9,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,10,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Pesel,11,1) BETWEEN '0' AND '9'),
	CONSTRAINT Klienci_Telefon_Check CHECK(
	SUBSTRING(Telefon,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(Telefon,9,1) BETWEEN '0' AND '9')
)
GO

CREATE TABLE Wypo¿yczenia(
	Wypo¿yczenie_ID INT IDENTITY(1,1) PRIMARY KEY,
	Klient_ID INT,
	Siedziba_ID INT,
	Pracownik_ID VARCHAR(15),
	Samochód_ID INT,
	Data_wyp DATE,
	CONSTRAINT Wyp_Klient_FK FOREIGN KEY (Klient_ID) REFERENCES Klienci(Klient_ID),
	CONSTRAINT Wyp_Siedziba_FK FOREIGN KEY (Siedziba_ID) REFERENCES Siedziby(Siedziba_ID),
	CONSTRAINT Wyp_Pracownik_FK FOREIGN KEY (Pracownik_ID) REFERENCES Pracownicy(Pracownik_ID),
	CONSTRAINT Wyp_Samochód_FK FOREIGN KEY (Samochód_ID) REFERENCES Samochody(Samochód_ID)
)
GO

CREATE TABLE Historia_Wypo¿yczenia(
	Wypo¿yczenie_ID INT PRIMARY KEY,
	Klient_ID INT,
	Siedziba_ID INT,
	Pracownik_ID VARCHAR(15),
	Samochód_ID INT,
	Data_wyp DATE,
	Data_zwrot DATE,
	Koszt_wyp MONEY,
	Przebyte_km DECIMAL(6,0),
	CONSTRAINT Hist_Wyp_Klient_FK FOREIGN KEY (Klient_ID) REFERENCES Klienci(Klient_ID),
	CONSTRAINT Hist_Wyp_Siedziba_FK FOREIGN KEY (Siedziba_ID) REFERENCES Siedziby(Siedziba_ID),
	CONSTRAINT Hist_Wyp_Pracownik_FK FOREIGN KEY (Pracownik_ID) REFERENCES Pracownicy(Pracownik_ID),
	CONSTRAINT Hist_Wyp_Samochód_FK FOREIGN KEY (Samochód_ID) REFERENCES Samochody(Samochód_ID)
)
GO

