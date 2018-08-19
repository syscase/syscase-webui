# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :examples do
      add_column :secure_log, String, null: false, default: ''
      add_column :normal_log, String, null: false, default: ''
    end
  end
end
