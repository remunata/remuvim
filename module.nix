inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];
  options.nvim-lib.neovimPlugins = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf wlib.types.stringable;
    default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  config.settings.config_directory = ./.;

  config.settings.dont_link = true;

  config.binName = "nvim";
  config.settings.aliases = [ "vi" ];

  config.settings.colorscheme = "terafox";
  config.specs.colorscheme = {
    lazy = true;
    data = pkgs.vimPlugins.nightfox-nvim;
  };

  config.specs.lze = [
    config.nvim-lib.neovimPlugins.lze
    {
      data = config.nvim-lib.neovimPlugins.lzextras;
      name = "lzextras";
    }
  ];

  config.specs.nix = {
    data = null;
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
  };

  config.specs.lua = {
    after = [ "general" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      lazydev-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
  };

  config.specs.rust = {
    after = [ "general" ];
    data = null;
    lazy = true;
    extraPackages = with pkgs; [
      rust-analyzer
      rustfmt
    ];
  };

  config.specs.php = {
    after = [ "general" ];
    data = null;
    lazy = true;
    extraPackages = with pkgs; [
      intelephense
    ];
  };

  config.specs.general = {
    after = [ "lze" ];

    extraPackages = with pkgs; [
      lazygit
      tree-sitter
      ripgrep
      fd
      universal-ctags
    ];

    lazy = true;

    data = with pkgs.vimPlugins; [
      {
        data = vim-sleuth;
        lazy = false;
      }
      {
        data = plenary-nvim;
        lazy = false;
      }
      {
        data = nvim-web-devicons;
        lazy = false;
      }
      snacks-nvim
      nvim-lspconfig
      nvim-surround
      blink-cmp
      blink-compat
      cmp-cmdline
      colorful-menu-nvim
      lualine-nvim
      gitsigns-nvim
      which-key-nvim
      fidget-nvim
      nvim-lint
      conform-nvim
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      noice-nvim
      dropbar-nvim
    ];
  };

  # These are from the tips and tricks section of the neovim wrapper docs!
  # https://birdeehub.github.io/nix-wrapper-modules/neovim.html#tips-and-tricks
  # We could put these in another module and import them here instead!

  # This submodule modifies both levels of your specs
  config.specMods =
    {
      # When this module is ran in an inner list,
      # this will contain `config` of the parent spec
      parentSpec ? null,
      # and this will contain `options`
      # otherwise they will be `null`
      parentOpts ? null,
      parentName ? null,
      # and then config from this one, as normal
      config,
      # and the other module arguments.
      ...
    }:
    {
      # you could use this to change defaults for the specs
      # config.collateGrammars = lib.mkDefault (parentSpec.collateGrammars or false);
      # config.autoconfig = lib.mkDefault (parentSpec.autoconfig or false);
      # config.runtimeDeps = lib.mkDefault (parentSpec.runtimeDeps or false);
      # config.pluginDeps = lib.mkDefault (parentSpec.pluginDeps or false);
      # or something more interesting like:
      # add an extraPackages field to the specs themselves
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
      # You could do this too
      # config.before = lib.mkDefault [ "INIT_MAIN" ];
    };

  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];

  # Inform our lua of which top level specs are enabled
  options.settings.cats = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf lib.types.bool;
    default = builtins.mapAttrs (_: v: v.enable) config.specs;
  };

  # build plugins from inputs set
  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default =
      prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input:
          let
            name = lib.removePrefix prefix input;
          in
          {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}
