RSpec.describe Api::V0x0::ServiceParametersSetsController, :type => :request do
  it("Uses IndexMixin") { expect(described_class.instance_method(:index).owner).to eq(Api::Mixins::IndexMixin) }

  let(:service_offering) { ServiceOffering.create!(:source => source, :tenant => tenant) }
  let(:source) { Source.create!(:tenant => tenant) }
  let(:tenant) { Tenant.create! }

  it "get /service_parameters_sets/:id lists all ServiceParametersSets" do
    service_parameters_set = ServiceParametersSet.create!(:service_offering => service_offering, :source => source, :tenant => tenant)

    get(api_v0x0_service_parameters_set_url(service_parameters_set.id))

    expect(response.status).to eq(200)
    expect(response.parsed_body).to match(a_hash_including("id" => service_parameters_set.id.to_s))
  end
end
