class Ability
	include CanCan::Ability
	
	def initialize(user)
		can :read, ActiveAdmin::Page, :name => "Dashboard"
		can :manage, AdminUser
		can :read, Attendee
		can :manage, BankAccount
		can :manage, Blog
		can :manage, Order
		can :manage, Pretest
		can :manage, Profile
		can :manage, TrainingLocation

		can :manage, TrainingSchedule
		can :create, Attendee
		can :update, Attendee do |attendee|	
			user.is?("#{attendee.training_location.name}_admin".downcase)			
		end

	end
		
end