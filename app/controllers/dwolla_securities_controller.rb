class DwollaSecuritiesController < ApplicationController

  require 'dwolla_v2'

  def index
    # create an application token
    @app_token = create_app_Token

    cusomter_randomizer = rand(100000000000)

    request_body = {
        :firstName => "Jane#{cusomter_randomizer}",
        :lastName => "Merchant#{cusomter_randomizer}",
        :email => "jmerchant#{cusomter_randomizer}@nomail.net",
        :type => 'receive-only',
        # Fo more information about customer types: https://developers.dwolla.com/concepts/customer-types#customer-types
        # Not required but suggested
        # :ipAddress => '0.0.0.0'
        # :businessName => 'TEST BUSINESS'
    }

    customer = @app_token.post "customers", request_body
    customer.response_headers[:location]

    customers = @app_token.get "customers", limit: 30
    @customer_overview = customers._embedded['customers']

    root = @app_token.get "/"
    account_url = root._links.account.href

    funding_sources = @app_token.get "#{account_url}/funding-sources"
    @sandbox_accounts = funding_sources._embedded['funding-sources']

  end

  def show
    customers = @app_token.get "customers", limit: 30
  end

  # ADD THE FOLLOWING METHOD/ACTIONS BELOW

  def new
    sec = DwollaSecurity.new
  end

  def create
    redirect_to dwolla_security_path(@robot)
  end

  # ADD IN A PRIVATE METHOD FOR ROBOT_PARAMS

  private
  def robot_params
    params.permit(:merchant_id, :merchant_first_name, :merchant_last_name, :merchant_email, :account_routing_number, :account_number, :bank_account_type, :name_for_account, :transfer_ammount, :transfer_source)
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
