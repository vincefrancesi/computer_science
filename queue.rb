# Queue
# Implementation of a classic FIFO queue using linked lists
#
# Usage:
#
# => jq = JobQueue.new
# => jq.empty?
# true
# => jq.enqueue(Proc.new {|i| puts "Job #{i}"}, [0])
# => jq.enqueue(Proc.new {|i| puts "Job #{i}"}, [1])
# => jq.count
# 2
# => jq.first
# <Job 1234: ...>
# => jq.last
# <Job 1235: ...>
# => jq.each { |j| puts j.inspect }
# <Job 1234: ...>
# <Job 1235: ...>
# => jq.last
# <Job 1235: ...>
# => job = jq.dequeue
# <Job 1234: ...>
# => job.perform
# Job 0
# => jq.count
# 1
class JobQueue
  attr_accessor :first, :last

  # Enqueue a new Job
  # task: Proc
  # args: Array
  #
  # Returns a new Job
  def enqueue(task, args)
    job = Job.new(task, args)

    if empty?
      self.first = job
    else
      last_job = self.last
      last_job.next_job = job
    end

    self.last = job

    return job
  end

  # Dequeue the next Job
  #
  # Returns the next Job to run
  def dequeue
    return nil if empty?

    first_job = first
    self.first = first_job.next_job

    return first_job
  end

  # Is Queue empty?
  #
  # Returns a Boolean
  def empty?
    return first.nil?
  end

  # Count of Jobs in Queue
  #
  # Returns an Integer
  def count
    counter = 0

    each do |job|
      counter += 1
    end

    return counter
  end

  # Iterate over each Job
  # block: Block
  #
  # Returns nil
  def each(&block)
    job = first

    while job
      if block
        block.yield(job)
      end

      job = job.next_job
    end
  end

  class Job
    attr_accessor :task, :args, :next_job

    # Initialize a Job
    # task: Proc
    # args: Array
    def initialize(task, args)
      self.task = task
      self.args = args
    end

    # Perform the Job
    #
    # Returns nil
    def perform
      task.call(*args)
    end

    # Inspect the Job
    #
    # Returns a String representation of the Job
    def inspect
      "<Job #{object_id} task=#{task.inspect} args=#{args.inspect}>"
    end
  end
end
