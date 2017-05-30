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


 


