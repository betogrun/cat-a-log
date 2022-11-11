# frozen_string_literal: true

class Cat
  class Record < ApplicationRecord
    self.table_name = 'cats'
  end
end
