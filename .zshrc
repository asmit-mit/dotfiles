export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/cuda/bin:$HOME/.cargo/bin:$PATH
export LD_LIBRARY_PATH=/usr/lib64:/usr/lib:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

export ZSH="$HOME/.oh-my-zsh"
export BAT_THEME="gruvbox-dark"

plugins=(git zsh-autosuggestions zsh-completions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza -lg"
alias la="eza -a"
alias c="clear"
alias cd="z"
alias files="yazi"

eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"

alias cd="z"

autoload -Uz add-zsh-hook
add-zsh-hook precmd _starship_init
function _starship_init() {
    eval "$(starship init zsh)"
    unfunction _starship_init
}

# Background tasks
xhost +local:docker &>/dev/null

# ROS setup
export ROS_MASTER_URI=http://localhost:11311

# Docker aliases
alias rosdocker="docker run -it --privileged \
    --device=/dev \
    --gpus \"device=0\" \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    -e ROS_MASTER_URI=http://localhost:11311 \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -v $HOME/ROS-1/:/app \
    ros:noetic bash"

alias ros2docker="docker run -it --privileged \
    --device=/dev \
    --gpus 'device=0' \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -v /usr/local/cuda:/usr/local/cuda \
    -v $HOME/ROS-2/:/app \
    ros:humble bash"

# Bindkeys
# bindkey -v
# export KEYTIMEOUT=1
bindkey '^y' autosuggest-accept
