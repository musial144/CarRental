USE Siec_Wypozyczalni

INSERT INTO Samochody VALUES('VolksWagen', 'Passat', 'Sedan', 2000, 1984, 100000, 'TAK', 50.00, 0.27)
INSERT INTO Samochody VALUES('Daewoo', 'Espero', 'Sedan', 1999, 1984, 200000, 'TAK', 40.00, 0.28)
INSERT INTO Samochody VALUES('Daewoo', 'Matiz', 'Sedan', 2004, 1984, 123970, 'TAK', 55.00, 0.28)
INSERT INTO Samochody VALUES('VolksWagen', 'Bora', 'Sedan', 2007, 1984, 120000, 'TAK', 38.00, 0.30)
INSERT INTO Samochody VALUES('Skoda', 'Fabia', 'Sedan', 2005, 1984, 91000, 'TAK', 35.00, 0.30)
INSERT INTO Samochody VALUES('Skoda', 'Octavia', 'Sedan', 2006, 1984, 940000, 'TAK', 43.00, 0.21)
INSERT INTO Samochody VALUES('Suzuki', 'Swift', 'Sedan', 2008, 1984, 540000, 'TAK', 47.00, 0.29)
INSERT INTO Samochody VALUES('Fiat', 'Panda', 'Sedan', 2008, 1984, 321000, 'TAK', 52.00, 0.35)
INSERT INTO Samochody VALUES('Honda', 'Civic', 'Sedan', 2006, 1984, 240000, 'TAK', 57.00, 0.33)
INSERT INTO Samochody VALUES('VolksWagen', 'Golf', 'Sedan', 2004, 1984, 83000, 'TAK', 60.00, 0.32)
INSERT INTO Samochody VALUES('Audi', 'a4', 'Sedan', 2002, 1984, 120000, 'TAK', 52.00, 0.30)
INSERT INTO Samochody VALUES('Audi', 'a3', 'Sedan', 2010, 1984, 130000, 'TAK', 46.00, 0.31)
INSERT INTO Samochody VALUES('Audi', 'a6', 'Sedan', 2011, 1984, 142586, 'TAK', 38.00, 0.31)
INSERT INTO Samochody VALUES('VolksWagen', 'Passat', 'Sedan', 2012, 1984, 124827, 'TAK', 40.00, 0.34)
INSERT INTO Samochody VALUES('VolksWagen', 'Passat', 'Sedan', 2005, 1984, 252673, 'TAK', 39.00, 0.26)
INSERT INTO Samochody VALUES('VolksWagen', 'Golf', 'Sedan', 2009, 1984, 351732, 'TAK', 37.00, 0.28)
INSERT INTO Samochody VALUES('VolksWagen', 'Golf', 'Sedan', 20012, 1984, 88244, 'TAK', 42.00, 0.27)
INSERT INTO Samochody VALUES('Honda', 'Civic', 'Sedan', 2013, 1984, 67231, 'TAK', 48.00, 0.25)
INSERT INTO Samochody VALUES('Skoda', 'Octavia', 'Sedan', 2011, 1984, 154673, 'TAK', 47.00, 0.24)

SELECT * FROM Samochody


INSERT INTO Regiony VALUES('Warszawa', 'Poland')
INSERT INTO Regiony VALUES('Lodz', 'Poland')
INSERT INTO Regiony VALUES('Rzeszow', 'Poland')
INSERT INTO Regiony VALUES('Krakow', 'Poland')
INSERT INTO Regiony VALUES('Wroclaw', 'Poland')
INSERT INTO Regiony VALUES('Gdansk', 'Poland')
INSERT INTO Regiony VALUES('Poznan', 'Poland')
INSERT INTO Regiony VALUES('Berlin', 'Deuchland')
INSERT INTO Regiony VALUES('Frankfurt', 'Deuchland')
INSERT INTO Regiony VALUES('Paris', 'French')
INSERT INTO Regiony VALUES('London', 'UK')

SELECT * FROM Regiony


INSERT INTO Adresy VALUES (1, 'Warszawa', '97-512', 'Nowa', 15, 27)
INSERT INTO Adresy VALUES (1, 'Skierniewice', '92-212', 'Ignacego', 78, 38)
INSERT INTO Adresy VALUES (2, 'Lodz', '94-312', 'Gwarna', 34, 59)
INSERT INTO Adresy VALUES (2, 'Tomaszow Mazowiecki', '97-412', 'Gospodarcza', 75, 58)
INSERT INTO Adresy VALUES (3, 'Rzaszow', '92-318', 'Ambro¿ego', 28, 18)
INSERT INTO Adresy VALUES (4, 'Krakow', '97-314', '¯o³nierza', 86, 71)
INSERT INTO Adresy VALUES (5, 'Wroclaw', '95-123', 'Studenta', 64, 32)
INSERT INTO Adresy VALUES (6, 'Gdansk', '94-812', 'Elona Muska', 56, 17)
INSERT INTO Adresy VALUES (7, 'Poznan', '88-412', 'Einsteina', 48, 62)
INSERT INTO Adresy VALUES (8, 'Berlin', '91-267', 'Hawkinga', 25, 81)
INSERT INTO Adresy VALUES (9, 'Frankfurt', '94-321', 'Pryncypa³y', 49, 18)
INSERT INTO Adresy VALUES (10, 'Paris', '91-432', 'Tima', 52, 27)
INSERT INTO Adresy VALUES (11, 'London', '97-256', 'Piotrkowska', 94, 92)
INSERT INTO Adresy VALUES (2, 'Piotrkow Trybunalski', '98-354', 'Krakowska', 47, 62)
INSERT INTO Adresy VALUES (1, 'Ostroleka', '96-253', 'W¹sowska', 12, 41)
INSERT INTO Adresy VALUES (2, 'Koluszki', '93-423', 'Karykaturowska', 67, 37)
INSERT INTO Adresy VALUES (7, 'Bydgoszcz', '89-367', 'W¹ska', 28, 16)
INSERT INTO Adresy VALUES (7, 'Torun', '87-311', 'Lema', 92, 23)
INSERT INTO Adresy VALUES (4, 'Zakopanem', '87-243', 'Tuwima', 42, 38)

SELECT * FROM Adresy

INSERT INTO Stanowiska VALUES ('Mechanik Sta¿ysta', 2000, 2500)
INSERT INTO Stanowiska VALUES ('Mechanik', 2500, 4000)
INSERT INTO Stanowiska VALUES ('Starszy mechanik', 4000, 8000)
INSERT INTO Stanowiska VALUES ('Manager', 5000, 9000)

SELECT * FROM Stanowiska

INSERT INTO Siedziby VALUES (1)
INSERT INTO Siedziby VALUES (2)
INSERT INTO Siedziby VALUES (3)
INSERT INTO Siedziby VALUES (4)
INSERT INTO Siedziby VALUES (5)
INSERT INTO Siedziby VALUES (6)
INSERT INTO Siedziby VALUES (7)

SELECT * FROM Siedziby

