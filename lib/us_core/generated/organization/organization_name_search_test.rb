require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module USCore
  class OrganizationNameSearchTest < Inferno::Test
    include USCore::SearchTest

    title 'Server returns valid results for Organization search by name'
    description %(
      A server SHALL support searching by name on the Organization resource. This
      test will pass if resources are returned and match the search criteria. If
      none are returned, the test is skipped'
    %)

    id :organization_name_search_test

    def properties
      @properties ||= SearchTestProperties.new(
        first_search: true,
        resource_type: 'Organization',
        search_param_names: ['name']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:organization_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
