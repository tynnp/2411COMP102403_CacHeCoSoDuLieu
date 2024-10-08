-- Truy van du lieu ------------------------------------------------------------------------------------------------------------------------
-- Cau 1 ------------------------------------------------------------------------------------------------------------------------
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI FROM CAUTHU
JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
WHERE CAULACBO.TENCLB = N'SHB Đà Nẵng' AND QUOCGIA.TENQG = N'Bra-xin'

-- Cau 2 ------------------------------------------------------------------------------------------------------------------------
SELECT HOTEN FROM CAUTHU
JOIN THAMGIA ON CAUTHU.MACT = THAMGIA.MACT
JOIN TRANDAU ON THAMGIA.MATD = TRANDAU.MATRAN
GROUP BY HOTEN HAVING SUM(SOTRAI) >= 2

-- Cau 3 ------------------------------------------------------------------------------------------------------------------------
SELECT MATRAN, NGAYTD, SANVD.TENSAN, CAULACBO1.TENCLB AS TENCLB1, CAULACBO2.TENCLB AS TENCLB2, KETQUA FROM TRANDAU
JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
JOIN CAULACBO AS CAULACBO1 ON TRANDAU.MACLB1 = CAULACBO1.MACLB
JOIN CAULACBO AS CAULACBO2 ON TRANDAU.MACLB2 = CAULACBO2.MACLB
WHERE NAM = 2009 AND VONG = 3

-- Cau 4 ------------------------------------------------------------------------------------------------------------------------
SELECT HUANLUYENVIEN.MAHLV, TENHLV, NGAYSINH, DIACHI, HLV_CLB.VAITRO, CAULACBO.TENCLB FROM HUANLUYENVIEN
JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
WHERE QUOCGIA.TENQG = N'Việt Nam'

-- Cau 5 ------------------------------------------------------------------------------------------------------------------------
SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI, COUNT(CAUTHU.MACT) AS CTNUOCNGOAI FROM CAULACBO
JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.MAQG <> 'VN'
GROUP BY CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI
HAVING COUNT(CAUTHU.MACT) > 2

-- Cau 6 ------------------------------------------------------------------------------------------------------------------------
SELECT TINH.TENTINH, COUNT(CAUTHU.MACT) AS SOLUONG FROM CAULACBO 
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.VITRI = N'Tiền Đạo' 
GROUP BY TINH.TENTINH 

-- Cau 7 ------------------------------------------------------------------------------------------------------------------------
SELECT CAULACBO.TENCLB, TINH.TENTINH FROM BANGXH
JOIN CAULACBO ON BANGXH.MACLB = CAULACBO.MACLB
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH

WHERE BANGXH.NAM = 2009 AND BANGXH.VONG = 3 AND BANGXH.HANG = (
	SELECT MIN(HANG) FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3
)

-- Cau 8 ------------------------------------------------------------------------------------------------------------------------
SELECT HUANLUYENVIEN.TENHLV FROM HUANLUYENVIEN
JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
WHERE HUANLUYENVIEN.DIENTHOAI IS NULL

-- Cau 9 ------------------------------------------------------------------------------------------------------------------------
SELECT HUANLUYENVIEN.TENHLV FROM HUANLUYENVIEN
LEFT JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
WHERE HUANLUYENVIEN.MAQG = 'VN' AND HLV_CLB.MACLB IS NULL

-- Cau 10 ------------------------------------------------------------------------------------------------------------------------
SELECT CAUTHU.HOTEN FROM CAUTHU 
JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
JOIN BANGXH ON CAULACBO.MACLB = BANGXH.MACLB
WHERE BANGXH.VONG = 3 AND BANGXH.NAM = 2009 AND (BANGXH.HANG > 6 OR BANGXH.HANG < 3)

-- Cau 11 ------------------------------------------------------------------------------------------------------------------------
DECLARE @TopClb VARCHAR(5)

SET @TopClb = (
	SELECT TOP 1 MACLB FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3
	ORDER BY HANG ASC
)

SELECT TRANDAU.NGAYTD, SANVD.TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, TRANDAU.KETQUA FROM TRANDAU
JOIN CAULACBO AS CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
JOIN CAULACBO AS CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN

