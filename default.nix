{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "dingo";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "MadAppGang";
    repo = "dingo";
    rev = "v${version}";
    hash = "sha256-l+GTAuAQ+UP0RasTt5LTR5aoWRwBaGRsFs2ris5LvLU=";
  };

  vendorHash = "sha256-M7DQJj7oue9RJ3mKXRdUBvxK9CnA6Y9pHfO7IQDhwPo=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "A meta-language for Go that adds Result types, error propagation (?), and pattern matching while maintaining 100% Go ecosystem compatibility";
    homepage = "https://github.com/MadAppGang/dingo";
    changelog = "https://github.com/MadAppGang/dingo/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dingo";
  };
}
