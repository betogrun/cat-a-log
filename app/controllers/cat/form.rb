# frozen_string_literal: true

class Cat
  class Form
    attr_reader :name, :breed, :favorite_quote

    def initialize(params = {})
      @name = params[:name]
      @breed = params[:breed]
      @favorite_quote = params[:favorite_quote]
    end
  end
end
