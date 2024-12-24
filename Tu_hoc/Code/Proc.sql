use DemoQLBanHang
go

--------------------------------------------------------

create procedure spDanhSachHangHoa (
	@MaLoai int,
	@MaNCC nvarchar(50)
) as 
begin
	select * from HangHoa 
	where MaLoai = @MaLoai and MaNCC = @MaNCC
end
go

execute spDanhSachHangHoa 1001, 'ss'
go

--------------------------------------------------------

create proc spLayHangHoaTheoLoai (
	@MaLoai int,
	@SoBanGhi int out
) as
begin
	select * from HangHoa 
	where MaLoai = @MaLoai
	set @SoBanGhi = @@ROWCOUNT
end
go

declare @SoBanGhi int
exec spLayHangHoaTheoLoai 1001, @SoBanGhi out
print CONCAT(N'Tổng cộng có ', @SoBanGhi, N' dòng')
go

--------------------------------------------------------

use DemoQLBanHang
go

create proc spThemLoai (
	@MaLoai int out,
	@TenLoai nvarchar(50),
	@MoTa nvarchar(max), 
	@Hinh nvarchar(50)
) as 
begin 
	insert into Loai(TenLoai, Hinh, MoTa) values
		(@TenLoai, @Hinh, @MoTa)
	set @MaLoai = @@IDENTITY
end
go 

declare @MaLoai int
exec spThemLoai @MaLoai out, N'Văn phòng phẩm', N'N/A', N'Văn phòng phẩm'
print CONCAT(N'Vừa thêm ', @MaLoai)
select * from Loai
go

---------------------------------------------------------------------------------

create proc spSuaLoai (
	@MaLoai int, 
	@TenLoai nvarchar(50),
	@Hinh nvarchar(50),
	@MoTa nvarchar(max)
) as
begin
	update Loai set TenLoai = @TenLoai, Hinh = @Hinh, MoTa = @MoTa
	where MaLoai = @MaLoai
end
go

exec spSuaLoai 1001, N'Laptop', N'laptop.png', N'laptop new'
select * from Loai
go

---------------------------------------------------------------------------------

create proc spXoaLoai @MaLoai int as
begin
	delete from Loai where MaLoai = @MaLoai
end
go

exec spXoaLoai 2009 
select * from Loai
go

---------------------------------------------------------------------------------

create proc spLayTatCaLoai as
begin 
	select * from Loai
end
go

exec spLayTatCaLoai
go

---------------------------------------------------------------------------------

create proc spLayThongTin @MaLoai int as
begin
	select * from Loai
	where MaLoai = @MaLoai
end
go

exec spLayThongTin 1001
go

---------------------------------------------------------------------------------

create proc spDanhSachHangHoaTheoLoai 
	@MaLoai int 
as
begin 
	select HH.*, TenLoai, TenCongTy as NhaCungCap from HangHoa HH
	join Loai L	on HH.MaLoai = L.MaLoai 
	join NhaCungCap NCC on NCC.MaNCC = HH.MaNCC
	where HH.MaLoai = @MaLoai
end
go

exec spDanhSachHangHoaTheoLoai 1001
go

---------------------------------------------------------------------------------

create proc spDanhSachKH @SoTien int as
begin
	select KH.HoTen, KH.DienThoai from KhachHang KH
	join HoaDon HD on KH.MaKH = HD.MaKH
	join ChiTietHD CT on HD.MaHD = CT.MaHD
	group by KH.HoTen, KH.DienThoai
	having sum(CT.SoLuong * CT.DonGia) > @SoTien
end
go

exec spDanhSachKH 600
go

---------------------------------------------------------------------------------

create proc spDanhSachHH @SoDon int as
begin
	select HH.TenHH, COUNT(MaHD) as SoLuong from HangHoa HH
	join ChiTietHD CT on CT.MaHH = HH.MaHH
	group by HH.TenHH
	having COUNT(MaHD) > @SoDon
end
go

select * from ChiTietHD
exec spDanhSachHH 10
go

---------------------------------------------------------------------------------

alter proc spDanhSachHHTheoSoLuong @SoLuong int as
begin
	select HH.TenHH, Sum(CT.SoLuong) as SoLuong from HangHoa HH
	join ChiTietHD CT on CT.MaHH = HH.MaHH
	group by HH.TenHH
	having Sum(CT.SoLuong) > @SoLuong
end
go

select * from ChiTietHD
exec spDanhSachHHTheoSoLuong 100
go

---------------------------------------------------------------------------------

alter proc spDanhSachHHTheoSoTien @SoTien float as
begin
	select HH.TenHH, Sum(CT.SoLuong * CT.DonGia) as SoTien from HangHoa HH
	join ChiTietHD CT on CT.MaHH = HH.MaHH
	group by HH.TenHH
	having sum(CT.SoLuong * CT.DonGia) > @SoTien
end
go

select * from ChiTietHD
exec spDanhSachHHTheoSoTien 50
go
