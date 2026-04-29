@EndUserText.label: 'Definción de parametros de entrada'
define root abstract entity ZA_INPUT_DATA_CHEQUE_CREATE
{
  Numero_doc_pago : vblnr;
  Sociedad        : dzbukr;
  Ejercicio       : gjahr;
  Banco_propio    : hbkid;
  ID_Cuenta       : hktid;
  Numero_Cheque   : chect;
}
