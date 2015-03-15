feature 'Holidays index' do

  context 'when visiting for the first time' do

    context 'when the current date is 2015-03-14' do

      before do
        class Date
          def self.today
            Date.new 2015, 3, 14
          end
        end

        VCR.use_cassette 'holidays_fetcher/current_date' do
          visit '/'
        end
      end

      it 'should return a 200 status code' do
        expect(page.status_code).to be(200)
      end

      it 'should display a holidays form' do
        expect(page).to have_css('form#holidays_form')
      end

      describe 'the form' do

        it 'should have the country set to "US"' do
          expect(page.find('#holidays_country > option[selected="selected"]').value).to eq('US')
        end

        it 'should have the date set to "March 14th, 2015"' do
          expect(page.find('#holidays_date').value).to eq('March 14th, 2015')
        end

      end

      it 'should display a message that no holidays were found' do
        expect(page).to have_content('No holidays found for March 14th, 2015 in United States.')
      end

      context 'when searching for a holidays in 1987-03' do

        before do
          fill_in 'holidays_date', with: 'March 1987'
          VCR.use_cassette 'holidays_fetcher/_year_1987_month_3_' do
            click_button 'Display Holidays'
          end
        end

        it 'should return a table of holiday results' do
          expect(page).to have_css('table#holiday_results')
        end

        describe 'the table' do

          it 'should list 3 results' do
            expect(page).to have_css('table#holiday_results > tbody > tr', count: 3)
          end

          describe 'the first result' do

            subject(:result) { page.find('table#holiday_results > tbody > tr:first') }

            it 'should show the formatted date "March 4th, 1987" in the first column' do
              expect(result.find('td:first')).to have_content('March 4th, 1987')
            end

            it 'should show the name of the holiday "Ash Wednesday" in the second column' do
              expect(result.find('td:nth-of-type(2)')).to have_content('Ash Wednesday')
            end

          end

        end

      end

    end

  end

end