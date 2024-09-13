defmodule Kpto.YAMLTest do
  use ExUnit.Case, async: true

  alias Kpto.YAML

  @yaml """
  apiVersion: config.kubernetes.io/v1
  kind: ResourceList
  functionConfig:
    apiVersion: foo-corp.com/v1
    kind: FulfillmentCenter
    metadata:
      name: staging
    spec:
      address: "100 Main St."
  items:
    - apiVersion: v1
      kind: Service
      metadata:
        name: wordpress
        labels:
          app: wordpress
        annotations:
          internal.config.kubernetes.io/index: "0"
          internal.config.kubernetes.io/path: "service.yaml"
      spec: # Example comment
        type: LoadBalancer
        selector:
          app: wordpress
          tier: frontend
        ports:
          - protocol: TCP
            port: 80
  """

  @module Kpto.Api.KRM.V1.ResourceList

  test "encode/1" do
    yaml =
      @yaml
      |> YAML.decode(@module)
      |> YAML.encode()

    assert yaml == """
           apiVersion: config.kubernetes.io/v1
           functionConfig:
             apiVersion: foo-corp.com/v1
             kind: FulfillmentCenter
             metadata:
               name: staging
             spec:
               address: 100 Main St.
           items:
             - apiVersion: v1
               kind: Service
               metadata:
                 annotations:
                   internal.config.kubernetes.io/index: '0'
                   internal.config.kubernetes.io/path: service.yaml
                 labels:
                   app: wordpress
                 name: wordpress
               spec:
                 ports:
                   - port: 80
                     protocol: TCP
                 selector:
                   app: wordpress
                   tier: frontend
                 type: LoadBalancer
           kind: ResourceList
           results: []
           """
  end

  test "decode/2" do
    assert %Kpto.Api.KRM.V1.ResourceList{
             api_version: "config.kubernetes.io/v1",
             function_config: %{
               "apiVersion" => "foo-corp.com/v1",
               "kind" => "FulfillmentCenter",
               "metadata" => %{"name" => "staging"},
               "spec" => %{"address" => "100 Main St."}
             },
             items: [
               %{
                 "apiVersion" => "v1",
                 "kind" => "Service",
                 "metadata" => %{
                   "annotations" => %{
                     "internal.config.kubernetes.io/index" => "0",
                     "internal.config.kubernetes.io/path" => "service.yaml"
                   },
                   "labels" => %{"app" => "wordpress"},
                   "name" => "wordpress"
                 },
                 "spec" => %{
                   "ports" => [%{"port" => 80, "protocol" => "TCP"}],
                   "selector" => %{"app" => "wordpress", "tier" => "frontend"},
                   "type" => "LoadBalancer"
                 }
               }
             ],
             kind: "ResourceList",
             results: nil
           } = YAML.decode(@yaml, @module)
  end
end
