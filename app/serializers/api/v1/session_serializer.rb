module Api
  module V1
    class SessionSerializer < ActiveModel::Serializer
      attributes :email, :uuid, :token
    end
  end
end
