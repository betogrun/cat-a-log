# frozen_string_literal: true

class Cat
  class Filter < ::Micro::Case
    attribute :repository, default: Repository

    def call!
      cats = repository.filter_cats

      Success(result: { cats: cats })
    end
  end
end
