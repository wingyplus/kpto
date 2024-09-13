#!/bin/sh

mix kpt.codegen -i openapi/krm.yaml -o ../kpto/lib/kpto/gen -n Kpto.Api.KRM.V1
