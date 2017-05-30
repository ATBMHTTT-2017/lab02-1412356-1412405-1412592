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





