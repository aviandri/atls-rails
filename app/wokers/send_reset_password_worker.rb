class SendResetPasswordWorker
	include Sidekiq::Worker

	def perform(attendee_id, token)
		AtlsMailer.send_forget_password(attendee_id, token).deliver!
	end
end