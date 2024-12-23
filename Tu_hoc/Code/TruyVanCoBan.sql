use DemoQLBanHang
go

select TenHH, Hinh, DonGia, MaHH from HangHoa
go

select TenHH, Hinh, DonGia, MaHH from HangHoa
order by DonGia desc
go

select top 10 TenHH, Hinh, DonGia, MaHH from HangHoa
order by DonGia asc
go

select CONCAT(MaHH, ' - ', TenHH) as [Thong Tin], DonGia as [Don Gia] from HangHoa
go

select distinct DonGia from HangHoa
go

select * from PhongBan 
where ThongTin is null
go

select * from KhachHang
where HoTen like N'%Số%'
go

select * from KhachHang
where HoTen like N'%N'
go

select * from HangHoa
where MaLoai in (1001, 1002, 1007)
go

select * from HangHoa 
where MaHH IN (
	select distinct MaHH from ChiTietHD
)
go

select * from HangHoa
where DonGia BETWEEN 20 AND 30
order by DonGia desc
go

select * from KhachHang
where year(NgaySinh) BETWEEN 2009 AND 2010
go

select HoTen, MaKH, Year(Getdate()) - Year(NgaySinh) as Tuoi from KhachHang
go

select upper(HoTen), MaKH, Year(Getdate()) - Year(NgaySinh) as Tuoi from KhachHang
order by MaKH desc
go