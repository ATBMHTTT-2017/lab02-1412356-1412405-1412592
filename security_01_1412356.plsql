ALTER TABLE atbmhtttdba.NhanVien
ADD 
(
  luong_encrypted RAW(2000),
  key RAW(128)
);
 
CREATE OR REPLACE PROCEDURE Encrypt_Luong (in_maNV varchar2)
AS
in_luong int;
encrypted_raw RAW(2000);
input_string VARCHAR2(200);
num_key_bytes NUMBER:=256/8;
key_bytes_raw RAW(32);
encryption_type PLS_INTEGER:=DBMS_CRYPTO.ENCRYPT_AES256+DBMS_CRYPTO.CHAIN_CBC+ DBMS_CRYPTO.PAD_PKCS5;
begin
select TO_CHAR(luong) into input_string from atbmhtttdba.NhanVien where maNV=in_maNV;
key_bytes_raw:=DBMS_CRYPTO.RANDOMBYTES (num_key_bytes);
encrypted_raw:=DBMS_CRYPTO.ENCRYPT
(src=>UTL_I18N.STRING_TO_RAW(input_string, 'AL32UTF8'),
	typ=>encryption_type,
	key=>key_bytes_raw);
update atbmhtttdba.NhanVien SET luong_encrypted=encrypted_raw where maNV=in_maNV;
update atbmhtttdba.NhanVien SET key=key_bytes_raw where maNV=in_maNV;
end;

CREATE OR REPLACE PROCEDURE Decrypt_Luong
as
luong_raw RAW(2000);
output_string VARCHAR2(200);
luong_decrypted_raw RAW(2000);
key_bytes_raw RAW(32);
encryption_type PLS_INTEGER:=DBMS_CRYPTO.ENCRYPT_AES256+DBMS_CRYPTO.CHAIN_CBC+ DBMS_CRYPTO.PAD_PKCS5;
begin
select luong_encrypted into luong_raw  from NhanVien where maNV=USER;
select key into key_bytes_raw from NhanVien where maNV=USER;
luong_decrypted_raw:=DBMS_CRYPTO.DECRYPT
  (src=>luong_raw,
	typ=>encryption_type,
	key=>key_bytes_raw);
  output_string:=UTL_I18N.RAW_TO_CHAR(luong_decrypted_raw,'AL32UTF8');
DBMS_OUTPUT.PUT_LINE('Luong:  '||output_string);
end;
