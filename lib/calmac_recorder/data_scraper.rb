require 'open-uri'
require 'nokogiri'

class DataScraper
  URL = 'http://status.calmac.info/service-status.aspx'
  STATUS_MATCHER = /^\/icons\/(.*)\.(jpg|jpeg|png|gif)$/

  def fetch
    doc.css(".servicediruptiontable tbody td.status-icon").map do |status_html|
      service_html = status_html.parent
      Sailing.new(
        service: service_for(service_html),
        crossing: crossing_for(service_html),
        text_code: text_code_for(service_html),
        status: status_for(status_html)
      )
    end
  end

  def service_for(service_html)
    find_child_for(service_html, 2)
  end

  def crossing_for(service_html)
    find_child_for(service_html, 3)
  end

  def text_code_for(service_html)
    find_child_for(service_html, 4)
  end

  def status_for(status_html)
    status_html
      .css('img')
      .attr('src')
      .value
      .match(STATUS_MATCHER)[1]
  rescue NoMethodError
    nil
  end

  private

  def find_child_for(service_html, child)
    service_html
      .at_css("td:nth-child(#{child})")
      .text
  rescue NoMethodError
    nil
  end

  def doc
    @doc ||= Nokogiri::HTML open(URL)
  end
end

