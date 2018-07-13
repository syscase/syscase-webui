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

      column :input,  String, null: false
      column :result, String, null: false
      column :sha256, String, null: false
      column :path,   String, null: false
      column :time,   Time,   null: false

      index :sha256
    end

    create_table :example_counts do
      primary_key :id
      foreign_key :example, :examples
      column :count, Integer, null: false
    end

    create_table :paths do
      primary_key :id
      foreign_key :example, :examples

      column :index,   Integer, null: false
      # Not defining address as foreign key to support unknown paths
      column :address, Integer, null: false, type: :Bignum

      index :address
    end
  end
end
