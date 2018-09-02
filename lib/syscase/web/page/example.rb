# frozen_string_literal: true

class Syscase
  class Web
    class Page
      # The example page
      class Example < self
        setting :template, 'example'

        register_page_as :example

        attr_reader :id

        def with(options = {})
          @id = options.fetch(:id)

          self
        end

        def example
          @example ||= Syscase::Web.db.container.relations
                                   .fetch(:examples)
                                   .by_id(id)
                                   .to_a.first
        end

        def code
          Syscase::Web.db.container.relations
                      .fetch(:paths)
                      .code_by_example(id)
                      .to_a
                      .map { |hash| hash[:code] }
                      .join("\n")
        end

        def secure_log
          Base64.decode64(example.fetch(:secure_log))
        end

        def normal_log
          Base64.decode64(example.fetch(:normal_log))
        end

        def qemu_log
          Base64.decode64(example.fetch(:qemu_log))
        end

        def name
          [
            format('%05d', id),
            example.fetch(:result)
          ].join(':')
        end
      end
    end
  end
end
