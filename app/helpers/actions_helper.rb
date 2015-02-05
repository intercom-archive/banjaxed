module ActionsHelper

  def action_info(action_object)
    @navigation=[]
    action_object.each do |action_obj|
      @navigation<<{:user_name=>action_obj.data[:user_name],:obj_id => action_obj.data[:id],:action_type => action_obj.data[:action_type],:from=>action_obj.data[:from], :to => action_obj.data[:to], :time => action_obj.data[:time]}
    end

  end
end