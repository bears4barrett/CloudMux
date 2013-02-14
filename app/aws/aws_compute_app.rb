require 'sinatra'
require 'fog'

class AwsComputeApp < ResourceApiBase
	#
	# Compute Instance
	#
	get '/instances/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.servers
			else
				filters = json_body["filters"]
				response = compute.servers.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/instances/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.servers.create(json_body["instance"])
				[OK, response.to_json]
			end
		end
	end
	
	post '/instances/start' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["instance"].nil?)
				[BAD_REQUEST]
			else
				response = compute.servers.get(json_body["instance"]["id"]).start
				[OK, response.to_json]
			end
		end
	end
	
	post '/instances/stop' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["instance"].nil?)
				[BAD_REQUEST]
			else
				response = compute.servers.get(json_body["instance"]["id"]).stop
				[OK, response.to_json]
			end
		end
	end
	
	post '/instances/reboot' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["instance"].nil?)
				[BAD_REQUEST]
			else
				response = compute.servers.get(json_body["instance"]["id"]).reboot
				[OK, response.to_json]
			end
		end
	end
	
	delete '/instances/terminate' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["instance"].nil?)
				[BAD_REQUEST]
			else
				response = compute.servers.get(json_body["instance"]["id"]).destroy
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Compute Availability Zones
	#
	get '/availability_zones/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.describe_availability_zones.body["availabilityZoneInfo"]
			else
				filters = json_body["filters"]
				response = compute.describe_availability_zones(filters).body["availabilityZoneInfo"]
			end
			[OK, response.to_json]
		end
	end
	
	#
	# Compute Flavors
	#
	get '/flavors/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			response = compute.flavors
			[OK, response.to_json]
		end
	end
	
	#
	# Compute Security Group
	#
	get '/security_groups/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.security_groups
			else
				filters = json_body["filters"]
				response = compute.security_groups.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/security_groups/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.security_groups.create(json_body["security_group"])
				[OK, response.to_json]
			end
		end
	end
	
	delete '/security_groups/delete' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["security_group"].nil?)
				[BAD_REQUEST]
			else
				response = compute.security_groups.get(json_body["security_group"]["name"]).destroy
				[OK, response.to_json]
			end
		end
	end
	
	
	#
	# Compute Key Pairs
	#
	get '/key_pairs/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.key_pairs
			else
				filters = json_body["filters"]
				response = compute.key_pairs.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/key_pairs/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.key_pairs.create(json_body["key_pair"])
				[OK, response.to_json]
			end
		end
	end
	
	delete '/key_pairs/delete' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["key_pair"].nil?)
				[BAD_REQUEST]
			else
				response = compute.key_pairs.get(json_body["key_pair"]["name"]).destroy
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Compute Spot Requests
	#
	get '/spot_requests/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.spot_requests
			else
				filters = json_body["filters"]
				response = compute.spot_requests.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/spot_requests/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.spot_requests.create(json_body["spot_request"])
				[OK, response.to_json]
			end
		end
	end
	
	delete '/spot_requests/delete' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["spot_request"].nil?)
				[BAD_REQUEST]
			else
				response = compute.spot_requests.get(json_body["spot_request"]["id"]).destroy
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Compute Elastic Ips
	#
	get '/addresses/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.addresses
			else
				filters = json_body["filters"]
				response = compute.addresses.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/addresses/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.addresses.create(json_body["address"])
				[OK, response.to_json]
			end
		end
	end
	
	delete '/addresses/delete' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["address"].nil?)
				[BAD_REQUEST]
			else
				response = compute.addresses.get(json_body["address"]["publicIp"]).destroy
				[OK, response.to_json]
			end
		end
	end
	
	post '/addresses/associate' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["associate"].nil?)
				[BAD_REQUEST]
			else
				response = compute.associate_address(json_body["associate"]["instanceId"], json_body["associate"]["publicIp"])
				[OK, response.to_json]
			end
		end
	end
	
	post '/addresses/disassociate' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil? || json_body["disassociate"].nil?)
				[BAD_REQUEST]
			else
				response = compute.disassociate_address(json_body["disassociate"]["publicIp"])
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Compute Reserved Instances
	#
	get '/reserved_instances/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.describe_reserved_instances.body["reservedInstanceSet"]
			else
				filters = json_body["filters"]
				response = compute.describe_reserved_instances(filters).body["reservedInstanceSet"]
			end
			[OK, response.to_json]
		end
	end
	
	put '/reserved_instances/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.addresses.create(json_body["reserved_instance"])
				[OK, response.to_json]
			end
		end
	end
	
	#
	# VPCs
	#
	get '/vpcs/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.vpcs
			else
				filters = json_body["filters"]
				response = compute.vpcs.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/vpcs/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.vpcs.create(json_body["vpc"])
				[OK, response.to_json]
			end
		end
	end
	
	#
	# DHCPs
	#
	get '/dhcp_options/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.dhcp_options
			else
				filters = json_body["filters"]
				response = compute.dhcp_options.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/dhcp_options/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.dhcp_options.create(json_body["dhcp"])
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Internet Gateways
	#
	get '/internet_gateways/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.internet_gateways
			else
				filters = json_body["filters"]
				response = compute.internet_gateways.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/internet_gateways/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.internet_gateways.create(json_body["internet_gateway"])
				[OK, response.to_json]
			end
		end
	end
	
	#
	# Subnets
	#
	get '/subnets/describe' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				response = compute.subnets
			else
				filters = json_body["filters"]
				response = compute.subnets.all(filters)
			end
			[OK, response.to_json]
		end
	end
	
	put '/subnets/create' do
		compute = get_compute_interface(params[:cred_id])
		if(compute.nil?)
			[BAD_REQUEST]
		else
			json_body = body_to_json(request)
			if(json_body.nil?)
				[BAD_REQUEST]
			else
				response = compute.subnets.create(json_body["subnet"])
				[OK, response.to_json]
			end
		end
	end
	
	
	def get_compute_interface(cred_id)
		if(cred_id.nil?)
			return nil
		else
			cloud_cred = Account.find_cloud_account(cred_id)
			if cloud_cred.nil?
				return nil
			else
				return Fog::Compute::AWS.new({:aws_access_key_id => cloud_cred.access_key, :aws_secret_access_key => cloud_cred.secret_key})
			end
		end
	end
	
	def body_to_json(request)
		if(!request.content_length.nil? && request.content_length != "0")
			return MultiJson.decode(request.body.read)
		else
			return nil
		end
	end

end
