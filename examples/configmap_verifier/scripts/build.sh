#!/bin/sh

dagger call -i build export --path=image.tar
docker load < image.tar
