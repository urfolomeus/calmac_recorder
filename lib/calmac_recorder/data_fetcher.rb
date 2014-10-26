require 'open-uri'
require 'nokogiri'

class DataFetcher
  URL = 'http://status.calmac.info/service-status.aspx'
  STATUS_MATCHER = /^\/icons\/(.*)\.(jpg|jpeg|png|gif)$/

  def status_for(service)
    status_img_src_for(service).match(STATUS_MATCHER)[1]
  rescue NoMethodError => e
    raise "Can't read status: #{e.message}"
  end

  private

  def status_img_src_for(service_name)
    service_status_for(service_name)
      .css('img')
      .attr('src')
      .value
  end

  def service_status_for(service_name)
    service_for(service_name)
      .at_css('td.status-icon')
  end

  def service_for(service_name)
    raise "No service given" if service_name.nil? || service_name == ''
    service = doc.at_css(".servicediruptiontable td:contains('#{service_name}')")
    raise "Service '#{service_name}' not found" unless service
    service.parent
  end

  def doc
    @doc ||= Nokogiri::HTML open(URL)
  end
end

