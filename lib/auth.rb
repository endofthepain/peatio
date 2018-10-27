# frozen_string_literal: true

# Provides authentication functionality.
module Auth
  # Exception-safe version of #authenticate!.
  #
  # @return [String, Member, NilClass]
  def authenticate(*args)
    authenticate!(*args)
  end

  private

  # Decodes and verifies JWT.
  # Returns authentic member email or raises an exception.
  #
  # @param [string] Authorization header with a Bearer token to decode
  # @return [String, Member, NilClass]
  def authenticate!(token)
    fetch_member(@authenticator.authenticate!(token))
  end

  def include(controller)
    controller.class_eval do
      @authenticator =
        Peatio::Auth::JWTAuthenticator.new(Rails.configuration.x.jwt_public_key)
    end
  end
end
