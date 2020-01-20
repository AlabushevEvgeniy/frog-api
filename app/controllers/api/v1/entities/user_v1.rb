module API
  module V1
    module Entities
      class UserV1 < Grape::Entity
        expose :id,            documentation: { type: 'Integer', desc: 'User ID' }
        expose :name,          documentation: { type: 'String', desc: 'User name' }
        expose :email,         documentation: { type: 'String', desc: 'User email' }
        expose :avatar,        documentation: { type: 'String', desc: 'User avatar' }
      end
    end
  end
end
