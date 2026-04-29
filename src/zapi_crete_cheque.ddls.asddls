@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'API para creacion de cheques'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZAPI_CRETE_CHEQUE
  as select from I_PaymentData
{
  key ClearingDocumentNumber,
  key ClearingDocumentYear,
      PaymentDate,
      PaymentDateTime
}
where
  PaymentType = 'C'
