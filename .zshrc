# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

 ENABLE_CORRECTION="true"  # Auto-correct commands

# can be customised e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# plugins: add wisely, too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ========================== My config (El-gibbor) ========================
# Mkdir and cd immidiately
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

# Newline after each output
precmd() { print "" }

DISABLE_AUTO_TITLE="true"

function set_terminal_title() {
  echo -en "\e]2;$@\a"
}
# ========================== My aliases (El-gibbor) =========================
alias py="python3"
alias x="chmod u+x"
alias sh="shellcheck"
alias gs="git status"
alias python="python3"
alias pep="pycodestyle"
alias sms="semistandard"
alias smf="semistandard --fix"
alias w3c="~/W3C-Validator/w3c_validator.py"
alias p="~/simple_automations/automated_tasks/gitPush.sh"
alias f="~/simple_automations/automated_tasks/createFile.sh"
alias sql="~/simple_automations/automated_tasks/sqlLogin.sh"
alias cps="~/simple_automations/automated_tasks/cp_to_server.sh"

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (could use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
  eval PR_USER='${PR_CYAN}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_CYAN}%#${PR_CYAN}'
  local PR_PROMPT='$PR_YELLOW➤ $PR_NO_COLOR'
elif [[ $UID -eq 0 ]]; then # root
  eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_RED➤ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
  eval PR_HOST='${PR_CYAN}%M${PR_NO_COLOR}' # no SSH
fi

local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"
local user_host='${PR_CYAN}${PR_USER}${PR_CYAN}@${PR_CYAN}${PR_HOST}'
local current_dir='%{$PR_MAGENTA%}%2~%{$PR_NO_COLOR%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$PR_RED%}‹$(rvm-prompt i v g s)›%{$PR_NO_COLOR%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$PR_RED%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$PR_NO_COLOR%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$PR_NO_COLOR%}'

# Newline after each output
precmd() { print "" }

# Customise Zsh Prompt
PROMPT="╭─ ${user_host} "[${current_dir}]" ${rvm_ruby}${git_branch}
╰─$PR_PROMPT "
RPS1="${return_code}"

# git status according to changes in repo
ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$PR_YELLOW%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"


# ====================== Airbnb clone Mysql server credentials =================
export HBNB_ENV=dev
export HBNB_MYSQL_USER=hbnb_dev
export HBNB_MYSQL_PWD=hbnb_dev_pwd
export HBNB_MYSQL_HOST=localhost
export HBNB_MYSQL_DB=hbnb_dev_db
export HBNB_TYPE_STORAGE=db
