class EnableUuidExtension < ActiveRecord::Migration[5.1]
    def change
        enable_extension 'uuid-ossp'
        enable_extension 'pgcrypto' # rails 5.1
    end
end
