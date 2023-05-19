# frozen_string_literal: true

class Cat
  module Repository
    module_function

    ToCat = ->(record) { ::Cat.new(record) }
    private_constant :ToCat

    def filter_cats
      Record
        .select(:id, :name, :breed, :favorite_quote, :created_at)
        .order(created_at: :desc)
        .map(&ToCat)
    end

    def find_cat(id)
      Record
        .select(:id, :name, :breed, :favorite_quote)
        .find_by(id: id)
        &.then(&ToCat)
    end

    def create_cat(name, breed, favorite_quote)
      Record
        .create(name: name, breed: breed, favorite_quote: favorite_quote)
        .then(&ToCat)
    end

    def update_cat(id, name, breed, favorite_quote)
      Record
        .update(id, name: name, breed: breed, favorite_quote: favorite_quote)
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
