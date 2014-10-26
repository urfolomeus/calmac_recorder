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
  property :due_depart,     String
  property :due_arrive,     String
  property :actual_depart,  String
  property :actual_arrive,  String
  property :cancelled,      Boolean

  validates_presence_of :service, :crossing
end

