module WamblZendesk
  module Import


    def to_zendesk
      "#{self.class.object_name.camelize}Serializer".constantize.new(self).serializable_hash
    end


    # def import _options = {}
    #   if !_options[:reimport] && self[:new_id].present?
    #     self._errors.destroy_all
    #     return true
    #   end
    #   params = { self.class.object_name => self.to_zendesk }
    #   request = NewZendesk.post(self.import_path, params)
    #   ap request.json if _options[:print] == true
    #   if _options[:save] == false
    #     if request.code == 201
    #       self.reset_attachments if self.class == Ticket
    #       return true
    #     else
    #       return false
    #     end
    #   end
    #   case request.code
    #   when 201
    #     self.new_id = request.json[self.class.object_name]['id']
    #     self._errors.destroy_all
    #     self.reset_attachments if self.class == Ticket
    #     self.save!
    #   else
    #     @message = ImportError.message_from_request(request)
    #     @params = {
    #       status_code: request.code,
    #       message: @message
    #     }
    #     @params.merge!(self.error_params(@message))
    #     ap @params
    #     self._errors.destroy_all
    #     self._errors.create!(@params)
    #     self.save!
    #   end
    #   request.code == 201
    # end
    # def unimport
    #   self.reset_attachments if self.class == Ticket
    #   self._errors.destroy_all
    #   self.update!(new_id: nil)
    # end
    # def delete
    #   if !self[:new_id]
    #     self._errors.destroy_all
    #     return true
    #   end
    #   request = NewZendesk.delete "/api/v2/#{self.class.object_name.pluralize}/#{self.new_id}"
    #   if request.code == 204
    #     unimport
    #     return true
    #   else
    #     return false
    #   end
    # end


  end
end
