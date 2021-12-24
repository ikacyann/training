class AddPinnedTweetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pinned_tweet, :text
  end
end
