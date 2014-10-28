require 'spec_helper'
require 'timecop'

describe Sailing do
  it { should validate_presence_of :service }
  it { should validate_presence_of :crossing }
  it { should validate_presence_of :status }

  it "adds timestamps before creating" do
    sailing = Sailing.new(
      service: 'COLL and TIREE',
      crossing: 'Oban- Coll- Tiree',
      status: 'orange'
    )
    now = Time.now
    Timecop.freeze(now) do
      sailing.save
    end
    expected = DateTime.parse(now.to_s).to_s
    expect(sailing.created_at.to_s).to eql(expected)
    expect(sailing.updated_at.to_s).to eql(expected)
  end
end
