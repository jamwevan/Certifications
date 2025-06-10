SELECT     SupplierTransactionID, SupplierID, PurchaseOrderID, SupplierInvoiceNumber, TransactionDate, AmountExcludingTax, TaxAmount, FinalizationDate
FROM        Purchasing.SupplierTransactions
WHere FinalizationDate > '2014-12-31'
Order By SupplierID, FinalizationDate
