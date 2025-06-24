{
  description = "app";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    self = {
      submodules = true;
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        name = "app";

        pkgs = import nixpkgs { inherit system; };

        version = pkgs.lib.fileContents ./VERSION;

        nativeBuildInputs = with pkgs; [ ];

        buildInputs = with pkgs; [ ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = name;

          nativeBuildInputs = nativeBuildInputs;
          buildInputs = buildInputs;

          src = ./.;

          preBuild = '''';

          postBuild = '''';

          buildPhase = ''
            runHook preBuild

            runHook postBuild
          '';

          preInstall = '''';

          postInstall = '''';

          installPhase = ''
            runHook preInstall

            cp ${name} $out

            runHook postInstall
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = buildInputs;
        };
      }
    );
}
