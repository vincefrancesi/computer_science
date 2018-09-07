# Basic Trigram Indexing
#
# Usage:
# => t = TrigramIndex.new
#
# Insert into the index
# => t.insert('foo')
# => t.insert('food')
#
# Search the index
# => t.search('foo')
# ['foo', 'food']
#
class TrigramIndex
  attr_accessor :index
  attr_accessor :records

  # Initialize the Trigram Index
  def initialize
    @index = {}
    @records = []
    @joins = []
  end

  # Insert a value into the index
  # value: String
  #
  # Returns an Array of Trigrams
  def insert(value)
    records << value
    record_id = records.count - 1

    trigrams = hash(value)
    trigrams.each do |tri|
      index[tri] ||= []
      index[tri] << record_id
    end
  end

  # Search the index
  # value: String
  #
  # Returns an Array of found Strings
  def search(value)
    record_ids = []

    hash(value).each do |tri|
      if ids = index[tri]
        record_ids += ids
      end
    end
    record_ids.uniq!

    record_ids.collect { |id| records[id] }
  end

  private

  def hash(value)
    index = 0

    chars = value.chars
    chars.collect do |char|
      tri = []
      before_index = index - 1
      after_index = index + 1

      if before_index == -1
        tri << "*"
      else
        tri << character_filter(chars[before_index])
      end
      tri << character_filter(chars[index])
      tri << character_filter(chars[after_index])

      index += 1
      tri.join('')
    end
  end

  def character_filter(char)
    return '*' if char.nil?

    char = char.downcase

    if char.match /[a-z]/
      return char
    else
      return '*'
    end
  end

end
