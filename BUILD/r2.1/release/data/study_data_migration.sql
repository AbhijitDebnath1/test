--  Migration for Study R2.1
-----------------------------


-- TBL_SITE 
UPDATE TBL_SITE SET ISINCLUDED1572 = 'N', MODIFIEDBY = 'SYSTEM', MODIFIEDDT = SYSDATE ;

COMMIT;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- TBL_SITECONTACTMAP
UPDATE TBL_SITECONTACTMAP SET STARTDATE = CREATEDDT , MODIFIEDBY = 'SYSTEM', MODIFIEDDT = SYSDATE ;
UPDATE TBL_SITECONTACTMAP SET ENDDATE = CREATEDDT , MODIFIEDBY = 'SYSTEM', MODIFIEDDT = SYSDATE ;

COMMIT;
----------------------------------------------------------------------------------------------------------------------------------------------------

--TBL_STUDYINDICATION

prompt --TBL_STUDYINDICATION before Count
SELECT COUNT(1) STUDYINDICATION_COUNT FROM TBL_STUDYINDICATION;

BEGIN
  FOR i IN(SELECT STUDYID,INDICATIONID,CREATEDBY,CREATEDDT
          FROM TBL_STUDY ) LOOP
          
    INSERT INTO TBL_STUDYINDICATION (STUDYINDICATIONID,STUDYID,INDICATIONID,ISACTIVE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYINDMAP.NEXTVAL,i.STUDYID,i.INDICATIONID,'Y',i.CREATEDBY,i.CREATEDDT) ;

    COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_STUDYINDICATION after Count
SELECT COUNT(1) STUDYINDICATION_COUNT FROM TBL_STUDYINDICATION;
----------------------------------------------------------------------------------------------------------------------------------------------------

--TBL_STUDYSECTIONSTATUS

prompt --TBL_STUDYSECTIONSTATUS before Count
SELECT COUNT(1) STUDYSECTIONSTATUS_COUNT FROM TBL_STUDYSECTIONSTATUS;

BEGIN
  FOR i IN(SELECT STUDYID,CREATEDBY,CREATEDDT
          FROM TBL_STUDY ) LOOP
          
    INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,1,'Y','Y',i.CREATEDBY,i.CREATEDDT);
    INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,2,'Y','Y',i.CREATEDBY,i.CREATEDDT) ;
	INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,3,'N','Y',i.CREATEDBY,i.CREATEDDT);
    INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,4,'N','Y',i.CREATEDBY,i.CREATEDDT) ;
	INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,5,'N','Y',i.CREATEDBY,i.CREATEDDT);
    INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,6,'N','Y',i.CREATEDBY,i.CREATEDDT) ;    
	INSERT INTO TBL_STUDYSECTIONSTATUS (STUDYSECTIONSTATUSID,STUDYID,SECTIONID,STATUS,ISAPPLICABLE,CREATEDBY,CREATEDDT)
    VALUES (SEQ_STUDYSECTIONSTATUS.NEXTVAL,i.STUDYID,7,'N','Y',i.CREATEDBY,i.CREATEDDT) ;
	
    COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_STUDYSECTIONSTATUS after Count
SELECT COUNT(1) STUDYSECTIONSTATUS_COUNT FROM TBL_STUDYSECTIONSTATUS;
----------------------------------------------------------------------------------------------------------------------------------------------------

--TBL_SITEIRBMAP

prompt --TBL_SITEIRBMAP before Count
SELECT COUNT(1) SITEIRBMAP_COUNT FROM TBL_SITEIRBMAP;

DECLARE
v_contactid  NUMBER (38,0);

