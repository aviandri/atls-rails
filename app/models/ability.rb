class Ability
	include CanCan::Ability
	
	def initialize(user)

		if user.kind_of? AdminUser
			can :read, ActiveAdmin::Page, :name => "Dashboard"
			can :manage, AdminUser
			can :read, Attendee
			can :manage, BankAccount
			can :manage, Blog
			can :manage, Order
			can :manage, Pretest
			can :manage, Profile
			can :manage, TrainingLocation
			can :manage, Campus
			can :manage, TrainingSchedule
			can :create, Attendee
			can :manage, Training
			can :manage, Event
			can :manage, News
			can [:update, :destroy], Attendee do |attendee|	
				user.authorized_for?(attendee.training_location)
			end
		elsif user.kind_of? Attendee
			can :read, Attendee do |a|
				a.id == user.id
			end
		end

	end
		
end