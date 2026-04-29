INTERFACE zif_create_cheque
  PUBLIC .


  TYPES:
    bdc_fval                       TYPE c LENGTH 000132 ##TYPSHADOW .
  TYPES:
    apq_ouac                       TYPE c LENGTH 000001 ##TYPSHADOW .
  TYPES:
    apq_grpn                       TYPE c LENGTH 000012 ##TYPSHADOW .
  TYPES apq_stda TYPE d .
  TYPES:
    apq_qdel                       TYPE c LENGTH 000001 ##TYPSHADOW .
  TYPES:
    apq_mapn                       TYPE c LENGTH 000012 ##TYPSHADOW .
  TYPES syst_subrc TYPE int4 .
  TYPES:
    bdc_tcode TYPE c LENGTH 000020 ##TYPSHADOW .
  TYPES:
    bdc_module TYPE c LENGTH 000040 ##TYPSHADOW .
  TYPES:
    bdc_dynnr TYPE c LENGTH 000004 ##TYPSHADOW .
  TYPES:
    bdc_mart TYPE c LENGTH 000001 ##TYPSHADOW .
  TYPES:
    bdc_spras TYPE c LENGTH 000001 ##TYPSHADOW .
  TYPES:
    bdc_mid TYPE c LENGTH 000020 ##TYPSHADOW .
  TYPES:
    bdc_mnr TYPE c LENGTH 000003 ##TYPSHADOW .
  TYPES:
    bdc_vtext1 TYPE c LENGTH 000100 ##TYPSHADOW .
  TYPES:
    bdc_akt TYPE c LENGTH 000004 ##TYPSHADOW .
  TYPES:
    fnam_____4 TYPE c LENGTH 000132 ##TYPSHADOW .
  TYPES:
    BEGIN OF bdcmsgcoll                    ,
      tcode   TYPE bdc_tcode,
      dyname  TYPE bdc_module,
      dynumb  TYPE bdc_dynnr,
      msgtyp  TYPE bdc_mart,
      msgspra TYPE bdc_spras,
      msgid   TYPE bdc_mid,
      msgnr   TYPE bdc_mnr,
      msgv1   TYPE bdc_vtext1,
      msgv2   TYPE bdc_vtext1,
      msgv3   TYPE bdc_vtext1,
      msgv4   TYPE bdc_vtext1,
      env     TYPE bdc_akt,
      fldname TYPE fnam_____4,
    END OF bdcmsgcoll                     ##TYPSHADOW .
  TYPES:
    _bdcmsgcoll                    TYPE STANDARD TABLE OF bdcmsgcoll                     WITH DEFAULT KEY ##TYPSHADOW .

  METHODS zfm_create_cheque
    IMPORTING
      !chect_006     TYPE bdc_fval DEFAULT ''
      !ctu           TYPE apq_ouac DEFAULT 'X'
      !gjahr_003     TYPE bdc_fval DEFAULT ''
      !group         TYPE apq_grpn OPTIONAL
      !hbkid_004     TYPE bdc_fval DEFAULT ''
      !hktid_005     TYPE bdc_fval DEFAULT ''
      !holddate      TYPE apq_stda OPTIONAL
      !keep          TYPE apq_qdel OPTIONAL
      !mode          TYPE apq_ouac DEFAULT 'N'
      !nodata        TYPE apq_ouac DEFAULT '/'
      !update        TYPE apq_ouac DEFAULT 'L'
      !user          TYPE apq_mapn OPTIONAL
      !vblnr_001     TYPE bdc_fval DEFAULT ''
      !zbukr_002     TYPE bdc_fval DEFAULT ''
    EXPORTING
      !subrc         TYPE syst_subrc
      !_rfc_message_ TYPE aco_proxy_msg_type
    CHANGING
      !messtab       TYPE _bdcmsgcoll OPTIONAL
    EXCEPTIONS
      rfc_communication_failure
      rfc_system_failure
      rfc_others .
ENDINTERFACE.
