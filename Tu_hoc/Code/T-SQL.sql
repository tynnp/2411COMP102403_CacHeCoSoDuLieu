declare @HoTen nvarchar(100)
select @HoTen = N'Nguyễn Ngọc Phú Tỷ'
print @HoTen

-------------------------------------------------
use DemoQLBanHang
go

declare @GiaTriLonNhat float, @GiaTriTrungBinh float
select @GiaTriLonNhat = max(DonGia), @GiaTriTrungBinh = avg(DonGia) from HangHoa
print CONCAT(N'Giá lớn nhất: ', @GiaTriLonNhat, N', Giá trung bình: ', @GiaTriTrungBinh)

-------------------------------------------------

declare @date date
set @date = '02-20-2005'
declare @curDate date = getdate()
declare @duaDate date = getdate() + 2

select @date as 'Date', @curDate as 'Cur Date', @duaDate as 'Due Date'

-------------------------------------------------

declare @bangTam table (
	MaKH nvarchar(50), 
	HoTen nvarchar(200)
)

insert into @bangTam
select MaKH, HoTen from KhachHang
where MaKH in (
	select distinct MaKH from HoaDon
)

select * from @bangTam

-------------------------------------------------

declare @a float, @b float
set @a = 2
set @b = 4

if @a > @b
	print CONCAT(@a, ' > ', @b)
else
	print CONCAT(@b, ' > ', @a)

-------------------------------------------------

select MaKH, HoTen, 
	case GioiTinh 
		when 1 then 'Nam'
		when 0 then 'Nu'
	end as 'GioiTinh'
from KhachHang

-------------------------------------------------

select MaHD, KH.MaKH, KH.HoTen, 
	case GioiTinh 
		when 1 then 'Nam'
		when 0 then 'Nu'
	end as 'GioiTinh', 
	case 
		when GioiTinh = 1 then 0.05
		when GioiTinh = 0 then 0.02
		else 0
	end as 'GiamGia'
from HoaDon HD join KhachHang KH on KH.MaKH = HD.MaKH

-------------------------------------------------

declare @n int, @sum int, @i int
select @n = 10, @sum = 0, @i = 1
while @i <= @n
begin 
	select @sum = @sum + @i,
	@i = @i + 1
end
print CONCAT(N'Tổng từ ', 1, N' đến ', @n, N' là ', @sum)

-------------------------------------------------

