# frozen_string_literal: true

class BaseContract
  # This use of ActiveModel::Attributes API as contract is just for fun =)
  # Any other validation library like dry-validation could be used instead.

  # Monkey patch to skip ActiveModel::UnknownAttributeError
  # https://github.com/rails/rails/blob/main/activemodel/lib/active_model/attribute_assignment.rb#L51
  module SkipUnknownAttributeError
    private

    def _assign_attribute(k, v) # rubocop:disable Naming/MethodParameterName
      setter = :"#{k}="
      public_send(setter, v) if respond_to?(setter)
    end
  end

  include ActiveModel::Model
  include ActiveModel::Attributes
  include SkipUnknownAttributeError

  # interface to call the contract
  def self.call(attributes = {})
    new(attributes).tap(&:validate!).attributes
  end

  # We want to permit all when we use a contract otherwise it won't mass assign.
  # ActiveModel::Attributes API won't assign unknown attributes.
  # ActiveModel::Attributes API will also try to cast types.
  # That makes strong params unnecessary (in theory).
  def initialize(attributes = {})
    attributes.permit! if attributes.is_a?(ActionController::Parameters)

    super
  end

  # This is our getter. It returns symbolized attrs for later use.
  # Also we could make additional modification or filtration of params here.
  def attributes
    super.symbolize_keys
  end
end
