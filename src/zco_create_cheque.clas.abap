CLASS zco_create_cheque DEFINITION
  PUBLIC
  CREATE PRIVATE

  GLOBAL FRIENDS zcl_crete_cheque .

  PUBLIC SECTION.

    INTERFACES if_aco_proxy .
    INTERFACES zif_create_cheque .
  PROTECTED SECTION.

    DATA destination TYPE rfcdest .
  PRIVATE SECTION.

    METHODS constructor
      IMPORTING
        !destination TYPE rfcdest .
ENDCLASS.



CLASS zco_create_cheque IMPLEMENTATION.


  METHOD constructor.
    me->destination = destination.
  ENDMETHOD.


  METHOD zif_create_cheque~zfm_create_cheque.
    CALL FUNCTION 'ZFM_CREATE_CHEQUE'
      DESTINATION me->destination
      EXPORTING
        chect_006             = chect_006
        ctu                   = ctu
        gjahr_003             = gjahr_003
        group                 = group
        hbkid_004             = hbkid_004
        hktid_005             = hktid_005
        holddate              = holddate
        keep                  = keep
        mode                  = mode
        nodata                = nodata
        update                = update
        user                  = user
        vblnr_001             = vblnr_001
        zbukr_002             = zbukr_002
      TABLES
        messtab               = messtab
      EXCEPTIONS
        communication_failure = 1 MESSAGE _rfc_message_
        system_failure        = 2 MESSAGE _rfc_message_
        OTHERS                = 3.
    IF sy-subrc NE 0.
      CASE sy-subrc.
        WHEN 1 .
          RAISE rfc_communication_failure.
        WHEN 2 .
          RAISE rfc_system_failure.
        WHEN 3 .
          RAISE rfc_others.
      ENDCASE.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
