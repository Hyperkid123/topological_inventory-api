module Api
  module V2x0
    class RootController < ApplicationController
      def openapi
        render :json => ::Insights::API::Common::OpenApi::Docs.instance["2.0"].to_json
      end
    end

    # Same behavior as api/v1.0/
    class AvailabilitiesController              < Api::V1x0::AvailabilitiesController; end
    class ClustersController                    < Api::V1x0::ClustersController; end
    class ContainerGroupsController             < Api::V1x0::ContainerGroupsController; end
    class ContainerImagesController             < Api::V1x0::ContainerImagesController; end
    class ContainerNodesController              < Api::V1x0::ContainerNodesController; end
    class ContainerProjectsController           < Api::V1x0::ContainerProjectsController; end
    class ContainerResourceQuotasController     < Api::V1x0::ContainerResourceQuotasController; end
    class ContainersController                  < Api::V1x0::ContainersController; end
    class ContainerTemplatesController          < Api::V1x0::ContainerTemplatesController; end
    class DatastoresController                  < Api::V1x0::DatastoresController; end
    class FlavorsController                     < Api::V1x0::FlavorsController; end
    class GraphqlController                     < Api::V1x0::GraphqlController; end
    class HostsController                       < Api::V1x0::HostsController; end
    class IpaddressesController                 < Api::V1x0::IpaddressesController; end
    class NetworkAdaptersController             < Api::V1x0::NetworkAdaptersController; end
    class NetworksController                    < Api::V1x0::NetworksController; end
    class OrchestrationStacksController         < Api::V1x0::OrchestrationStacksController; end
    class SecurityGroupsController              < Api::V1x0::SecurityGroupsController; end
    class ServiceInstanceNodesController        < Api::V1x0::ServiceInstanceNodesController; end
    class ServiceInstancesController            < Api::V1x0::ServiceInstancesController; end
    class ServiceInventoriesController          < Api::V1x0::ServiceInventoriesController; end
    class ServiceOfferingIconsController        < Api::V1x0::ServiceOfferingIconsController; end
    class ServiceOfferingNodesController        < Api::V1x0::ServiceOfferingNodesController; end
    class ServiceOfferingsController            < Api::V1x0::ServiceOfferingsController; end
    class ServicePlansController                < Api::V1x0::ServicePlansController; end
    class SourceRegionsController               < Api::V1x0::SourceRegionsController; end
    class SourcesController                     < Api::V1x0::SourcesController; end
    class SubnetsController                     < Api::V1x0::SubnetsController; end
    class SubscriptionsController               < Api::V1x0::SubscriptionsController; end
    class TagsController                        < Api::V1x0::TagsController; end
    class TasksController                       < Api::V1x0::TasksController; end
    class VmsController                         < Api::V1x0::VmsController; end
    class VolumeAttachmentsController           < Api::V1x0::VolumeAttachmentsController; end
    class VolumesController                     < Api::V1x0::VolumesController; end
    class VolumeTypesController                 < Api::V1x0::VolumeTypesController; end

    # New / changed in api/v2.0/
    class TaggingsController < ApplicationController
      include Api::V1::Mixins::IndexMixin

      # Present these as tags
      private_class_method def self.api_doc_definition
        @api_doc_definition ||= api_doc.definitions["Tag"]
      end

      def self.presentation_name
        "Tag".freeze
      end

      def create
        primary_instance = primary_collection_model.find(request_path_parts["primary_collection_id"])
        tag = Tag.find_or_create_by!(Tag.parse(params_for_create["tag"]))
        primary_instance.tags << tag

        render :json => tag, :status => :created, :location => "#{instance_link(primary_instance)}/tags"
      end

      private

      def model
        primary_collection_model.tagging_relation_name.to_s.singularize.classify.safe_constantize
      end
    end
  end
end
