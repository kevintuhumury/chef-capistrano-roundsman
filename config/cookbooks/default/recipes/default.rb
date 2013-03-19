abort "please set :stage as one of the attributes in capistrano" unless node[:stage]

package "imagemagick"
package "memcached"
package "postfix"
package "nodejs"

gem_package "bundler"
