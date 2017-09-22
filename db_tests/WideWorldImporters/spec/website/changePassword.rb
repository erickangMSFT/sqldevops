describe 'WideWorldImporters: Website.ChangePassword' do
    it 'successfully changes a password' do
        expect{
            sql.WideWorldImporters.website.init_n_changePassword(
                :PersonID => 3150, 
                :LogonName => 'emily@widworldimporters.com', 
                :InitialPassword => 'SqlDevOps2017', 
                :NewPassword => 'Yukon1000')}
            .not_to raise_error
    end

    it 'denies PersonID == 1' do
        expect{
            sql.WideWorldImporters.website.changePassword(
                :PersonID => 1, 
                :OldPassword => 'SqlDevOps2017', 
                :NewPassword => 'Yukon1000')}
            .to raise_error(TinyTds::Error, "Invalid Password Change")
    end

    it 'denies an invalid old password' do
        expect{
            sql.WideWorldImporters.website.init_n_changeWrongPassword(
                :PersonID => 3150, 
                :LogonName => 'emily@widworldimporters.com', 
                :InitialPassword => 'SqlDevOps2017', 
                :OldPassword => 'WrongPassword', 
                :NewPassword => 'Yukon1000')}
            .to raise_error(TinyTds::Error, "Invalid Password Change")
    end
end