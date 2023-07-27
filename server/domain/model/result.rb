# frozen_string_literal: true

module Model
  class Result
    attr_reader :success, :error, :value

    def initialize(success:, error: nil, value: nil)
      @success = success
      @error = error
      @value = value
    end

    def self.success(value)
      new(success: true, value:)
    end

    def self.failure(error)
      new(success: false, error:)
    end

    def success?
      success
    end

    def and_then(&block)
      return self unless success?

      block.call(value)
    end
  end
end
