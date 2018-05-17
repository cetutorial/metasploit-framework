require 'swagger/blocks'

module EventApiDoc
  include Swagger::Blocks

  NAME_DESC = 'The name of the event.'
  NAME_EXAMPLE = 'module_run'
  HOST_DESC = 'The address of the host related to this event.'
  HOST_EXAMPLE = '127.0.0.1'
  CRITICAL_DESC = 'true if the event is considered critical.'
  SEEN_DESC = 'true if a user has acknowledged the event.'
  USERNAME_DESC = 'Name of the user that triggered the event.'
  INFO_DESC = 'Information about the event specific to the event name.'
  INFO_EXAMPLE = '{:command=>"irb"}'

# Swagger documentation for Event model
  swagger_schema :Event do
    key :required, [:name]
    property :id, type: :integer, format: :int32
    property :workspace_id, type: :integer, format: :int32
    property :name, type: :string, description: NAME_DESC, example: NAME_EXAMPLE
    property :critical, type: :boolean, description: CRITICAL_DESC
    property :seen, type: :string, description: SEEN_DESC
    property :username, type: :string, description: USERNAME_DESC
    property :info, type: :string, description: INFO_DESC, example: INFO_EXAMPLE
    property :created_at, type: :string, format: :date_time
    property :updated_at, type: :string, format: :date_time
  end

  swagger_path '/api/v1/events' do
    # Swagger documentation for /api/v1/events POST
    operation :post do
      key :description, 'Create an event.'
      key :tags, [ 'event' ]

      parameter do
        key :in, :body
        key :name, :body
        key :description, 'The attributes to assign to the event.'
        key :required, true
        schema do
          property :workspace, type: :string, required: true
          property :name, type: :string, description: NAME_DESC, example: NAME_EXAMPLE
          property :host, type: :string, format: :ipv4, description: HOST_DESC, example: HOST_EXAMPLE
          property :critical, type: :boolean, description: CRITICAL_DESC
          property :username, type: :string, description: USERNAME_DESC
          property :info, type: :string, description: INFO_DESC, example: INFO_EXAMPLE
        end
      end

      response 200 do
        key :description, 'Successful operation.'
        schema do
          key :type, :object
          key :'$ref', :Event
        end
      end
    end
  end
end