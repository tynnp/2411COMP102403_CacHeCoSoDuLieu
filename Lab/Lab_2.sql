-- Cau 23 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE RULE R_VITRI AS
@Vitri IN (N'Thủ Môn', N'Tiền Đạo', N'Tiền Vệ', N'Trung Vệ', N'Hậu Vệ')

GO 
SP_BINDRULE 'R_VITRI', 'CAUTHU.VITRI'

-- Cau 24 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE RULE R_VAITRO AS
@Vaitro IN (N'HLV Chính', N'HLV Phụ', N'HLV Thể Lực', N'HLV Thủ Môn')

GO
SP_BINDRULE 'R_VAITRO', 'HLV_CLB.VAITRO'

-- Cau 25 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE RULE R_TUOICT AS
YEAR(GETDATE()) - YEAR(@Tuoi) >= 18

GO 
SP_BINDRULE 'R_TUOICT', 'CAUTHU.NGAYSINH'

-- Cau 26 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE RULE R_SOTRAI AS
@Sotrai > 0

GO
SP_BINDRULE 'R_SOTRAI', 'THAMGIA.SOTRAI'

-- Cau 27 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE VIEW V_SHB_BRAXIN AS 
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI FROM CAUTHU
JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
WHERE CAULACBO.TENCLB = N'SHB Đà Nẵng' AND QUOCGIA.TENQG = N'Bra-xin'

GO
SELECT * FROM V_SHB_BRAXIN

-- Cau 28 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE VIEW V_NAM2009_VONG3 AS
SELECT MATRAN, NGAYTD, SANVD.TENSAN, CAULACBO1.TENCLB AS TENCLB1, CAULACBO2.TENCLB AS TENCLB2, KETQUA FROM TRANDAU
JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
JOIN CAULACBO AS CAULACBO1 ON TRANDAU.MACLB1 = CAULACBO1.MACLB
JOIN CAULACBO AS CAULACBO2 ON TRANDAU.MACLB2 = CAULACBO2.MACLB
WHERE NAM = 2009 AND VONG = 3

GO 
SELECT * FROM V_NAM2009_VONG3

-- Cau 29 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE VIEW V_HLVVN AS
SELECT HUANLUYENVIEN.MAHLV, TENHLV, NGAYSINH, DIACHI, HLV_CLB.VAITRO, CAULACBO.TENCLB FROM HUANLUYENVIEN
JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
WHERE QUOCGIA.TENQG = N'Việt Nam'

GO
SELECT * FROM V_HLVVN

-- Cau 30 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE VIEW V_CTNN AS
SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI, COUNT(CAUTHU.MACT) AS CTNUOCNGOAI FROM CAULACBO
JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.MAQG <> 'VN'
GROUP BY CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI
HAVING COUNT(CAUTHU.MACT) > 2

GO
SELECT * FROM V_CTNN

-- Cau 31 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE VIEW V_TIENDAO AS 
SELECT TINH.TENTINH, COUNT(CAUTHU.MACT) AS SOLUONG FROM CAULACBO 
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.VITRI = N'Tiền Đạo' 
GROUP BY TINH.TENTINH 

GO 
SELECT * FROM V_TIENDAO

-- Cau 32 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE VIEW V_VTCAONHATVONG3NAM2009 AS
SELECT CAULACBO.TENCLB, TINH.TENTINH FROM BANGXH
JOIN CAULACBO ON BANGXH.MACLB = CAULACBO.MACLB
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH

WHERE BANGXH.NAM = 2009 AND BANGXH.VONG = 3 AND BANGXH.HANG = (
	SELECT MIN(HANG) FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3
)

GO
SELECT * FROM V_VTCAONHATVONG3NAM2009

-- Cau 33 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE VIEW V_CHUACOSDT AS 
SELECT HUANLUYENVIEN.TENHLV FROM HUANLUYENVIEN
JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
WHERE HUANLUYENVIEN.DIENTHOAI IS NULL

GO 
SELECT * FROM V_CHUACOSDT

-- Cau 34 ------------------------------------------------------------------------------------------------------------------------
-- NO QUERY

