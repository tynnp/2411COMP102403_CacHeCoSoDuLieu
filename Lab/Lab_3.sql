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

-- Cau 59  ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa 
GO 

DECLARE POINT_CLB CURSOR FOR 
SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN FROM CAULACBO
JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN 

OPEN POINT_CLB
DECLARE @Maclb VARCHAR(5), @Tenclb NVARCHAR(100), @Tensan NVARCHAR(100)
FETCH NEXT FROM POINT_CLB INTO @Maclb, @Tenclb, @Tensan 

WHILE @@FETCH_STATUS = 0
BEGIN 
    PRINT N'Mã câu lạc bộ ' + @Maclb 
    PRINT N'Tên câu lạc bộ ' + @Tenclb 
    PRINT N'Tên sân ' + @Tensan
    PRINT ''
    FETCH NEXT FROM POINT_CLB INTO @Maclb, @Tenclb, @Tensan
END

CLOSE POINT_CLB
DEALLOCATE POINT_CLB