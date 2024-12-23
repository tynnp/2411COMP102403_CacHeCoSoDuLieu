use DemoQLBanHang
go 

select * from HangHoa 
where MaHH NOT IN (
	select distinct MaHH from ChiTietHD
)
go

select * from HangHoa 
where not exists (
	select null from ChiTietHD 
	where HangHoa.MaHH = ChiTietHD.MaHH
)
go

update HangHoa set DonGia = 190
where MaHH = 1002
go

select HH.*
from HangHoa HH 
join (
	select MAX(DonGia) AS DonGiaLonNhat from HangHoa 
) as T ON T.DonGiaLonNhat = HH.DonGia
go

------------------------------------------------------

create table KhachHang_Backup (
	MaKH nvarchar(50) primary key, 
	HoTen nvarchar(100)
)
go

insert into KhachHang_Backup 
select MaKH, HoTen from KhachHang
where MaKH in (
	select distinct MaKH from HoaDon
)
go

select * from KhachHang_Backup

------------------------------------------------------

create table NhanVien_Backup (
	MaNV nvarchar(50) primary key,
	HoTen nvarchar(100)
)
go

insert into NhanVien_Backup
select MaNV, HoTen from NhanVien
where MaNV in (
	select MaNV from HoaDon
)
go

select * from NhanVien_Backup
go

alter table NhanVien_Backup
add Luong int
go

update NhanVien_Backup set Luong = 30000
where MaNV = N'cavani'
go