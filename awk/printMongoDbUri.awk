# /^[ \t]*MONGODB_URI=(.*)$/ { gsub(/^[ \t]*MONGODB_URI=/, "export MONGODB_URI="); print $0 }

/^[ \t]*MONGODB_URI=(.*)$/ { gsub(/^[ \t]*MONGODB_URI=/, ""); print $0 }
