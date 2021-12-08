resource "local_file" "first" {
  filename        = "/home/yura/edu/test_dir/terraform/local_file.txt"
  content         = "First local resource created using Terraform."
  file_permission = "0600"
}