-- Cau 35 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE XINCHAO(@Ten NVARCHAR(MAX)) AS
BEGIN 
    PRINT N'Xin chào ' + @Ten
END

GO 
XINCHAO N'Nguyễn Ngọc Phú Tỷ'

-- Cau 36 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE TONG(@s1 int, @s2 int) AS
BEGIN 
    DECLARE @tg int 
    SET @tg = @s1 + @s2
    PRINT N'Tổng là: ' + CAST(@tg AS NVARCHAR)
END 

GO 
TONG 2, 3

-- Cau 37 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE TONG(@s1 int, @s2 int, @tong int output) AS
BEGIN
    SET @tong = @s1 + @s2
    RETURN @tong 
END 

GO 
DECLARE @tong int 
SET @tong = 0
EXECUTE TONG 2, 3, @tong out
SELECT @tong AS TONG2SO

-- Cau 38 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SOLONNHAT(@s1 int, @s2 int) AS
BEGIN 
    DECLARE @max int 

    IF @s1 > @s2 
        SET @max = @s1
    ELSE 
        SET @max = @s2

    PRINT N'Số lớn nhất của ' + CAST(@s1 AS NVARCHAR) + N' và ' + CAST(@s2 AS NVARCHAR) + N' là ' + CAST(@max AS NVARCHAR)
END 

GO 
SOLONNHAT 2, 3

-- Cau 39 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE MINVAMAX(@s1 int, @s2 int, @max int output, @min int output) AS 
BEGIN 
    IF @s1 > @s2 SELECT @max = @s1, @min = @s2
    ELSE SELECT @max = @s2, @min = @s1
    RETURN 
END 

GO 
DECLARE @max int, @min int 
SELECT @max = 0, @min = 0s
EXECUTE MINVAMAX 2, 3, @max out, @min out 
SELECT @max AS SOLON, @min AS SONHO

-- Cau 40 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE TU_1_DEN_N (@n int) AS
BEGIN 
    DECLARE @i int, @out VARCHAR(MAX)
    SELECT @i = 1, @out = ''

    WHILE (@i <= @n) 
        BEGIN 
            SELECT @out = @out + CAST(@i AS VARCHAR) + ' ',
            @i = @i + 1
        END 

    PRINT @out
END

GO 
EXECUTE TU_1_DEN_N 5

-- Cau 41 ------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE TONG_VA_SLSOCHAN(@n int) AS 
BEGIN 
    DECLARE @cnt int, @sum int, @i int 
    SELECT @cnt = 0, @sum = 0, @i = 1

    WHILE (@i <= @n) 
        BEGIN 
            SELECT @sum = @sum + @i
            IF @i % 2 = 0 SET @cnt = @cnt + 1
            SET @i = @i + 1
        END 

    PRINT N'Tổng: ' + CAST (@sum AS VARCHAR)
    PRINT N'Số lượng số chẵn: ' + CAST(@cnt AS VARCHAR)
END 

GO 
EXECUTE TONG_VA_SLSOCHAN 10

-- Cau 42 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE SOTRANHOA AS
BEGIN 
    DECLARE @s int
    SELECT @s = COUNT(*) FROM TRANDAU

    WHERE VONG = 3 AND NAM = 2009 
    AND LEFT(KETQUA, CHARINDEX('-', KETQUA) - 1) = RIGHT(KETQUA, LEN(KETQUA) - CHARINDEX('-', KETQUA))

    PRINT N'Số trận hòa ở vòng 3 năm 2009 là ' + CAST(@s AS VARCHAR)
END

GO 
EXECUTE SOTRANHOA

-- Cau 43.27 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE SHB_BRAXIN AS 
BEGIN 
    SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI FROM CAUTHU
    JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
    JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
    WHERE CAULACBO.TENCLB = N'SHB Đà Nẵng' AND QUOCGIA.TENQG = N'Bra-xin'
    RETURN
END 

GO
EXECUTE SHB_BRAXIN

