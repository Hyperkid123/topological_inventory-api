module Api
  module V0
    class EndpointsController < ApplicationController
      include Api::Mixins::IndexMixin

      def create
        endpoint = Endpoint.create!(create_params)
        render :json => endpoint, :status => :created, :location => api_v0x0_endpoint_url(endpoint.id)
      end

      def destroy
        Endpoint.destroy(params[:id])
        head :no_content
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      def show
        render json: Endpoint.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      def update
        Endpoint.update(params[:id], update_params)
        head :no_content
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      private

      def create_params
        ActionController::Parameters.new(JSON.parse(request.body.read)).permit(:role, :port, :source_id, :default, :scheme, :host, :path, :tenant_id)
      end

      def update_params
        params.permit(:role, :port, :source_id, :default, :scheme, :host, :path)
      end

      def list_params
        params.permit(:source_id, :tenant_id)
      end

      def model
        Endpoint
      end
    end
  end
end
