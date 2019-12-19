# frozen_string_literal: true

class TransferGeneralError < StandardError; end

class TransferService
  def initialize(args = {})
    @args = args
  end

  def perform
    Transaction.with_advisory_lock('funds_transfer') do
      ActiveRecord::Base.transaction do
        Transaction.create_with_transfer!(@args)
      end
    end
  rescue ActiveRecord::RecordInvalid => _e
    raise
  rescue StandardError => e
    raise TransferGeneralError, e.message
  end
end
