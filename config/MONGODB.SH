#!/bin/bash

# Create MongoDB admin user
echo "Creating MongoDB admin user..."
sudo mongo admin --eval "db.createUser({user: 'root', pwd: 'LeThanhPhong2506', roles: [{role: 'dbAdmin', db: 'admin'}]})"
echo "MongoDB admin user created successfully."

