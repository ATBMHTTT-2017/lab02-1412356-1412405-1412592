----------------------Insert new column in table PHANCONG:signature-------------------
ALTER TABLE atbmhtttdba.PHANCONG
ADD 
(
  signature RAW(2000)
);

--------------------------CREATE FUNCTION create_signature AND verify_signature-------------------------
CREATE OR REPLACE FUNCTION create_signature(
                                       in_message IN NUMBER,
                                        in_private_key IN CLOB )
RETURN raw
IS
  signature RAW(2000);
BEGIN
    --
    -- RSA SIGN
    --
  signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(in_private_key),
        private_key_password => '',
        hash => ora_rsa.hash_sha256);
  RETURN signature;
END;

 
CREATE OR REPLACE FUNCTION verify_signature(in_message IN NUMBER, in_signature IN RAW, in_public_key IN CLOB)
RETURN varchar2 DETERMINISTIC
IS
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

DECLARE
  in_private_key CLOB := '-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgFHCVMcO2wbSdathk6+bhYZT4wfffgvFqPVx+m1XUWylNNUHNqMm
jDyesIRVPI83k5sg6i6TfW6s2kT5IDagtOwIS8uWaKnbkVkLV4HyBkkneGDZSD3A
/OwpQn+QnnCMQwgExXd79IdhiM4ja0pU8yPAGVQHXXCxXj3+aVy6Y0o/AgMBAAEC
gYAMBrHBtgWxszNryiaXJiE16RD0D4PS53g64lEb1EQ93u8uhqkaxojKQe1lCcSm
rF4h622G/Fru9K4Ghz6dynXSN5B3YdihuTxxI10yaCphkRtfbVX1a7GaxQjWDbI6
gNhP7TI0LtMTY0DiMdcgW32Qt4NtPDlmZrPoJeUFN8pDQQJBAJ1GHTP6pj7VPA9U
kWCMFUbW7pEVy9ACX0leQB/uG8YSmuh7nVmT6GXlt+A1yKBJGQ52SAH677w+0Kvw
YjLApXMCQQCFFQFj6qBZb/5lpHWhfwr+qseq16gSW+RweReJ9m8JP31Snl6ss2rD
3LppoIWsOLH32OH3L98RvfGhJ1DeU/UFAkAD1RqPErOMYmvVP81PGfrGwCQOGwbd
acFiq05KuOWqXPezZJfAAA+ws/lYGFdsOHvI028LxU6kOq+hEPmDnRgrAkA5vLhC
shtpUhZr4KMMMsMBY/SGYVPQyz9bsJ2OxHS97WagvobSpHCQkyXpB7SW2G4V2mmG
xaUg3GiFgzopiwFFAkAgAHirsCZaC0s1Ghf9qh9El6bBZa7pdCs5RayoaD44csMn
ZXjBZSlT7B5+GVO+BdpuIznbc9Ar+FEFflgRX6ZB
-----END RSA PRIVATE KEY-----';
signature RAW(2000);
BEGIN
FOR PC IN (SELECT * FROM PHANCONG)
  LOOP  
	  signature:=create_signature(PC.phuCap,in_private_key); 
	  UPDATE PHANCONG SET signature=signature WHERE maNV=PC.maNV;
	  COMMIT;
  END LOOP;
END;
-------------------------------VERIFY SIGNATURE------------------------------
DECLARE
in_public_key CLOB := '-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgFHCVMcO2wbSdathk6+bhYZT4wff
fgvFqPVx+m1XUWylNNUHNqMmjDyesIRVPI83k5sg6i6TfW6s2kT5IDagtOwIS8uW
aKnbkVkLV4HyBkkneGDZSD3A/OwpQn+QnnCMQwgExXd79IdhiM4ja0pU8yPAGVQH
XXCxXj3+aVy6Y0o/AgMBAAE=
-----END PUBLIC KEY-----';
BEGIN
FOR PC IN (SELECT * FROM atbmhtttdba.PHANCONG)
  LOOP  
	  IF PC.maNV=sys_context ('userenv', 'session_user') THEN
	  ATBMHTTTDBA.verify_signature(PC.phuCap,PC.signature, in_public_key); 
	  END IF;
  END LOOP;
END;

