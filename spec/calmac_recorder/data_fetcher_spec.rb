require 'spec_helper'
require_relative '../../lib/calmac_recorder/data_fetcher'

describe 'fetching data' do
  let(:df) { DataFetcher.new }

  before :each do
    fixture_path = File.open(File.join(File.dirname(__FILE__), 'calmac_data_sample.html'))
    allow(df).to receive(:open) { fixture_path }
  end

  describe '#status_for' do
    context 'if service exists' do
      context 'and status can be read' do
        it 'returns "orange-info" if status is orange and there is info' do
          expect(
            df.status_for('Oban- Coll- Tiree')
          ).to eql('orange-info')
        end

        it 'returns "orange" if status is orange and there is no info' do
          expect(
            df.status_for('Ullapool - Stornoway')
          ).to eql('orange')
        end

        it 'returns "green" if status is green and there is no info' do
          expect(
            df.status_for('Largs - Cumbrae Slip')
          ).to eql('green')
        end

        it 'can see status for all crossings on a service' do
          expect(
            df.status_for('Ullapool - Stornoway')
          ).to eql('orange')

          expect(
            df.status_for('Freight Ullapool - Stornoway')
          ).to eql('green')
        end

        it 'can get the status by the service name' do
          expect(
            df.status_for('COLL and TIREE')
          ).to eql('orange-info')
        end

        it 'can get the status by the crossing name' do
          expect(
            df.status_for('Oban- Coll- Tiree')
          ).to eql('orange-info')
        end

        it 'can get the status by the text code' do
          expect(
            df.status_for('calmac 16')
          ).to eql('orange-info')
        end
      end

      it "raises Can't Read Status if service no status icon" do
        expect {
          df.status_for('NO STATUS')
        }.to raise_error(/Can't read status/)
      end

      it "raises Can't Read Status if service no status icon image" do
        expect {
          df.status_for('NO IMAGE')
        }.to raise_error(/Can't read status/)
      end

      it "raises Can't Read Status if service status is in invalid format" do
        expect {
          df.status_for('INCOMPATIBLE STATUS')
        }.to raise_error(/Can't read status/)
      end
    end

    context 'if service does not exist' do
      it 'raises a No Service Given if no service given' do
        expect{
          df.status_for(nil)
        }.to raise_error('No service given')
      end

      it 'raises a No Service Given if blank service given' do
        expect{
          df.status_for('')
        }.to raise_error('No service given')
      end

      it 'raises a Service Not Found if no service found' do
        expect{
          df.status_for('NOWHERE')
        }.to raise_error("Service 'NOWHERE' not found")
      end
    end
  end
end
