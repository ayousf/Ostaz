class Ability

include CanCan::Ability

def initialize(user)
	#can :manage, :all if user.role == "admin"
	#can :read, :all if user.role == "accountant" || user.role == "dataentry"
	can :read, :all
end

end
