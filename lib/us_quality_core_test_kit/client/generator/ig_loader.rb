# frozen_string_literal: true

require_relative '../generator/ig_loader'
require_relative 'ig_resources'

module USQualityCoreTestKit
  module Client
    class Generator
      class IGLoader < USQualityCoreTestKit::Generator::IGLoader
        def ig_resources
          @ig_resources ||= IGResources.new
        end
      end
    end
  end
end
