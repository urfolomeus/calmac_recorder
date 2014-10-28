require 'spec_helper'
require_relative '../../lib/calmac_recorder/data_scraper'

describe 'scraper data' do
  let(:ds) { DataScraper.new }
  let(:valid_html_doc) {
    Nokogiri::HTML(%q{
      <tr class="tabbedContentRow">
        <td class="status-icon">
          <a href="service-status-details.aspx?routeID=16">
            <img src="/icons/orange-info.png" alt="Disrupted and Extra Info" title="Disruption Details and Extra Info" width="49" height="49">
          </a>
        </td>
        <td><a href="service-status-details.aspx?routeID=16">COLL and TIREE</a></td>
        <td><a href="service-status-details.aspx?routeID=16">Oban- Coll- Tiree</a></td>
        <td>calmac 16</td>
      </tr>
    })
  }

  before :each do
    fixture_path = File.open(File.join(File.dirname(__FILE__), 'calmac_data_sample.html'))
    allow(ds).to receive(:open) { fixture_path }
  end

  describe '#service_for' do
    it 'returns service if service is found' do
      expect(ds.service_for(valid_html_doc)).to eql('COLL and TIREE')
    end

    it 'returns nil if there is no service' do
      html_doc = Nokogiri::HTML(%q{
        <tr class="tabbedContentRow">
        </tr>
      })
      expect(ds.service_for(html_doc)).to be_nil
    end
  end

  describe '#crossing_for' do
    it 'returns crossing if crossing is found' do
      expect(ds.crossing_for(valid_html_doc)).to eql('Oban- Coll- Tiree')
    end

    it 'returns nil if there is no crossing' do
      html_doc = Nokogiri::HTML(%q{
        <tr class="tabbedContentRow">
        </tr>
      })
      expect(ds.crossing_for(html_doc)).to be_nil
    end
  end

  describe '#text_code_for' do
    it 'returns text_code if text_code is found' do
      expect(ds.text_code_for(valid_html_doc)).to eql('calmac 16')
    end

    it 'returns nil if there is no text_code' do
      html_doc = Nokogiri::HTML(%q{
        <tr class="tabbedContentRow">
        </tr>
      })
      expect(ds.text_code_for(html_doc)).to be_nil
    end
  end

  describe '#status_for' do
    it 'returns status if status is found' do
      expect(ds.status_for(valid_html_doc)).to eql('orange-info')
    end

    it 'returns nil if there is no status' do
      html_doc = Nokogiri::HTML(%q{
        <tr class="tabbedContentRow">
        </tr>
      })
      expect(ds.status_for(html_doc)).to be_nil
    end

    it 'returns nil if the status is not in the expected format' do
      html_doc = Nokogiri::HTML(%q{
        <tr class="tabbedContentRow">
          <td class="status-icon">
            <a href="service-status-details.aspx?routeID=16">
              <img src="/somthing/else.php" alt="Disrupted and Extra Info" title="Disruption Details and Extra Info" width="49" height="49">
            </a>
          </td>
        </tr>
      })
      expect(ds.status_for(html_doc)).to be_nil
    end
  end
end
