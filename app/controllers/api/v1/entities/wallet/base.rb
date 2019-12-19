# frozen_string_literal: true

module API
  module V1
    module Entities
      module Wallet
        class Base < Grape::Entity
          expose :id, documentation: { type: 'Integer' }
          expose :walletable_id, documentation: { type: 'Integer' }
          expose :balance, documentation: { type: 'String' }
          expose :name, documentation: { type: 'String' }

          private

          def name
            "#{object.walletable_type} - #{object.walletable.name}"
          end
        end
      end
    end
  end
end
