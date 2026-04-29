FUNCTION zfm_create_cheque.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CTU) LIKE  APQI-PUTACTIVE DEFAULT 'X'
*"     VALUE(MODE) LIKE  APQI-PUTACTIVE DEFAULT 'N'
*"     VALUE(UPDATE) LIKE  APQI-PUTACTIVE DEFAULT 'L'
*"     VALUE(GROUP) LIKE  APQI-GROUPID OPTIONAL
*"     VALUE(USER) LIKE  APQI-USERID OPTIONAL
*"     VALUE(KEEP) LIKE  APQI-QERASE OPTIONAL
*"     VALUE(HOLDDATE) LIKE  APQI-STARTDATE OPTIONAL
*"     VALUE(NODATA) LIKE  APQI-PUTACTIVE DEFAULT '/'
*"     VALUE(VBLNR_001) LIKE  BDCDATA-FVAL DEFAULT ''
*"     VALUE(ZBUKR_002) LIKE  BDCDATA-FVAL DEFAULT ''
*"     VALUE(GJAHR_003) LIKE  BDCDATA-FVAL DEFAULT ''
*"     VALUE(HBKID_004) LIKE  BDCDATA-FVAL DEFAULT ''
*"     VALUE(HKTID_005) LIKE  BDCDATA-FVAL DEFAULT ''
*"     VALUE(CHECT_006) LIKE  BDCDATA-FVAL DEFAULT ''
*"  EXPORTING
*"     VALUE(SUBRC) LIKE  SYST-SUBRC
*"  TABLES
*"      MESSTAB STRUCTURE  BDCMSGCOLL OPTIONAL
*"----------------------------------------------------------------------

  subrc = 0.

  PERFORM bdc_nodata      USING nodata.

  PERFORM open_group      USING group user keep holddate ctu.

  PERFORM bdc_dynpro      USING 'SAPMFCHK' '0500'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'PAYR-CHECT'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=UPDA'.
  PERFORM bdc_field       USING 'PAYR-VBLNR'
                                vblnr_001.
  PERFORM bdc_field       USING 'PAYR-ZBUKR'
                                zbukr_002.
  PERFORM bdc_field       USING 'PAYR-GJAHR'
                                gjahr_003.
  PERFORM bdc_field       USING 'PAYR-HBKID'
                                hbkid_004.
  PERFORM bdc_field       USING 'PAYR-HKTID'
                                hktid_005.
  PERFORM bdc_field       USING 'PAYR-CHECT'
                                chect_006.
  PERFORM bdc_transaction TABLES messtab
  USING                         'FCH5'
                                ctu
                                mode
                                update.
  IF sy-subrc <> 0.
    subrc = sy-subrc.
    EXIT.
  ENDIF.

  PERFORM close_group USING     ctu.





ENDFUNCTION.
INCLUDE bdcrecxy .
