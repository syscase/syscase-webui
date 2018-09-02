# frozen_string_literal: true

class Syscase
  class Web
    # Base page
    class Page < LB::Project::Page
      LB::Project::View.setup(self)

      def covered
        @covered ||= Syscase::Web.db.repository(
          Syscase::Web::Persistence::Repositories::Paths
        ).coverage_count
      end

      def coverage
        @coverage ||= covered.to_f / total.to_f
      end

      def total
        @total ||= Syscase::Web.db.repository(
          Syscase::Web::Persistence::Repositories::Addresses
        ).count
      end
    end
  end
end