BEGIN
  FOR i IN(SELECT * FROM TBL_ADDLSITEMAPPING WHERE IRBNAME IS NOT NULL ) LOOP
        
        BEGIN  
            SELECT CONTACTID into v_contactid FROM TBL_ADDITIONALFACILITY where ADDITIONALFACILITYID = i.ADDITIONALFACILITYID ;
        EXCEPTION 
            WHEN OTHERS THEN
                v_contactid := NULL;
        END;
        
        IF v_contactid IS NOT NULL THEN
            INSERT INTO TBL_SITEIRBMAP (SITEIRBID,SITEID,IRBTYPE,IRBNAME,CONTACTID,STATUS,STARTDATE,ENDDATE,STUDYID,FACILITYID,ISINCLUDED1572,MEETINGFREQUENCY,OTHMTNGFREQNAME,PACKSUBMISSION,REQPAYMENTAPPROVAL,REQBUDGETAPPROVAL,EXTERNALCENTRALIRBID,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
            VALUES (SEQ_SITEIRBMAP.NEXTVAL,i.SITEID,(SELECT tirt.irbtypeid FROM TBL_IRBTYPE tirt 
                                                     WHERE tirt.irbtypename = (CASE WHEN i.ethicscommtype = 'Review Only' THEN
                                                                                        'Review'
                                                                                    WHEN i.ethicscommtype = 'Central Acting as Local' THEN
                                                                                        'Central/Acts as Local'
                                                                                    ELSE
                                                                                        i.ethicscommtype
                                                                               END)),
                    i.IRBNAME,v_contactid,i.ISACTIVE,i.CREATEDDT,i.MODIFIEDDT,NULL,i.FACILITYID,NULL,
                    (SELECT tmf.meetingfreqid FROM TBL_MEETINGFREQ tmf WHERE tmf.MEETINGFREQNAME = i.meetingfreqirb),NULL,
                    (SELECT tps.packagesubid FROM TBL_PACKAGESUBMISSION tps WHERE tps.packagesubname = i.pkgsubperiod),i.ISIRBREQPAYMENT,i.ISIRBREQCONTAPPROVAL,NULL,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
        END IF;
        
        COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_SITEIRBMAP after Count
SELECT COUNT(1) SITEIRBMAP_COUNT FROM TBL_SITEIRBMAP;
----------------------------------------------------------------------------------------------------------------------------------------------------

--TBL_SITEIRBREGISTRATION

prompt --TBL_SITEIRBREGISTRATION before Count
SELECT COUNT(1) SITEIRBREGISTRATION_COUNT FROM TBL_SITEIRBREGISTRATION;

DECLARE
v_siteirbid  NUMBER (38,0);

BEGIN

  FOR i IN( select * from TBL_ADDLSITEMAPPING where IRBNAME IS NOT NULL AND REGISTRATIONNO IS NOT NULL ) LOOP
  
        BEGIN
           SELECT SITEIRBID into v_siteirbid FROM TBL_SITEIRBMAP WHERE IRBNAME = i.IRBNAME ;
        EXCEPTION 
           WHEN OTHERS THEN
              v_siteirbid := NULL;
        END;
          
        IF v_siteirbid IS NOT NULL THEN
            INSERT INTO TBL_SITEIRBREGISTRATION (SITEIRBREGISTRATIONID,SITEIRBID,REGISTRATIONNUMBER,REGISTERINTBODY,STATUS,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
            VALUES (SEQ_SITEIRBREGISTRATION.NEXTVAL,v_siteirbid,i.REGISTRATIONNO,NULL,i.ISACTIVE,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
        END IF;

        COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_SITEIRBREGISTRATION after Count
SELECT COUNT(1) SITEIRBREGISTRATION_COUNT FROM TBL_SITEIRBREGISTRATION;
----------------------------------------------------------------------------------------------------------------------------------------------------

--TBL_SITELABMAP

prompt --TBL_SITELABMAP before Count
SELECT COUNT(1) SITELABMAP_COUNT FROM TBL_SITELABMAP;

DECLARE
v_contactid  NUMBER (38,0);

BEGIN
  FOR i IN(SELECT * FROM TBL_ADDLSITEMAPPING WHERE LABNAME IS NOT NULL ) LOOP
          
          BEGIN
		  SELECT CONTACTID into v_contactid FROM TBL_ADDITIONALFACILITY where ADDITIONALFACILITYID = i.ADDITIONALFACILITYID ;
          EXCEPTION 
            WHEN OTHERS THEN
                v_contactid := NULL;
          END;
          
          IF v_contactid IS NOT NULL THEN
            INSERT INTO TBL_SITELABMAP (SITELABID,SITEID,LABTYPE,LABNAME,CONTACTID,STATUS,STARTDATE,ENDDATE,FACILITYID,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
            VALUES (SEQ_SITELABMAP.NEXTVAL,i.SITEID,'Local',i.LABNAME,v_contactid,i.ISACTIVE,i.CREATEDDT,i.MODIFIEDDT,i.FACILITYID,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
          END IF;
          
          COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_SITELABMAP after Count
SELECT COUNT(1) SITELABMAP_COUNT FROM TBL_SITELABMAP;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- TBL_SITELABACCREDITATION
prompt --TBL_SITELABACCREDITATION before Count
SELECT COUNT(1) SITELABACCREDITATION_COUNT FROM TBL_SITELABACCREDITATION;

DECLARE
v_sitelabid  NUMBER (38,0);
v_glp		 NUMBER (38,0);
v_clia		 NUMBER (38,0);
v_cap		 NUMBER (38,0);
v_iso		 NUMBER (38,0);


BEGIN

select LABACCREDITATIONID into v_glp from TBL_LABACCREDITATION where LABACCREDITATIONCD = 'GLP' ;
select LABACCREDITATIONID into v_clia from TBL_LABACCREDITATION where LABACCREDITATIONCD = 'CLIA' ;
select LABACCREDITATIONID into v_cap from TBL_LABACCREDITATION where LABACCREDITATIONCD = 'CAP' ;
select LABACCREDITATIONID into v_iso from TBL_LABACCREDITATION where LABACCREDITATIONCD = 'ISO' ;

  FOR i IN(SELECT * FROM TBL_ADDLSITEMAPPING WHERE GLP = 'Y' OR CLIA = 'Y' OR CAP = 'Y' OR ISO = 'Y' ) LOOP
          
        BEGIN
            SELECT SITELABID into v_sitelabid FROM TBL_SITELABMAP where siteid = i.siteid AND LABNAME = i.LABNAME ;
		EXCEPTION
          WHEN OTHERS THEN
              v_sitelabid := NULL;
        END;
         
        IF v_sitelabid IS NOT NULL THEN 
        IF i.GLP = 'Y' THEN
		   INSERT INTO TBL_SITELABACCREDITATION (SITEACCREDITATIONID,SITELABID,LABACCREDITATIONID,OTHERLABACCREDITATION,STATUS,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
		   VALUES (SEQ_SITELABACCREDITATION.NEXTVAL,v_sitelabid,v_glp,i.OTHERACCREDITATION,i.ISACTIVE,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
		ELSIF
			i.CLIA = 'Y' THEN
			INSERT INTO TBL_SITELABACCREDITATION (SITEACCREDITATIONID,SITELABID,LABACCREDITATIONID,OTHERLABACCREDITATION,STATUS,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
		   VALUES (SEQ_SITELABACCREDITATION.NEXTVAL,v_sitelabid,v_clia,i.OTHERACCREDITATION,i.ISACTIVE,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
		ELSIF
			i.CAP = 'Y' THEN
			INSERT INTO TBL_SITELABACCREDITATION (SITEACCREDITATIONID,SITELABID,LABACCREDITATIONID,OTHERLABACCREDITATION,STATUS,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
		   VALUES (SEQ_SITELABACCREDITATION.NEXTVAL,v_sitelabid,v_cap,i.OTHERACCREDITATION,i.ISACTIVE,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
		ELSIF
			i.ISO = 'Y' THEN
			INSERT INTO TBL_SITELABACCREDITATION (SITEACCREDITATIONID,SITELABID,LABACCREDITATIONID,OTHERLABACCREDITATION,STATUS,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
		   VALUES (SEQ_SITELABACCREDITATION.NEXTVAL,v_sitelabid,v_iso,i.OTHERACCREDITATION,i.ISACTIVE,i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
		END IF;
        END IF;
    
        COMMIT;
  
  END LOOP;
END;
/

prompt --TBL_SITELABACCREDITATION after Count
SELECT COUNT(1) SITELABACCREDITATION_COUNT FROM TBL_SITELABACCREDITATION;
------------------------------------------------------------------------------------------------------------------------------------------------
--TBL_SITESTAFFACMAPPING
prompt --TBL_SITESTAFFACMAPPING before Count
SELECT COUNT(1) SITESTAFFACMAPPING_COUNT FROM TBL_SITESTAFFACMAPPING;

DECLARE 
facid number (38,0) ;

BEGIN

    FOR i IN(SELECT DISTINCT SITEID,USERROLEID,CREATEDDT,CREATEDBY,MODIFIEDDT,MODIFIEDBY FROM TBL_USERROLEMAP 
            WHERE SITEID IS NOT NULL 
            and userid in (select userid from tbl_userprofiles where issponsor = 'N' )
            and siteid in (select siteid from tbl_site where isactive = 'Y') ) LOOP

        BEGIN
        SELECT PRINCIPALFACILITYID into facid FROM TBL_SITE WHERE SITEID = i.SITEID ;           
        EXCEPTION
            WHEN OTHERS THEN
                 facid := NULL;
        END;    
        
        IF facid IS NOT NULL THEN
            INSERT INTO TBL_SITESTAFFACMAPPING (SITESTAFFID,USERROLEID,FACILITYID,ISPRIMARYFACILITY,CREATEDBY,CREATEDDT,MODIFIEDBY,MODIFIEDDT)
            VALUES (SEQ_SITESTAFFACMAPPING.NEXTVAL,i.USERROLEID,facid,'Y',i.CREATEDBY,i.CREATEDDT,i.MODIFIEDBY,i.MODIFIEDDT) ;
        END IF;
        
        COMMIT;
        
    END LOOP;
END;
/

prompt --TBL_SITESTAFFACMAPPING after Count
SELECT COUNT(1) SITESTAFFACMAPPING_COUNT FROM TBL_SITESTAFFACMAPPING;
------------------------------------------------------------------------------------------------------------------------------------------------          