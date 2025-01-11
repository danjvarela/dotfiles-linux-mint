function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

function fkillp() {
  local pid
  pid=$(lsof -i -P -n | sed 1d | fzf --multi --exact --header="Select processes to kill (use TAB to select multiple)" | awk '{print $2}')
  
  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

# lazygit with yadm
function ylg() {
  cd ~
  yadm enter lazygit
  cd -
}

function ynvim() {
  file=$(yadm list -a | fzf) && nvim $HOME/$file
}

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi

  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

tkill() {
    local sessions
    sessions=$(tmux ls | fzf --exit-0 --multi) || return $?
    while IFS= read -r session; do
        if [[ $session =~ ^([^:]+): ]]; then
            echo "Killing ${BASH_REMATCH[1]}"
            tmux kill-session -t "${BASH_REMATCH[1]}"
        fi
    done <<< "$sessions"

}

sws() {
  local current_directory_name=$(basename "$PWD")
  tmuxinator start default -n "$current_directory_name" .
}
