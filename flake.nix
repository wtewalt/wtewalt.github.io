{
  description = "Personal profile site dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [ pkgs.python3 ];

        shellHook = ''
          serve() {
            echo "Serving site at http://localhost:8080"
            python3 -m http.server 8080
          }
          echo "Personal profile site dev shell"
          echo "Run 'serve' to start the local server at http://localhost:8080"
        '';
      };
    });
  };
}
