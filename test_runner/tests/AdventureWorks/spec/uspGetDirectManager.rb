# Method "describe" opens up an example group.
describe 'uspGetDirectManager Tests' do
  # Test for getting direct manager hierachy and employee detail.
  it 'Testing uspGetDirectManager with @businessentityid = 2' do
    
    # Seed orgchart procs unittest mock data
    seed_orgchart_data()

    # counting for the returned rows
	  expect(sql.adventureworks.exec_humanresources_uspGetDirectManager(:id => 2).count).to be == 1

    # other test case samples
    # matching with expected result data in csv
    # expect(sql.adventureworks.exec_humanresources_uspGetDirectManager(:id => 2)).to match('adventureworks/uspGetDirectManager_expected_result_for_businessentityid_2.csv')
	  
    # column value matching in result sets
    # sql.adventureworks.exec_humanresources_uspGetDirectManager(:id => 2) do |results|
	  #	expect(results[0][0][:BusinessEntityID]).to be == 1  
	  # end
  end
end
