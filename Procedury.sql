USE Siec_Wypozyczalni

-- DROP PROCEDURE DodajPracownika

CREATE PROCEDURE DodajPracownika (@Adres_ID INT, @Stanowisko_ID INT, @Siedziba_ID INT, @Imie VARCHAR(30), 
								 @Nazwisko VARCHAR(30), @Pesel VARCHAR(11), @Telefon VARCHAR(9), 
								 @Data_zatr DATE=NULL)
AS
BEGIN
	
	IF @Data_zatr IS NULL
	BEGIN
		SET @Data_zatr = (SELECT CONVERT(date, GETDATE()))
	END
	DECLARE @Prac_ID VARCHAR(15), @Inicjaly VARCHAR(2), @Liczba_prac INT, @Pensja INT

	SET @Inicjaly = SUBSTRING(@Imie, 1, 1) + SUBSTRING(@Nazwisko, 1, 1)
	SET @Prac_ID = @Inicjaly + CAST(@Siedziba_ID AS VARCHAR) + CAST(YEAR(@Data_zatr) as VARCHAR)
	SET @Liczba_prac = (SELECT count(*) FROM Pracownicy 
						WHERE SUBSTRING(Pracownicy.Pracownik_ID, 1, LEN(@Prac_ID)) = @Prac_ID)
	SET @Pensja = (SELECT Pensja_min FROM Stanowiska WHERE Stanowisko_ID = @Stanowisko_ID)

	SET @Prac_ID = @Prac_ID + CAST(@Liczba_prac AS VARCHAR)

	INSERT INTO Pracownicy VALUES (@Prac_ID, @Adres_ID, @Stanowisko_ID, @Siedziba_ID, @Imie, @Nazwisko, 
								   @Pesel, @Telefon, @Pensja, @Data_zatr)
END;


EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678910', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678911', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678912', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678913', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678914', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Marcel', 'Pawlak', '12345678915', '333666999', '2015-07-07'
EXEC DodajPracownika 1, 1, 1, 'Kuba', 'Mostowiak', '11122233344', '123456789'



SELECT * FROM Pracownicy

-- DELETE FROM Pracownicy

--------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE WyswietlPojazdy

CREATE PROCEDURE WyswietlPojazdy (@czyDostepne INT)
AS
BEGIN
	IF @czyDostepne = 0 
	BEGIN
		SELECT * FROM Samochody
	END
	IF @czyDostepne = 1
	BEGIN
		SELECT * FROM Samochody WHERE Samochody.Dostêpnoœæ = 'TAK'
	END
	IF @czyDostepne = 2
	BEGIN
		SELECT * FROM Samochody WHERE Samochody.Dostêpnoœæ = 'NIE'
	END
END;

EXEC WyswietlPojazdy 0
EXEC WyswietlPojazdy 1
EXEC WyswietlPojazdy 2



--------------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE PrzelicznikSamochodu

CREATE PROCEDURE PrzelicznikSamochodu(@Cena_dzien Money, @Cena_km Money, @Marka VARCHAR(10), @Model VARCHAR(10))
AS
BEGIN
	IF @Marka = '0' AND @Model <> '0'
	BEGIN

		IF @Cena_dzien <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_dzien = @Cena_dzien
			WHERE Model = @Model
		END

		IF @Cena_km <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_km = @Cena_km
			WHERE Model = @Model
		END

	END


	IF @Marka <> '0' AND @Model = '0'
	BEGIN

		IF @Cena_dzien <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_dzien = @Cena_dzien
			WHERE Marka = @Marka
		END

		IF @Cena_km <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_km = @Cena_km
			WHERE Marka = @Marka
		END
	END


	IF @Marka <> '0' AND @Model <> '0'
	BEGIN

		IF @Cena_dzien <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_dzien = @Cena_dzien
			WHERE Model = @Model AND Marka = @Marka
		END

		IF @Cena_km <> 0
		BEGIN
			UPDATE Samochody
			SET Cena_km = @Cena_km
			WHERE Model = @Model AND Marka = @Marka
		END
	END
