node.default[:nginx][:init_style] = "init"
node.default[:nginx][:source][:modules] << "passenger"