-- Cau 43.28 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE NAM2009_VONG3 AS
BEGIN 
    SELECT MATRAN, NGAYTD, SANVD.TENSAN, CAULACBO1.TENCLB AS TENCLB1, CAULACBO2.TENCLB AS TENCLB2, KETQUA FROM TRANDAU
    JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
    JOIN CAULACBO AS CAULACBO1 ON TRANDAU.MACLB1 = CAULACBO1.MACLB
    JOIN CAULACBO AS CAULACBO2 ON TRANDAU.MACLB2 = CAULACBO2.MACLB
    WHERE NAM = 2009 AND VONG = 3
    RETURN 
END 

GO
EXECUTE NAM2009_VONG3

-- Cau 43.29 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE HLVVN AS 
BEGIN 
    SELECT HUANLUYENVIEN.MAHLV, TENHLV, NGAYSINH, DIACHI, HLV_CLB.VAITRO, CAULACBO.TENCLB FROM HUANLUYENVIEN
    JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
    JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
    JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
    WHERE QUOCGIA.TENQG = N'Việt Nam'
END 

GO
EXECUTE HLVVN

-- Cau 43.30 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE CTNN AS
BEGIN 
    SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI, COUNT(CAUTHU.MACT) AS CTNUOCNGOAI FROM CAULACBO
    JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN
    JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
    WHERE CAUTHU.MAQG <> 'VN'
    GROUP BY CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI
    HAVING COUNT(CAUTHU.MACT) > 2
END

GO
EXECUTE CTNN 

-- Cau 43.31 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE TIENDAO AS
BEGIN 
    SELECT TINH.TENTINH, COUNT(CAUTHU.MACT) AS SOLUONG FROM CAULACBO 
    JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
    JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
    WHERE CAUTHU.VITRI = N'Tiền Đạo' 
    GROUP BY TINH.TENTINH 
END 

GO 
EXECUTE TIENDAO

-- Cau 43.32 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE VTCAONHATVONG3NAM2009 AS
BEGIN 
    SELECT CAULACBO.TENCLB, TINH.TENTINH FROM BANGXH
    JOIN CAULACBO ON BANGXH.MACLB = CAULACBO.MACLB
    JOIN TINH ON CAULACBO.MATINH = TINH.MATINH

    WHERE BANGXH.NAM = 2009 AND BANGXH.VONG = 3 AND BANGXH.HANG = (
        SELECT MIN(HANG) FROM BANGXH
        WHERE NAM = 2009 AND VONG = 3
    )
END 

GO 
EXECUTE VTCAONHATVONG3NAM2009

-- Cau 43.33 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE CHUACOSDT AS
BEGIN 
    SELECT HUANLUYENVIEN.TENHLV FROM HUANLUYENVIEN
    JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
    WHERE HUANLUYENVIEN.DIENTHOAI IS NULL
END 

GO 
EXECUTE CHUACOSDT

-- Cau 44.42 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE SOTRANHOA (@vong int, @nam int) AS 
BEGIN 
    DECLARE @cnt int 
    SELECT @cnt = COUNT(*) FROM TRANDAU

    WHERE VONG = @vong AND NAM = @nam 
    AND LEFT(KETQUA, CHARINDEX('-', KETQUA) - 1) = RIGHT(KETQUA, LEN(KETQUA) -CHARINDEX('-', KETQUA))

    PRINT N'Số trận hòa ở vòng ' + CAST(@vong AS VARCHAR) + N' năm ' + CAST(@nam AS VARCHAR) + N' là ' + CAST(@cnt AS VARCHAR)
END 

GO
EXECUTE SOTRANHOA 3, 2009

-- Cau 44.27 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa 
GO 

CREATE PROCEDURE CLB_QG (@Tenclb NVARCHAR(50), @Tenqg NVARCHAR(50)) AS 
BEGIN 
    SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI FROM CAUTHU 
    JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
    JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
    WHERE CAULACBO.TENCLB = @Tenclb AND QUOCGIA.TENQG = @Tenqg
END 

GO 
EXECUTE CLB_QG N'SHB Đà Nẵng', N'Bra-xin'

