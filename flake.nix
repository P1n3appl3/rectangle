{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = { flake-utils, nixpkgs, rust-overlay, ... }: flake-utils.lib.eachDefaultSystem (system: let
    np = import nixpkgs {
      inherit system;
      overlays = [ rust-overlay.overlays.default ];
    };
  in {
    devShells.default = np.mkShell {
      nativeBuildInputs = with np; [
        flip-link
        elf2uf2-rs
        (np.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
      ];
    };
  });
}
