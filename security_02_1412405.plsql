----------------------Insert new column in table PHANCONG:signature-------------------
ALTER TABLE atbmdba.PHANCONG
ADD 
(
  signature RAW(2000)
);

--------------------------CREATE FUNCTION create_signature AND verify_signature-------------------------
CREATE OR REPLACE FUNCTION create_signature( in_message IN NUMBER, in_private_key in clob )
RETURN RAW
AS
  signature RAW(2000);
BEGIN
    --
    -- RSA SIGN
    --
        signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(in_private_key),
        hash => ORA_RSA.HASH_SHA256);
  RETURN signature;
END;

 
create or replace function verify_signature(in_message in number, in_signature in raw, in_public_key in clob)
RETURN RAW
AS
  signature_check_result PLS_INTEGER;
BEGIN	
    --
    -- RSA VERIFY
    --
    signature_check_result := ORA_RSA.VERIFY(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'), 
        signature => in_signature, 
        public_key => UTL_RAW.cast_to_raw(in_public_key),
        HASH => ORA_RSA.HASH_SHA256);
 
    IF signature_check_result = 1 THEN
       RETURN 'Signature verification passed.'; 
    ELSE
       RETURN 'Signature cannot be verified.'; 
    END IF; 
  EXCEPTION
   -- ORA_RSA exception handling 
   WHEN ORA_RSA.RSA_EXCEPTION THEN
     BEGIN
       IF ORA_RSA.GET_RSA_ERROR() = ORA_RSA.RSA_WRONG_PASSWORD_ERR THEN
         DBMS_OUTPUT.PUT_LINE('The password for the private key is not matching: ' || SQLERRM);
       ELSIF ORA_RSA.GET_RSA_ERROR() = ORA_RSA.RSA_KEY_ERR THEN
         DBMS_OUTPUT.PUT_LINE('The provided key is not a valid RSA key.');
       ELSIF ORA_RSA.GET_RSA_ERROR() = ORA_RSA.RSA_ENCRYPTION_ERR THEN
         DBMS_OUTPUT.PUT_LINE('Error when performing RSA operation: ' || SQLERRM);
       ELSIF ORA_RSA.GET_RSA_ERROR() = ORA_RSA.RSA_GENERAL_IO_ERR THEN
         DBMS_OUTPUT.PUT_LINE('I/O error: ' || SQLERRM);
       END IF;
     END;

   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('General error : ' || SQLERRM );  
END;

--------------CREATE SIGNATURE AND INSERT IT'S VALUES INTO TABLE PHANCONG--------------
declare
  private_key clob := '-----BEGIN PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMJOVHMWQpGWTiR7
F5z3WQIIvJYUDubZAPUxzj2NgriomhnowjgiK40Q2UPNxgBq3wlMhMpAp01+Or6R
2mkOctOZ55Qjgm2VzTovW4MuOLWGB43fXm3qDe05/SIdV3K3h2KVwcNqecJTR25T
RNeGHo4r8cce3BnuVzEKjk2DNQOXAgMBAAECgYEAuqIMQaL+++IYWrgU/UMkLmz/
31OS4K9NWTamt77F8eKYagyFCO/hTxUA6zyqU9pTMxZZcf9Z83gsqsFjvYcQSHy6
mRXFuORzh0r/wXKJtyFF0B26KC7WipqtPAuzn7SNGNeMh8g3H1qH8neEjir15Uai
6lR/sDIOZlO9sUJoZBECQQDkLXnXl/YXGoQDdupUQMzrF+ZK/od2U9YjdSOi+k/j
x23usurtzRhYGW/73vJd9Sw6Qc6ijPr+ItSpnl+qaxzvAkEA2f+OVzn1HwmYbc2a
Booo32aT96TJrwN8V4gC7m5hseHoXDDoXmwLZwNm7+w0vu3lk1p9tSqs8oc/nR0E
fHhT2QJAOQslasCSxTPbzQHtkyKgGCXhbN40/1/2KOcgAZ6SWl+BHCuej9S2QVAa
rt0Num+Qnv/UqM6V8PLEN6NgRzqAAQJBALeQYrp+WjKNcOYc97LECdC73qLsBswx
QjWumNFO70LLOE7Q/AnuLtfKXJZwrqWLSwJ+c1XnHoSGcIGK2qk45VkCQA6b1qCv
jGFksgcQ8vff5lwOWfJ2ZxA8Zpgeq5w7EaDTWS/WhtVUYg3bBsadgXb3LxpZScxq
U4Ad7pAZrI6H6Tc=
-----END PRIVATE KEY-----';
begin
  update phancong set signature= create_signature(0.5,private_key)   where manv='TC001001';
  update phancong set signature= create_signature(0.2,private_key)   where manv='TC002001';
  update phancong set signature= create_signature(0.1,private_key)   where manv='TP001002';
  update phancong set signature= create_signature(0.3,private_key)   where manv='TP003002';
  UPDATE PHANCONG SET signature= create_signature(0.8,private_key)  WHERE maNV='TP005002';
end;

-------------------------------VERIFY SIGNATURE------------------------------

declare
  in_public_key clob := '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCTlRzFkKRlk4kexec91kCCLyW
FA7m2QD1Mc49jYK4qJoZ6MI4IiuNENlDzcYAat8JTITKQKdNfjq+kdppDnLTmeeU
I4Jtlc06L1uDLji1hgeN315t6g3tOf0iHVdyt4dilcHDannCU0duU0TXhh6OK/HH
HtwZ7lcxCo5NgzUDlwIDAQAB
-----END PUBLIC KEY-----';
sig raw(2000);
phucap float;
begin 
  select phuCap into phucap from atbmdba.phancong where manv = user;
  select signature into sig from atbmdba.phancong where manv = user;
	  atbmdba.verify_signature(phucap, sig, in_public_key); 
END;

------GRANT FOR USER TO VERIFY SIGNATURE--------------
grant select on atbmdba.PHANCONG to TC001001;
grant execute on verify_generature to TC001001; 
