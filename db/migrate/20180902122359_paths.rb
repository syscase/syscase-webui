# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:paths) do
      add_column :start,     Numeric
      add_column :end,       Numeric
      add_column :level,     Integer
      add_column :is_secure, TrueClass
      add_index :start
      add_index :end
      add_index :level
      add_index :is_secure
    end
  end
end
