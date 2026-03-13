#!/bin/bash

python app/app.py &
sleep 5
curl --fail http://localhost:5000/health
  