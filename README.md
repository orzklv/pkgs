<p align="center">
    <img src=".github/assets/header.png" alt="Orzklv's {Pack}">
</p>

<p align="center">
    <h3 align="center">Set of helpful packages written by & for Orzklv.</h3>
</p>

<p align="center">
    <img align="center" src="https://img.shields.io/github/languages/top/orzklv/pkgs?style=flat&logo=nixos&logoColor=ffffff&labelColor=242424&color=242424" alt="Top Used Language">
    <a href="https://t.me/orzklvb"><img align="center" src="https://img.shields.io/badge/Chat-grey?style=flat&logo=telegram&logoColor=ffffff&labelColor=242424&color=242424" alt="Telegram Channel"></a>
    <a href="https://github.com/orzklv/nix/actions/workflows/test.yml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/orzklv/pkgs/test.yml?style=flat&logo=github&logoColor=ffffff&labelColor=242424&color=242424" alt="Test CI"></a>
</p>

## About

This repository actually used to be within my [nix configuration](https://github.com/orzklv/nix). Later, I decided to move all exportable packages, overlays and libs to other repository for lighter input result and more community use. Feel free to use them, feel free to send PR and add your own packages if you feel like.

## Packages

- [Dev Clean](./packages/dev-clean/default.nix): clean your developer directory from builds & temporary files
- [Force Push](./packages/force-push/default.nix): do force push using your github bearer token
- [Google](./packages/google/default.nix): start googling right from your terminal
- [Krisper](./packages/krisper/default.nix): discord krisp patcher for nixos
- [Org Location](./packages/org-location/default.nix): change "location" of a github organization

Packages can be used via `nix run` by calling it's names. You can refer to this example shown below:

```shell
# Names are always lowercase spaced with '-'
nix run github:orzklv/pkgs#<name-here>
```

## Overlays

Repository includes a plug'n'use overlay to add my packages within your `pkgs` instance to call right from your `pkgs`. You should call it something like that:

```nix
# First, let's add this repo to your inputs
{
  inputs = {
    orzklv-pkgs = {
      url = "github:orzklv/pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

# Now proceed to call overlays from repo/inputsx
{
  # Somewhere here...
  nixpkgs = {
    # You can add overlays here!
    overlays = [
      ...
      inputs.orzklv-pkgs.overlays.pkgs
    ];
  };
}
```

## Thanks

- [Template](https://github.com/xinux-org/templates) - Started with this template
- [Nix](https://nixos.org/) - Masterpiece of package management

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Orzklv's {Pack}">
</p>
