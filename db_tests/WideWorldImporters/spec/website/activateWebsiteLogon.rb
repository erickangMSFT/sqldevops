describe 'WideWorldImporters: Website.ActivateWebsiteLogon' do
    it 'successfully activates a website logon' do
        expect(
            sql.WideWorldImporters.website.activateLogon(
                :PersonID => 3150, 
                :LogonName => 'emily@widworldimporters.com', 
                :Password => 'SqlDevOps2017').count)
            .to eq(1)
    end

    it 'denies the logon activation for PersonID == 1' do
        expect{
            sql.WideWorldImporters.website.activateLogon(
                :PersonID => 1, 
                :LogonName => 'testuser@wideworldimporters.com', 
                :Password => 'SqlDevOps2017')}
            .to raise_error(TinyTds::Error, 'Invalid PersonID')

    end

    it 'denies a logon activation if already activated' do
        expect{
            sql.WideWorldImporters.website.activateLogon(
                :PersonID => 2, 
                :LogonName => 'kaylaw@wideworldimporters.com', 
                :Password => 'SqlDevOps2017')}
            .to raise_error(TinyTds::Error, 'Invalid PersonID')

    end

end