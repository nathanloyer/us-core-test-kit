require 'fhir_models'

require_relative 'ext/fhir_models'
require_relative 'generator/ig_loader'
require_relative 'generator/ig_metadata_extractor'
require_relative 'generator/group_generator'
require_relative 'generator/read_test_generator'
require_relative 'generator/search_test_generator'
require_relative 'generator/suite_generator'

module USCore
  class Generator
    attr_accessor :ig_resources, :ig_metadata

    def generate
      load_ig_package
      extract_metadata
      generate_search_tests
      generate_read_tests
      # generate_vread_tests
      # generate_history_tests
      # generate_provenance_tests
      # generate_validation_tests
      # generate_must_support_tests
      # generate_reference_resolution_tests
      generate_groups
      generate_suites

      # These won't be generated, but we need them:
      # - CapabilityStatement group
      # - DAR group
    end

    def extract_metadata
      self.ig_metadata = IGMetadataExtractor.new(ig_resources).extract
      File.open('metadata.yml', 'w') do |file|
        file.write(YAML.dump(ig_metadata.to_hash))
      end
    end

    def load_ig_package
      FHIR.logger = Logger.new('/dev/null')
      self.ig_resources = IGLoader.new.load
    end

    def generate_read_tests
      ReadTestGenerator.generate(ig_metadata)
    end

    def generate_search_tests
      SearchTestGenerator.generate(ig_metadata)
    end

    def generate_groups
      GroupGenerator.generate(ig_metadata)
    end

    def generate_suites
      SuiteGenerator.generate(ig_metadata)
    end
  end
end
