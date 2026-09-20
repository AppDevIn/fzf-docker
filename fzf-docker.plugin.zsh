fzf_docker_image_ids() {
  command docker image ls --format '{{.ID}}'
}

fzf_docker_images() {
  command docker image ls --format '{{.ID}}\t{{.Repository}}:{{.Tag}}\t{{.Size}}'
}

fzf_docker_container_ids() {
  command docker container ls --all --format '{{.ID}}'
}

fzf_docker_running_containers() {
  command docker container ls --format '{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}'
}

fzf_docker_select_image_ids() {
  fzf_docker_images |
    command fzf --multi --delimiter=$'\t' --with-nth=1,2,3 |
    command awk -F '\t' '{print $1}'
}

fzf_docker_select_container_ids() {
  fzf_docker_container_ids | command fzf --multi
}

fzf_docker_select_running_container_ids() {
  fzf_docker_running_containers |
    command fzf --multi --delimiter=$'\t' --with-nth=1,2,3,4 |
    command awk -F '\t' '{print $1}'
}

fzf_docker_insert_image_ids() {
  local selected_ids
  selected_ids="$(fzf_docker_select_image_ids)" || return
  [[ -n "$selected_ids" ]] || return

  LBUFFER+="${LBUFFER:+ }${selected_ids//$'\n'/ }"
  zle reset-prompt
}

fzf_docker_insert_running_container_ids() {
  local selected_ids
  selected_ids="$(fzf_docker_select_running_container_ids)" || return
  [[ -n "$selected_ids" ]] || return

  LBUFFER+="${LBUFFER:+ }${selected_ids//$'\n'/ }"
  zle reset-prompt
}

if [[ -o interactive ]]; then
  zle -N fzf_docker_insert_image_ids
  zle -N fzf_docker_insert_running_container_ids
  bindkey '^[di' fzf_docker_insert_image_ids
  bindkey '^[dc' fzf_docker_insert_running_container_ids
fi
