CREATE OR REPLACE TABLE ANALYTICS_DB.CULTIVATION.INVOICES_BIOTRACK as
select PO,
       DISPENSARY,
       STATE,
       DATE,
       SKU_NAME,
       PRICE,
       QUANTITY,
       REVENUE,
       GROSS_SALES,
       STATUS,
       BRAND,
       CATEGORY,
       FORM,
       TYPE,
       SIZE,
       ITEM_ID,
       a.STRAIN,
       STRAIN_TYPE,
       STRAIN_STATUS,
       PACKAGED_WEIGHT,
       DRY_EQUIVALENT_WEIGHT,
       GROW_FACILITY,
       SKU_VOLUME_GRAMS,
       SKU_VOLUME_DRY_EQUIVALENT_GRAMS,
       SALES_REP,
       EXTRACTION_METHOD,
       CBD_RATIO,
       PROJECT_ID,
       DISCOUNT,
       ZIP,
       FIPS,
       CRESCO_OWNED,
       IS_SAMPLE,
       SALES_REP_COMPANY,
       MSO_FLG,
       CULTIVATOR, remainingweight as Remaining_Weight,INVENTORYROOM_NAME as BT_INVENTORYROOM,PRODUCTID as BT_PRODUCT
from "ANALYTICS_DB"."WHOLESALE"."WHOLESALE_SALES" a
left join (select  sum(remainingweight) as remainingweight, productid, strain, INVENTORY_ID, INVENTORYROOM_NAME from ANALYTICS_DB.CULTIVATION.BIOTRACK_CURRENT_INVENTORY where   inventoryroom_name like '%Pre%'
group by productid, strain, INVENTORY_ID, INVENTORYROOM_NAME) b


on lower(b.productid) like lower(concat('%',split_part(SKU_NAME,' - ',1),'%'))   and
   lower(b.productid) like concat('%', CONCAT(LOWER(SPLIT_PART(split_part(split_part(SKU_NAME, ' - ', 2), 'g', 1), ' ',
                                                                1)), '%'))
   and lower(b.productid) like CASE WHEN
                                                                    CONCAT('%',
LOWER(SPLIT_PART(split_part(SKU_NAME,' - ',2),' ' , 2))
     ,'%') in ('%7g%','%14g%')
                                                                 THEN   REPLACE(CONCAT('%',
LOWER(SPLIT_PART(split_part(SKU_NAME,' - ',2),' ' , 2))
     ,'%'), 'g','.0')
                                                                ELSE REPLACE(CONCAT('%',
LOWER(SPLIT_PART(split_part(SKU_NAME,' - ',2),' ' , 2))
     ,'%'),'g','') END
and lower(b.productid) like lower(concat('%',split_part(SKU_NAME,' - ',3),'%'))

where status = 'Pending' and state = 'IL'
group by
PO,
       DISPENSARY,
       STATE,
       DATE,
       SKU_NAME,
       PRICE,
       QUANTITY,
       REVENUE,
       GROSS_SALES,
       STATUS,
       BRAND,
       CATEGORY,
       FORM,
       TYPE,
       SIZE,
       ITEM_ID,
       a.STRAIN,
       STRAIN_TYPE,
       STRAIN_STATUS,
       PACKAGED_WEIGHT,
       DRY_EQUIVALENT_WEIGHT,
       GROW_FACILITY,
       SKU_VOLUME_GRAMS,
       SKU_VOLUME_DRY_EQUIVALENT_GRAMS,
       SALES_REP,
       EXTRACTION_METHOD,
       CBD_RATIO,
       PROJECT_ID,
       DISCOUNT,
       ZIP,
       FIPS,
       CRESCO_OWNED,
       IS_SAMPLE,
       SALES_REP_COMPANY,
       MSO_FLG,
       CULTIVATOR, INVENTORY_ID, remainingweight , INVENTORYROOM_NAME , PRODUCTID;