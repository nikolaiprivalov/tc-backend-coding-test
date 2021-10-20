# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveModel::ValidationError, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  private

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def unprocessable_entity(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
