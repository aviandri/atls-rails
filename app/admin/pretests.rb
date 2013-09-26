ActiveAdmin.register Pretest do

	form do |f|
		f.inputs do 
			f.input :question, :as => 'text'
			f.input :answer_one, :as => 'text'
			f.input :answer_two, :as => 'text'
			f.input :answer_three, :as => 'text'
			f.input :answer_four, :as => 'text'
			f.input :answer_five, :as => 'text'
			f.input :correct_answer, :as =>  :select, :collection => [1,2,3,4,5]
		end
		f.actions
	end	

  controller do
    def max_csv_records; @per_page; end
  end

end
