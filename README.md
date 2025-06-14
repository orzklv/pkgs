<p align="center">
    <img src=".github/assets/header.png" alt="Orzklv's {Pack}">
</p>

<p align="center">
    <h3 align="center">Set of helpful packages written by & for Orzklv.</h3>
</p>

<p align="center">
    <img align="center" src="https://img.shields.io/github/languages/top/orzklv/pkgs?style=flat&logo=nixos&logoColor=ffffff&labelColor=242424&color=242424" alt="Top Used Language">
    <a href="https://github.com/orzklv/nix/actions/workflows/test.yml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/orzklv/pkgs/test.yml?style=flat&logo=github&logoColor=ffffff&labelColor=242424&color=242424" alt="Test CI"></a>
</p>

## About

This repository actually used to be within my [nix configuration](https://github.com/orzklv/nix). Later, I decided to move all exportable packages, overlays and libs to other repository for lighter input result and more community use. Feel free to use them, feel free to send PR and add your own packages if you feel like.

## Adding repository

This is certainly easiest and yet the very beginning of using my repository with your nix configurations! In order to do that, open your flake configuration in your favorite editor of choice, and then locate for `inputs`. You may have either called each `inputs` seperately like that:

```nix
  inputs.nixpkgs.url = "...";
  inputs.nixpkgs-unstable.url = "...";
  ...
```

or nested it like that:

```nix
  inputs = {
    nixpkgs.url = "...";
    nixpkgs-unstable.url = "...";
  };
```

If you used seperate calls, please, go with nested one, because it will you more convenience when it comes to aligning nixpkgs dependencies to avoid having multiple nixpkgs instances, in a few words, it will be more readable. So, now inside your inputs, do it like that:

```nix
  inputs = {
    nixpkgs.url = "...";
    nixpkgs-unstable.url = "...";
    ...

    # You may copy/paste the code below!
    orzklv = {
      url = "github:orzklv/pkgs";
      inputs = {
        # For everything
        nixpkgs.follows = "nixpkgs";
        # For `unstable` overlay
        # If you have unstable in your inputs!!!
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };

  };
```

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

Or, simply use my `additions` overlay [(refer to this for more)](#overlays) in your nixpkgs configuration and then feel free to add my packages to your nix configs like that:

```nix
  environment.systemPackages = with pkgs; [
    google
    krisper
  ];
```

## Lib

I have a few useful functions initially created for myself to abstract certain things in my nix configurations. However, later I decided to ship it as a library which you can easily add to `lib` just by mergeng my lib to your nixpkgs lib as following:

```nix
  # Nixpkgs, Home-Manager and orzklv's helpful functions
  lib = nixpkgs.lib // home-manager.lib // orzklv.lib;
```

## Overlays

Repository includes many useful overlays which enables you to manipulate your `pkgs` instance delivered from `nixpkgs`. You may call & use them something like that:

```nix
# First, localte where you defined nixpkgs configurations
{
  # Alright, this starts like that...
  nixpkgs = {
    # If there's no overlays array, define it yourself!
    overlays = [
      # If you already have overlays, there will be some here
      ...
      # Then, from new line, call my overlays
      inputs.orzklv.overlays.additions
      inputs.orzklv.overlays.<name>
    ];
  };
}
```

You may obtain list of available overlays either from [overlays/default.nix](./overlays/default.nix) or refer to this list (might be outdated):

- [Additions](./overlays/additions.nix): merging my packages to your `pkgs` instance, so you can call them within pkgs right away.
- [Modifications](./overlays/modifications.nix): some modifications for pre-existing pkgs delivered from your `inputs.nixpkgs`.
- [Unstable](./overlays/unstable.nix): Binding unstable nixpkgs channel to `pkgs.unstable` variable for calling unstable packages.

## Thanks

- [Template](https://github.com/xinux-org/templates) - Started with this template
- [Nix](https://nixos.org/) - Masterpiece of package management

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Orzklv's {Pack}">
</p>
