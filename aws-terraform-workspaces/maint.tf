provider "aws" {
  region = var.region
}

resource "aws_workspaces_workspace" "workspaces" {
  count          = length(var.usuarios)
  directory_id   = "d-946732ee5e"                    ## ID do diretorio do AD 
  user_name      = var.usuarios[count.index]
  bundle_id      = "wsb-brz9yq262"                   ## ID do Bundle com o Perfil_DEV_Nov2022

 workspace_properties {
    compute_type_name                         = "POWER"
    user_volume_size_gib                      = 100
    root_volume_size_gib                      = 80
    running_mode                              = "ALWAYS_ON"
    running_mode_auto_stop_timeout_in_minutes = 0
  }

    tags = {
    Prod = "konecta"
  }
}

