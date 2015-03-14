require_relative '../../lib/holidays_fetcher'

describe HolidayApp::HolidaysFetcher do

  before { @fetcher = HolidayApp::HolidaysFetcher }

  describe '#results' do

    context 'when passed "US" for the country' do

      before { @country = 'US' }

      [
        { year: 1999 },
        { year: 1987, month: 3 },
        { year: 2004, month: 8, day: 10 }
      ].each do |example_date_params|

        context "when passed #{example_date_params} for the date_params" do

          subject(:results) do
            VCR.use_cassette "holidays_fetcher/#{example_date_params}" do
              @fetcher.new(@country, example_date_params).results
            end
          end

          it { is_expected.to be_an(Array) }

          describe 'each array item' do

            it 'should be a kind of Hash' do
              results.each do |result|
                expect(result).to be_a(Hash)
              end
            end

            it 'should contain a country' do
              results.each do |result|
                expect(result['country']).not_to be_nil
              end
            end

            it 'should contain a date' do
              results.each do |result|
                expect(result['date']).not_to be_nil
              end
            end

            it 'should contain a name' do
              results.each do |result|
                expect(result['name']).not_to be_nil
              end
            end

          end

        end

      end

    end

  end

end