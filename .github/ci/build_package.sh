#!/bin/bash

set -e

apk add zip
cd src && l3build ctan
