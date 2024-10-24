load('ext://helm_remote', 'helm_remote')

# Cilium CNI
helm_remote(
    'cilium',
    version="1.16.1",
    namespace="kube-system",
    repo_name='cilium',
    values=['./infra/cilium/helm-values.yaml'],
    repo_url='https://helm.cilium.io'
)

# Create a local resource that waits for Cilium's deployment to be complete
local_resource(
    'cilium_wait',
    cmd='echo "Waiting for Cilium..."',
    resource_deps=['cilium'],
    deps=['./infra/cilium/helm-values.yaml']
)

local_resource(
    'lb_crds',
    cmd='kubectl apply -f ./infra/cilium/crd-values.yaml',
    resource_deps=['cilium_wait'],
    deps=['./infra/cilium/crd-values.yaml']
)

local_resource(
    'flux',
    cmd='./scripts/flux-bootstrap.sh',
    resource_deps=['lb_crds'],
    deps=['./scripts/flux-bootstrap.sh'],
    env={'GITHUB_TOKEN': os.getenv('GITHUB_TOKEN', '')}
)
