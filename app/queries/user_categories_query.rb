# Find unique categories used by a give user

class UserCategoriesQuery
  def self.call(user)
    Category.includes(:links)
      .where(id: user.links.map(&:category_id))
      .references(:links)
      .uniq
  end
end
