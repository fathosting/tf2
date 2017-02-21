settings {
    inotifyMode = "CloseWrite or Modify"
}

sync {
    default.rsync,
    source = "/home/steam/tf2/tf",
    target = "/home/steam/backup",
    rsync = {
        archive  = true
    }
}
