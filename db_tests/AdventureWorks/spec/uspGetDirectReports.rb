# Method "describe" opens up an example group.
describe 'uspGetDirectReports Tests' do

 # Test for getting direct reports and employee detail.
  it ' Testing uspGetDirectReports proc with @businessentityid = 1' do
    # Seed orgchart procs unittest mock data
	  seed_orgchart_data()

    # matching with expected result data in csv
    expect(sql.adventureworks.exec_humanresources_uspGetDirectReports(:id => 1)).to match('adventureworks/uspGetDirectReports_expected_result_for_businessentityid_1.csv')
  end
end
