CLASS zcl_crete_cheque DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS create_instance
      IMPORTING
        !destination  TYPE rfcdest OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO zif_create_cheque .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS constructor .
ENDCLASS.



CLASS zcl_crete_cheque IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD create_instance.
    result = NEW zco_create_cheque( destination = destination  ).
  ENDMETHOD.
ENDCLASS.
