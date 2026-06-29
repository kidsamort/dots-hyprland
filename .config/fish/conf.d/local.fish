# Load secrets
if test -f ~/.bashrc_secrets
    source ~/.bashrc_secrets
end

# LM Studio CLI
set -gx PATH $PATH /home/kidsamort/.lmstudio/bin

# Kiro CLI + Claude Code paths
set -gx ANTHROPIC_BASE_URL "http://localhost:1234/v1"
set -gx ANTHROPIC_API_KEY "lm-studio"
set -gx ANTHROPIC_MODEL "google/gemma-4-e4b"
fish_add_path ~/.local/bin
