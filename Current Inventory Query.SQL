create or replace table ANALYTICS_DB.CULTIVATION.BIOTRACK_CURRENT_INVENTORY as
select * from ANALYTICS_DB.CULTIVATION.LEVEL_FINAL where transferredout = 0 and remainingweight > 0 and deleted = 0
