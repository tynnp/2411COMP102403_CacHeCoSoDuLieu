use DemoQLBanHang
go

create view View_HangHoaDaBan as
	select cthd.*, TenHH from ChiTietHD cthd 
	join HangHoa hh on cthd.MaHH = hh.MaHH
go

select * from View_HangHoaDaBan