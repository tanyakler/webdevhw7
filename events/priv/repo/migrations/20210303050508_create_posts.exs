defmodule Events.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :text, null: false
      add :date, :utc_datetime, null: false
      add :description, :text, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
