ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Posts" do
          ul do
            Attendee.find(:all, limit: 5).each do |peserta|
              li link_to(peserta.name, admin_peserta_path(peserta))
            end
          end
        end
      end

    end
  end # content
end
