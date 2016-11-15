module Snowflakes
  class OverflowError < StandardError
    def initialize(topic, current, maximum)
      formats = {
        topic: topic,
        current: current,
        maximum: maximum
      }

      if current < 0
        super('Invalid %{topic} (${current} < 0)' % formats)
      else
        super('Invalid %{topic} (${current} > ${maximum})' % formats)
      end
    end
  end

  class InvalidSystemClockError < StandardError
    def initialize(time, last)
      super('Time goes backward! (%{time} < %{last})' % { time: time, last: last })
    end
  end

  class Snowflake
    def initialize(u, l)
      @u = u
      @l = l
    end

    def to_hex
      '%016x%016x' % [@u, @l]
    end
  end

  class Node
    STEP_BITS = 16
    NODE_BITS = 48

    MAX_STEPS = (1 << STEP_BITS)
    MAX_NODES = (1 << NODE_BITS)

    def initialize(id, step = 0, since = 0)
      if not id.is_a? Integer or id < 0 or id >= MAX_NODES
        raise OverflowError.new('id', id, MAX_NODES)
      end

      if not step.is_a? Integer or step < 0 or step >= MAX_STEPS
        raise OverflowError.new('step', step, MAX_STEPS)
      end

      @id = id
      @last = 0
      @step = step
      @since = since
    end

    def next
      time = now

      if time < @last
        raise InvalidSystemClockError.new(time, @last)
      end

      if time == @last
        @step = (@step + 1) % MAX_STEPS
        if @step == 0
          time = waitUntilNextMillisecond(time)
        end
      else
        @step = 0
      end

      @last = time

      generate(time, @id, @step)
    end

    def now
      (Time.now.to_f * 1000).to_i - @since
    end

    private

    def generate(time, id, step)
      Snowflake.new(time, id << (STEP_BITS) + step)
    end

    def waitUntilNextMillisecond(time)
      t = time
      while t < time
        t = now
      end
      t
    end
  end
end
