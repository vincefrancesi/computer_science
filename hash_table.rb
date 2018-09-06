# Basic Hash Table
#
# Usage:
# => ht = HashTable.new
#
# Add a key value pair
# => ht['key'] = 'value'
# value
#
# Find a value with a key
# => ht['key']
# value
#
class HashTable
  attr :array, :prime

  # Prime numbers used in Hashing
  PRIMES = [
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29
  ]

  # Initial size of Array
  SIZE = 25

  # Initialize the HashTable
  def initialize
    @array = Array.new(SIZE)
    @prime = PRIMES[rand(PRIMES.count)]
    @resizing = false
  end

  # Lookup keys
  #
  # Returns value of key or nil
  def lookup(key)
    if key_pair = pair(key, hash(key))
      key_pair[1]
    end
  end

  alias_method :[], :lookup

  # Insert value with key
  #
  # key: String
  # value: Any Object
  #
  # Returns value
  def insert(key, value)
    index = hash(key)

    if array[index].nil?
      @array[index] = []
    end

    if key_pair = pair(key, index)
      key_pair[1] = value
    else
      @array[index] << [key, value]
    end

    if should_resize?
      puts "resizing: #{collisions?} - #{fifty_percent_usage?}"

      resize
    end

    value
  end

  alias_method :[]=, :insert

  # Any collisions?
  #
  # Returns Boolean
  def collisions?
    array.any? { |pairs| pairs && pairs.count > 1 }
  end

  private

  def pair(key, index)
    row = array[index]
    if row
      row.detect { |store| key == store[0] }
    end
  end

  def hash(value)
    # Simple hashing function
    index = 1
    int_value = value.chars.inject(0) do |sum, char|
      index += 1
      sum += char.ord + (prime ** index)
      sum
    end

    int_value % @array.count
  end

  def high_usage?
    unused_indexes = array.select { |pairs| pairs.nil? }.count
    (unused_indexes.to_f / array.count.to_f) < 0.5
  end

  def should_resize?
    high_usage?
  end

  def resize
    resizing do
      @prime = PRIMES[rand(PRIMES.count)]
      old_array = @array
      @array = Array.new(SIZE + old_array.count)

      old_array.each do |row|
        next if row.nil?
        row.each { |key_pair| insert(*key_pair) }
      end
    end
  end

  def resizing(&block)
    return if @resizing

    @resizing = true
    block.yield
    @resizing = false
  end

end
