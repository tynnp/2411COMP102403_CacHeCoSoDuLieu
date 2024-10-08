## Khái niệm cơ bản
### 1. Kiểu dữ liệu
- Kiểu dữ liệu là một định nghĩa để xác định loại dữ liệu mà đối tượng có thể chứa. 
- Có 2 loại kiểu dữ liệu: System-Supplied data types và User-defined data types.

### 2. Gói lệnh (batch)
- Batch là một tập các lệnh T-SQL nằm liên tiếp nhau, có thể dùng từ khóa `GO` để kết thúc.
- Các lệnh trong batch được biên dịch và thực thi đồng thời. Nếu một lệnh trong batch bị lỗi thì batch cũng xem như lỗi.
- Các lệnh CREATE bị ràng buộc nằm trong một batch đơn.

### 3. Kịch bản (script)
- Một kịch bản là một tập của một hay nhiều bó lệnh được lưu thành một tập tin `.sql`.

### 4. Biến (variable)
- Biến là một đối tượng trong tập lệnh T-SQl mà nó dùng để lưu trữ dữ liệu.
- Có 2 loại biến: biến cục bộ (local), biến toàn cục (global).
- Biến global được SQL Server đưa ra và có thể dùng bất kỳ lúc nào mà không cần khai báo (được xem như những hàm chuẩn của SQL Server).

### 5. Biến cục bộ (local variable)
- Được khai báo trong phần thân của một bó lệnh hoặc một thủ tục.
- Phạm vi hoạt động của biến bắt đầu từ điểm mà nó được khai báo cho đến khi kết thúc một batch/stored procedure/Function mà nó được khai báo.
- Tên của biến bắt đầu bởi ký tự `@`.
- Khai báo: `DECLARE @var_name var_type`  

**Gán giá trị cho biến**
- Nếu biến vừa khai báo xong thì mặc định là `NULL`.
- Dùng lệnh `SET` hoặc `SELECT` để gán giá trị cho biến.
- Cú pháp:
    + `SET @var_name = expression`
    + `SELECT @var_name1 = expression1, @var_name2 = expression2, ...`

### 6. Biến toàn cục (global variable)
- Biến toàn cục được định nghĩa như hàm của hệ thống. 
- Các biến này không có kiểu dữ liệu, tên biến bắt đầu bởi ký tự `@@`. Sau đây là một số biến toàn cục:
    + `@@VERSION`: Phiên bản của SQL Server và hệ điều hành.
    + `@@SERVERNAME`: Trả về tên của máy chủ SQL Server.
    + `@@TRANCOUNT`: Số transaction đang mở.
    + `@@ROWCOUNT`: Số dòng bị ảnh hưởng đối với lệnh thực thi gần nhất.
    + `@@IDENTITY`: Trả về số identity phát sinh sau cùng.
    + `@@ERROR`: Trả về STT lỗi của lệnh sau cùng mà SQL thực thi, là 0 có nghĩa là câu lệnh thực thi hoàn thành.
    + `@@FETCH_STATUS`: Trả về trạng thái lệnh Fetch của biến con trỏ có thành công hay không (`0`: thành công, `-1`: bị lỗi hoặc vượt quá phạm vi, `-2`: thất bại).

### 7. Khối BEGIN .. END
- Nếu nhiều lệnh cần thực thi có liên quan với nhau thì đặt các lệnh này trong `BEGIN .. END`.
- Cú pháp:
``` tsql
BEGIN
    statement | statement_block
END
```

### 8. Lệnh RETURN
- Dùng để trả về một giá trị, lệnh này nằm trong một khối hay procedure.
- Nếu gặp lệnh RETURN, quá trình xử lý khối hay procedure sẽ kết thúc.
- Cú pháp: `RETURN expression`

### 9. Lệnh PRINT
- Dùng để in thông tin ra màn hình kết quả của SQL.
- Cú pháp: `PRINT 'any ASCII text' | @local_variable | @@Function | string_expr`

### 10. Ghi chú (Comment)
- Ghi chú trên một dòng: sử dụng ký tự `--`, mọi thứ trên cùng một dòng sau ký tự này sẽ được xem là ghi chú và không được thực thi.
- Ghi chú trên nhiều dòng: sử dụng ký tự `/* ... */`, mọi thứ giữa `/*` và `*/` sẽ được xem là ghi chú và không được thực thi.