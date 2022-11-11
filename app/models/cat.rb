# frozen_string_literal: true

class Cat
  attr_reader :id, :name, :breed, :favorite_quote

  def initialize(id:, name:, breed:, favorite_quote:)
    @id = id
    @name = name
    @breed = breed
    @favorite_quote = favorite_quote
  end
end
