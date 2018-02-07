# rake csv:import:invitations

module CsvImporters
  class InvitationsImporter < Effective::CSVImporter
    def columns
      {
        email: A,
        name: B
      }
    end

    # Devise invitable
    def process_row
      return unless col(:email).include?('@') && col(:email).include?('.')

      User.invite!(email: col(:email), name: col(:name), roles: roles)
    end

    private

    def roles
      if col(:email).include?('codeandeffect.com')
        [:admin]
      else
        []
      end
    end

  end
end