-- Cau 44.28 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE TDVONGNAM (@vong int, @nam int) AS
BEGIN 
    SELECT MATRAN, NGAYTD, SANVD.TENSAN, CAULACBO1.TENCLB AS TENCLB1, CAULACBO2.TENCLB AS TENCLB2, KETQUA FROM TRANDAU
    JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
    JOIN CAULACBO AS CAULACBO1 ON TRANDAU.MACLB1 = CAULACBO1.MACLB
    JOIN CAULACBO AS CAULACBO2 ON TRANDAU.MACLB2 = CAULACBO2.MACLB
    WHERE VONG = @vong AND NAM = @nam 
END 

GO 
EXECUTE TDVONGNAM 3, 2009

-- Cau 44.29 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO 

CREATE PROCEDURE HLVVN (@Tenqg NVARCHAR(50)) AS
BEGIN   
    SELECT HUANLUYENVIEN.MAHLV, TENHLV, DIACHI, HLV_CLB.VAITRO, CAULACBO.TENCLB FROM HUANLUYENVIEN
    JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
    JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
    JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG 
    WHERE QUOCGIA.TENQG = @Tenqg
END     

GO 
EXECUTE HLVVN N'Việt Nam'

-- Cau 44.30 ------------------------------------------------------------------------------------------------------------------------
USE QLBongDa
GO

CREATE PROCEDURE CTNN ()

-- Cau 44.31 ------------------------------------------------------------------------------------------------------------------------


-- Cau 44.32 ------------------------------------------------------------------------------------------------------------------------


-- Cau 45  ------------------------------------------------------------------------------------------------------------------------


-- Cau 46 ------------------------------------------------------------------------------------------------------------------------


-- Cau 47 ------------------------------------------------------------------------------------------------------------------------


-- Cau 48 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_VTCAUTHU ON CAUTHU FOR INSERT AS
BEGIN 
    DECLARE @Vitri NVARCHAR(20)
    SELECT @Vitri = VITRI FROM INSERTED
    
    IF @Vitri NOT IN (N'Thủ Môn', N'Tiền Đạo', N'Tiền Vệ', N'Trung Vệ', N'Hậu Vệ')
    BEGIN
        RAISERROR (N'Vị trí không hợp lệ!', 15, 1);
        ROLLBACK TRAN
        RETURN 
    END
END

-- Cau 49 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SOAO ON CAUTHU FOR INSERT AS
BEGIN
    DECLARE @So int, @Maclb VARCHAR(5)
    SELECT @So = SO, @Maclb = MACLB FROM INSERTED

    IF ((COUNT(*) FROM CAUTHU WHERE SO = @So AND MACLB = @Maclb) > 1)
        BEGIN
            RAISERROR (N'Số áo bị trùng!', 15, 1)
            ROLLBACK TRAN 
            RETURN 
        END
END 

-- Cau 50 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THEMMOI ON CAUTHU FOR INSERT AS
BEGIN 
    PRINT N'Đã thêm cầu thủ mới!'
END

-- Cau 51 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_CAUTHUNG ON CAUTHU FOR INSERT AS
BEGIN 
    DECLARE @Maclb VARCHAR(5), @Maqg VARCHAR(5)
    SELECT @Maclb = MACLB, @Maqg = MAQG FROM INSERTED

    IF ((SELECT COUNT(*) FROM CAUTHU WHERE @Maclb = MACLB AND MAQG <> 'VN') > 8 AND @Maqg <> 'VN')
        BEGIN 
            RAISERROR (N'Số cầu thủ nước ngoài đã đạt tối đa!', 15, 1)
            ROLLBACK TRAN
            RETURN
        END
END

-- CAU 52 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THEMQG ON QUOCGIA FOR INSERT AS
BEGIN 
    DECLARE @Tenqg NVARCHAR(60)
    SELECT @Tenqg = TENQG FROM INSERTED

    IF ((SELECT COUNT(*) FROM QUOCGIA WHERE @Tenqg = TENQG) > 1)
        BEGIN 
            RAISERROR (N'Tên quốc gia đã tồn tại!', 15, 1)
            ROLLBACK TRAN 
            RETURN
        END 
