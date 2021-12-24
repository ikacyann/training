class Post < ApplicationRecord

    def user
        return User.find_by(id: slfe.user_id)
    end
end
