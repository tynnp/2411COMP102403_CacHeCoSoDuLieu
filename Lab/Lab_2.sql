-- Cau 35
CREATE PROCEDURE XINCHAO(@Ten NVARCHAR(MAX)) AS
BEGIN 
    PRINT N'Xin chào ' + @Ten
END

GO 
XINCHAO N'Nguyễn Ngọc Phú Tỷ'

-- Cau 36
CREATE PROCEDURE TONG(@s1 int, @s2 int) AS
BEGIN 
    DECLARE @tg int 
    SET @tg = @s1 + @s2
    PRINT N'Tổng là: ' + CAST(@tg AS NVARCHAR)
END 

GO 
TONG 2, 3

-- Cau 37
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

-- Cau 38
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

-- Cau 39
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

-- Cau 40
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

-- Cau 41
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

-- Cau 42
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

-- Cau 43


-- Cau 44


-- Cau 45 


-- Cau 46


-- Cau 47


-- Cau 48
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

-- Cau 49
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

-- Cau 50
CREATE TRIGGER TG_THEMMOI ON CAUTHU FOR INSERT AS
BEGIN 
    PRINT N'Đã thêm cầu thủ mới!'
END

-- Cau 51
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

-- CAU 52
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


-- Cau 53
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

-- Cau 54
CREATE TRIGGER TG_THAYDOIKQ ON TRANDAU FOR UPDATE AS
BEGIN 
    IF UPDATE(KETQUA)
        BEGIN 
            RAISERROR (N'Không được đổi kết quả!', 15, 1)
            ROLLBACK TRAN
            RETURN 
        END 
END

-- Cau 55.a
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

-- Cau 55.b
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

-- Cau 56.a
CREATE TRIGGER TG_THEMCLB ON CAULACBO FOR INSERT AS
BEGIN 
    DECLARE @Tenclb NVARCHAR(100)
    SELECT @Tenclb = TENCLB FROM INSERTED

    IF ((SELECT COUNT(*) FROM CAULACBO WHERE TENCLB = @Tenclb) > 1)
        BEGIN
            RAISERROR(N'Trùng tên với CLB khác!', 15, 1)
        END
END

-- Cau 56.b
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

-- Cau 57.a
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT MACT FROM INSERTED
        END
END 

-- Cau 57.b
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT MACT, HOTEN AS TENMOI FROM INSERTED
        END
END 

-- Cau 57.c
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT INSERTED.MACT, DELETED.HOTEN AS TENCU FROM INSERTED
            JOIN DELETED ON INSERTED.MACT = DELETED.MACT
        END
END 

-- Cau 57.d
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            SELECT INSERTED.MACT, DELETED.HOTEN AS TENCU, INSERTED.HOTEN AS TENMOI FROM INSERTED
            JOIN DELETED ON INSERTED.MACT = DELETED.MACT
        END
END 

-- Cau 57.e
CREATE TRIGGER TG_SUACAUTHU ON CAUTHU AFTER UPDATE AS
BEGIN 
    IF UPDATE(HOTEN)
        BEGIN 
            DECLARE @Thongbao NVARCHAR(MAX)
            SELECT @Thongbao = COALESCE(@ThongBao + CHAR(13), '') + N'Vừa sửa thông tin của cầu thủ có mã số ' + CAST(MACT AS NVARCHAR) FROM INSERTED
            PRINT @ThongBao
        END
END