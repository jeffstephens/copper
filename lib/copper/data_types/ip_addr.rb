require 'ipaddr'

module Copper
	module DataTypes

		class IPAddress
			def initialize(value)
				if value.is_a? ::String
					@value = ::IPAddress.parse(value)
				elsif value.is_a?(::IPAddress::IPv4)
					@value = value
				elsif value.is_a?(::IPAddress::IPv6)
					@value = value
				else
					raise ::Copper::RuntimeError, "cannot convert #{value} to IPAddress"
				end
			rescue ArgumentError => exc
				raise ::Copper::RuntimeError, exc.message
			end

			def first
				@value.first
			end

			def last
				@value.last
			end

			def in(value)
				if value.is_a?(::Copper::DataTypes::IPAddress)
					to_check = value.ip_address
				elsif value.is_a?(::IPAddress)
					to_check = value
				else
					raise ::Copper::RuntimeError, "#{value} is not an IP address"
				end

				(@value.first.to_i <= to_check.to_i) && (@value.last.to_i >= to_check.to_i)
			end

			def full_address
				@value.to_string
			end

			def address
				@value.address
			end

			def netmask
				@value.netmask
			end

			def octets
				@value.octets
			end

			def prefix
				@value.prefix.to_i
			end

			def is_network
				@value.network?
			end

			def is_loopback
				@value.loopback?
			end

			def is_multicast
				@value.multicast?
			end

			def is_class_a
				@value.a?
			end

			def is_class_b
				@value.b?
			end

			def is_class_c
				@value.c?
			end

			def ip_address
				@value
			end

			def to_s
				@value.to_string
			end
		end

	end

end
