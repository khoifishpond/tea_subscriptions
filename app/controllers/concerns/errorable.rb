module Errorable
  extend ActiveSupport::Concern

  def error(message)
    {
      'errors': [
        {
          'status': 'Bad Request',
          'message': message,
          'code': 400
        }
      ]
    }
  end
end