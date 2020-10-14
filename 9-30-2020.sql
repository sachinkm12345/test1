SELECT BU.NAME,
       A.RECEIPT_NUMBER,
       A.RECEIPT_DATE,
       B.GL_DATE  AS ACCOUNTING_DATE,
       A.CURRENCY_CODE,
       ROUND(A.AMOUNT,2) AS ENTERED_AMOUNT,
       ROUND(B.AMOUNT_APPLIED,2) AS APPLIED_AMOUNT,
       A.STATUS 


FROM HR_ORGANIZATION_UNITS_F_TL BU,
     AR_CASH_RECEIPTS_ALL A,
     AR_PAYMENT_SCHEDULES_ALL B,
     AR_RECEIVABLE_APPLICATIONS_ALL C

WHERE BU.ORGANIZATION_ID = A.ORG_ID
AND   A.CASH_RECEIPT_ID = B.CASH_RECEIPT_ID 
AND   B.CASH_RECEIPT_ID = C.CASH_RECEIPT_ID 
AND   C.DISPLAY = 'Y' 
AND   UPPER(A.STATUS) = 'APP'
AND BU.NAME = NVL(:P_BU_NAME,BU.NAME)
AND A.RECEIPT_NUMBER = NVL(:P_R_NUMBER,A.RECEIPT_NUMBER)
AND A.RECEIPT_DATE BETWEEN (:P_FROM) AND (:P_TO)


====================================================re num  lov
  SELECT A.RECEIPT_NUMBER FROM AR_CASH_RECEIPTS_ALL A ,HR_ORGANIZATION_UNITS_F_TL BU
WHERE BU.NAME = NVL(:P_BU_NAME , BU.NAME)


SELECT BU.NAME,
       A.RECEIPT_NUMBER,
       A.RECEIPT_DATE,
       B.GL_DATE  AS ACCOUNTING_DATE,
       A.CURRENCY_CODE,
       ROUND(A.AMOUNT,2) AS ENTERED_AMOUNT,
       ROUND(B.AMOUNT_APPLIED,2) AS APPLIED_AMOUNT


FROM HR_ORGANIZATION_UNITS_F_TL BU,
     AR_CASH_RECEIPTS_ALL A,
     AR_PAYMENT_SCHEDULES_ALL B,
     AR_RECEIVABLE_APPLICATIONS_ALL C

WHERE BU.ORGANIZATION_ID = A.ORG_ID
AND   A.CASH_RECEIPT_ID = B.CASH_RECEIPT_ID 
AND   B.CASH_RECEIPT_ID = C.CASH_RECEIPT_ID 
AND   C.DISPLAY = 'Y' 
AND BU.NAME = NVL(:P_BU_NAME,BU.NAME)
AND A.RECEIPT_NUMBER = NVL(:P_R_NUMBER,A.RECEIPT_NUMBER)
AND A.RECEIPT_DATE BETWEEN (:P_FROM) AND (:P_TO)

=============================================================================bursting query

SELECT DISTINCT  BU.NAME                                           AS KEY,
                'Test_layout'                                      AS template,
                'en-US'                                            AS locale,
                'EXCEL'                                             AS output_format,
                'EMAIL'                                            AS del_channel,
                'Test Receipts Report'                              AS output_name,
                'sackm@deloitte.com'                               AS parameter1,
                'bip-collections@oracle.com'                       AS parameter3,
                'Test Receipts Report'                              AS parameter4,
                'Hi'
                || ','
                || BU.NAME
                || 'Please find attached the test invoice report.' AS parameter5,
                'TRUE'                                             AS parameter6
FROM HR_ORGANIZATION_UNITS_F_TL BU
WHERE (:P_BU_NAME) IS NULL 






















[‎9/‎30/‎2020 12:20 PM]  Parab, Sonal Sanjay:  
No Title 
select distinct
fabuv.BU_NAME as KEY,
'Bursting_Layout' as template,
'en-US' as locale,
'EXCEL' AS output_format,
'Receipts_Report1' as output_name,
'EMAIL' AS del_channel,
'sparab@deloitte.com' as parameter1,
'bip-collections@oracle.com' as parameter3,
'Receipts Report' as parameter4,
 'Hi, Please find your Receipt attached to this mail.' AS parameter5,
'TRUE' AS parameter6,
'parab.sonal108@gmail.com' as parameter7
from
FUN_ALL_BUSINESS_UNITS_V fabuv,
AR_CASH_RECEIPTS_ALL acra,
AR_PAYMENT_SCHEDULES_ALL apsa,
AR_RECEIVABLE_APPLICATIONS_ALL araa
where
acra.ORG_ID = fabuv.BU_ID
and acra.CASH_RECEIPT_ID = apsa.CASH_RECEIPT_ID
and acra.CASH_RECEIPT_ID = araa.CASH_RECEIPT_ID
and araa.DISPLAY = 'Y'
and acra.STATUS = 'APP'
and (fabuv.BU_NAME in (:p_bu) OR LEAST(:p_bu) IS NULL)
and acra.receipt_date between (:p_from_date) and (:p_to_date)
and acra.RECEIPT_NUMBER = NVL(:p_receipt_num, acra.RECEIPT_NUMBER) 
 
