# frozen_string_literal: true

def make_concurrent_calls(object, method, params)
  processes = 2.times.map do |_|
    ForkBreak::Process.new do
      object.send(method, params)
    end
  end
  processes.each{ |process| process.finish.wait }
end
