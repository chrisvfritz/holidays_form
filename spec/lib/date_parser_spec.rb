require 'active_support/core_ext/integer/inflections'
require_relative '../../lib/date_parser'

describe HolidayApp::DateParser do

  before { @parser = HolidayApp::DateParser }

  describe '#date_params' do

    context 'when passed ""' do

      before { @current_date = Date.today }
      subject { @parser.new('').date_params }
      it { is_expected.to eq({ year: @current_date.year, month: @current_date.month, day: @current_date.day }) }

    end

    context 'when passed "1999"' do

      subject { @parser.new('1999').date_params }
      it { is_expected.to eq({ year: 1999 }) }

    end

    context 'when passed "feb 1987"' do

      subject { @parser.new('feb 1987').date_params }
      it { is_expected.to eq({ year: 1987, month: 2 }) }

    end

    context 'when passed "april 1, 2004"' do

      subject { @parser.new('april 1, 2004').date_params }
      it { is_expected.to eq({ year: 2004, month: 4, day: 1 }) }

    end

  end

  describe '#to_s' do

    context 'when passed ""' do

      before { @current_date = Date.today }
      subject { @parser.new('').to_s }
      it { is_expected.to eq( @current_date.strftime("%B #{@current_date.day.ordinalize}, %Y") ) }

    end

    context 'when passed "1999"' do

      subject { @parser.new('1999').to_s }
      it { is_expected.to eq('1999') }

    end

    context 'when passed "feb 1987"' do

      subject { @parser.new('feb 1987').to_s }
      it { is_expected.to eq('February 1987') }

    end

    context 'when passed "april 1, 2004"' do

      subject { @parser.new('april 1, 2004').to_s }
      it { is_expected.to eq('April 1st, 2004') }

    end

  end

end