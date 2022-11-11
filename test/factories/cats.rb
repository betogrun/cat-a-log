# frozen_string_literal: true

FavoriteQuotes = -> {
  [
    Faker::Quote.jack_handey,
    Faker::Quote.robin,
    Faker::Quote.yoda,
    Faker::Movies::LordOfTheRings.quote,
    Faker::Quotes::Shakespeare.as_you_like_it_quote
  ]
}

FactoryBot.define do
  factory :cat, class: Cat::Record do
    name { Faker::Creature::Cat.name }
    breed { Faker::Creature::Cat.breed }
    favorite_quote { FavoriteQuotes.call.sample }
  end
end
