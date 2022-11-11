# frozen_string_literal: true

class Cat
  class Update < ::Micro::Case
    include ActiveModel::Validations

    attribute :id
    attribute :name
    attribute :breed
    attribute :favorite_quote
    attribute :repository, default: Repository

    validates :name, :breed, :favorite_quote, presence: true

    def call!
      return Failure(:not_found) unless repository.cat_exists?(id)

      return Failure(:invalid_params, result: { errors: self.errors }) unless valid?

      cat = repository.update_cat(id, name, breed, favorite_quote)

      Success(result: { cat:})
    end
  end
end
