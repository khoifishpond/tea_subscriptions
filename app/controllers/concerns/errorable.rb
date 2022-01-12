module Errorable
  extend ActiveSupport::Concern

  def error(status, message, code)
    {
      'errors': [
        {
          'status': status,
          'message': message,
          'code': code
        }
      ]
    }
  end
end