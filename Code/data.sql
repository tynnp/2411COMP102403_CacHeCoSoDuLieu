USE MASTER
GO

-- Tao co so du lieu
CREATE DATABASE QLBongDa
GO

-- Tao bang
USE QLBongDa
GO

CREATE TABLE QUOCGIA (
	MAQG VARCHAR(5), 
	TENQG NVARCHAR(60) NOT NULL,
	CONSTRAINT PK_QUOCGIA PRIMARY KEY (MAQG)
)
GO

CREATE TABLE TINH (
	MATINH VARCHAR(5),
	TENTINH NVARCHAR(100) NOT NULL, 
	CONSTRAINT PK_TINH PRIMARY KEY (MATINH)
)
GO

CREATE TABLE SANVD (
	MASAN VARCHAR(5), 
	TENSAN NVARCHAR(100) NOT NULL, 
	DIACHI NVARCHAR(100), 
	CONSTRAINT PK_SANVD PRIMARY KEY (MASAN)
)
GO

CREATE TABLE HUANLUYENVIEN (
	MAHLV VARCHAR(5), 
	TENHLV NVARCHAR(100) NOT NULL, 
	NGAYSINH DATETIME, 
	DIACHI NVARCHAR(100), 
	DIENTHOAI NVARCHAR(20), 
	MAQG VARCHAR(5) NOT NULL, 
	CONSTRAINT PK_HLV PRIMARY KEY (MAHLV), 
	CONSTRAINT FK_HLV FOREIGN KEY (MAQG) REFERENCES QUOCGIA(MAQG)
)
GO

CREATE TABLE CAULACBO (
	MACLB VARCHAR(5), 
	TENCLB NVARCHAR(100), 
	MASAN VARCHAR(5), 
	MATINH VARCHAR(5), 
	CONSTRAINT PK_CAULACBO PRIMARY KEY (MACLB),
	CONSTRAINT FK_CAULACBO_MASAN FOREIGN KEY (MASAN) REFERENCES SANVD(MASAN),
	CONSTRAINT FK_CAULACBO_MATINH FOREIGN KEY (MATINH) REFERENCES TINH(MATINH)
)
GO 

CREATE TABLE HLV_CLB (
	MAHLV VARCHAR(5),
	MACLB VARCHAR(5),
	VAITRO NVARCHAR(100),
	CONSTRAINT PK_HLVCLB PRIMARY KEY (MAHLV, MACLB),
	CONSTRAINT FK_HLVCLB_MAHLV FOREIGN KEY (MAHLV) REFERENCES HUANLUYENVIEN(MAHLV),
	CONSTRAINT FK_HLVCLB_CLB FOREIGN KEY (MACLB) REFERENCES CAULACBO(MACLB)
)
GO

CREATE TABLE CAUTHU (
	MACT NUMERIC IDENTITY, 
	HOTEN NVARCHAR(100) NOT NULL, 
	VITRI NVARCHAR(50) NOT NULL, 
	NGAYSINH DATETIME, 
	DIACHI NVARCHAR(200), 
	MACLB VARCHAR(5) NOT NULL, 
	MAQG VARCHAR(5) NOT NULL, 
	SO INT NOT NULL, 
	CONSTRAINT PK_CAUTHU PRIMARY KEY (MACT),
	CONSTRAINT FK_CAUTHU_HLV FOREIGN KEY (MACLB) REFERENCES CAULACBO(MACLB),
	CONSTRAINT FK_CAUTHU_QUOCGIA FOREIGN KEY (MAQG) REFERENCES QUOCGIA(MAQG)
)
GO

CREATE TABLE TRANDAU (
	MATRAN NUMERIC IDENTITY,
	NAM INT NOT NULL, 
	VONG INT NOT NULL, 
	NGAYTD DATETIME NOT NULL, 
	MACLB1 VARCHAR(5) NOT NULL, 
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL,
	CONSTRAINT PK_TRANDAU PRIMARY KEY (MATRAN), 
	CONSTRAINT FK_TRANDAU_MACLB1 FOREIGN KEY (MACLB1) REFERENCES CAULACBO(MACLB), 
	CONSTRAINT FK_TRANDAU_MACLB2 FOREIGN KEY (MACLB2) REFERENCES CAULACBO(MACLB),
	CONSTRAINT FK_TRANDAU_MASAN FOREIGN KEY (MASAN) REFERENCES SANVD(MASAN)
)
GO

CREATE TABLE THAMGIA (
	MATD NUMERIC, 
	MACT NUMERIC, 
	SOTRAI INT,
	CONSTRAINT PK_THAMGIA PRIMARY KEY (MATD, MACT),
	CONSTRAINT FK_THAMGIA_MATD FOREIGN KEY (MATD) REFERENCES TRANDAU(MATRAN),
	CONSTRAINT FK_THAMGIA_MACT FOREIGN KEY (MACT) REFERENCES CAUTHU(MACT)
)
GO

