# frozen_string_literal: true

class Cat
  class Find < ::Micro::Case
    attribute :id
    attribute :repository, default: Repository

    def call!
      cat = repository.find_cat(id)

      return Failure(:not_found) unless cat

      Success(result: { cat: })
    end
  end
end
