# frozen_string_literal: true

class Cat
  module Repository
    module_function

    ToCat = ->(record) do
      ::Cat.new(
        id: record.id,
        name: record.name,
        breed: record.breed,
        favorite_quote: record.favorite_quote
      )
    end

    def filter_cats
      Record
        .select(:id, :name, :breed, :favorite_quote)
        .map(&ToCat)
    end

    def find_cat(id)
      Record
        .select(:id, :name, :breed, :favorite_quote)
        .find_by(id:)
        &.then(&ToCat)
    end

    def create_cat(name, breed, favorite_quote)
      Record
        .create(name:, breed:, favorite_quote:)
        .then(&ToCat)
    end

    def update_cat(id, name, breed, favorite_quote)
      Record
        .update(id, name:, breed:, favorite_quote:)
        .then(&ToCat)
    end

    def destroy_cat(id)
      Record.destroy(id)
    end

    def cat_exists?(id)
      Record.exists?(id)
    end
  end
end
