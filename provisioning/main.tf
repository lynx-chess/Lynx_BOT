terraform {
  backend "http" {
    update_method = "PUT"
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key = var.private_key
  private_key_password = var.private_key_password
  region = var.region
}

resource "oci_core_instance" "lynx-vm" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
	}
	availability_config {
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = var.availability_domain
	compartment_id = var.compartment_ocid
	create_vnic_details {
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = var.subnet_id
	}
	display_name = var.vm_display_name
	freeform_tags = {
		"Project" = "Lynx"
	}
	instance_options {
		are_legacy_imds_endpoints_disabled = "true"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
		"ssh_authorized_keys" = var.ssh_public_key
        "user_data" : base64encode(file("user-data.sh"))
	}
	shape = "VM.Standard.A1.Flex"
	shape_config {
		memory_in_gbs = "12"
		ocpus = "3"
	}
	source_details {
		source_id = "ocid1.image.oc1.uk-london-1.aaaaaaaaqxf2zi634v7pirstfzjku5seji5m5senrt7jhnfmbanj4swo2lqa"  # Oracle-Linux-8.4-aarch64-2021.10.04-0
		source_type = "image"
	}
	extended_metadata = {}
	nsg_ids = []
}

output "instance_ip_addr" {
    value = oci_core_instance.lynx-vm.public_ip
    description = "VM public IP address"
}