WHERE TRANDAU.MACLB1 = @TopClb OR TRANDAU.MACLB2 = @TopClb AND TRANDAU.NAM = 2009 AND TRANDAU.VONG <= 3

-- Cau 12 ------------------------------------------------------------------------------------------------------------------------
SELECT NGAYTD, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA FROM TRANDAU
JOIN CAULACBO AS CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
JOIN CAULACBO AS CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
WHERE MONTH(NGAYTD) = 3 AND KETQUA LIKE '%-0'  

-- Cau 13 ------------------------------------------------------------------------------------------------------------------------
SELECT MACT, HOTEN, FORMAT(NGAYSINH, 'dd/MM/yyyy') AS NGAYSINH FROM CAUTHU
WHERE HOTEN LIKE N'% Công %'

-- Cau 14 ------------------------------------------------------------------------------------------------------------------------
SELECT MACT, HOTEN, FORMAT(NGAYSINH, 'dd/MM/yyyy') AS NGAYSINH FROM CAUTHU
WHERE HOTEN NOT LIKE N'Nguyễn %'

-- Cau 15 ------------------------------------------------------------------------------------------------------------------------
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI FROM HUANLUYENVIEN
JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
WHERE HUANLUYENVIEN.MAQG = 'VN' AND DATEDIFF(YEAR, NGAYSINH, GETDATE()) BETWEEN 35 AND 40

-- Cau 16 ------------------------------------------------------------------------------------------------------------------------
SELECT CAULACBO.TENCLB FROM HLV_CLB
JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
JOIN HUANLUYENVIEN ON HLV_CLB.MAHLV = HUANLUYENVIEN.MAHLV
WHERE VAITRO = N'HLV Chính' AND DAY(NGAYSINH) = 20 AND MONTH(NGAYSINH) = 5

-- Cau 17 ------------------------------------------------------------------------------------------------------------------------
SELECT TOP 1 CAULACBO.TENCLB, TINH.TENTINH FROM CAULACBO
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN (
	SELECT MACLB, SUM(THANG) AS TONGBANTHANG FROM BANGXH
	WHERE NAM = 2009 AND VONG <= 3
	GROUP BY MACLB
) TMP ON CAULACBO.MACLB = TMP.MACLB
ORDER BY TMP.TONGBANTHANG DESC 

-- Cau 18 ------------------------------------------------------------------------------------------------------------------------
SELECT CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI, COUNT(CAUTHU.MACT) AS SLCTNN FROM CAULACBO
JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
JOIN QUOCGIA ON CAUTHU.MAQG = QUOCGIA.MAQG
WHERE QUOCGIA.MAQG <> 'VN'
GROUP BY CAULACBO.MACLB, CAULACBO.TENCLB, SANVD.TENSAN, SANVD.DIACHI 
HAVING COUNT(CAUTHU.MACT) > 2

-- Cau 19 ------------------------------------------------------------------------------------------------------------------------
SELECT TOP 1 CAULACBO.TENCLB, TINH.TENTINH, (SUM(BANGXH.THANG) - SUM(BANGXH.THUA)) AS HIEUSO FROM CAULACBO
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN BANGXH ON CAULACBO.MACLB = BANGXH.MACLB
WHERE BANGXH.NAM = 2009
GROUP BY CAULACBO.TENCLB, TINH.TENTINH 
ORDER BY HIEUSO DESC

-- Cau 20 ------------------------------------------------------------------------------------------------------------------------
WITH THAPNHAT AS (
	SELECT TOP 1 MACLB FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3 
	ORDER BY HANG DESC 
) 

SELECT TRANDAU.NGAYTD, SANVD.TENSAN, CLB1.TENCLB, CLB2.TENCLB, TRANDAU.KETQUA FROM TRANDAU 
JOIN CAULACBO CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
JOIN CAULACBO CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
WHERE TRANDAU.MACLB1 = (SELECT MACLB FROM THAPNHAT) 
OR TRANDAU.MACLB2 = (SELECT MACLB FROM THAPNHAT)

-- Cau 21 ------------------------------------------------------------------------------------------------------------------------


-- Cau 22 ------------------------------------------------------------------------------------------------------------------------

