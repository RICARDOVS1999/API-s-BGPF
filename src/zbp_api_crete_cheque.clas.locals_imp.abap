CLASS lhc_ZAPI_CRETE_CHEQUE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA gs_create_cheque TYPE za_input_data_cheque_create.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zapi_crete_cheque RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zapi_crete_cheque RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zapi_crete_cheque.

    METHODS create_cheque FOR MODIFY
      IMPORTING keys FOR ACTION zapi_crete_cheque~create_cheque RESULT result.

ENDCLASS.

CLASS lhc_ZAPI_CRETE_CHEQUE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD create_cheque.
    ASSIGN keys[ 1 ] TO FIELD-SYMBOL(<fs_key>).
    DATA ls_create_cheque TYPE za_input_data_cheque_create.

    ls_create_cheque = VALUE #( Banco_propio    = <fs_key>-%param-Banco_propio
                                Ejercicio       = <fs_key>-%param-Ejercicio
                                ID_Cuenta       = <fs_key>-%param-ID_Cuenta
                                Numero_Cheque   = <fs_key>-%param-Numero_Cheque
                                Numero_doc_pago = <fs_key>-%param-Numero_doc_pago
                                Sociedad        = <fs_key>-%param-Sociedad ).

    IF ls_create_cheque IS NOT INITIAL.
      gs_create_cheque = ls_create_cheque.

      APPEND VALUE #( %key   = <fs_key>-%key
                      %param = VALUE #( tipo    = 'S'
                                        clase   = 'SUC'
                                        mensaje = 'Prueba existosa' ) )
             TO result.
    ELSE.
      APPEND VALUE #(
     %tky = <fs_key>-%tky
     %msg = new_message(
       id       = 'ZAPI_INPUT_FIELDS'
       number   = '001'
       severity = if_abap_behv_message=>severity-error
*                              v1       = 'Error en API externa'
     )
 ) TO reported-zapi_crete_cheque.

      APPEND VALUE #( %tky =  <fs_key>-%tky ) TO failed-zapi_crete_cheque.
      RETURN.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZAPI_CRETE_CHEQUE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZAPI_CRETE_CHEQUE IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    DATA lo_operation TYPE REF TO if_bgmc_op_single.
    DATA(ls_create_cheque) = lhc_zapi_crete_cheque=>gs_create_cheque.

    lo_operation = NEW zcl_bgpf_call_fch5( ls_create_cheque ).

    TRY.
        DATA(lo_process) = cl_bgmc_process_factory=>get_default( )->create( ).

        lo_process->set_name( 'Controlled Process' )->set_operation( lo_operation ).

        lo_process->save_for_execution(
*          RECEIVING
*            ro_monitor =
        ).
      CATCH cx_bgmc INTO DATA(lx_bgmc).
        DATA(lv_message) = lx_bgmc->get_text(  ).

        APPEND VALUE #(  %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                             text = lv_message )
                         ) TO  reported-zapi_crete_cheque .

        " raise exception .
        RAISE EXCEPTION lx_bgmc.
    ENDTRY.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
