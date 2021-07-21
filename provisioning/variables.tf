variable "vm_display_name" {
    type = string
    default = "test-lynx-vm"
}
variable "compartment_ocid" {
    type = string
}
variable "region" {
    type = string
}
variable "tenancy_ocid" {
    type = string
}
variable "user_ocid" {
    type = string
}
variable "fingerprint" {
    type = string
}
variable "private_key" {
    type = string
}
variable "private_key_password" {
    type = string
}
variable "ssh_public_key"{
    type = string
}
variable "subnet_id" {
    type = string
}
variable "availability_domain" {
    type = string
}