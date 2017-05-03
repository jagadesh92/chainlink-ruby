require 'ethereum'

module Ethereum
  class FormattedOracle < OracleBase

    SCHEMA_NAME = 'ethereumFormatted'

    validates :address, format: { with: /\A0x[0-9a-f]{40}\z/ }
    validates :update_address, format: { with: /\A(?:0x)?[0-9a-f]*\z/ }

    def get_status(assignment_snapshot, previous_snapshot = nil)
      value = previous_snapshot.try(:value)
      write = updater.perform value, value
      write.snapshot_decorator
    end

    def ready?
      true
    end


    private

    def set_up_from_body
      if body.present?
        self.address = body['address']
        self.update_address = body['updateAddress'] || body['method']
      end
      self.ethereum_account = owner
    end

  end
end