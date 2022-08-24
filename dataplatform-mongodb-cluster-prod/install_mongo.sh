sudo mv /tmp/mongodb-org-4.4.repo /etc/yum.repos.d/mongodb-org-4.4.repo

sudo yum install -y mongodb-org

#Ensure your system has the checkpolicy package installed
sudo yum install checkpolicy

cat > mongodb_cgroup_memory.te <<EOF
    module mongodb_cgroup_memory 1.0;

    require {
        type cgroup_t;
        type mongod_t;
        class dir search;
        class file { getattr open read };
    }

    #============= mongod_t ==============
    allow mongod_t cgroup_t:dir search;
    allow mongod_t cgroup_t:file { getattr open read };
EOF


checkmodule -M -m -o mongodb_cgroup_memory.mod mongodb_cgroup_memory.te

semodule_package -o mongodb_cgroup_memory.pp -m mongodb_cgroup_memory.mod

sudo semodule -i mongodb_cgroup_memory.pp

#Permit Access to netstat for FTDC

cat > mongodb_proc_net.te <<EOF
module mongodb_proc_net 1.0;

require {
    type proc_net_t;
    type mongod_t;
    class file { open read };
}

#============= mongod_t ==============
allow mongod_t proc_net_t:file { open read };
EOF

checkmodule -M -m -o mongodb_proc_net.mod mongodb_proc_net.te

semodule_package -o mongodb_proc_net.pp -m mongodb_proc_net.mod

sudo semodule -i mongodb_proc_net.pp

# Start MongoDB.

sudo systemctl start mongod

# Verify the MongoDB has started successfully
sudo systemctl status mongod



