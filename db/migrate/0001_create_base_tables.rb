class CreateBaseTables < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :slug
      t.string :color
      t.string :logo

      t.timestamps
    end

    add_index :organizations, :slug, unique: true

    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.boolean :admin, default: false
      t.references :current_organization, foreign_key: { to_table: :organizations }

      t.datetime :last_login
      t.timestamps
    end

    add_index :users, :username, unique: true

    create_table :events do |t|
      t.references :organizer, foreign_key: { to_table: :organizations }
      t.string :name, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.integer :kegs, null: false
      t.boolean :enrollment_closed, default: false
      t.boolean :option, default: false
      t.boolean :risky, default: false
      t.text :bartender_instruction

      t.timestamps
    end

    create_table :enrollment_types do |t|
      t.references :organization, foreign_key: true
      t.string :name, null: false
      t.integer :nature, null: false

      t.timestamps
    end

    create_table :enrollments do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.references :enrollment_type, foreign_key: true

      t.timestamps
    end

    add_index :enrollments, [:user_id, :event_id], unique: true

    create_table :events_locations, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :location, index: true
    end

    add_index :events_locations, [:event_id, :location_id], unique: true

    create_table :events_organizations, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :organization, index: true
    end

    add_index :events_organizations, [:event_id, :organization_id], unique: true

    create_table :locations do |t|
      t.string :name, null: false
      t.boolean :prevents_conflict, default: true
      t.string :color

      t.timestamps
    end

    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true
      t.boolean :active, default: true
      t.boolean :bartender, default: false
      t.boolean :planner, default: false
      t.boolean :manager, default: false

      t.timestamps
    end

    add_index :memberships, [:user_id, :organization_id], unique: true
  end
end
