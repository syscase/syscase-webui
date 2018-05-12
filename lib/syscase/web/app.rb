# frozen_string_literal: true

class Syscase
  class Web
    # Main routing entry point
    class App < Syscase::Web::Route
      route do |r|
        r.i18n_set_locale_from(:http)

        r.public

        r.root do
          r.redirect '/coverage'
        end

        r.on 'coverage' do
          r.run Syscase::Web::Route::Coverage.freeze.app
        end
      end
    end
  end
end
