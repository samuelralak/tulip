class RolifyCreateRoles < ActiveRecord::Migration
  def migrate(direction)
    super

    user_type = UserType.find_by(code: 'SUPER-USER')
    user = User.create!(
      name: 'Super', 
      email: 'superuser@novel.com', 
      password: '12345678', 
      password_confirmation: '12345678',
      user_type_id: user_type.id
    )

    user.add_role :super
  end

  def change
    create_table(:roles, id: :uuid) do |t|
      t.string :name
      t.string :resource_type
      t.uuid   :resource_id

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.uuid :user_id
      t.uuid :role_id
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
  end
end
