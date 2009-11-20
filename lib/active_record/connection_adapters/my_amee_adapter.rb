require 'active_record/connection_adapters/abstract_adapter'
require 'active_record/connection_adapters/mysql_adapter'
require 'active_record/connection_adapters/nulldb_adapter'
require 'set'

module ActiveRecord
  class Base
    # Establishes a connection to the database that's used by all Active Record objects.
    def self.my_amee_connection(config) # :nodoc:
      # Fetch config
      new_config = MyAmee::Config.application_config(:database)
      if new_config
        config.merge! new_config if new_config
        
        config = config.symbolize_keys
        host     = config[:host]
        port     = config[:port]
        socket   = config[:socket]
        username = config[:username] ? config[:username].to_s : 'root'
        password = config[:password].to_s
        database = config[:database]

        # Require the MySQL driver and define Mysql::Result.all_hashes
        unless defined? Mysql
          begin
            require_library_or_gem('mysql')
          rescue LoadError
            $stderr.puts '!!! The bundled mysql.rb driver has been removed from Rails 2.2. Please install the mysql gem and try again: gem install mysql.'
            raise
          end
        end
        MysqlCompat.define_all_hashes_method!

        mysql = Mysql.init
        mysql.ssl_set(config[:sslkey], config[:sslcert], config[:sslca], config[:sslcapath], config[:sslcipher]) if config[:sslca] || config[:sslkey]

        ConnectionAdapters::MysqlAdapter.new(mysql, logger, [host, username, password, database, port, socket], config)
      else
        ConnectionAdapters::NullDBAdapter.new
      end
    end
  end
end
