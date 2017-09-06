#!/usr/local/bin/powershell

 $ref_tables = @("Application.People", 
            "Application.Countries", 
            "Application.StateProvinces", 
            "Application.Cities", 
            "Application.DeliveryMethods", 
            "Application.PaymentMethods", 
            "Application.TransactionTypes", 
            "Purchasing.SupplierCategories",
            "Purchasing.Suppliers",
            "Sales.BuyingGroups",
            "Sales.CustomerCategories",
            "Warehouse.Colors",
            "Warehouse.PackageTypes",
            "Warehouse.StockItems")

 foreach ($ref_table in $ref_tables) {
    $bcp_file = "./out/" + $ref_table + ".bcp"
    $fmt_file = "./out/"+ $ref_table + ".fmt"
    write-host "**** bcp in: " + $ref_table -foreground cyan
    /usr/local/bin/bcp $ref_table in ./$bcp_file -f $fmt_file -h "TABLOCK,CHECK_CONSTRAINTS" -q  -S linux-vm -Usa -PYukon900 -d WideWorldImportersTest
 }