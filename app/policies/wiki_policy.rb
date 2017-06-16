class WikiPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def show?
    user.present?
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present?
  end

  def new?
    user.standard? || user.premium? || user.admin?
  end

  def create?
    user.standard? || user.premium? || user.admin?
  end
end
