CLASS zcl_bgpf_call_fch5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor IMPORTING i_create_cheque TYPE za_input_data_cheque_create .
    INTERFACES if_serializable_object .
    INTERFACES if_bgmc_operation .
    INTERFACES if_bgmc_op_single .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gs_create_cheque TYPE za_input_data_cheque_create.
ENDCLASS.



CLASS zcl_bgpf_call_fch5 IMPLEMENTATION.


  METHOD if_bgmc_op_single~execute.

    cl_abap_tx=>modify( ).
    DATA lt_messtab TYPE STANDARD TABLE OF bdcmsgcoll.
    DATA(lo_fm_inst) = zcl_crete_cheque=>create_instance(
*                           destination =
                        ).
    cl_abap_tx=>save( ).

    lo_fm_inst->zfm_create_cheque(
      EXPORTING  chect_006                 = CONV bdc_fval( gs_create_cheque-Numero_Cheque )
                 ctu                       = 'X'
                 gjahr_003                 = CONV bdc_fval( gs_create_cheque-Ejercicio )
                 hbkid_004                 = CONV bdc_fval( gs_create_cheque-Banco_propio )
                 hktid_005                 = CONV bdc_fval( gs_create_cheque-ID_Cuenta )
                 mode                      = 'N'
                 nodata                    = '/'
                 update                    = 'L'
                 vblnr_001                 = CONV bdc_fval( gs_create_cheque-Numero_doc_pago )
                 zbukr_002                 = CONV bdc_fval( gs_create_cheque-Sociedad )
      IMPORTING
                 subrc                     = DATA(lv_subrc)
                 _rfc_message_             = DATA(lv_rfc_message)
      CHANGING
                 messtab                   = lt_messtab
      EXCEPTIONS rfc_communication_failure = 1
                 rfc_system_failure        = 2
                 rfc_others                = 3
                 OTHERS                    = 4 ).
    IF line_exists( lt_messtab[ msgtyp  = 'E' ] ).
      ASSIGN lt_messtab[ 1 ] TO FIELD-SYMBOL(<fs_messtab>).

      RAISE EXCEPTION NEW cx_bgmc_operation( textid = VALUE #( msgid = <fs_messtab>-msgid
                                                               msgno = <fs_messtab>-msgnr
                                                 )
                                             ).

    ENDIF.
  ENDMETHOD.
  METHOD constructor.
    CLEAR gs_create_cheque.
    gs_create_cheque = i_create_cheque.
  ENDMETHOD.

ENDCLASS.
