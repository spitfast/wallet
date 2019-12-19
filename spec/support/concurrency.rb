# frozen_string_literal: true

def make_concurrent_calls(object, method, params = nil)
  processes = 2.times.map do |_|
    ForkBreak::Process.new do
      params.present? ? object.send(method, params) : object.send(method)
    end
  end
  processes.each { |process| process.finish.wait }
end