END 


-- Cau 53 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THEMTINH ON TINH FOR INSERT AS
BEGIN 
    DECLARE @Tentinh NVARCHAR(100)
    SELECT @Tentinh = TENTINH FROM INSERTED

    IF ((SELECT COUNT(*) FROM TINH WHERE @Tentinh = TENTINH) > 1)
        BEGIN
            RAISERROR (N'Tên tỉnh đã tồn tại!', 15, 1)
            ROLLBACK TRAN
            RETURN 
        END 
END 

-- Cau 54 ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THAYDOIKQ ON TRANDAU FOR UPDATE AS
BEGIN 
    IF UPDATE(KETQUA)
        BEGIN 
            RAISERROR (N'Không được đổi kết quả!', 15, 1)
            ROLLBACK TRAN
            RETURN 
        END 
END

-- Cau 55.a ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_VAITROHLV ON HLV_CLB FOR INSERT AS
BEGIN 
    DECLARE @Vaitro NVARCHAR(100) 
    SELECT @Vaitro = VAITRO FROM INSERTED

    IF @Vaitro NOT IN (N'HLV Chính', N'HLV Phụ', N'HLV Thể lực', N'HLV Thủ Môn')
        BEGIN 
            RAISERROR(N'Vai trò không hợp lệ!', 15, 1)
            ROLLBACK TRAN
            RETURN
        END 
END 

-- Cau 55.b ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SLHLVCHINH ON HLV_CLB FOR INSERT AS
BEGIN
    DECLARE @Vaitro NVARCHAR(100), @Maclb VARCHAR(5)
    SELECT @Vaitro = VAITRO, @Maclb = MACLB FROM INSERTED

    IF ((SELECT COUNT(*) FROM HLV_CLB WHERE VAITRO = N'HLV Chính' AND MACLB = @Maclb) > 2 AND @Vaitro = N'HLV Chính')
        BEGIN 
            RAISERROR(N'Số lượng HLV Chính đã đạt giới hạn!', 15, 1)
            ROLLBACK TRAN 
            RETURN 
        END
END

-- Cau 56.a ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THEMCLB ON CAULACBO FOR INSERT AS
BEGIN 
    DECLARE @Tenclb NVARCHAR(100)
    SELECT @Tenclb = TENCLB FROM INSERTED

    IF ((SELECT COUNT(*) FROM CAULACBO WHERE TENCLB = @Tenclb) > 1)
        BEGIN
            RAISERROR(N'Trùng tên với CLB khác!', 15, 1)
        END
END

-- Cau 56.b ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_THEMCLB ON CAULACBO FOR INSERT AS
BEGIN 
    DECLARE @Tenclb NVARCHAR(100)
    SELECT @Tenclb = TENCLB FROM INSERTED

    IF ((SELECT COUNT(*) FROM CAULACBO WHERE TENCLB = @Tenclb) > 1)
        BEGIN 
            RAISERROR(N'Trùng tên với CLB khác!', 15, 1)
            ROLLBACK TRAN 
            RETURN
        END
END

-- Cau 57.a ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT MACT FROM INSERTED
        END
END 

-- Cau 57.b ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT MACT, HOTEN AS TENMOI FROM INSERTED
        END
END 

-- Cau 57.c ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT INSERTED.MACT, DELETED.HOTEN AS TENCU FROM INSERTED
            JOIN DELETED ON INSERTED.MACT = DELETED.MACT
        END
END 

-- Cau 57.d ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT INSERTED.MACT, DELETED.HOTEN AS TENCU, INSERTED.HOTEN AS TENMOI FROM INSERTED
            JOIN DELETED ON INSERTED.MACT = DELETED.MACT
        END
END 

-- Cau 57.e ------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            DECLARE @Thongbao NVARCHAR(MAX)
            SELECT @Thongbao = COALESCE(@ThongBao + CHAR(13), '') + N'Vừa sửa thông tin của cầu thủ có mã số ' + CAST(MACT AS NVARCHAR) FROM INSERTED
            PRINT @ThongBao
        END
END