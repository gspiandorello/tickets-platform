terraform {

  cloud {
    organization = "a3-construcao"

    workspaces {
      name = "a3-construcao-workspace"
    }
  }
}