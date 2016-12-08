module AdminHelper
  def build_admin_menu
    Effective::Menu.new().build do
      item 'View Site', :root_path

      item 'Users', :admin_users_path
      item 'Organizations', :admin_organizations_path
      item 'Internships', :admin_internships_path

      dropdown 'Interns' do
        item 'Interns', :admin_interns_path
        divider
        item 'Agreements', :admin_agreements_path
        item 'Proofs', :admin_proofs_path
        item 'Declarations', :admin_declarations_path
        item 'Surveys', :admin_surveys_path
      end

      item 'Awards', :admin_awards_path
      item 'Pages', '/admin/pages'
      item 'Logs', '/admin/logs'

      dropdown 'Reports' do
        item 'Report: Signed Agreements', :admin_report_signed_agreements_path
      end
    end
  end
end
