describe 'WideWorldImporters: Website.InsertCustomerOrders' do
    
    # UDTTs
    # @Orders Website.OrderList READONLY,
    # @OrderLines Website.OrderLineList READONLY,

    before :each do
        load_csv('WideWorldImporters/customers/load/sales_customers.csv', 'Sales.Customers')
      end

    it 'successfully creates orders' do
        order_list = TableVariable.new(
            '@order_list',
            'Website.OrderList',
            [   'OrderReference', 'CustomerID', 
                'ContactPersonID', 'ExpectedDeliveryDate', 
                'CustomerPurchaseOrderNumber', 'IsUndersupplyBackordered', 
                'Comments', 'DeliveryInstructions'],
            [
                [1, 1, 3, '2017-09-09', 1, 0, 'Order Unittest', 'Delivery Instruction']
            ]
        )
    
        order_lines = TableVariable.new(
            '@order_lines',
            "Website.OrderLineList",
            ['OrderReference', 'StockItemID', 'Description', 'Quantity'],
            [
                [1, 1, 'Unittest Description', 1]
            ]
        )


        expect{
            sproc(
                'Website.InsertCustomerOrders', 
                :Orders => order_list, 
                :OrderLines => order_lines, 
                :OrdersCreatedByPersonID => 1, 
                :SalespersonPersonID => 1)
        }.to_not raise_error
    end

    it 'fails for invalid orders' do
        
        #invalid customerID
        order_list = TableVariable.new(
            '@order_list',
            'Website.OrderList',
            [   'OrderReference', 'CustomerID', 
                'ContactPersonID', 'ExpectedDeliveryDate', 
                'CustomerPurchaseOrderNumber', 'IsUndersupplyBackordered', 
                'Comments', 'DeliveryInstructions'],
            [
                [1, 2, 3, '2017-09-09', 1, 0, 'Order Unittest', 'Delivery Instruction']
            ]
        )
    
        order_lines = TableVariable.new(
            '@order_lines',
            "Website.OrderLineList",
            ['OrderReference', 'StockItemID', 'Description', 'Quantity'],
            [
                [1, 1, 'Unittest Description', 1]
            ]
        )


        expect{
            sproc(
                'Website.InsertCustomerOrders', 
                :Orders => order_list, 
                :OrderLines => order_lines, 
                :OrdersCreatedByPersonID => 1, 
                :SalespersonPersonID => 1)
        }.to raise_error(TinyTds::Error)
    end

    it 'fails for invalid orderlines' do
       
       order_list = TableVariable.new(
        '@order_list',
        'Website.OrderList',
        [   'OrderReference', 'CustomerID', 
            'ContactPersonID', 'ExpectedDeliveryDate', 
            'CustomerPurchaseOrderNumber', 'IsUndersupplyBackordered', 
            'Comments', 'DeliveryInstructions'],
        [
            [1, 1, 3, '2017-09-09', 1, 0, 'Order Unittest', 'Delivery Instruction']
        ]
    )

    #Invalid orderlines - invalid StockItemID
    order_lines = TableVariable.new(
        '@order_lines',
        "Website.OrderLineList",
        ['OrderReference', 'StockItemID', 'Description', 'Quantity'],
        [
            [1, 500, 'Invalid StockItemID', 2]
        ]
    )

    expect{
        sproc(
            'Website.InsertCustomerOrders', 
            :Orders => order_list, 
            :OrderLines => order_lines, 
            :OrdersCreatedByPersonID => 1, 
            :SalespersonPersonID => 1)
    }.to raise_error(TinyTds::Error)
    end

    it 'fails for an invalid creted by person id' do
        order_list = TableVariable.new(
            '@order_list',
            'Website.OrderList',
            [   'OrderReference', 'CustomerID', 
                'ContactPersonID', 'ExpectedDeliveryDate', 
                'CustomerPurchaseOrderNumber', 'IsUndersupplyBackordered', 
                'Comments', 'DeliveryInstructions'],
            [
                [1000, 1, 3, '2017-09-09', 1, 0, 'Order Unittest', 'Delivery Instruction']
            ]
        )
    
        #Invalid orderlines - invalid StockItemID
        order_lines = TableVariable.new(
            '@order_lines',
            "Website.OrderLineList",
            ['OrderReference', 'StockItemID', 'Description', 'Quantity'],
            [
                [1000, 1, 'Invalid StockItemID orderline', 2]
            ]
        )
    
        expect{
            sproc(
                'Website.InsertCustomerOrders', 
                :Orders => order_list, 
                :OrderLines => order_lines, 
                :OrdersCreatedByPersonID => 0, #invalid created by person id
                :SalespersonPersonID => 1)
        }.to raise_error(TinyTds::Error)
    end

    it 'fails for an invalid sales person id' do
        order_list = TableVariable.new(
            '@order_list',
            'Website.OrderList',
            [   'OrderReference', 'CustomerID', 
                'ContactPersonID', 'ExpectedDeliveryDate', 
                'CustomerPurchaseOrderNumber', 'IsUndersupplyBackordered', 
                'Comments', 'DeliveryInstructions'],
            [
                [1000, 1, 3, '2017-09-09', 1, 0, 'Order Unittest', 'Delivery Instruction']
            ]
        )
    
        #Invalid orderlines - invalid StockItemID
        order_lines = TableVariable.new(
            '@order_lines',
            "Website.OrderLineList",
            ['OrderReference', 'StockItemID', 'Description', 'Quantity'],
            [
                [1000, 1, 'Invalid StockItemID orderline', 2]
            ]
        )
    
        expect{
            sproc(
                'Website.InsertCustomerOrders', 
                :Orders => order_list, 
                :OrderLines => order_lines, 
                :OrdersCreatedByPersonID => 1, 
                :SalespersonPersonID => 0) #invalid Sales person ID
        }.to raise_error(TinyTds::Error)
    end
end
