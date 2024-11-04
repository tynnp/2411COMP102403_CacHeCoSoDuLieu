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

-- Cau 60  ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa 
GO 

DECLARE POINT_DOIBONG CURSOR FOR 
SELECT CAULACBO.TENCLB, SLNN FROM CAULACBO LEFT JOIN (
    SELECT MACLB, COUNT(MACT) AS SLNN FROM CAUTHU 
    JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
    WHERE QUOCGIA.MAQG <> 'VN'
    GROUP BY CAUTHU.MACLB
) CAUTHUNN ON CAULACBO.MACLB = CAUTHUNN.MACLB
ORDER BY CAULACBO.TENCLB

OPEN POINT_DOIBONG
DECLARE @Tenclb NVARCHAR(100), @Slnn int 
FETCH NEXT FROM POINT_DOIBONG INTO @Tenclb, @Slnn 

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Tên câu lạc bộ ' + @Tenclb

    IF (@Slnn != 0)
        PRINT N'Số cầu thủ nước ngoài: ' + CAST(@Slnn AS VARCHAR)
    ELSE 
        PRINT N'Không có cầu thủ nước ngoài!'
    PRINT ''
    
    FETCH NEXT FROM POINT_DOIBONG INTO @Tenclb, @Slnn
END 

CLOSE POINT_DOIBONG
DEALLOCATE POINT_DOIBONG

-- Cau 61  ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

DECLARE POINT_DOIBONG CURSOR FOR
SELECT CAULACBO.TENCLB, SLNB FROM CAULACBO LEFT JOIN (
    SELECT HLV_CLB.MACLB, COUNT(HLV_CLB.MAHLV) SLNB FROM HUANLUYENVIEN 
    JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
    WHERE MAQG IN (
        SELECT MAQG FROM QUOCGIA 
        WHERE MAQG <> 'VN'
    )
    GROUP BY HLV_CLB.MACLB
) CT ON CAULACBO.MACLB = CT.MACLB
GROUP BY TENCLB, SLNB

OPEN POINT_DOIBONG
DECLARE @clb NVARCHAR(50), @hlvnn int 

FETCH NEXT FROM POINT_DOIBONG INTO @clb, @hlvnn
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Tên đội: ' + @clb 
    IF (@hlvnn != 0)
        BEGIN 
            PRINT N'Số huấn luyện viên nước ngoài: ' + CAST(@hlvnn AS VARCHAR(50))
        END 
    ELSE
        BEGIN
            PRINT N'Không có'
        END
    FETCH NEXT FROM POINT_DOIBONG INTO @clb, @hlvnn
END

CLOSE POINT_DOIBONG
DEALLOCATE POINT_DOIBONG