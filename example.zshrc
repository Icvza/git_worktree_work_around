gt() {
    local cmd="$1"
    shift || true

    if [ -z "$GT_APP_ENV_SOURCE" ] || [ ! -f "$GT_APP_ENV_SOURCE" ]; then
        echo "GT_APP_ENV_SOURCE is unset or missing; update ~/.zshrc with the app .env path"
        return 1
    fi
    if [ -z "$GT_SS_UI_ENV_SOURCE" ] || [ ! -f "$GT_SS_UI_ENV_SOURCE" ]; then
        echo "GT_SS_UI_ENV_SOURCE is unset or missing; update ~/.zshrc with the ss-ui .env path"
        return 1
    fi

    case "$cmd" in
        ad)
            local worktree_path="$1"
            local branch="$2"
            if [ -z "$worktree_path" ] || [ -z "$branch" ]; then
                echo "Usage: gt ad <path> <branch>"
                return 1
            fi
            git worktree add "$worktree_path" "$branch" && {
                symLinkWorkTree "$GT_APP_ENV_SOURCE" "$worktree_path/apps/site"
                symLinkWorkTree "$GT_SS_UI_ENV_SOURCE" "$worktree_path/packages/se-supersonic-ui"
            }
            ;;
        new)
            local worktree_path="$1"
            local branch="$2"
            if [ -z "$worktree_path" ] || [ -z "$branch" ]; then
                echo "Usage: gt new <path> <branch>"
                return 1
            fi
            git worktree add -b "$branch" "$worktree_path" && {
                symLinkWorkTree "$GT_APP_ENV_SOURCE" "$worktree_path/apps/site"
                symLinkWorkTree "$GT_SS_UI_ENV_SOURCE" "$worktree_path/packages/se-supersonic-ui"
            }
            ;;
        *)
            echo "Usage: gt ad <path> <branch> | gt new <path> <branch>"
            return 1
            ;;
    esac
}

