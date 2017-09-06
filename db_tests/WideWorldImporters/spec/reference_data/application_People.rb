describe 'WideWorldImporters reference table: Application.People' do
    it 'contains PersonID == 1 as a template' do
        expect(sql.WideWorldImporters.reference_data.check_personid(:id => 1)).to match('WideWorldImporters/reference_data/match/application_people_personid_1.csv')
    end
end