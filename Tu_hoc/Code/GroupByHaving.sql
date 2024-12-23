use DemoQLBanHang
go 

select H.MaLoai as [Mã loại], TenLoai as [Tên loại],
		count(MaHH) as [Số lượng], 
		max(DonGia) as [Giá lớn nhất],
		avg(DonGia) as [Giá trung bình],
		min(NgaySX) as [Ngày sản xuất lâu nhất]
from HangHoa H 
join Loai L on H.MaLoai = L.MaLoai
group by H.MaLoai, TenLoai
having avg(DonGia) > 25