END;

EXEC PrzelicznikSamochodu 40.00, 0.24, 'VolksWagen', 'Passat'

SELECT * FROM Samochody


-------------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE Zwieksz_Pensje

CREATE PROCEDURE Zwieksz_Pensje(@Pracownik_ID VARCHAR(15), @Procent_podw NUMERIC(4,2))
AS
BEGIN
	DECLARE @Max_pensja INT, @Pensja INT
	SET @Procent_podw = (@Procent_podw + 100)/100
	SET @Max_pensja = (SELECT Pensja_max FROM Stanowiska 
					   WHERE Stanowisko_ID = (SELECT Stanowisko_ID FROM Pracownicy 
											  WHERE Pracownik_ID = @Pracownik_ID))
	SET @Pensja = @Procent_podw * (SELECT Pensja FROM Pracownicy 
								   WHERE Pracownik_ID = @Pracownik_ID)

	IF @Pensja > @Max_pensja
	BEGIN
		UPDATE Pracownicy
		SET Pensja = @Max_pensja
		WHERE Pracownik_ID = @Pracownik_ID

		PRINT 'OJ BYCZKU -1'
		RETURN
	END
	
	IF @Pensja <= @Max_pensja
	BEGIN
		UPDATE Pracownicy
		SET Pensja = @Pensja
		WHERE Pracownik_ID = @Pracownik_ID
	END
END;

SELECT * FROM Pracownicy

EXEC Zwieksz_Pensje 'MP120150', 10.00
EXEC Zwieksz_Pensje 'MP120152', 5.00

SELECT * FROM Pracownicy


------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE DodajKlienta

CREATE PROCEDURE DodajKlienta(@Pesel VARCHAR(11), @Adres_Klienta INT=NULL, 
							  @Imie VARCHAR(30)=NULL, @Nazwisko VARCHAR(30)=NULL, 
							  @Telefon VARCHAR(9)=NULL)
AS
BEGIN
	 DECLARE @WyszukanyKlient INT
	 SET @WyszukanyKlient = (SELECT Klient_ID FROM Klienci WHERE Pesel = @Pesel)

	 IF @WyszukanyKlient IS NOT NULL
	 BEGIN
		RETURN @WyszukanyKlient;
	 END


	 IF ( (@Adres_Klienta IS NULL) OR (@Imie IS NULL) OR (@Nazwisko IS NULL)
		   OR (@Telefon IS NULL) )
	 BEGIN
		PRINT ('ZAPOMNIA£EŒ DANYCH KLIENTA BYKU');
		RETURN;
	 END


	 INSERT INTO Klienci VALUES (@Adres_Klienta, @Imie, @Nazwisko, @Pesel, @Telefon)
	 
	 SET @WyszukanyKlient = (SELECT Klient_ID FROM Klienci WHERE Pesel = @Pesel)

	 RETURN @WyszukanyKlient;
END;


SELECT * FROM Klienci

DECLARE @Klient_ID INT
EXEC @Klient_ID = DodajKlienta '12345678910', 1, 'Grzegorz', 'Brzêczeszczykiewicz', '123456789'
PRINT @Klient_ID

DECLARE @Klient_ID INT
EXEC @Klient_ID = DodajKlienta '12345678910'
PRINT @Klient_ID

DECLARE @Klient_ID INT
EXEC @Klient_ID = DodajKlienta '10987654321'
PRINT @Klient_ID

SELECT * FROM Klienci


------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE WypozyczenieSamochodu

CREATE PROCEDURE WypozyczenieSamochodu(@Klient_ID INT, @Siedziba_ID INT, @Pracownik_ID VARCHAR(15), 
									   @Samochod_ID INT, @Data_wyp DATE=NULL)