CREATE TABLE BANGXH (
	MACLB VARCHAR(5), 
	NAM INT, 
	VONG INT,
	SOTRAI INT NOT NULL,
	THANG INT NOT NULL,
	HOA INT NOT NULL,
	THUA INT NOT NULL,
	HIEUSO VARCHAR(5) NOT NULL, 
	DIEM INT NOT NULL,
	HANG INT NOT NULL,
	CONSTRAINT PK_BANGXH PRIMARY KEY (MACLB, NAM, VONG),
	CONSTRAINT FK_BANGXH FOREIGN KEY (MACLB) REFERENCES CAULACBO(MACLB)
)
GO

-- Them du lieu
INSERT INTO QUOCGIA VALUES 
	('ANH', N'Anh Quốc'),
	('BDN', N'Bồ Đào Nha'),
	('BRA', N'Bra-xin'),
	('HQ', N'Hàn Quốc'),
	('ITA', N'Ý'),
	('TBN', N'Tây Ban Nha'),
	('THA', N'Thái Lan'),
	('THAI', N'Thái Lan'),
	('VN', N'Việt Nam')

INSERT INTO TINH VALUES
	('BD', N'Bình Dương'),
	('DN', N'Đà Nẵng'),
	('DT', N'Đồng Tháp'),
	('GL', N'Gia Lai'),
	('HN', N'Hà Nội'),
	('HP', N'Hải Phòng'),
	('KH', N'Khánh Hòa'),
	('LA', N'Long An'),
	('NA', N'Nghệ An'),
	('NB', N'Ninh Bình'),
	('PY', N'Phú Yên'),
	('SG', N'Sài Gòn'),
	('TH', N'Thanh Hóa')

