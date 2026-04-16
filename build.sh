#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== Building Docker image with multistage Dockerfile.python ===${NC}"

docker build -f Dockerfile.python -t web-python-app .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build successful!${NC}"
    
    docker stop web_python 2>/dev/null
    docker rm web_python 2>/dev/null
    
    docker run -d --name web_python -p 5000:5000 web-python-app
    
    echo -e "${GREEN}Container started on port 5000${NC}"
    echo -e "${GREEN}Test: curl http://localhost:5000${NC}"
    
    sleep 2
    docker logs web_python
else
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi
