UPDATE TBL_JUSTIFICATION SET ISACTIVE = 'N', MODIFIEDDT = SYSDATE, MODIFIEDBY = 'SYSTEM' 
WHERE JUSTIFICATIONDESC IN ('Standard','Expedited') ;

COMMIT;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'Expedited Access Removal',SYSDATE,'SYSTEM','Y','SPONSOR') ;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'No Longer Employed by Sponsor',SYSDATE,'SYSTEM','Y','SPONSOR') ;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'Role doesn''t require access to SIP Platform',SYSDATE,'SYSTEM','Y','SPONSOR') ;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'Expedited Access Removal',SYSDATE,'SYSTEM','Y','SITE') ;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'Present on site but no longer requires access to Study',SYSDATE,'SYSTEM','Y','SITE') ;

INSERT INTO TBL_JUSTIFICATION (JUSTIFICATIONID,JUSTIFICATIONDESC,CREATEDDT,CREATEDBY,ISACTIVE,USERTYPE)
VALUES (SEQ_JUSTIFICATION.NEXTVAL,'No longer employed at site',SYSDATE,'SYSTEM','Y','SITE') ;

COMMIT; 