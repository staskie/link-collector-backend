module Api
  module V1
    class SessionSerializer < ActiveModel::Serializer
      root false
      attributes :email, :uuid, :token
    end
  end
end
