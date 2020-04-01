# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body) if response.body.present?
    end
  end
end
