# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:addresses) do
      set_column_type :address, :numeric
    end

    alter_table(:paths) do
      set_column_type :address, :numeric
    end
  end
end
