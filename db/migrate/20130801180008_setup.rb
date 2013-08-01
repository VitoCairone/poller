class Setup < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :presence => true

      t.timestamps
    end

    create_table :polls do |t|
      t.integer :user_id, :presence => true

      t.timestamps
    end

    add_index :polls, :user_id

    create_table :questions do |t|
      t.text :body, :presence => true
      t.integer :poll_id, :presence => true

      t.timestamps
    end

    add_index :questions, :poll_id

    create_table :choices do |t|
      t.text :choice_text, :presence => true
      t.integer :question_id, :presence => true

      t.timestamps
    end

    add_index :choices, :question_id

    create_table :responses do |t|
      t.integer :user_id, :presence => true
      t.integer :choice_id, :presence => true

      t.timestamps
    end

    add_index :responses, :user_id
    add_index :responses, :choice_id

  end
end
