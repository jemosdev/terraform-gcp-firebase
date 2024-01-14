output "project_number" {
  value = data.google_project.project.number
}

output "firebase_dashboard" {
  value = "https://console.firebase.google.com/project/${google_firebase_project.default.project}/overview"
}