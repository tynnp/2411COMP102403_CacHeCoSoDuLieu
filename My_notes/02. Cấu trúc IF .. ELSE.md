## Cấu trúc IF .. ELSE 
Cho phép thực thi một hay nhiều lệnh tùy thuộc vào một điều kiện nào đó.  
Cú pháp:
``` tsql
IF condition
    statements 1
ELSE 
    statements 2
```
- `condition`: biểu thức Boolean, một so sánh, một hàm trả về giá trị `TRUE` hoặc `FALSE`.
- `statements 1`: lệnh sẽ thực thi nếu `condition 1` là `TRUE`.
- `statements 2`: lệnh sẽ thực thi nếu `condition 2` là `FALSE`.  

Thường được kết hợp với khối `BEGIN .. END` để nhóm các lệnh lại với nhau, cần thiết khi muốn thực hiện nhiều lệnh trong một nhánh:
``` tsql
IF condition
    BEGIN
        -- lệnh sẽ được thực thi nếu condition là TRUE.
    END
ELSE
    BEGIN
        -- lệnh sẽ được thực thi nếu condition là FALSE.
    END
```

**Ví dụ 1**, Kiểm tra xem có nhân viên nào mà địa chỉ ở Thành phố Hồ Chí Minh không:
```tsql
USE QuanLyDeAn
GO

IF (SELECT COUNT(*) FROM NHANVIEN WHERE DCHI like 'TPHCM' > 0)
    PRINT 'Co nhan vien o Tp.HCM'
ELSE
    PRINT 'Khong co nhan vien o Tp.HCM'
```

**Ví dụ 2**, Kiểm tra số lượng dự án mà một nhân viên tham gia:
```tsql 
USE QuanLyDeAn
GO

SET NOCOUNT ON 
DECLARE @sodean int
DECLARE @manv char(5)
DECLARE @msg char(10)

SET @manv = '33344'
SELECT @sodean = COUNT(soda) FROM PHANCONG
WHERE MANV = @manv

IF @sodean < 3
    SET @msg = 'Tham gia it'
ELSE
    SET @msg = 'Tham gia nhieu'

PRINT 'Nhan vien ' + @manv + ' ' + @msg
```

**Ví dụ 3**, Kiểm tra xem có bao nhiêu nhân viên đã được phân công tham gia vào một dự án cụ thể:
``` tsql
USE QuanLyDeAn
GO

DECLARE @msg varchar(100)
DECLARE @mada char(5)
DECLARE @soduan INT

SET @mada = '5'
SET @soduan = (SELECT COUNT(MANV) FROM PHANCONG WHERE soda = @mada)

IF @soduan > 5
    BEGIN 
        SET NOCOUNT ON
        SET @msg = 'So nhan vien duoc phan cong tham gia la: ' + CAST(@soduan AS varchar(10))
        PRINT @msg
    END
ELSE
    PRINT 'Chua co nhan vien nao duoc phan cong'
```