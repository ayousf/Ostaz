class Ability

include CanCan::Ability

def initialize(user)
	can :manage, :all if user.role == "Admin"
	#can :read, :all if user.role == "accountant" || user.role == "dataentry"
	can :read, :all if user.role == "Accountant"

end

end
