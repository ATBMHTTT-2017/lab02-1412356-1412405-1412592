-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MODIFY TABLES

ALTER TABLE atbmhtttdba.CHITIEU
RENAME COLUMN soTien TO soTienRaw;

ALTER TABLE atbmhtttdba.CHITIEU
ADD 
(
  soTien RAW(1024),
   hashedKey RAW(128)
);





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HASH KEY FUNCTION

CREATE OR REPLACE 
FUNCTION fn_hash_key
(
  in_key IN VARCHAR2
)
RETURN RAW
AS
BEGIN
	RETURN dbms_crypto.HASH( 
                                                        src => UTL_RAW.cast_to_raw(in_key),
                                                        TYP => DBMS_CRYPTO.HASH_SH1
                                                       );
END;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ENCRYPT FUNCTION

CREATE OR REPLACE
FUNCTION fn_encrypt
(
  in_data IN VARCHAR2, 
  in_key IN VARCHAR2
)
return RAW DETERMINISTIC
AS
BEGIN
	RETURN DBMS_CRYPTO.encrypt( 
                                                                  src => in_data,
                                                                  typ => dbms_crypto.DES_CBC_PKCS5,
                                                                  key =>UTL_RAW.cast_to_raw(in_key)
                                                                );
END;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DECRYPT  FUNCTION

CREATE OR REPLACE
FUNCTION fn_decrypt_to_number
(
  in_data IN VARCHAR2,
  in_hashed_key IN VARCHAR2,
  in_key IN VARCHAR2
)
RETURN NUMBER
AS
BEGIN
	IF (dbms_crypto.HASH(src => UTL_RAW.cast_to_raw(in_key),typ => dbms_crypto.HASH_SH1) = in_hashed_key)  THEN
    RETURN to_number(dbms_crypto.decrypt(
                                                                                  src => in_data,
                                                                                  typ => dbms_crypto.DES_CBC_PKCS5,
                                                                                  KEY => UTL_RAW.cast_to_raw(in_key)
                                                                                ));
    ELSE
		RETURN NULL;
	END IF;
END;

CREATE OR REPLACE
FUNCTION fn_decrypt_to_raw
(
  in_data IN VARCHAR2,
  in_hashed_key IN VARCHAR2,
  in_key IN VARCHAR2
)
RETURN RAW
AS
BEGIN
	IF (dbms_crypto.HASH(src => UTL_RAW.cast_to_raw(in_key),typ => dbms_crypto.HASH_SH1) = in_hashed_key)  THEN
    RETURN dbms_crypto.decrypt(
                                                              src => in_data,
                                                              typ => dbms_crypto.DES_CBC_PKCS5,
                                                              KEY => UTL_RAW.cast_to_raw(in_key)
                                                            );
    ELSE
		RETURN in_data;
	END IF;
END;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE hashedKey COLUMN

UPDATE atbmhtttdba.CHITIEU SET hashedKey = fn_hash_key('TD001103') WHERE duAn = '001011';
UPDATE atbmhtttdba.CHITIEU SET hashedKey = fn_hash_key('TD002103') WHERE duAn = '002012';
UPDATE atbmhtttdba.CHITIEU SET hashedKey = fn_hash_key('TD003103') WHERE duAn = '003033';
UPDATE atbmhtttdba.CHITIEU SET hashedKey = fn_hash_key('TD004103') WHERE duAn = '004014';
UPDATE atbmhtttdba.CHITIEU SET hashedKey = fn_hash_key('TD005103') WHERE duAn = '005015';





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE soTien COLUMN

UPDATE atbmhtttdba.CHITIEU SET soTien = fn_encrypt(soTienRaw, 'TD001103') WHERE duAn = '001011';
UPDATE atbmhtttdba.CHITIEU SET soTien = fn_encrypt(soTienRaw, 'TD002103') WHERE duAn = '002012';
UPDATE atbmhtttdba.CHITIEU SET soTien = fn_encrypt(soTienRaw, 'TD003103') WHERE duAn = '003033';
UPDATE atbmhtttdba.CHITIEU SET soTien = fn_encrypt(soTienRaw, 'TD004103') WHERE duAn = '004014';
UPDATE atbmhtttdba.CHITIEU SET soTien = fn_encrypt(soTienRaw, 'TD005103') WHERE duAn = '005015';





