-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. TẠO CƠ SỞ DỮ LIỆU
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tạo bảng Chi Nhánh
CREATE TABLE CHINHANH
(
  maCN CHAR(3) NOT NULL 
  ,tenCN NVARCHAR2(50) NOT NULL 
  ,truongChiNhanh	CHAR(8) NULL
  ,CONSTRAINT PK_CHINHANH PRIMARY KEY(maCN) ENABLE
);

CREATE TABLE PHONGBAN
(
  maPhong CHAR(4) NOT NULL
  ,tenPhong NVARCHAR2(50) NOT NULL
  ,truongPhong CHAR(8) NULL
  ,ngayNhanChuc DATE NULL
  ,soNhanVien INT NOT NULL
  ,chiNhanh CHAR(3) NULL
  ,CONSTRAINT PK_PHONGBAN PRIMARY KEY(maPhong) ENABLE
  ,CONSTRAINT FK_PHONGBAN_CHINHANH FOREIGN KEY(chiNhanh) REFERENCES CHINHANH(maCN) ENABLE
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tạo bảng Nhân Viên
CREATE TABLE NHANVIEN
(
  maNV CHAR(8) NOT NULL
  ,hoTen NVARCHAR2(50) NOT NULL
  ,diaChi NVARCHAR2(70) NOT NULL
  ,email NVARCHAR2(50) NOT NULL
  ,chiNhanh CHAR(3) NULL 
  ,maPhong CHAR(4) NULL
  ,luong INT NULL
  ,CONSTRAINT PK_NHANVIEN PRIMARY KEY(maNV) ENABLE
  ,CONSTRAINT FK_NHANVIEN_CHINHANH FOREIGN KEY(chiNhanh) REFERENCES CHINHANH(maCN) ENABLE
  ,CONSTRAINT FK_NHANVIEN_PHONGBAN FOREIGN KEY(maPhong) REFERENCES PHONGBAN(maPhong) ENABLE
);

-- Tạo khóa ngoại Trưởng Phòng (Phòng Ban -> Nhân Viên)
ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PHONGBAN_NHANVIEN FOREIGN KEY(truongPhong) REFERENCES NHANVIEN(maNV) ENABLE;

-- Tạo khóa ngoại Trưởng Chi Nhanh (Chi Nhánh -> Nhân Viên)
ALTER TABLE CHINHANH
ADD CONSTRAINT FK_CHINHANH_NHANVIEN FOREIGN KEY(truongChiNhanh) REFERENCES NHANVIEN(maNV) ENABLE;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tạo bảng Dự Án
CREATE TABLE DUAN
(
  maDA CHAR(6) NOT NULL
  ,tenDA NVARCHAR2(100) NOT NULL
  ,kinhPhi INT NOT NULL
  ,phongChuTri CHAR(4) NULL
  ,truongDA CHAR(8) NULL
  ,CONSTRAINT PK_DUAN PRIMARY KEY(maDA) ENABLE
  ,CONSTRAINT FK_DUAN_PHONGBAN FOREIGN KEY(phongChuTri) REFERENCES PHONGBAN(maPhong)ENABLE
  ,CONSTRAINT FK_DUAN_NHANVIEN FOREIGN KEY(truongDA) REFERENCES NHANVIEN(maNV) ENABLE
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tạo bảng Chi Tiêu
CREATE TABLE CHITIEU
(
  maChiTieu CHAR(7) NOT NULL
  ,tenChiTieu NVARCHAR2(100) NOT NULL
  ,soTien INT NOT NULL
  ,duAn CHAR(6) NULL
  ,CONSTRAINT PK_CHITIEU PRIMARY KEY(maChiTieu) ENABLE
  ,CONSTRAINT FK_CHITIEU_DUAN FOREIGN KEY(duAn) REFERENCES DUAN(maDA) ENABLE
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tạo bảng Phân Công
CREATE TABLE PHANCONG
(
  maNV CHAR(8) NOT NULL
  ,duAn CHAR(6) NOT NULL
  ,vaiTro NVARCHAR2(50) NOT NULL
  ,phuCap INT NOT NULL
  ,CONSTRAINT PK_PHANCONG PRIMARY KEY(maNV, duAn) ENABLE
  ,CONSTRAINT FK_PHANCONG_DUAN FOREIGN KEY(duAn) REFERENCES DUAN(maDA) ENABLE
  ,CONSTRAINT FK_PHANCONG_NHANVIEN FOREIGN KEY(maNV) REFERENCES NHANVIEN(maNV) ENABLE
);





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. THÊM DỮ LIỆU
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Phân Công
INSERT INTO CHINHANH
(
  maCN-- CHAR(3) NOT NULL 
  ,tenCN-- NVARCHAR2(50) NOT NULL 
  ,truongChiNhanh--	CHAR(8) NOT NULL 
  --,CONSTRAINT PK_CHINHANH PRIMARY KEY(maCN) ENABLE
)
VALUES ('001', 'Chi Nhánh  Tp. Hồ Chí Minh', NULL);
INSERT INTO CHINHANH VALUES ('002', 'Chi Nhánh Hà Nội', NULL);
INSERT INTO CHINHANH VALUES ('003', 'Chi Nhánh Tp. Cần Thơ', NULL);
INSERT INTO CHINHANH VALUES ('004', 'Chi Nhánh Tp. Đà Nẵng', NULL);
INSERT INTO CHINHANH VALUES ('005', 'Chi Nhánh Tp.Hải Phòng', NULL);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Phòng Ban
INSERT INTO PHONGBAN
(
  maPhong-- CHAR(4) NOT NULL
  ,tenPhong-- NVARCHAR2(50) NOT NULL
  ,truongPhong-- CHAR(8) NULL
  ,ngayNhanChuc-- DATE NULL
  ,soNhanVien-- INT NOT NULL
  ,chiNhanh-- CHAR(3) NOT NULL
  --,CONSTRAINT PK_PHONGBAN PRIMARY KEY(maPhong) ENABLE
  --,CONSTRAINT FK_PHONGBAN_CHINHANH FOREIGN KEY(chiNhanh) REFERENCES CHINHANH(maCN) ENABLE
)
VALUES ('0010', 'Phòng Nhân Sự', NULL, NULL, 2, '001');
INSERT INTO PHONGBAN VALUES ('0011', 'Phòng Nhân Sự', NULL, NULL, 1, '001');
INSERT INTO PHONGBAN VALUES ('0020', 'Phòng Kế Toán', NULL, NULL, 2, '002');
INSERT INTO PHONGBAN VALUES ('0021', 'Phòng Kế Hoạch', NULL, NULL, 1, '002');
INSERT INTO PHONGBAN VALUES ('0030', 'Phòng Nhân Sự', NULL, NULL, 2, '003');
INSERT INTO PHONGBAN VALUES ('0031', 'Phòng Kế Toán', NULL, NULL, 1, '003');
INSERT INTO PHONGBAN VALUES ('0040', 'Phòng Kế Hoạch', NULL, NULL, 2, '004');
INSERT INTO PHONGBAN VALUES ('0041', 'Phòng Nhân Sự', NULL, NULL, 1, '004');
INSERT INTO PHONGBAN VALUES ('0050', 'Phòng Kế Toán', NULL, NULL, 2, '005');
INSERT INTO PHONGBAN VALUES ('0051', 'Phòng Kế Hoạch', NULL, NULL, 1, '005');

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Nhân Viên
INSERT INTO NHANVIEN
(
  maNV-- CHAR(8) NOT NULL
  ,hoTen-- NVARCHAR2(30) NOT NULL
  ,diaChi-- NVARCHAR2(70) NOT NULL
  ,email-- NVARCHAR2(50) NOT NULL
  ,chiNhanh-- CHAR(3) NOT NULL 
  ,maPhong-- CHAR(4) NOT NULL
  ,luong-- INT NULL
  --,CONSTRAINT PK_NHANVIEN PRIMARY KEY(maNV) ENABLE
  --,CONSTRAINT FK_NHANVIEN_CHINHANH FOREIGN KEY(chiNhanh) REFERENCES CHINHANH(maCN) ENABLE
  --,CONSTRAINT FK_NHANVIEN_PHONGBAN FOREIGN KEY(maPhong) REFERENCES PHONGBAN(maPhong) ENABLE
)
VALUES ('GD000001', 'Vũ Thành An', 'Q. 8, Tp. Hồ Chí Minh', 'vttan@fit.hcmus.edu.vn', NULL, NULL, 20000000);
INSERT INTO NHANVIEN VALUES ('GD000002', 'Đỗ Minh Tân', 'Q. 9, Tp. Hồ Chí Minh', 'dmtan@fit.hcmus.edu.vn', NULL, NULL, 20000000);
INSERT INTO NHANVIEN VALUES ('GD000003', 'Mạc Văn Sơ', 'Q. 1, Tp. Hồ Chí Minh', 'mvso@fit.hcmus.edu.vn', NULL, NULL, 20000000);
INSERT INTO NHANVIEN VALUES ('GD000004', 'Đinh Nguyên Hân', 'Q. 11, Tp. Hồ Chí Minh', 'dnhan@fit.hcmus.edu.vn', NULL, NULL, 20000000);
INSERT INTO NHANVIEN VALUES ('GD000005', 'Trần Hồng Mỹ', 'Q. 12, Tp. Hồ Chí Minh', 'thmy@fit.hcmus.edu.vn', NULL, NULL, 20000000);

INSERT INTO NHANVIEN VALUES ('TC001001', 'Nguyễn Phúc Minh', 'Q. 5, Tp. Hồ Chí Minh', 'npminh@fit.hcmus.edu.vn', '001', '0010', 20000000);
INSERT INTO NHANVIEN VALUES ('TC002001', 'Nguyễn Đào Thảo Nguyên', 'Q. 7, Tp. Hồ Chí Minh', 'ndtnguyen@fit.hcmus.edu.vn', '002', '0020', 30000000);
INSERT INTO NHANVIEN VALUES ('TC003001', 'Nguyễn Hồng Phúc', 'Q. 10, Tp. Hồ Chí Minh', 'nhphuc@fit.hcmus.edu.vn', '003', '0031', 40000000);
INSERT INTO NHANVIEN VALUES ('TC004001', 'Lữ Tâm Long', 'Q. 10, Tp. Hồ Chí Minh', 'ltlong@fit.hcmus.edu.vn', '004', '0040', 25000000);
INSERT INTO NHANVIEN VALUES ('TC005001', 'Lê Minh Hiến', 'Q. 10, Tp. Hồ Chí Minh', 'nlmhien@fit.hcmus.edu.vn', '005', '0051', 25000000);

INSERT INTO NHANVIEN VALUES ('TP001002', 'Nguyễn Huỳnh Ánh Thảo', 'Q.Bình Thạnh, Tp. Hồ Chí Minh', 'nhathao@fit.hcmus.edu.vn', '001', '0010', 50000000);
INSERT INTO NHANVIEN VALUES ('TP002002', 'Trần Sỹ Anh', 'Q.BThanh, Tp. Hồ Chí Minh', 'tsanh@fit.hcmus.edu.vn', '002', '0021', 35000000);
INSERT INTO NHANVIEN VALUES ('TP003002', 'Mai Đăng Khoa', 'Q.Phú Nhuận, Tp. Hồ Chí Minh', 'mdkhoa@fit.hcmus.edu.vn', '003', '0030', 18000000);
INSERT INTO NHANVIEN VALUES ('TP004002', 'Nguyễn Đình Hiếu', 'Q.7, Tp. Hồ Chí Minh', 'ndhieu@fit.hcmus.edu.vn', '004', '0041', 22000000);
INSERT INTO NHANVIEN VALUES ('TP005002', 'Lý Quốc Anh Duy', 'Q.7, Tp. Hồ Chí Minh', 'lqaduy@fit.hcmus.edu.vn', '005', '0050', 27000000);

INSERT INTO NHANVIEN VALUES ('TD001103', 'Nguyễn Như Khoa', 'Q.7, Tp. Hồ Chí Minh', 'nnkhoa@fit.hcmus.edu.vn', '001', '0011', 25000000);
INSERT INTO NHANVIEN VALUES ('TD002103', 'Đào Thị Thu Thảo', 'Q.7, Tp. Hồ Chí Minh', 'dttthao@fit.hcmus.edu.vn', '002', '0021', 30000000);
INSERT INTO NHANVIEN VALUES ('TD003103', 'Huỳnh Bảo Huân', 'Q.10, Tp. Hồ Chí Minh', 'hbhuan@fit.hcmus.edu.vn', '003', '0031', 40000000);
INSERT INTO NHANVIEN VALUES ('TD004103', 'Võ Anh Kiệt', 'Q.6, Tp. Hồ Chí Minh', 'vakiet@fit.hcmus.edu.vn', '004', '0041', 30000000);
INSERT INTO NHANVIEN VALUES ('TD005103', 'Lê Dân', 'Q.3, Tp. Hồ Chí Minh', 'ldan@fit.hcmus.edu.vn', '005', '0051', 23000000);

INSERT INTO NHANVIEN VALUES ('NV001004', 'Cao Băng Tâm', 'Q.5, Tp. Hồ Chí Minh', 'cbtam@fit.hcmus.edu.vn', '001', '0010', 35000000);
INSERT INTO NHANVIEN VALUES ('NV002004', 'Tăng Gia Ngọc', 'Q.1, Tp. Hồ Chí Minh', 'tgngoc@fit.hcmus.edu.vn', '002', '0021', 32000000);
INSERT INTO NHANVIEN VALUES ('NV003004', 'Đỗ Trần Trúc Thảo', 'Q.2, Tp. Hồ Chí Minh', 'dttructhao@fit.hcmus.edu.vn', '003', '0030', 29000000);
INSERT INTO NHANVIEN VALUES ('NV004004', 'Hồ Khánh Việt Long', 'Q.3, Tp. Hồ Chí Minh', 'hkvlong@fit.hcmus.edu.vn', '004', '0041', 26000000);
INSERT INTO NHANVIEN VALUES ('NV005004', 'Võ Thanh Tú', 'Q.7, Tp. Hồ Chí Minh', 'vttu@fit.hcmus.edu.vn', '005', '0050', 35000000);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cập nhật khóa ngoại Trưởng Chi Nhánh  (Chi Nhánh -> Nhân Viên)
UPDATE  CHINHANH SET truongChiNhanh = 'TC001001' WHERE maCN = '001';
UPDATE  CHINHANH SET truongChiNhanh = 'TC002001' WHERE maCN = '002';
UPDATE  CHINHANH SET truongChiNhanh = 'TC003001' WHERE maCN = '003';
UPDATE  CHINHANH SET truongChiNhanh = 'TC004001' WHERE maCN = '004';
UPDATE  CHINHANH SET truongChiNhanh = 'TC005001' WHERE maCN = '005';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cập nhật khóa ngoại Trưởng Phòng  (Phòng Ban -> Nhân Viên)
UPDATE  PHONGBAN SET truongPhong = 'TP001002' WHERE maPhong = '0010';
UPDATE  PHONGBAN SET truongPhong = 'TP002002' WHERE maPhong = '0020';
UPDATE  PHONGBAN SET truongPhong = 'TP003002' WHERE maPhong = '0030';
UPDATE  PHONGBAN SET truongPhong = 'TP004002' WHERE maPhong = '0040';
UPDATE  PHONGBAN SET truongPhong = 'TP005002' WHERE maPhong = '0050';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cập nhật "Ngày nhận chức"  của bảng Phòng Ban
UPDATE  PHONGBAN SET ngayNhanChuc = TO_DATE('2017/05/10', 'yyyy/mm/dd') ;

INSERT INTO DUAN
(
  maDA --CHAR(6) NOT NULL
  ,tenDA --NVARCHAR2(70) NOT NULL
  ,kinhPhi --INT NOT NULL
  ,phongChuTri --CHAR(4) 
  ,truongDA --CHAR(8) 
  --,CONSTRAINT PK_DUAN PRIMARY KEY(maDA) ENABLE
 -- ,CONSTRAINT FK_DUAN_PHONGBAN FOREIGN KEY(phongChuTri) REFERENCES PHONGBAN(maPhong)ENABLE
  --,CONSTRAINT FK_DUAN_NHANVIEN FOREIGN KEY(truongDA) REFERENCES NHANVIEN(maNV) ENABLE
)
VALUES('001011', 'Chung cư tái định cư Thảo Điền, P.Thảo Điền, Quận 2', 432, '0011', 'TD001103');
INSERT INTO DUAN VALUES('002012', 'Dự án khu nhà ở thu nhập thấp, P.Hiệp Thạnh, Quận 12', 123, '0021', 'TD002103');
INSERT INTO DUAN VALUES('003033', ' Dự án khu đô thị mới Lê Minh Xuân, H.Bình Chánh', 501 ,'0031', 'TD003103');
INSERT INTO DUAN VALUES('004014', 'Dự án NOXH tại số 35 Hồ Học Lãm, P.An Lạc, H.Bình Tân', 300, '0041', 'TD004103');
INSERT INTO DUAN VALUES('005015', 'Dự án khu khu dân cư Minh Thành xã Thới Tam Thôn, H.Hóc Môn', 90 , '0051','TD005103');

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Chi Tiêu
INSERT INTO CHITIEU
(
  maChiTieu --CHAR(7) NOT NULL
  ,tenChiTieu --NVARCHAR2(70) NOT NULL
  ,soTien --INT NOT NULL
  ,duAn --CHAR(8) 
  --,CONSTRAINT PK_CHITIEU PRIMARY KEY(maChiTieu) ENABLE
  --,CONSTRAINT FK_CHITIEU_DUAN FOREIGN KEY(duAn) REFERENCES DUAN(maDA) ENABLE
)
VALUES ('0010411', 'Mua nguyên vật liệu xây dựng', 320, '001011');
INSERT INTO CHITIEU VALUES ('0021222', 'Tiền đền bù giải phóng mặt bằng', 30, '002012');
INSERT INTO CHITIEU VALUES ('0030333', 'Chi phí ăn uống của công nhân', 11, '003033');
INSERT INTO CHITIEU VALUES ('0041244', 'Phụ cấp tăng ca của công nhân', 5, '004014');
INSERT INTO CHITIEU VALUES ('0051155', 'Chi chí hỗ trợ chữa trị tai nạn lao động', 13, '005015');


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Phân Công
INSERT INTO PHANCONG
(
  maNV --CHAR(8) NOT NULL
  ,duAn --CHAR(6) NOT NULL
  ,vaiTro --NVARCHAR(50) NOT NULL
  ,phuCap --INT NOT NULL
 -- ,CONSTRAINT PK_PHUCAP PRIMARY KEY(maNV, duAn) ENABLE
 -- ,CONSTRAINT FK_PHUCAP_DUAN FOREIGN KEY(duAn) REFERENCES DUAN(maDA) ENABLE
  --,CONSTRAINT FK_PHUCAP_NHANVIEN FOREIGN KEY(maNV) REFERENCES NHANVIEN(maNV) ENABLE
)
VALUES('TC001001', '001011', 'Phó trưởng dự án', 0.5);
INSERT INTO PHANCONG VALUES ('TC002001', '002012', 'Ban quản lí dự án', 0.2);
INSERT INTO PHANCONG VALUES ('TP001002', '003033', 'Nhân viên điều phối dự án', 0.1);
INSERT INTO PHANCONG VALUES ('TP003002', '004014', 'Giám sát viên', 0.3);
INSERT INTO PHANCONG VALUES ('TP005002', '005015', 'Nhân viên hành chính dự án', 0.7);





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. TẠO NGƯỜI DÙNG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trường Phòng
CREATE USER TP001002
identified by 001002;
GRANT CREATE SESSION TO "TP001002" ;

CREATE USER TP002002
IDENTIFIED BY 002002;
grant create session to "TP002002" ;

CREATE USER TP003002
IDENTIFIED BY 003002;
grant create session to "TP003002" ;

CREATE USER TP004002
IDENTIFIED BY 004002;
grant create session to "TP004002" ;

CREATE USER TP005002
IDENTIFIED BY 005002;
grant create session to "TP005002" ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Giám Đốc
CREATE USER GD000001
IDENTIFIED BY 000001;
GRANT CREATE SESSION TO "GD000001" ;

CREATE USER GD000002
IDENTIFIED BY 000002;
grant create session to "GD000002" ;

CREATE USER GD000003
IDENTIFIED BY 000003;
grant create session to "GD000003" ;

CREATE USER GD000004
IDENTIFIED BY 000004;
GRANT CREATE SESSION TO "GD000004" ;

CREATE USER GD000005
IDENTIFIED BY 000005;
grant create session to "GD000005" ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trưởng Chi Nhánh
CREATE USER TC001001
IDENTIFIED BY 001001;
GRANT CREATE SESSION TO "TC001001" ;

CREATE USER TC002001
IDENTIFIED BY 002001;
GRANT CREATE SESSION TO "TC002001" ;

CREATE USER TC003001
IDENTIFIED BY 003001;
GRANT CREATE SESSION TO "TC003001" ;

CREATE USER TC004001
IDENTIFIED BY 004001;
GRANT CREATE SESSION TO "TC004001" ;

CREATE USER TC005001
IDENTIFIED BY 005001;
grant create session to "TC005001" ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trưởng Dự Án
CREATE USER TD001103
IDENTIFIED BY 001103;
GRANT CREATE SESSION TO "TD001103" ;

CREATE USER TD002103
IDENTIFIED BY 002103;
GRANT CREATE SESSION TO "TD002103" ;

CREATE USER TD003103
IDENTIFIED BY 003103;
GRANT CREATE SESSION TO "TD003103" ;

CREATE USER TD004103
IDENTIFIED BY 004103;
GRANT CREATE SESSION TO "TD004103" ;

CREATE USER TD005103
IDENTIFIED BY 005103;
GRANT CREATE SESSION TO "TD005103" ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Nhân Viên
CREATE USER NV001004
IDENTIFIED BY 001004;
GRANT CREATE SESSION TO "NV001004" ;

CREATE USER NV002004
IDENTIFIED BY 002004;
GRANT CREATE SESSION TO "NV002004" ;

CREATE USER NV003004
IDENTIFIED BY 003004;
GRANT CREATE SESSION TO "NV003004" ;

CREATE USER NV004004
IDENTIFIED BY 004004;
GRANT CREATE SESSION TO "NV004004" ;

CREATE USER NV005004
IDENTIFIED BY 005004;
GRANT CREATE SESSION TO "NV005004" ;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. TẠO VAI TRÒ
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE ROLE TruongDuAn;
CREATE ROLE TruongPhong;
CREATE ROLE TruongChiNhanh;
CREATE ROLE NhanVien;
CREATE ROLE GiamDoc;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 4. GÁN VAI TRÒ CHO NGƯỜI DÙNG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trường Phòng
GRANT TruongPhong to TP001002;
GRANT TruongPhong to TP002002;
GRANT TruongPhong to TP003002;
GRANT TruongPhong to TP004002;
GRANT TruongPhong to TP005002;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Giám Đốc
GRANT GiamDoc to GD000001;
GRANT GiamDoc to GD000002;
GRANT GiamDoc to GD000003;
GRANT GiamDoc to GD000004;
GRANT GiamDoc to GD000005;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trưởng Dự Án
GRANT TruongDuAn to TD001103;
GRANT TruongDuAn to TD002103;
GRANT TruongDuAn to TD003103;
GRANT TruongDuAn to TD004103;
GRANT TruongDuAn to TD005103;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trưởng Chi Nhánh
GRANT TruongChiNhanh to TC001001;
GRANT TruongChiNhanh to TC002001;
GRANT TruongChiNhanh to TC003001;
GRANT TruongChiNhanh to TC004001;
GRANT TruongChiNhanh to TC005001;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Nhân Viên
GRANT NhanVien to NV001004;
GRANT NhanVien to NV002004;
GRANT NhanVien to NV003004;
GRANT NhanVien to NV004004;
GRANT NhanVien to NV005004;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 5. STORED PROCEDURE
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Cập Nhật Bảng Phòng Ban
CREATE OR REPLACE PROCEDURE sp_capNhatPhongBan
(
  maPhongParam CHAR
  ,tenPhongParam NVARCHAR2
  ,truongPhongParam CHAR
  ,ngayNhanChucParam DATE 
  ,soNhanVienParam INT 
  ,chiNhanhParam CHAR
)
AS
BEGIN

  UPDATE PHONGBAN
  SET tenPhong = tenPhongParam,
      truongPhong = truongPhongParam,
      ngayNhanChuc = ngayNhanChucParam,
      soNhanVien = soNhanVienParam,
      chiNhanh = chiNhanhParam
  WHERE maphong = maPhongParam;
  COMMIT;
END;

--------------------------------------------------------------------------------------------------------------------
-- Chỉ trưởng dự án được phép xem và cập nhật thông tin chi tiêu của dự án của mình. (VPD)
CREATE OR REPLACE
FUNCTION sec_qlChiTieu
(
    p_schema VARCHAR2,
    p_object VARCHAR2
)
RETURN VARCHAR2
as
  duAn CHAR(6);
BEGIN
  SELECT maDA INTO duAn FROM atbmhtttdba.DUAN  WHERE truongDA = USER;
  RETURN 'duAn='|| q'[']' || duAn || q'[']';
END;
BEGIN
  DBMS_RLS.add_policy
  (object_schema => 'atbmhtttdba',
  object_name => 'CHITIEU',
  policy_name => 'S_U_ChiTieu',
  function_schema => 'atbmhtttdba',
  policy_function => 'sec_qlChiTieu',
  statement_types => 'SELECT, UPDATE');
END;
