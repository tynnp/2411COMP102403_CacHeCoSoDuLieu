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

