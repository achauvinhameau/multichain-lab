Purpose
=======

small lab to test how a blockchain is working, based on the multichain tool. To ease the lab, docker containers are created for each node of the blockchain, first install docker if you don't already have an environnement up and ready.

Lab
===

Init the Lab (Linux version)
------------

```
git clone https://github.com/achauvinhameau/multichain-lab.git
cd multichain-lab
```

Create image
------------

```
docker build -t multichain-lab .
```

This image (474MB) is build on centos base (196MB). This image installs an apache httpd server for the multichain-web-demo server that is easy to use and visual. It creates the blockchain on the first node and connects all the other nodes to it

Usage
------

Start the first node, it creates the blockchain first block and initiate the web server to see the chain from this node.

```
docker run -d --name node1 --rm -p 80:80 -m 64m multichain-lab
```

From your favorite browser, point to the page exposed on the standard http port of your server running docker, on the first page, choose the node named Default.
On the my node section, note the Node address as it will be used to connect the other nodes to it.

An association relation needs to be created between nodes with privilege granting, open in the browser the Permissions section and check the Connect + Send + Receive permissions.

Start the second node:

```
docker run -d --name node2 --rm -e MC_FIRST=chain1@172.17.0.2:2510 multichain-lab
```

You have 30 seconds to grand the address of this node in the permission page (For address). Use the docker logs command to get the output of the second container node that should look like 

```
$ docker logs -f 62a1d01e10755ee76b038715f90d22eaaa3fb1fbbed673c7fcc8a0deb6289142
Retrieving blockchain parameters from the seed node 172.17.0.2:2510 ...
Blockchain successfully initialized.

Please ask blockchain admin or user having activate permission to let you connect and/or transact:
multichain-cli chain1 grant 1SKjCzL1Am71hdqdNXnp6wQDRhswFvKyhnUUPJ connect
multichain-cli chain1 grant 1SKjCzL1Am71hdqdNXnp6wQDRhswFvKyhnUUPJ connect,send,receive
```

The address of the node is available on the last 2 lines, cut and paste if (1SK...) on the web form and apply the change permissions. If working, you could check on the Node page that you now have a connected node.

You can start some other nodes, make sure you change the name of the container

Have fun...