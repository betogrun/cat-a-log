# frozen_string_literal: true

class Cat
  class Destroy < ::Micro::Case
    include ActiveModel::Validations

    attribute :id
    attribute :repository, default: Repository

    def call!
      repository.destroy_cat(id)

      Success()
    rescue ActiveRecord::RecordNotFound
      Failure(:not_found)
    end
  end
end