AS
BEGIN
	IF @Data_wyp IS NULL
	BEGIN
		SET @Data_wyp = (SELECT CONVERT(date, GETDATE()))
	END

	DECLARE @CzySamochodWolny VARCHAR(3), @CzySamochodIstnieje INT


	SET @CzySamochodIstnieje = (SELECT count(Samochód_ID) FROM Samochody WHERE Samochód_ID = @Samochod_ID)
	SET @CzySamochodWolny = (SELECT Dostêpnoœæ FROM Samochody WHERE Samochód_ID = @Samochod_ID)


	IF @CzySamochodIstnieje = 0
	BEGIN
		PRINT ( 'SORRY, Taki samochód nie istnieje');
		RETURN;
	END

	IF @CzySamochodWolny LIKE 'NIE'
	BEGIN
		PRINT ( 'Samochód ju¿ wyporzyczony' );
		RETURN;
	END

	DECLARE  @CzyWypozyczono INT
	SET @CzyWypozyczono = 0

	INSERT INTO Wypo¿yczenia VALUES (@Klient_ID, @Siedziba_ID, @Pracownik_ID, @Samochod_ID, @Data_wyp)

	SET @CzyWypozyczono = (SELECT count(Wypo¿yczenie_ID) FROM Wypo¿yczenia 
						   WHERE Klient_ID = @Klient_ID AND Samochód_ID = @Samochod_ID)

	IF @CzyWypozyczono = 0
	BEGIN
		PRINT ('Oj, nie uda³o siê wypo¿yczyæ')
		RETURN;
	END

	UPDATE Samochody
	SET Dostêpnoœæ = 'NIE'
	WHERE Samochód_ID = @Samochod_ID

END;


DECLARE @Klient_ID INT
EXEC @Klient_ID = DodajKlienta '11223344556', 2, 'Mateusz', 'Morawiecki', '123456789'
EXEC @Klient_ID = DodajKlienta '11223344555', 3, 'Grzegorz', 'Braun', '123456788'
EXEC @Klient_ID = DodajKlienta '11223344554', 4, 'Janusz', 'Korwin', '123456787'
EXEC @Klient_ID = DodajKlienta '11223344553', 5, 'Andrzej', 'Duda', '123456786'
EXEC @Klient_ID = DodajKlienta '11223344552', 6, 'Jaros³aw', 'Kaczyñski', '123456785'

SELECT * FROM Klienci
SELECT * FROM Siedziby
SELECT * FROM Pracownicy
SELECT * FROM Samochody

EXEC WypozyczenieSamochodu 1, 1, 'MP120150', 1, '2016-05-05'
EXEC WypozyczenieSamochodu 2, 2, 'MP120150', 2, '2016-05-06'
EXEC WypozyczenieSamochodu 3, 1, 'MP120151', 1, '2016-05-07'
EXEC WypozyczenieSamochodu 2, 3, 'MP120151', 3


SELECT * FROM Wypo¿yczenia
SELECT * FROM Samochody

EXEC WyswietlPojazdy 2

----------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE ZwrotSamochodu

