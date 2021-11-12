require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module USCore
  class PractitionerNameSearchTest < Inferno::Test
    include USCore::SearchTest

    title 'Server returns valid results for Practitioner search by name'
    description %(
      A server SHALL support searching by name on the Practitioner resource. This
      test will pass if resources are returned and match the search criteria. If
      none are returned, the test is skipped'
    %)

    id :practitioner_name_search_test

    def properties
      @properties ||= SearchTestProperties.new(
        first_search: true,
        resource_type: 'Practitioner',
        search_param_names: ['name']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:practitioner_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
