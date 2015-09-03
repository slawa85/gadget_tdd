require 'rails_helper'

RSpec.describe GadgetsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/gadgets').to route_to('gadgets#index')
    end

    it 'routes to #new' do
      expect(:get => '/gadgets/new').to route_to('gadgets#new')
    end

    it 'routes to #show' do
      expect(:get => '/gadgets/1').to route_to('gadgets#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/gadgets/1/edit').to route_to('gadgets#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/gadgets').to route_to('gadgets#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/gadgets/1').to route_to('gadgets#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/gadgets/1').to route_to('gadgets#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/gadgets/1').to route_to('gadgets#destroy', :id => '1')
    end

    it 'routes to #search' do
      expect(:get => '/gadgets/search?q=bla').to route_to('gadgets#search', :q => 'bla')
    end
  end
end
