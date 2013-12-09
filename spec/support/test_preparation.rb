require 'factory_girl'
require 'database_cleaner'

shared_context 'test_preparation' do

  def setup
    FactoryGirl.factories.clear
    FactoryGirl.find_definitions
  end

  def teardown
    DatabaseCleaner.clean
  end

end
