
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'GLP','GLP','SYSTEM',SYSDATE,null,null);
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'CLIA','CLIA','SYSTEM',SYSDATE,null,null);
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'CAP','CAP','SYSTEM',SYSDATE,null,null);
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'ISO','ISO','SYSTEM',SYSDATE,null,null);
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'OTHER','Other','SYSTEM',SYSDATE,null,null);
Insert into TBL_LABACCREDITATION (LABACCREDITATIONID,LABACCREDITATIONCD,LABACCREDITATIONNAME,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT) 
values (SEQ_LABACCREDITATION.NEXTVAL,'NONE','None','SYSTEM',SYSDATE,null,null);
update TBL_LABACCREDITATION SET LABACCREDITATIONNAME = 'Others' where LABACCREDITATIONID = 5; 

COMMIT;