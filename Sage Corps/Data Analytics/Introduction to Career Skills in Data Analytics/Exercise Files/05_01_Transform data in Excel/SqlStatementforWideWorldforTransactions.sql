SELECT        Purchasing.SupplierTransactions.SupplierTransactionID, Purchasing.SupplierTransactions.SupplierID, Purchasing.SupplierTransactions.PurchaseOrderID, Purchasing.SupplierTransactions.SupplierInvoiceNumber, 
                         Purchasing.SupplierTransactions.TransactionDate, Purchasing.SupplierTransactions.AmountExcludingTax, Purchasing.SupplierTransactions.TaxAmount, Purchasing.SupplierTransactions.FinalizationDate, 
                         Purchasing.Suppliers.SupplierName
FROM            Purchasing.SupplierTransactions INNER JOIN
                         Purchasing.Suppliers ON Purchasing.SupplierTransactions.SupplierID = Purchasing.Suppliers.SupplierID
--ORDER BY Purchasing.SupplierTransactions.SupplierID, Purchasing.SupplierTransactions.FinalizationDate
where PurchaseOrderID is not null	
