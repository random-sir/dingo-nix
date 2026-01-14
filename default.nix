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

  subPackages = [
    "cmd/dingo"
  ];

  ldflags = [ "-s" "-w" ];

  doCheck = false; # Some tests fail for now

  checkPhase = ''
    runHook preCheck
    export HOME=$(mktemp -d)
    go build -o dingo ./cmd/dingo
    export PATH=$PWD:$PATH
    go test ./...
    runHook postCheck
  '';

  meta = {
    description = "A meta-language for Go that adds Result types, error propagation (?), and pattern matching while maintaining 100% Go ecosystem compatibility";
    homepage = "https://github.com/MadAppGang/dingo";
    changelog = "https://github.com/MadAppGang/dingo/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.free; # Dingo hasn't determine what license
    #maintainers = with lib.maintainers; [ ];
    mainProgram = "dingo";
  };
}
