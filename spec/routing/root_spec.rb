require 'rails_helper'

RSpec.describe 'root', type: :routing do
  it 'routes to welcome#index' do
    expect(get: '/').to route_to('welcome#index')
  end
end
