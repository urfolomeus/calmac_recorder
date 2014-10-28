class Sailing
  include DataMapper::Resource

  property :id,             Serial
  property :service,        String
  property :crossing,       String
  property :text_code,      String
  property :status,         String
  property :info,           Text
  property :created_at,     DateTime
  property :updated_at,     DateTime
  property :due_depart,     DateTime
  property :due_arrive,     DateTime
  property :actual_depart,  DateTime
  property :actual_arrive,  DateTime
  property :cancelled,      Boolean

  validates_presence_of :service, :crossing, :status
end

