require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'chitter_app_test')

      DatabaseConnection.setup('chitter_app_test')
    end

    it 'this connection is persistent' do
      # Grab the connection as a return value from the .setup method
      connection = DatabaseConnection.setup('chitter_app_test')
    
      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('chitter_app_test')
  
      expect(connection).to receive(:exec_params).with("SELECT * FROM chitter;", [])
  
      DatabaseConnection.query("SELECT * FROM chitter;")
    end
  end
end