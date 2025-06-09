/****** Script for SelectTopNRows command from SSMS  ******/
SELECT     Purchasing.SupplierTransactions.SupplierTransactionID, Purchasing.SupplierTransactions.SupplierID, Purchasing.SupplierTransactions.TransactionTypeID, Purchasing.SupplierTransactions.PurchaseOrderID, Purchasing.SupplierTransactions.PaymentMethodID, 
                  Purchasing.SupplierTransactions.SupplierInvoiceNumber, Purchasing.SupplierTransactions.TransactionDate, Purchasing.SupplierTransactions.AmountExcludingTax, Purchasing.SupplierTransactions.TaxAmount, Purchasing.SupplierTransactions.TransactionAmount, 
                  Purchasing.SupplierTransactions.OutstandingBalance, Purchasing.SupplierTransactions.FinalizationDate, Purchasing.SupplierTransactions.IsFinalized, Purchasing.SupplierTransactions.LastEditedBy, Purchasing.SupplierTransactions.LastEditedWhen, 
                  Purchasing.Suppliers.SupplierName
FROM        Purchasing.SupplierTransactions LEFT OUTER JOIN
                  Purchasing.Suppliers ON Purchasing.SupplierTransactions.SupplierID = Purchasing.Suppliers.SupplierID