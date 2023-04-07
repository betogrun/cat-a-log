# frozen_string_literal: true

class Cat
  delegate :id, :name, :breed, :favorite_quote, :created_at, to: :@record

  def initialize(record)
    @record = record
  end
end
