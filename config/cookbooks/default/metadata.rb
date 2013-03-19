name              "default"
maintainer        "Kevin Tuhumury"
maintainer_email  "kevin.tuhumury@gmail.com"
description       "Installs default packages, Nginx and MySQL."
version           "0.0.2"

recipe "default", "Installs default packages."
recipe "nginx",   "Installs Nginx and Passenger and adds the Nginx configuration file."
recipe "mysql",   "Creates the MySQL user, the database and sets its permissions."

depends "nginx"
