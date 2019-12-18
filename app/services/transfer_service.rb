# frozen_string_literal: true

class TransferValidationError < StandardError; end
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
  rescue ActiveRecord::RecordInvalid => e
    raise TransferValidationError, e.message
  rescue StandardError => e
    raise TransferGeneralError, e.message
  end
end
