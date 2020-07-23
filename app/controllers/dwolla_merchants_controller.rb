class DwollaMerchantsController < ApplicationController

  require 'dwolla_v2'


  def index
    # create an application token
    @app_token = create_app_Token

    cusomter_randomizer = rand(100000000000)

    customers = @app_token.get "customers", limit: 30
    @customer_overview = customers._embedded['customers']


  end

  def show
    # create an application token
    @app_token = create_app_Token

    customer_url = 'https://api-sandbox.dwolla.com/customers/'
    request_url = customer_url+params[:id]

    @customer = @app_token.get request_url

    funding_sources = @app_token.get "#{request_url}/funding-sources"

    @customer_funding_sources = funding_sources._embedded['funding-sources']

    transfers = @app_token.get request_url+'/transfers'
    @transfers = transfers._embedded['transfers']

  end

  def new
    @dwolla_merchant = DwollaMerchant.new
  end

  def create
    # create an application token
    @app_token = create_app_Token

    puts(params[:dwolla_merchant][:first_name])

    request_body = {
            :firstName => params[:dwolla_merchant][:first_name],
            :lastName => params[:dwolla_merchant][:last_name],
            :email => params[:dwolla_merchant][:email],
            :type => 'receive-only',
            # Fo more information about customer types: https://developers.dwolla.com/concepts/customer-types#customer-types
            # Not required but suggested
            # :ipAddress => '0.0.0.0'
            # :businessName => 'TEST BUSINESS'
        }

    customer = @app_token.post "customers", request_body
    customer.response_headers[:location]

    newly_minted_customer = @app_token.get customer.response_headers[:location]

    redirect_to dwolla_merchants_path(newly_minted_customer.id)
  end

# ADD IN A PRIVATE METHOD FOR ROBOT_PARAMS

  private
  def dwolla_merchant_params
    params.require(:merchant_params).permit(:first_name, :last_name, :email)
  end

  def create_app_Token
    first_endpoint = DwollaSecurity.first
    $dwolla = DwollaV2::Client.new(key: first_endpoint.key, secret: first_endpoint.secret) do |config|
      if first_endpoint.target.include? "sandbox"
        config.environment = :sandbox # optional - defaults to production
      end
    end

    # create an application token
    $dwolla.auths.client
  end

end