CREATE PROCEDURE ZwrotSamochodu(@Samochod_ID INT, @Przebieg DECIMAL(6,0), @Data_odd DATE=NULL)
AS
BEGIN

	IF @Data_odd IS NULL
	BEGIN
		SET @Data_odd = (SELECT CONVERT(date, GETDATE()))
	END

	DECLARE @CzasWypozyczenia INT, @Cena_dzien MONEY, @Cena_km MONEY

	DECLARE @Wypozyczenie_ID INT, @Klient_ID INT, @Siedziba_ID INT, @Pracownik_ID VARCHAR(15),
			@Data_wyp DATE, @Koszta MONEY, @Przebyte_km DECIMAL(6,0)

	SET @Wypozyczenie_ID = (SELECT Wypo¿yczenie_ID FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID)
	SET @Klient_ID = (SELECT Klient_ID FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID)
	SET @Siedziba_ID = (SELECT Siedziba_ID FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID)
	SET @Pracownik_ID = (SELECT Pracownik_ID FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID)
	SET @Przebyte_km = @Przebieg - (SELECT Przebieg FROM Samochody WHERE Samochód_ID = @Samochod_ID)

	SET @Data_wyp = (SELECT Data_wyp FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID)
	SET @CzasWypozyczenia = DATEDIFF(day,@Data_wyp, @Data_odd)
	SET @Cena_dzien = (SELECT Cena_dzien FROM Samochody WHERE Samochód_ID = @Samochod_ID)
	SET @Cena_km = (SELECT Cena_km FROM Samochody WHERE Samochód_ID = @Samochod_ID)

	SET @Koszta = @Cena_dzien * @CzasWypozyczenia + @Cena_km * @Przebyte_km


	IF @Przebyte_km < 0
	BEGIN
		PRINT ('OJ, chyba Ÿle wpisa³eœ przebieg byku')
		RETURN;
	END

	INSERT INTO Historia_Wypo¿yczenia VALUES (@Wypozyczenie_ID, @Klient_ID, @Siedziba_ID, @Pracownik_ID, 
											  @Samochod_ID, @Data_wyp, @Data_odd, @Koszta, @Przebyte_km)

	DELETE FROM Wypo¿yczenia WHERE Samochód_ID = @Samochod_ID

	UPDATE Samochody
	SET Dostêpnoœæ = 'TAK'
	WHERE Samochód_ID = @Samochod_ID

	UPDATE Samochody
	SET Przebieg = @Przebieg
	WHERE Samochód_ID = @Samochod_ID

	RETURN @Koszta
END;

DECLARE @Koszta MONEY
EXEC @Koszta = ZwrotSamochodu 1, 100100, '2016-05-07'
PRINT @Koszta

DECLARE @Koszta MONEY
EXEC @Koszta = ZwrotSamochodu 3, 100100
PRINT @Koszta

EXEC WyswietlPojazdy 2
--------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE ZliczWypozyczenia

CREATE PROCEDURE ZliczWypozyczenia (@Klient_ID INT=NULL, @Pracownik_ID VARCHAR(15)=NULL)
AS
BEGIN
	IF (@Klient_ID IS NULL) AND (@Pracownik_ID IS NULL)
	BEGIN
		PRINT ('Nie poda³eœ kogo wypo¿yczenia byku')
		RETURN;
	END


	IF (@Klient_ID IS NOT NULL) AND (@Pracownik_ID IS NOT NULL)
	BEGIN
		PRINT ('Nie b¹dŸ zach³anny, wybierz jednego byku')
		RETURN;
	END


	DECLARE @Wypozyczenia INT


	IF @Klient_ID IS NOT NULL
	BEGIN

		SET @Wypozyczenia = (SELECT count(Wypo¿yczenie_ID) 
							 FROM Historia_Wypo¿yczenia 
							 WHERE Klient_ID = @Klient_ID)

		SET @Wypozyczenia = @Wypozyczenia 
						  + (SELECT count(Wypo¿yczenie_ID) 
							 FROM Wypo¿yczenia 
							 WHERE Klient_ID = @Klient_ID)
		RETURN @Wypozyczenia
	END


	IF @Pracownik_ID IS NOT NULL
	BEGIN

		SET @Wypozyczenia = (SELECT count(Wypo¿yczenie_ID) 
							 FROM Historia_Wypo¿yczenia 
							 WHERE Pracownik_ID = @Pracownik_ID)

		SET @Wypozyczenia = @Wypozyczenia 
						  + (SELECT count(Wypo¿yczenie_ID) 
							 FROM Wypo¿yczenia 
							 WHERE Pracownik_ID = @Pracownik_ID)
		RETURN @Wypozyczenia
	END
END;

SELECT * FROM  Historia_Wypo¿yczenia
SELECT * FROM Wypo¿yczenia

DECLARE @IleWypozyczen INT
EXEC @IleWypozyczen = ZliczWypozyczenia NULL, 'MP120150'
PRINT @IleWypozyczen


DECLARE @IleWypozyczen INT
EXEC @IleWypozyczen = ZliczWypozyczenia 1, NULL
PRINT @IleWypozyczen