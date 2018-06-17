# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :files do
      primary_key :id
      column :name, String, null: false
    end

    create_table :functions do
      primary_key :id
      column :name, String, null: false
      column :signature, String, null: false
      foreign_key :file, :files
    end

    create_table :lines do
      primary_key :id
      foreign_key :file, :files
      foreign_key :function, :functions
      column :line, Integer, null: false
      index :line

      column :code, String, null: false
    end

    create_table :addresses do
      primary_key :id, type: :Bignum
      column :address, Integer, type: :Bignum, null: false

      foreign_key :line, :lines

      column :code, String, null: false
    end

    create_table :examples do
      primary_key :id
      column :input, String, null: false
      column :hash, String, null: false
      column :path, String, null: false
      column :time, DateTime, null: false
      column :count, Integer, null: false
    end

    create_table :paths do
      foreign_key :example, :examples
      column :index, Integer, null: false
      primary_key %i[example index]

      foreign_key :address, :addresses, type: :Bignum
    end

    create_table :jobs do
      primary_key :id
      column :state, String, null: false
      column :input, String, null: false
      column :hash, String, null: false
      column :path, String, null: false
      column :time, DateTime, null: false
    end
  end
end
