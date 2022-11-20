# frozen_string_literal: true

# Controller logic: fallback requests for React Router.
# Leave this here to help deploy your app later!
class FallbackController < ApplicationController
  def index
    # React app index page
    render file: 'public/index.html'
  end
end