INSERT INTO SANVD VALUES 
	('CL', N'Chi Lăng', N'127 Võ Văn Tần, Đà Nẵng'),
	('CLDT', N'Cao Lãnh', N'134 TX Cao Lãnh, Đồng Tháp'),
	('GD', N'Gò Đậu', N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
	('HD', N'Hàng Đẫy', N'345 Lý Chiêu Hoàng, Bạch Mai, Hà Nội'),
	('LA', N'Long An', N'102 Hùng Vương, Tp Tân An, Long An'),
	('NT', N'Nha Trang', N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
	('PL', N'Pleiku', N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
	('TH', N'Tuy Hòa', N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
	('TN', N'Thống Nhất', N'123 Lý Thường Kiệt, Quận 5, TpHCM')

INSERT INTO HUANLUYENVIEN VALUES 
	('HLV01', N'Vital', '1955-10-15', NULL, '0918011075', 'BDN'),
	('HLV02', N'Lê Huỳnh Đức', '1972-5-20', NULL, '01223456789', 'VN'),
	('HLV03', N'Kiatisuk', '1970-12-11', NULL, '0199123456', 'THA'),
	('HLV04', N'Hoàng Anh Tuấn', '1970-6-10', NULL, '0989112233', 'VN'),
	('HLV05', N'Trần Công Minh', '1973-7-7', NULL, '0909099990', 'VN'),
	('HLV06', N'Trần Văn Phúc', '1965-3-2', NULL, '01650101234', 'VN'),
	('HLV07', N'Yoon-Hwan-Cho', '1960-2-2', NULL, NULL, 'HQ'),
	('HLV08', N'Yun-Kyum-Choi', '1962-3-3', NULL, NULL, 'HQ')

INSERT INTO CAULACBO VALUES
    ('BBD', N'BECAMEX BÌNH DƯƠNG', 'GD', 'BD'),
    ('CSDT', N'TẬP ĐOÀN CAO SU ĐỒNG THÁP', 'CLDT', 'DT'),
    ('GDT', N'GẠCH ĐỒNG TÂM LONG AN', 'LA', 'LA'),
    ('HAGL', N'HOÀNG ANH GIA LAI', 'PL', 'GL'),
    ('KKH', N'KHATOCO KHÁNH HÒA', 'NT', 'KH'),
    ('SDN', N'SHB ĐÀ NẴNG', 'CL', 'DN'),
    ('TPY', N'THÉP PHÚ YÊN', 'TH', 'PY')

INSERT INTO HLV_CLB VALUES
    ('HLV01', 'GDT', N'HLV Chính'), 
    ('HLV02', 'SDN', N'HLV Chính'), 
    ('HLV03', 'HAGL', N'HLV Chính'), 
    ('HLV04', 'KKH', N'HLV Chính'), 
    ('HLV05', 'TPY', N'HLV Chính'), 
    ('HLV06', 'CSDT', N'HLV Chính'), 
    ('HLV07', 'BBD', N'HLV Chính'), 
    ('HLV08', 'BBD', N'HLV Thủ Môn')

INSERT INTO CAUTHU(HOTEN, VITRI, NGAYSINH, MACLB, MAQG, SO) VALUES
    (N'Nguyễn Vũ Phong', N'Tiền Vệ', '2016-10-23', 'BBD', 'VN', 17), 
    (N'Nguyễn Công Vinh', N'Tiền Đạo', '2016-10-23', 'HAGL', 'VN', 9), 
    (N'Nguyễn Hồng Sơn', N'Tiền Vệ', '2016-10-23', 'SDN', 'VN', 9), 
    (N'Lê Tấn Tài', N'Tiền Vệ', '2016-10-23', 'KKH', 'VN', 14), 
    (N'Phạm Hồng Sơn', N'Thủ Môn', '2016-10-23', 'HAGL', 'VN', 1), 
    (N'Ronaldo', N'Tiền Vệ', '2016-10-23', 'SDN', 'BRA', 7), 
    (N'Ronaldo', N'Tiền Vệ', '2016-10-23', 'SDN', 'BRA', 8), 
    (N'Vidic', N'Tiền Vệ', '2016-10-23', 'HAGL', 'ANH', 3), 
    (N'Trần Văn Santos', N'Thủ Môn', '2016-10-23', 'BBD', 'BRA', 1), 
    (N'Nguyễn Trường Sơn', N'Hậu Vệ', '2016-10-23', 'BBD', 'VN', 4), 
    (N'Lê Huỳnh Đức', N'Tiền Đạo', '2016-10-23', 'BBD', 'VN', 10), 
    (N'Huỳnh Hồng Sơn', N'Tiền Vệ', '2016-10-23', 'BBD', 'VN', 9), 
    (N'Lee Nguyễn', N'Tiền Đạo', '2016-10-23', 'BBD', 'VN', 14), 
    (N'Bùi Tấn Trường', N'Thủ Môn', '2016-10-23', 'CSDT', 'VN', 1), 
    (N'Phan Văn Tài Em', N'Tiền Vệ', '2016-10-23', 'GDT', 'VN', 10), 
    (N'Lý Tiểu Long', N'Tiền Vệ', '2016-10-23', 'TPY', 'VN', 7)

INSERT INTO TRANDAU(NAM, VONG, NGAYTD, MACLB1, MACLB2, MASAN, KETQUA) VALUES
    (2009, 1, '2009-02-07', 'BBD', 'SDN', 'GD', '3-0'), 
    (2009, 1, '2009-02-07', 'KKH', 'GDT', 'NT', '1-1'), 
    (2009, 2, '2009-02-16', 'SDN', 'KKH', 'CL', '2-2'), 
    (2009, 2, '2009-02-16', 'TPY', 'BBD', 'TH', '5-0'), 
    (2009, 3, '2009-03-01', 'TPY', 'GDT', 'TH', '0-2'), 
    (2009, 3, '2009-03-01', 'KKH', 'BBD', 'NT', '0-1'), 
    (2009, 4, '2009-03-07', 'KKH', 'TPY', 'NT', '1-0'), 
    (2009, 4, '2009-03-07', 'BBD', 'GDT', 'GD', '2-2')

INSERT INTO THAMGIA VALUES
    ('1', '1', '2'), 
    ('1', '11', '1'), 
    ('2', '4', '1'), 
    ('2', '16', '1'), 
    ('3', '3', '1'), 
    ('3', '4', '2'), 
    ('3', '7', '1'), 
    ('4', '15', '5'), 
    ('5', '16', '2'), 
    ('6', '13', '1'), 
    ('7', '4', '1'), 
    ('8', '12', '2'), 
    ('8', '16', '2')

INSERT INTO BANGXH VALUES 
    ('BBD', '2009', '1', '1', '1', '0', '0', '3-0', '3', '1'), 
    ('KKH', '2009', '1', '1', '0', '1', '0', '1-1', '1', '2'), 
    ('GDT', '2009', '1', '1', '0', '1', '0', '1-1', '1', '3'), 
    ('TPY', '2009', '1', '0', '0', '0', '0', '0-0', '0', '3'), 
    ('SDN', '2009', '1', '1', '0', '0', '1', '0-3', '0', '5'), 
    ('TPY', '2009', '2', '1', '1', '0', '0', '5-0', '3', '1'), 
    ('BBD', '2009', '2', '2', '1', '0', '1', '3-5', '3', '2'), 
    ('KKH', '2009', '2', '2', '0', '2', '0', '3-3', '2', '3'), 
    ('GDT', '2009', '2', '1', '0', '1', '0', '1-1', '1', '4'), 
    ('SDN', '2009', '2', '2', '1', '1', '0', '2-5', '1', '5'), 
    ('BBD', '2009', '3', '3', '2', '0', '1', '4-5', '6', '1'), 
    ('GDT', '2009', '3', '2', '1', '1', '0', '3-1', '4', '2'), 
    ('TPY', '2009', '3', '2', '1', '0', '1', '5-2', '3', '3'), 
    ('KKH', '2009', '3', '3', '0', '2', '1', '3-4', '2', '4'), 
    ('SDN', '2009', '3', '2', '1', '1', '0', '2-5', '1', '5'), 
    ('BBD', '2009', '4', '4', '2', '1', '1', '6-7', '7', '1'), 
    ('GDT', '2009', '4', '3', '1', '2', '0', '5-1', '5', '2'), 
    ('KKH', '2009', '4', '4', '1', '2', '1', '4-4', '5', '3'), 
    ('TPY', '2009', '4', '3', '1', '0', '2', '5-3', '3', '4'), 
    ('SDN', '2009', '4', '2', '1', '1', '0', '2-5', '1', '5')