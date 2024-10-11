-- Cau 58  ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

DECLARE POINT_CT CURSOR FOR 
SELECT MACT, HOTEN, VITRI FROM CAUTHU

OPEN POINT_CT 
DECLARE @Mact NUMERIC(18, 0), @Ten NVARCHAR(100), @Vitri NVARCHAR(50)
FETCH NEXT FROM POINT_CT INTO @Mact, @Ten, @Vitri

WHILE @@FETCH_STATUS = 0
    BEGIN 
        PRINT N'Mã cầu thủ ' + CAST(@Mact AS VARCHAR(50))
        PRINT N'Tên cầu thủ ' + @Ten 
        PRINT N'Vị trí ' + @Vitri
        PRINT ''
        FETCH NEXT FROM POINT_CT INTO @Mact, @Ten, @Vitri
    END

CLOSE POINT_CT 
DEALLOCATE POINT_CT