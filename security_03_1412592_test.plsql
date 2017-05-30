-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 
SELECT  dbms_crypto.HASH(UTL_RAW.cast_to_raw( 'TD001103' ), 3),hashedKey FROM atbmhtttdba.CHITIEU, DUAL WHERE duAn = '001011';

SELECT maChiTieu,  fn_decrypt_to_number(soTien, hashedKey, 'TD005103') AS soTien, soTienRaw, duAn
FROM atbmhtttdba.CHITIEU;

SELECT maChiTieu,  fn_decrypt_to_raw(soTien, hashedKey, 'TD001103') AS soTien, soTienRaw, duAn
FROM atbmhtttdba.CHITIEU;

