# frozen_string_literal: true

Dir[File.join(__dir__, '..', 'gateways', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, '..', 'presenters', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, '..', 'helpers', '*.rb')].sort.each { |file| require file }
