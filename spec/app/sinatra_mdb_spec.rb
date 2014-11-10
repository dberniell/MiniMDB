require 'sinatra_mdb'

module SinatraMdb
  describe 'Web' do
    include Rack::Test::Methods

    def app
      SinatraMdb::Web
    end

    before do
      Capybara.app = app
    end

    describe '/' do
      it 'says Hello World' do
        get '/'

        expect(last_response).to be_ok
        expect(last_response.body).to include('Hello World')
      end
    end

    describe 'hola' do
      it 'says hello to a person' do
        post '/hola', name: 'David'
        expect(last_response).to be_ok
        expect(last_response.body).to include('David')
      end
    end

    describe 'acceptance test' do
      it 'checks the contents' do
        visit '/'

        expect(page).to have_content('Hello World')
      end
    end

    describe 'searching' do
      it 'emulate search clicking submit' do
        visit '/'

        fill_in('name', with: 'Pepe')
        click_on('Submit')
        expect(page).to have_content('Pepe')
      end
    end

    describe 'imdb' do
      it 'gets the correct form' do
        visit '/imdb'

        expect(page).to have_content('Write down the film you want listed')
      end

      it 'searches films' do
        visit '/imdb'
        
        fill_in('query', with: '2001')
        click_on('Search')
        expect(page).to have_content('2001')
      end
    end
  end
end
