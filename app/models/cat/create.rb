# frozen_string_literal: true

class Cat
  class Create < ::Micro::Case
    include ActiveModel::Validations

    attribute :name
    attribute :breed
    attribute :favorite_quote
    attribute :repository, default: Repository

    validates :name, :breed, :favorite_quote, presence: true

    def call!
      return Failure(:invalid_params, result: { errors: self.errors }) unless valid?

      cat = repository.create_cat(name, breed, favorite_quote)

      Success(result: { cat: cat })
    end
  end
end
