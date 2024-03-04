{ config, lib, pkgs, ... }:

{

programs.zsh = {
  enable = true;
  dotDir = ".config/zsh";
  enableAutosuggestions = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;

  history = {
    save = 1000000;
    size = 1000000;
  };
  historySubstringSearch.enable = true;

  defaultKeymap = "emacs";
  autocd = false;

  shellAliases = {
    # npm
    ni    = "npm i";
    nr    = "npm run";
    # pnpm
    p     = "pnpm";
    pi    = "p i";
    pch   = "p changeset";
    pe    = "p exec";
    px    = "p dlx";
    pc    = "p pc";
    dev   = "p dev";
    # git
    g     = "git";

    prune_git_branches_merged_to_main="git checkout -q main && git for-each-ref refs/heads/ \"--format=%(refname:short)\" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse \"$branch^{tree}\") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done";
    # github
    gpr   = "gh pr";
    gprl  = "gh pr list";
    gprc  = "gh pr checkout";
    gprv  = "gh pr view";
    gprvw = "gh pr view -w";
    # nvim
    n     = "nvim";
    nv    = "nvim";
    # ls/eza
    ls    = "eza --icons -a";
    ll    = "eza --icons -lag --header";
    mkdir = "mkdir -p";
    # code
    c     = "code";
    cr    = "code -r";
    # cd
    cdp   = "cd $(git rev-parse --show-toplevel)";
    fcd   = "cd $(fd -t d | fzf)";
    #misc
    cl    = "clear";
    srv   = "simple-http-server";

  };
  initExtra = ''
    setopt notify
    setopt share_history
    setopt inc_append_history
    setopt hist_ignore_all_dups
    setopt hist_save_no_dups
    setopt hist_find_no_dups
    unsetopt autocd beep extendedglob nomatch

    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word

    function pf {
      FILTER=$1
      shift
      p --filter "*"$FILTER"*" $@
    }

    function gacmp {
      g a . && g cm $1 && g push
    }

    function gcmp {
      g cm $1 && g push
    }

    function zn {
        z $1 && n
    }

    function zc {
        z $1 && code . && cd -
    }

    function zcr {
        z $1 && code -r .
    }
  '';
};

# home.file.".config/zsh/scripts".source = ./files/scripts;
# home.file.".config/zsh/scripts".recursive = true;

}
