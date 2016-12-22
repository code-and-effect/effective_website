# rake csv:import:invitations

module CsvImporters
  class InvitationsImporter < Effective::CSVImporter
    def columns
      {
        email: A,
        first_name: B,
        last_name: C
      }
    end

    # Devise invitable
    def process_row
      return unless col(:email).include?('@') && col(:email).include?('.')

      User.invite!(
        email: col(:email),
        roles: roles,
        first_name: col(:first_name),
        last_name: col(:last_name)
      )
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
