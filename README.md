Creates a 4-node puppet cluster:

* node01: postgresql    (postgresql.ubnt.int.yo61.net)
* node02: puppetdb      (puppetdb.ubnt.int.yo61.net)
* node03: puppet master (puppet.ubnt.int.yo61.net)
* node04: puppetboard   (pboard.ubnt.int.yo61.net)

puppet ca, puppet master, puppetdb, & pboard certs are pre-generated and stored in hiera

vagrant hostmanager plugin used to update hosts files (guests and host)

puppet is used to provision the hosts - modules are installed to the modules dir using librarian-puppet. roles and profiles are installed from the "local" dir; other modules are either installed from the forge, or directly from github. 

Getting Started
---------------
```
vagrant plugin install vagrant hostmanager
gem install librarian puppet
cd provisioning && librarian-puppet install
vagrant up
```
All server certs are pre-generated and deployed from hiera.

To generate client certs, run the following code:
```
# first run - create the certs
for n in 1 2 3 4; do vagrant ssh --command "sudo puppet agent --test" node0$n ; done

# sign the certs on the master
vagrant ssh --command 'for n in 1 2 3 4 ; do sudo puppet cert sign node0$n.ubnt.int.yo61.net ; done' node03

# second run - cert gets pulled down to client and populates puppetdb
for n in 1 2 3 4; do vagrant ssh --command "sudo puppet agent --test" node0$n ; done

# FIXME - set supplementary group for puppetboard user so it can read certs in puppet dir
# should be able to to this a better way, eg. in puppet
vagrant ssh --command "sudo usermod -G puppet -a puppetboard && sudo service httpd restart" node04
```
Now browse to http://pboard.ubnt.int.yo61.neto

If there are problems, check puppetboard can talk to puppetdb as follows:
```
vagrant ssh node04
sudo su - puppetboard
curl 'https://puppetdb.ubnt.int.yo61.net:8081/v3/facts/node01' --cacert /var/lib/puppet/ssl/certs/ca.pem --cert /var/lib/puppet/ssl/certs/pboard.ubnt.int.yo61.net.pem --key /var/lib/puppet/ssl/private_keys/pboard.ubnt.int.yo61.net.pem
```
You should not get an error, and get an empty set back, ie. [ ]
