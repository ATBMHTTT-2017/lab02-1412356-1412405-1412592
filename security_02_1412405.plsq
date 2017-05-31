----------------------Insert new column in table NHANVIEN:signature-------------------
ALTER TABLE atbmhtttdba.NhanVien
ADD 
(
  signature VARCHAR2(4000)
);

--------------------------CREATE FUNCTION create_signature AND verify_signature-------------------------
CREATE OR REPLACE FUNCTION create_signature(
                                       in_message IN VARCHAR2,
                                        in_private_key IN CLOB )
RETURN raw DETERMINISTIC
IS
  signature RAW(32000);
BEGIN
  signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(in_private_key),
        private_key_password => '',
        hash => ora_rsa.hash_sha256);
  RETURN signature;
END;

 
CREATE OR REPLACE FUNCTION verify_signature(in_message IN VARCHAR2, in_signature IN RAW, in_public_key IN CLOB)
RETURN varchar2 DETERMINISTIC
IS
  signature_check_result PLS_INTEGER;
BEGIN
  IF in_signature IS NULL THEN
		RETURN 'Signature cannot be verified.';
	END IF; 
    signature_check_result := ORA_RSA.VERIFY(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'), 
        signature => in_signature, 
        public_key => UTL_RAW.cast_to_raw(in_public_key),
        HASH => ORA_RSA.HASH_SHA256);
 
    IF signature_check_result = 1 THEN
       RETURN 'Signature verification passed.'; 
    ELSE
       RETURN 'Signature cannot be verified.'; 
    END IF; 
END;

--------------CREATE SIGNATURE AND INSERT IT'S VALUES INTO TABLE NHANVIEN--------------

