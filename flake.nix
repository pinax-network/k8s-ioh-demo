{
  description = "A demo on kubernetes with kind and FluxCD";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cilium-cli
            fluxcd
            jq
            k9s
            kind
            kubectl
            kubernetes-helm
            kubevirt
            sops
            ssh-to-age
            tilt
            yq
          ];
        };
      }
    );
}
