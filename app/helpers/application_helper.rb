module ApplicationHelper

  def resource_name
    :attendee
  end

  def resource
    @resource ||= Attendee.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:attendee]
  end
end