UPDATE atbmhtttdba.NHANVIEN set signature = create_signature(luong,'-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFBLUjjrpiAAo4xYWO1TNZuRQHRlZ6f0KmGqoFvqXDigGHT6QDu8
x973MXMFdgZU06mI4xiK95GPwaVxleL0h2cquBHy2MIaKT/0yQRBuuYjcVaVUc5T
soOKrYB5gm60QV3/UitTCOPdR4v/wxb0mCYfZPQMQU9GMY/P34Btfn29AgMBAAEC
gYAWuXqHyYm2vPeMnORuJoKhiLZpOtnfWuczxQqleOqozAaf9MOBJKicnfFM0Fra
598PuEItjAcNF1aC8GavWO2JH5x6ZokHvvXaOupSTct/SmNy/crFsnWNFK2jWC9h
qBp5xMvsQMR9ZILkcreP6lCZCpglJMJh/FrGokOj+PiyAQJBAJ9/WntqTLBmKrhx
dDDcH5iK7yyIMmo32AddiHOrsBhWZ1N7wieX8+ClU7U81xsjqqk031GCeJ211yV7
svexX90CQQCA4CKVePjO/dz30jflng6CB2Y7mluh/rvvJsiEx6W3oWaIbQEJpL+A
FIrqWgvtiy6DQXmjLZpximuw7aBYwKdhAkBpJ8W36HV3N2SjBenc7MPIBpF5grH6
Zab/9CKqYF9RLGYjHEz9XalkSpvNubb4JaO2uy0gyCxNjj2ycMOlmkPhAkB/4mpP
GvkDJiUEgkVXhI1u+Hq5QIYXbVj+iuTF5fuLCg1d6ZTzBdnF9hyXSv21HbztIKbc
hx9P9gTBUDwidiJhAkAMfK3o7gxmz6UONXJuInfOOIJlgWvupkrd5RlnO12k2fp0
ffiCu/Xx1g6u3YdBR06nBUWtODeWrGKVbxe/E0Vp
-----END RSA PRIVATE KEY-----')  where manv = 'TC002001';

UPDATE atbmhtttdba.NHANVIEN set signature = create_signature(luong,'-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFBLUjjrpiAAo4xYWO1TNZuRQHRlZ6f0KmGqoFvqXDigGHT6QDu8
x973MXMFdgZU06mI4xiK95GPwaVxleL0h2cquBHy2MIaKT/0yQRBuuYjcVaVUc5T
soOKrYB5gm60QV3/UitTCOPdR4v/wxb0mCYfZPQMQU9GMY/P34Btfn29AgMBAAEC
gYAWuXqHyYm2vPeMnORuJoKhiLZpOtnfWuczxQqleOqozAaf9MOBJKicnfFM0Fra
598PuEItjAcNF1aC8GavWO2JH5x6ZokHvvXaOupSTct/SmNy/crFsnWNFK2jWC9h
qBp5xMvsQMR9ZILkcreP6lCZCpglJMJh/FrGokOj+PiyAQJBAJ9/WntqTLBmKrhx
dDDcH5iK7yyIMmo32AddiHOrsBhWZ1N7wieX8+ClU7U81xsjqqk031GCeJ211yV7
svexX90CQQCA4CKVePjO/dz30jflng6CB2Y7mluh/rvvJsiEx6W3oWaIbQEJpL+A
FIrqWgvtiy6DQXmjLZpximuw7aBYwKdhAkBpJ8W36HV3N2SjBenc7MPIBpF5grH6
Zab/9CKqYF9RLGYjHEz9XalkSpvNubb4JaO2uy0gyCxNjj2ycMOlmkPhAkB/4mpP
GvkDJiUEgkVXhI1u+Hq5QIYXbVj+iuTF5fuLCg1d6ZTzBdnF9hyXSv21HbztIKbc
hx9P9gTBUDwidiJhAkAMfK3o7gxmz6UONXJuInfOOIJlgWvupkrd5RlnO12k2fp0
ffiCu/Xx1g6u3YdBR06nBUWtODeWrGKVbxe/E0Vp
-----END RSA PRIVATE KEY-----')  where manv = 'TP001002';

UPDATE atbmhtttdba.NHANVIEN set signature = create_signature(luong,'-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFBLUjjrpiAAo4xYWO1TNZuRQHRlZ6f0KmGqoFvqXDigGHT6QDu8
x973MXMFdgZU06mI4xiK95GPwaVxleL0h2cquBHy2MIaKT/0yQRBuuYjcVaVUc5T
soOKrYB5gm60QV3/UitTCOPdR4v/wxb0mCYfZPQMQU9GMY/P34Btfn29AgMBAAEC
gYAWuXqHyYm2vPeMnORuJoKhiLZpOtnfWuczxQqleOqozAaf9MOBJKicnfFM0Fra
598PuEItjAcNF1aC8GavWO2JH5x6ZokHvvXaOupSTct/SmNy/crFsnWNFK2jWC9h
qBp5xMvsQMR9ZILkcreP6lCZCpglJMJh/FrGokOj+PiyAQJBAJ9/WntqTLBmKrhx
dDDcH5iK7yyIMmo32AddiHOrsBhWZ1N7wieX8+ClU7U81xsjqqk031GCeJ211yV7
svexX90CQQCA4CKVePjO/dz30jflng6CB2Y7mluh/rvvJsiEx6W3oWaIbQEJpL+A
FIrqWgvtiy6DQXmjLZpximuw7aBYwKdhAkBpJ8W36HV3N2SjBenc7MPIBpF5grH6
Zab/9CKqYF9RLGYjHEz9XalkSpvNubb4JaO2uy0gyCxNjj2ycMOlmkPhAkB/4mpP
GvkDJiUEgkVXhI1u+Hq5QIYXbVj+iuTF5fuLCg1d6ZTzBdnF9hyXSv21HbztIKbc
hx9P9gTBUDwidiJhAkAMfK3o7gxmz6UONXJuInfOOIJlgWvupkrd5RlnO12k2fp0
ffiCu/Xx1g6u3YdBR06nBUWtODeWrGKVbxe/E0Vp
-----END RSA PRIVATE KEY-----')  where manv = 'TP003002';

UPDATE atbmhtttdba.NHANVIEN set signature = create_signature(luong,'-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFBLUjjrpiAAo4xYWO1TNZuRQHRlZ6f0KmGqoFvqXDigGHT6QDu8
x973MXMFdgZU06mI4xiK95GPwaVxleL0h2cquBHy2MIaKT/0yQRBuuYjcVaVUc5T
soOKrYB5gm60QV3/UitTCOPdR4v/wxb0mCYfZPQMQU9GMY/P34Btfn29AgMBAAEC
gYAWuXqHyYm2vPeMnORuJoKhiLZpOtnfWuczxQqleOqozAaf9MOBJKicnfFM0Fra
598PuEItjAcNF1aC8GavWO2JH5x6ZokHvvXaOupSTct/SmNy/crFsnWNFK2jWC9h
qBp5xMvsQMR9ZILkcreP6lCZCpglJMJh/FrGokOj+PiyAQJBAJ9/WntqTLBmKrhx
dDDcH5iK7yyIMmo32AddiHOrsBhWZ1N7wieX8+ClU7U81xsjqqk031GCeJ211yV7
svexX90CQQCA4CKVePjO/dz30jflng6CB2Y7mluh/rvvJsiEx6W3oWaIbQEJpL+A
FIrqWgvtiy6DQXmjLZpximuw7aBYwKdhAkBpJ8W36HV3N2SjBenc7MPIBpF5grH6
Zab/9CKqYF9RLGYjHEz9XalkSpvNubb4JaO2uy0gyCxNjj2ycMOlmkPhAkB/4mpP
GvkDJiUEgkVXhI1u+Hq5QIYXbVj+iuTF5fuLCg1d6ZTzBdnF9hyXSv21HbztIKbc
hx9P9gTBUDwidiJhAkAMfK3o7gxmz6UONXJuInfOOIJlgWvupkrd5RlnO12k2fp0
ffiCu/Xx1g6u3YdBR06nBUWtODeWrGKVbxe/E0Vp
-----END RSA PRIVATE KEY-----')  where manv = 'TP005002';


