resource "shoreline_notebook" "airbyte_data_ingestion_failure" {
  name       = "airbyte_data_ingestion_failure"
  data       = file("${path.module}/data/airbyte_data_ingestion_failure.json")
  depends_on = [shoreline_action.invoke_restart_airbyte_server]
}

resource "shoreline_file" "restart_airbyte_server" {
  name             = "restart_airbyte_server"
  input_file       = "${path.module}/data/restart_airbyte_server.sh"
  md5              = filemd5("${path.module}/data/restart_airbyte_server.sh")
  description      = "Restart the Airbyte server and try the ingestion process again."
  destination_path = "/tmp/restart_airbyte_server.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_restart_airbyte_server" {
  name        = "invoke_restart_airbyte_server"
  description = "Restart the Airbyte server and try the ingestion process again."
  command     = "`chmod +x /tmp/restart_airbyte_server.sh && /tmp/restart_airbyte_server.sh`"
  params      = ["NAMESPACE","DEPLOYMENT_NAME"]
  file_deps   = ["restart_airbyte_server"]
  enabled     = true
  depends_on  = [shoreline_file.restart_airbyte_server]
}

