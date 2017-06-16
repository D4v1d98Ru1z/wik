class WikiPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def new
    user.standard? || user.premium? || user.admin?
  end

  def create
    user.standard? || user.premium? || user.admin?
  end
end
