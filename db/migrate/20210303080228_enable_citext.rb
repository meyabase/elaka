class EnableCitext < ActiveRecord::Migration[6.1]
  def change
    enable_extension("citext")
  end
end
